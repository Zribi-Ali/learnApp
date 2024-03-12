import 'package:dio/dio.dart';
import 'package:downloads_path_provider_28/downloads_path_provider_28.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:permission_handler/permission_handler.dart';

class Telecharger extends StatefulWidget {
  final String cour;
  final String type;
  const Telecharger({required this.cour, required this.type});
  @override
  State<Telecharger> createState() => _HomeState();
}

class _HomeState extends State<Telecharger> with TickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..addListener(() {
        setState(() {});
      });
    controller.repeat(reverse: true);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.cour);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        margin: const EdgeInsets.only(top: 50),
        child: Column(
          children: [
            Text("Nom de fichier: ${widget.cour.split('/').last}"),
            const Divider(),
            ElevatedButton(
              onPressed: () async {
                Map<Permission, PermissionStatus> statuses = await [
                  Permission.storage,
                  //add more permission to request here.
                ].request();

                if (statuses[Permission.storage]!.isGranted) {
                  var dir = await DownloadsPathProvider.downloadsDirectory;
                  if (dir != null) {
                    String savename = widget.cour.split('/').last;
                    String savePath = dir.path + "/$savename";
                    print(savePath);
                    print(widget.type + widget.cour + '*******************');
                    try {
                      await Dio().download(widget.type + widget.cour, savePath,
                          onReceiveProgress: (received, total) {
                        if (total != -1) {
                          print((received / total * 100).toStringAsFixed(0) +
                              "%");
                          Fluttertoast.showToast(
                              msg: (received / total * 100).toStringAsFixed(0) +
                                  "%",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 4,
                              backgroundColor: Colors.amberAccent[700],
                              textColor: Colors.white,
                              fontSize: 16.0);
                        }
                      });
                    } on DioError catch (e) {
                      print(e.message);
                    }
                  }
                } else {}
              },
              child: const Text("Download File"),
            ),
          ],
        ),
      ),
    );
  }
}
