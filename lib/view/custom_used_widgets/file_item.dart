import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:testing/assets_url.dart';
import 'package:url_launcher/link.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../models/core/file.dart';
import 'package:downloads_path_provider_28/downloads_path_provider_28.dart';

import 'telechargement.dart';

enum Type { lesson, stream }

class FileItem extends StatelessWidget {
  const FileItem({
    required this.file,
    required this.type,
    Key? key,
  }) : super(key: key);
  final File file;
  final Type type;

  String getUrl() {
    if (type == Type.lesson) {
      return AssetsUrl.lessonsFiles;
    } else {
      return AssetsUrl.StreamFiles;
    }
  }

  @override
  Widget build(BuildContext context) {
    String firstHalf;
    if (file.titleFile.length > 20) {
      firstHalf = file.titleFile.substring(0, 20) +
          "..." +
          file.titleFile
              .substring(file.titleFile.length - 4, file.titleFile.length);
    } else {
      firstHalf = file.titleFile;
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        FaIcon(
          FontAwesomeIcons.filePdf,
          color: Colors.redAccent[700],
        ),
        Text(
          firstHalf,
          style: GoogleFonts.roboto(fontSize: 16),
        ),
        IconButton(
          icon: Icon(Icons.download_rounded),
          color: Colors.amberAccent[700],
          iconSize: 30,
          onPressed: () async {
            showDialog(
              context: context,
              builder: (BuildContext context) =>
                  _buildPopupDialogdownlod(context, file.titleFile),
            );

            /* Map<Permission, PermissionStatus> statuses = await [
              Permission.storage,
              //add more permission to request here.
            ].request();

            if (statuses[Permission.storage]!.isGranted) {
              var dir = await DownloadsPathProvider.downloadsDirectory;
              if (dir != null) {
                String savename = getUrl().split('/').last;
                String savePath = dir.path + "/$savename";
                print(savePath);
                print(getUrl());
                try {
                  await Dio().download(getUrl(), savePath,
                      onReceiveProgress: (received, total) {
                    if (total != -1) {
                      print((received / total * 100).toStringAsFixed(0) + "%");
                    }
                  });
                  print("File is saved to download folder.");
                  Fluttertoast.showToast(
                      msg: "File is saved to download folder",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 16.0);
                } on DioError catch (e) {
                  print(e.message);
                }
              }
            } else {} */
          },
        ),
        /*
        Link(
          uri: Uri.parse(getUrl()),
          builder: (context, followLink) => TextButton(
              onPressed: () {
                followLink;
              },
              child: Text(
                AppLocalizations.of(context)!.download,
                style: TextStyle(color: Colors.black, fontSize: 16),
              )),
        )
        */
      ],
    );
  }

  Widget _buildPopupDialogdownlod(BuildContext context, cour) {
    return AlertDialog(
      content: Container(
        height: MediaQuery.of(context).size.height * .4,
        child: Telecharger(cour: cour, type: getUrl()),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Close'),
        ),
      ],
    );
  }
}
