import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../models/core/student_stream.dart';
import '../models/core/user.dart';
import '../models/helper/student_stream_helper.dart';
import 'user_provider.dart';

class StudentStreamProvider extends ChangeNotifier {
  final _helper = StudentStreamHelper();
  bool loading = false;

  List<StudentStream> _studentStreamList = [];

  List<StudentStream> get studentStreamList => _studentStreamList;

  List<User> _studentsOfStream = [];

  List<User> get studentsOfStream => _studentsOfStream;

  initializeStudentStreams(int idStream, BuildContext context) async {
    print("starting initialization");
    loading = true;
    _studentStreamList = (await _helper.get())!;
    await setStudentForStream(idStream, context);
    loading = false;
    notifyListeners();
    print("finished initialization");
  }

  resetAll() {
    print("inside reset list");
    _studentStreamList.clear();
    _studentsOfStream.clear();
  }

  setStudentForStream(int idStream, BuildContext context) async {
    _filterByIdStream(idStream);
    if (_studentStreamList.isEmpty) {
      print("no students for this stream");
      return;
    }
    print("still going");
    for (int id in _getIdStudentList()) {
      User user =
          await Provider.of<UserProvider>(context, listen: false).getById(id);

      _studentsOfStream.add(user);
    }
  }

  _filterByIdStream(int id) {
    print("filtered");
    _studentStreamList =
        _studentStreamList.where((element) => element.idStream == id).toList();
  }

  List<int> _getIdStudentList() =>
      _studentStreamList.map((e) => e.idStudent).toList();

  Future<bool> addStudentToStream(StudentStream studentStream) async {
    bool result = await _helper.post(studentStream);
    print("provider result $result");
    return result;
  }
}
