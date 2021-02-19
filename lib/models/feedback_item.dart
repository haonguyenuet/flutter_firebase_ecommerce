import 'package:cloud_firestore/cloud_firestore.dart';

class FeedbackItem {
  // Feedback Id
  final String fid;
  // User id
  final String uid;
  // Rating
  final int rating;
  // Feedback content
  final String content;
  // Create date
  final Timestamp timestamp;
  // Contructor
  FeedbackItem({
    this.fid,
    this.timestamp,
    this.uid,
    this.rating,
    this.content,
  });

// Json data from server turns into model data
  static FeedbackItem fromMap(String id, Map<String, dynamic> data) {
    return FeedbackItem(
      fid: id,
      uid: data["uid"],
      rating: data["rating"] ?? 0,
      content: data["content"] ?? "",
      timestamp: data["timestamp"] ?? Timestamp.now(),
    );
  }

  // From model data turns into json data => server
  Map<String, dynamic> toMap() {
    Map<String, dynamic> feedbackItemData = {
      "fid": this.fid,
      "uid": this.uid,
      "rating": this.rating,
      "content": this.content,
      "timestamp": this.timestamp ?? Timestamp.now(),
    };
    return feedbackItemData;
  }

  // Clone and update
  FeedbackItem cloneWith({
    fid,
    uid,
    timestamp,
    rating,
    content,
  }) {
    return FeedbackItem(
      fid: fid ?? this.fid,
      uid: uid ?? this.uid,
      timestamp: timestamp ?? this.timestamp,
      rating: rating ?? this.rating,
      content: content ?? this.content,
    );
  }
}
