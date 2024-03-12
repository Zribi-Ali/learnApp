import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../assets_url.dart';
import '../../models/core/user.dart';
import '../../provider/class_provider.dart';
import '../../provider/stream_provider.dart';
import '../../provider/student_stream_provider.dart';
import '../../provider/user_provider.dart';

class StudentStreamView extends StatefulWidget {
  const StudentStreamView({Key? key}) : super(key: key);

  @override
  _StudentsState createState() => _StudentsState();
}

class _StudentsState extends State<StudentStreamView> {
  @override
  void initState() {
    super.initState();
    if (Provider.of<StudentStreamProvider>(context, listen: false)
        .studentStreamList
        .isEmpty) {
      Provider.of<StudentStreamProvider>(context, listen: false)
          .initializeStudentStreams(
              Provider.of<AppStreamProvider>(context, listen: false)
                  .onClickStream!
                  .idStream,
              context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Consumer2<StudentStreamProvider, AppStreamProvider>(
      builder: (context, studentStreamProvider, appStreamProvider, child) {
        if (studentStreamProvider.loading) {
          return Center(child: CircularProgressIndicator());
        } else if (studentStreamProvider.studentsOfStream.isEmpty) {
          return Center(
              child: Text(
            AppLocalizations.of(context)!.noStudentsForStream,
            style: GoogleFonts.jaldi(color: Colors.black45, fontSize: 18),
          ));
        } else {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 20),
            child: ListView.separated(
                itemBuilder: (context, index) => StudentStreamWidget(
                    user: studentStreamProvider.studentsOfStream[index]),
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 15),
                itemCount: studentStreamProvider.studentsOfStream.length),
          );
        }
      },
    ));
  }
}

class StudentStreamWidget extends StatefulWidget {
  const StudentStreamWidget({
    Key? key,
    required this.user,
  }) : super(key: key);

  final User user;

  @override
  State<StudentStreamWidget> createState() => _StudentStreamWidgetState();
}

class _StudentStreamWidgetState extends State<StudentStreamWidget> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        widget.user.fullname,
        textAlign: TextAlign.right,
        style: GoogleFonts.roboto(color: Colors.black, fontSize: 18),
      ),
      trailing: FutureBuilder(
        future: Provider.of<ClassProvider>(context, listen: false)
            .getClassTitle(widget.user.idClass),
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          if (snapshot.hasData) {
            return Text(
              snapshot.data!,
              style: GoogleFonts.jaldi(color: Colors.black45),
            );
          } else if (snapshot.hasError) {
            return Icon(
              Icons.error,
              color: Theme.of(context).colorScheme.primary,
            );
          } else {
            return Text(
              AppLocalizations.of(context)!.loading,
              style: GoogleFonts.jaldi(color: Colors.black45),
            );
          }
        },
      ),
      leading: widget.user.img == "" || widget.user.img == "no"
          ? CircleAvatar(
              backgroundColor: Colors.grey.shade50,
              backgroundImage: NetworkImage(
                "https://static.stayjapan.com/assets/user_no_photo-4896a2d64d70a002deec3046d0b6ea6e7f01628781493566c95a02361524af97.png",
              ),
              radius: 30,
            )
          : CircleAvatar(
              backgroundImage: NetworkImage(AssetsUrl.users +
                  Provider.of<UserProvider>(context).user.img),
              radius: 30,
            ),
    );
  }
}
