import 'package:flutter/cupertino.dart';

import '../models/core/review.dart';
import '../models/helper/review_helper.dart';

class ReviewProvider extends ChangeNotifier {
  final _helper = ReviewHelper();

  bool loading = false;
  List<Review> _reviews = [];

  Future<void> initializeReviews() async {
    loading = true;
    _reviews = (await _helper.get());
    loading = false;
    notifyListeners();
  }

  List<Review> getReviewsByIdStream(int idStream) => _reviews
      .where(
        (element) => element.idStream == idStream,
      )
      .toList();

  Review? getReviewByIdCourse(int id) {
    try {
      return _reviews.firstWhere((element) => element.idCourse == id);
    } catch (e) {
      return null;
    }
  }

  List<Review> get reviews => _reviews;

  Future<bool> postNewReview(Review newReview) => _helper.post(newReview);
}
