import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/cupertino.dart';
import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:flutter/foundation.dart';

class CloudStorageService extends ChangeNotifier {
  bool isUploading = false;
  bool isSucess = false;
  String imageUrl;
  String userId;
  String email;
  double dataTransferSize;
  double totalDataSize;

  Future<String> clubImageUpload({@required File imageToUpload}) async {
    String fileNameToUpload = path.basename(imageToUpload.path);

    firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
        .ref()
        .child('Club')
        .child(fileNameToUpload);
    try {
      firebase_storage.UploadTask task = ref.putFile(imageToUpload);
      //  useless code await storage.ref("imageToUpload").putFile(imageToUpload);

      task.snapshotEvents.listen((event) async {
        if (event.state == firebase_storage.TaskState.running) {
          isUploading = true;
          dataTransferSize = (event.bytesTransferred / 1024).roundToDouble();
          totalDataSize = (event.totalBytes / 1024).roundToDouble();
          notifyListeners();
        }
        if (event.state == firebase_storage.TaskState.success) {
          isSucess = true;
          isUploading = false;
          await event.ref.getDownloadURL().then((urlOfImage) {
            imageUrl = urlOfImage;
            print('IMage URL FRom main pass:$imageUrl');
            //  print('image URL from Main: $urlOfImage');
            notifyListeners();
          });
        }
      });

      return imageUrl.toString();
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> feedsImageUpload({@required File imageToUpload}) async {
    String fileNameToUpload = path.basename(imageToUpload.path);

    firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
        .ref()
        .child('feeds')
        .child(fileNameToUpload);
    try {
      firebase_storage.UploadTask task = ref.putFile(imageToUpload);
      //  useless code await storage.ref("imageToUpload").putFile(imageToUpload);

      task.snapshotEvents.listen((event) async {
        if (event.state == firebase_storage.TaskState.running) {
          isUploading = true;
          dataTransferSize = (event.bytesTransferred / 1024).roundToDouble();
          totalDataSize = (event.totalBytes / 1024).roundToDouble();
          notifyListeners();
        }
        if (event.state == firebase_storage.TaskState.success) {
          isSucess = true;
          isUploading = false;
          await event.ref.getDownloadURL().then((urlOfImage) {
            imageUrl = urlOfImage;
            print('IMage URL FRom main pass:$imageUrl');
            //  print('image URL from Main: $urlOfImage');
            notifyListeners();
          });
        }
      });

      return imageUrl.toString();
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> eventsImageUpload({@required File imageToUpload}) async {
    String fileNameToUpload = path.basename(imageToUpload.path);

    firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
        .ref()
        .child('Club')
        .child(fileNameToUpload);
    try {
      firebase_storage.UploadTask task = ref.putFile(imageToUpload);
      //  useless code await storage.ref("imageToUpload").putFile(imageToUpload);

      task.snapshotEvents.listen((event) async {
        if (event.state == firebase_storage.TaskState.running) {
          isUploading = true;
          dataTransferSize = (event.bytesTransferred / 1024).roundToDouble();
          totalDataSize = (event.totalBytes / 1024).roundToDouble();
          notifyListeners();
        }
        if (event.state == firebase_storage.TaskState.success) {
          isSucess = true;
          isUploading = false;
          await event.ref.getDownloadURL().then((urlOfImage) {
            imageUrl = urlOfImage;
            print('IMage URL FRom main pass:$imageUrl');
            //  print('image URL from Main: $urlOfImage');
            notifyListeners();
          });
        }
      });

      return imageUrl.toString();
    } catch (e) {
      return e.toString();
    }
  }

  cloudServiceVariableReset() {
    isSucess = false;
    isUploading = false;
    imageUrl = null;
    notifyListeners();
  }
}
