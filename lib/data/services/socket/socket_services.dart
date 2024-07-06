import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:social_book/core/utils/api_endpoints.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketServices {
  BuildContext? _context;

  IO.Socket socket = IO.io(
    ApiEndPoints.socketUrl,
    IO.OptionBuilder().setTransports(['websocket']).build(),
  );

  connectSocket(String username, BuildContext context) {
    _context = context;
    socket = IO.io(ApiEndPoints.socketUrl,
        IO.OptionBuilder().setTransports(['websocket']).build());
    if (_context != null) {
      log('From here it is calling');
    }
  }

  disconnectSocket() {
    socket.onDisconnect((data) {
      log('Is Socket Disconnected: ${socket.disconnected}');
    });
    socket.disconnect();
    socket.clearListeners();
    socket.close();
    socket.dispose();
    log('Is Socket Active: ${socket.active}');
  }
}
