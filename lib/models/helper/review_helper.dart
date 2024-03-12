import 'dart:convert';

import '../core/review.dart';
import '../services/api_review_service.dart';

class ReviewHelper {
  final _api = ApiReviewService();

  Future<List<Review>> get() async {
    var result = await _api.get();
    if (result != null) {
      return List<Review>.from(
          json.decode(result).map((e) => Review.fromJson(e)));
    } else {
      print("Review helper, get error occured");
      return [];
    }
  }

  Future<Review?> getById(int id) async {
    var result = await _api.getById(id);
    if (result != null) {
      return Review.fromJson(json.decode(result)[0]);
    } else {
      print("Review helper, get by id error occured");
      return null;
    }
  }

  Future<bool> post(Review review) async {
    print("inside helper");
    return _api.post(json.encode(review.toJson()));
  }
}
