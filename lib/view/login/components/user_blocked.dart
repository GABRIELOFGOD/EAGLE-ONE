import 'package:flutter/material.dart';
import 'package:youdoc/common/color_extention.dart';
import 'package:youdoc/sockets/socket_service.dart';
import 'package:youdoc/sockets/stream_socket.dart';

class UserBlocked extends StatefulWidget {
  const UserBlocked({super.key});

  @override
  State<UserBlocked> createState() => _UserBlockedState();
}

class _UserBlockedState extends State<UserBlocked> {

  String _convertToDisplayTime(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    if (duration.inHours == 0) {
      return "$twoDigitMinutes:$twoDigitSeconds";
    }
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }
  
  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.bottomCenter,
        child: Material(
          color: Colors.transparent,
          child: Container(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.9,
            ),
            decoration: BoxDecoration(
              color: TColor.dialog,
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.all(20),
            width: MediaQuery.of(context).size.width * 0.9,
            child: (SocketService.socket != null && SocketService.socket!.connected)
                ? StreamBuilder(
                    stream: streamSocket.getResponse,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        if (snapshot.data.toString() == "0") {
                          return const Text("Socket Status : TICKING TIMEOUT");
                        } else {
                          return Text(
                            'Socket Status : TIMER TICKING - ${_convertToDisplayTime(
                              Duration(
                                seconds: int.parse(snapshot.data.toString()),
                              ),
                            ).toString()}',
                          );
                        }
                      } else {
                        if (SocketService.socket!.connected) {
                          return const Text("Socket Status : CONNECTED");
                        } else {
                          return const Text("Socket Status : DISCONNECTED");
                        }
                      }
                    },
                  )
                : const Text('Socket Status : DISCONNECTED'),
          ),
        ),
      );
  }
}