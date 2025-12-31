/**
 * Mock PostgreSQL server implementing the wire protocol
 * Supports startup, simple query, and basic authentication
 */

export class PostgresMock {
  constructor(port = 5432) {
    this.port = port;
    this.server = null;
    this.tables = new Map(); // table_name -> [rows]
    this.queryHandlers = new Map(); // query pattern -> handler function
  }

  start() {
    this.server = Bun.listen({
      hostname: "127.0.0.1",
      port: this.port,
      socket: {
        data: (socket, data) => this.handleData(socket, data),
        open: (socket) => {
          socket.pgState = "startup";
        },
        close: (socket) => {},
        error: (socket, error) => console.error("PostgreSQL mock error:", error),
      },
    });
    return this;
  }

  stop() {
    if (this.server) {
      this.server.stop();
      this.server = null;
    }
    this.tables.clear();
    this.queryHandlers.clear();
  }

  handleData(socket, data) {
    const buf = Buffer.from(data);

    if (socket.pgState === "startup") {
      this.handleStartup(socket, buf);
    } else {
      this.handleMessage(socket, buf);
    }
  }

  handleStartup(socket, buf) {
    // Read message length (first 4 bytes)
    const len = buf.readInt32BE(0);
    // Read protocol version (next 4 bytes)
    const version = buf.readInt32BE(4);

    // SSL request (80877103)
    if (version === 80877103) {
      // Reject SSL with 'N'
      socket.write(Buffer.from("N"));
      return;
    }

    // Regular startup message (protocol 3.0 = 196608)
    if (version === 196608) {
      // Send AuthenticationOk (R\0\0\0\8\0\0\0\0)
      socket.write(Buffer.from([0x52, 0, 0, 0, 8, 0, 0, 0, 0]));

      // Send ParameterStatus messages
      this.sendParameterStatus(socket, "server_version", "15.0");
      this.sendParameterStatus(socket, "client_encoding", "UTF8");
      this.sendParameterStatus(socket, "DateStyle", "ISO, MDY");

      // Send BackendKeyData
      const keyData = Buffer.alloc(13);
      keyData[0] = 0x4b; // 'K'
      keyData.writeInt32BE(12, 1); // length
      keyData.writeInt32BE(1234, 5); // process ID
      keyData.writeInt32BE(5678, 9); // secret key
      socket.write(keyData);

      // Send ReadyForQuery
      socket.write(Buffer.from([0x5a, 0, 0, 0, 5, 0x49])); // 'Z' + length + 'I' (idle)

      socket.pgState = "ready";
    }
  }

  sendParameterStatus(socket, name, value) {
    const len = 4 + name.length + 1 + value.length + 1;
    const buf = Buffer.alloc(1 + len);
    buf[0] = 0x53; // 'S'
    buf.writeInt32BE(len, 1);
    buf.write(name, 5);
    buf[5 + name.length] = 0;
    buf.write(value, 5 + name.length + 1);
    buf[5 + name.length + 1 + value.length] = 0;
    socket.write(buf);
  }

  handleMessage(socket, buf) {
    const msgType = String.fromCharCode(buf[0]);
    const len = buf.readInt32BE(1);

    switch (msgType) {
      case "Q": // Simple Query
        const query = buf.toString("utf8", 5, 5 + len - 5).replace(/\0/g, "");
        this.handleQuery(socket, query);
        break;

      case "X": // Terminate
        socket.end();
        break;

      case "P": // Parse (extended query)
        // Send ParseComplete
        socket.write(Buffer.from([0x31, 0, 0, 0, 4]));
        break;

      case "B": // Bind
        // Send BindComplete
        socket.write(Buffer.from([0x32, 0, 0, 0, 4]));
        break;

      case "D": // Describe
        // Send NoData
        socket.write(Buffer.from([0x6e, 0, 0, 0, 4]));
        break;

      case "E": // Execute
        // Send EmptyQueryResponse
        socket.write(Buffer.from([0x49, 0, 0, 0, 4]));
        break;

      case "S": // Sync
        // Send ReadyForQuery
        socket.write(Buffer.from([0x5a, 0, 0, 0, 5, 0x49]));
        break;

      default:
        console.log(`Unknown PostgreSQL message type: ${msgType}`);
    }
  }

  handleQuery(socket, query) {
    const upperQuery = query.toUpperCase().trim();

    // Check custom handlers first
    for (const [pattern, handler] of this.queryHandlers) {
      if (query.match(pattern)) {
        const result = handler(query);
        this.sendQueryResult(socket, result.columns, result.rows);
        return;
      }
    }

    // Built-in query handling
    if (upperQuery.startsWith("SELECT")) {
      this.handleSelect(socket, query);
    } else if (upperQuery.startsWith("INSERT")) {
      this.handleInsert(socket, query);
    } else if (upperQuery.startsWith("UPDATE")) {
      this.handleUpdate(socket, query);
    } else if (upperQuery.startsWith("DELETE")) {
      this.handleDelete(socket, query);
    } else if (upperQuery.startsWith("CREATE")) {
      this.sendCommandComplete(socket, "CREATE TABLE");
    } else if (upperQuery.startsWith("DROP")) {
      this.sendCommandComplete(socket, "DROP TABLE");
    } else if (upperQuery === "BEGIN" || upperQuery === "BEGIN TRANSACTION") {
      this.sendCommandComplete(socket, "BEGIN");
    } else if (upperQuery === "COMMIT") {
      this.sendCommandComplete(socket, "COMMIT");
    } else if (upperQuery === "ROLLBACK") {
      this.sendCommandComplete(socket, "ROLLBACK");
    } else {
      // Unknown query - just return empty result
      this.sendCommandComplete(socket, "OK");
    }

    // Send ReadyForQuery
    socket.write(Buffer.from([0x5a, 0, 0, 0, 5, 0x49]));
  }

  handleSelect(socket, query) {
    // Parse simple SELECT queries
    const match = query.match(/SELECT\s+(.+)\s+FROM\s+(\w+)/i);
    if (match) {
      const tableName = match[2].toLowerCase();
      const table = this.tables.get(tableName);

      if (table && table.rows.length > 0) {
        this.sendQueryResult(socket, table.columns, table.rows);
        return;
      }
    }

    // Default: return empty result with generic columns
    this.sendQueryResult(socket, ["column1"], []);
  }

  handleInsert(socket, query) {
    this.sendCommandComplete(socket, "INSERT 0 1");
  }

  handleUpdate(socket, query) {
    this.sendCommandComplete(socket, "UPDATE 1");
  }

  handleDelete(socket, query) {
    this.sendCommandComplete(socket, "DELETE 1");
  }

  sendQueryResult(socket, columns, rows) {
    // Send RowDescription
    this.sendRowDescription(socket, columns);

    // Send DataRows
    for (const row of rows) {
      this.sendDataRow(socket, row);
    }

    // Send CommandComplete
    this.sendCommandComplete(socket, `SELECT ${rows.length}`);
  }

  sendRowDescription(socket, columns) {
    // Calculate total length
    let len = 4 + 2; // length + field count
    for (const col of columns) {
      len += col.length + 1 + 18; // name + null + field info
    }

    const buf = Buffer.alloc(1 + len);
    let offset = 0;

    buf[offset++] = 0x54; // 'T'
    buf.writeInt32BE(len, offset);
    offset += 4;
    buf.writeInt16BE(columns.length, offset);
    offset += 2;

    for (const col of columns) {
      buf.write(col, offset);
      offset += col.length;
      buf[offset++] = 0; // null terminator

      buf.writeInt32BE(0, offset); // table OID
      offset += 4;
      buf.writeInt16BE(0, offset); // column number
      offset += 2;
      buf.writeInt32BE(25, offset); // type OID (text)
      offset += 4;
      buf.writeInt16BE(-1, offset); // type size
      offset += 2;
      buf.writeInt32BE(-1, offset); // type modifier
      offset += 4;
      buf.writeInt16BE(0, offset); // format code (text)
      offset += 2;
    }

    socket.write(buf);
  }

  sendDataRow(socket, row) {
    const values = Array.isArray(row) ? row : Object.values(row);
    const strValues = values.map((v) => (v === null ? null : String(v)));

    // Calculate length
    let len = 4 + 2; // length + column count
    for (const v of strValues) {
      len += 4; // value length
      if (v !== null) len += v.length;
    }

    const buf = Buffer.alloc(1 + len);
    let offset = 0;

    buf[offset++] = 0x44; // 'D'
    buf.writeInt32BE(len, offset);
    offset += 4;
    buf.writeInt16BE(strValues.length, offset);
    offset += 2;

    for (const v of strValues) {
      if (v === null) {
        buf.writeInt32BE(-1, offset); // NULL
        offset += 4;
      } else {
        buf.writeInt32BE(v.length, offset);
        offset += 4;
        buf.write(v, offset);
        offset += v.length;
      }
    }

    socket.write(buf);
  }

  sendCommandComplete(socket, tag) {
    const len = 4 + tag.length + 1;
    const buf = Buffer.alloc(1 + len);
    buf[0] = 0x43; // 'C'
    buf.writeInt32BE(len, 1);
    buf.write(tag, 5);
    buf[5 + tag.length] = 0;
    socket.write(buf);
  }

  sendError(socket, message) {
    // Error message format: 'E' + length + severity + code + message + null
    const severity = "ERROR";
    const code = "42000";

    let len =
      4 +
      1 +
      severity.length +
      1 +
      1 +
      code.length +
      1 +
      1 +
      message.length +
      1 +
      1;

    const buf = Buffer.alloc(1 + len);
    let offset = 0;

    buf[offset++] = 0x45; // 'E'
    buf.writeInt32BE(len, offset);
    offset += 4;

    buf[offset++] = 0x53; // 'S' severity
    buf.write(severity, offset);
    offset += severity.length;
    buf[offset++] = 0;

    buf[offset++] = 0x43; // 'C' code
    buf.write(code, offset);
    offset += code.length;
    buf[offset++] = 0;

    buf[offset++] = 0x4d; // 'M' message
    buf.write(message, offset);
    offset += message.length;
    buf[offset++] = 0;

    buf[offset++] = 0; // terminator

    socket.write(buf);
  }

  // Helper methods for test setup
  createTable(name, columns) {
    this.tables.set(name.toLowerCase(), { columns, rows: [] });
  }

  insertRow(tableName, row) {
    const table = this.tables.get(tableName.toLowerCase());
    if (table) {
      table.rows.push(row);
    }
  }

  setQueryHandler(pattern, handler) {
    this.queryHandlers.set(pattern, handler);
  }

  clearTables() {
    this.tables.clear();
  }
}

export function createPostgresMock(port = 5432) {
  return new PostgresMock(port).start();
}
