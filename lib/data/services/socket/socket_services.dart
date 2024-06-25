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
      // _context!.read<GetChatBloc>().add(FetchAllUserChatsEvent());
      // _listenMessage(_context);
      // _getOnlineUsers(_context);
      // _makeUserActive(username);
    }
  }
}
