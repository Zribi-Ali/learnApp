import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'package:url_launcher/link.dart';
import '../../assets_url.dart';
import '../../models/core/student_stream.dart';
import '../../models/core/user.dart';
import '../../provider/file_provider.dart';
import '../../provider/stream_provider.dart';
import '../../provider/student_stream_provider.dart';
import '../../provider/user_provider.dart';
import '../custom_used_widgets/file_item.dart';
import '../live/live_now.dart';

class StreamView extends StatefulWidget {
  const StreamView({Key? key, required this.employee}) : super(key: key);

  final User employee;

  @override
  _OnlineState createState() => _OnlineState();
}

class _OnlineState extends State<StreamView> {
  @override
  void initState() {
    Provider.of<FileProvider>(context, listen: false).initializeFilesForStream(
        Provider.of<AppStreamProvider>(context, listen: false)
            .onClickStream!
            .idStream);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bool test;
    Provider.of<AppStreamProvider>(context, listen: false).UserHaveStream(
        Provider.of<UserProvider>(context, listen: false).user.id,
        Provider.of<AppStreamProvider>(context).onClickStream!.idStream);
    print(Provider.of<AppStreamProvider>(context).onClickStream!.idStream);
    print(Provider.of<UserProvider>(context, listen: false).user.id);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 38.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            teacherInfo(),
            const SizedBox(
              height: 30,
            ),
            /*********************************** */
            Provider.of<AppStreamProvider>(context).test == true
                ? Container()
                : linkButton(context),
            SizedBox(
              height: 25,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'ملفات الدرس ',
                style: GoogleFonts.roboto(
                    fontSize: 25, color: Colors.amberAccent[700]),
              ),
            ),
            SizedBox(
              height: 18,
            ),
            Provider.of<FileProvider>(context).loading
                ? Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: MediaQuery.of(context).size.width / 5),
                    child: Center(
                      child: CircularProgressIndicator(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  )
                : Provider.of<FileProvider>(context).files.isEmpty
                    ? Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: MediaQuery.of(context).size.width / 5),
                        child: Center(
                          child: Text(
                            AppLocalizations.of(context)!.noFiles,
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                      )
                    : Expanded(
                        child: ListView.builder(
                        itemBuilder: ((context, index) => FileItem(
                            type: Type.stream,
                            file: Provider.of<FileProvider>(context)
                                .files[index])),
                        itemCount:
                            Provider.of<FileProvider>(context).files.length,
                      )),
            SizedBox(
              height: 36,
            ),
            buildButtonContainer(),
          ],
        ),
      ),
    );
  }

  Row teacherInfo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        widget.employee.img == ""
            ? CircleAvatar(
                backgroundImage: NetworkImage(
                  "https://static.stayjapan.com/assets/user_no_photo-4896a2d64d70a002deec3046d0b6ea6e7f01628781493566c95a02361524af97.png",
                ),
                radius: 30,
              )
            : CircleAvatar(
                backgroundImage:
                    NetworkImage(AssetsUrl.users + widget.employee.img),
                radius: 30,
              ),
        const SizedBox(
          width: 20,
        ),
        Text(
          AppLocalizations.of(context)!.teacher + " : ",
          style: GoogleFonts.abel(
              color: Colors.amberAccent[700],
              fontSize: 20,
              fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          width: 5,
        ),
        Text(
          widget.employee.fullname,
          style: GoogleFonts.abel(fontSize: 20, color: Colors.black54),
        ),
        SizedBox(
          width: 12,
        ),
      ],
    );
  }

  Padding linkButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Container(
        height: 56.0,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(23.0), color: Colors.amber),
        child: Link(
          uri: Uri.parse(Provider.of<AppStreamProvider>(context)
              .onClickStream!
              .linkStream),
          builder: ((context, followLink) => MaterialButton(
                onPressed: () {
                  addStudentToStream();
                  followLink;
                },
                child: Text(
                  AppLocalizations.of(context)!.onlineMeeting,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                  ),
                ),
              )),
        ),
      ),
    );
  }

  Widget buildButtonContainer() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Container(
          height: 56.0,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(23.0),
              color: Colors.redAccent[700]),
          child: MaterialButton(
            onPressed: () => Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (_) => LiveNow())),
            child: Text(
              "وقف البث",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
              ),
            ),
          )),
    );
  }

  void addStudentToStream() async {
    print("student stream add proccess start");
    StudentStream studentStream = StudentStream(
        idStudent: Provider.of<UserProvider>(context, listen: false).user.id,
        idStream: Provider.of<AppStreamProvider>(context, listen: false)
            .onClickStream!
            .idStream,
        mydate: DateTime.now());
    bool result =
        await Provider.of<StudentStreamProvider>(context, listen: false)
            .addStudentToStream(studentStream);
    print("add student stream result $result");
  }
}
