import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class StorageRepository {
  FirebaseStorage storage = FirebaseStorage.instanceFor(bucket: "gs://e-commerce-flutter-526ce.appspot.com");

  /// Return photo URL
  Future<String> uploadImage(String ref, File file) async {
    var storageRef = storage.ref().child(ref);
    var uploadTask = await storageRef.putFile(file);

    String downloadURL = await uploadTask.ref.getDownloadURL();
    return downloadURL;
  }
}
