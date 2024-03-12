import 'package:flutter/cupertino.dart';

import '../models/core/stream.dart';
import '../models/helper/stream_helper.dart';

class AppStreamProvider extends ChangeNotifier {
  final _helper = StreamHelper();

  bool loading = false;

  List<AppStream> _streams = [];

  List<AppStream> _streamsForUserToday = [];

  List<AppStream> get streams => _streams;

  int? _idCourse;

  AppStream? _onClickStream;

  AppStream? get onClickStream => _onClickStream;

  setOnClickStream(AppStream stream) {
    _onClickStream = stream;
    print("new stream id : ${stream.idStream}");
  }

  int? get currentIdCourse {
    return _idCourse;
  }

  void setIdCourse(int id) {
    _idCourse = id;
    print("current id course : $_idCourse");
    notifyListeners();
  }

  initializeStreams() async {
    loading = true;
    _streams = (await _helper.get())!;
    _streams =
        _streams.where((element) => element.idCourse == _idCourse).toList();
    loading = false;
    notifyListeners();
  }

  bool _test = false;
  UserHaveStream(int iduser, int idStream) async {
    if ((await _helper.UserHaveStream(iduser, idStream)) == "true") {
      print("true ************** UserHaveStream");
      _test = true;
    } else {
      _test = false;
    }
    notifyListeners();
  }

  bool get test => _test;

  initializeStreamsForUserToday(int idUser) async {
    print("inside initialize streams for user today PROVIDER");
    loading = true;
    _streamsForUserToday = (await _helper.getStreamsForUserToday(idUser))!;
    print("Streams for today are : ${_streamsForUserToday}");
    loading = false;

    notifyListeners();
  }

  List<AppStream> getAvailableStreams() {
    List<AppStream> availableStreams = _streamsForUserToday
        .where((stream) => stream.datetimeStream
            .subtract(Duration(hours: 1))
            .isAtSameMomentAs(DateTime.now()))
        .toList();
    return availableStreams;
  }

  List<AppStream> getUpcomingStreams() {
    return _streams
        .where((stream) =>
            stream.datetimeStream
                .add(Duration(hours: 2))
                .compareTo(DateTime.now()) >
            0)
        .toList();
  }

  List<AppStream> getPastStreams() {
    return _streams
        .where((stream) => stream.datetimeStream.compareTo(DateTime.now()) < 0)
        .toList();
  }

  List<AppStream> getNowStreams({int? hours}) {
    return _streams
        .where((stream) =>
            stream.datetimeStream.compareTo(DateTime.now()) > 0 &&
            stream.datetimeStream
                    .add(Duration(hours: hours ?? 2))
                    .compareTo(DateTime.now()) <
                0)
        .toList();
  }
}
