import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

/// Feedback item model
class FeedBack extends Equatable {
  /// Feedback Id
  final String id;

  /// User id
  final String userId;

  /// Rating
  final int rating;

  /// Feedback content
  final String content;

  /// Create date
  final Timestamp timestamp;

  /// Contructor
  FeedBack({
    required this.id,
    required this.timestamp,
    required this.userId,
    required this.rating,
    required this.content,
  });

  /// Json data from server turns into model data
  static FeedBack fromMap(Map<String, dynamic> data) {
    return FeedBack(
      id: data["id"] ?? "",
      userId: data["userId"] ?? "",
      rating: data["rating"] ?? 0,
      content: data["content"] ?? "",
      timestamp: data["timestamp"] ?? Timestamp.now(),
    );
  }

  /// From model data turns into json data => server
  Map<String, dynamic> toMap() {
    return {
      "id": this.id,
      "userId": this.userId,
      "rating": this.rating,
      "content": this.content,
      "timestamp": this.timestamp,
    };
  }

  /// Clone and update
  FeedBack cloneWith({
    id,
    userId,
    timestamp,
    rating,
    content,
  }) {
    return FeedBack(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      timestamp: timestamp ?? this.timestamp,
      rating: rating ?? this.rating,
      content: content ?? this.content,
    );
  }

  // Compare two feedback item by id
  @override
  List<Object> get props => [id, userId, rating, content, timestamp];
}
