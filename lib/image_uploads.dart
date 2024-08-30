import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'image_controller.dart';

class ImageUploads extends StatefulWidget {
  @override
  _ImageUploadsState createState() => _ImageUploadsState();
}

class _ImageUploadsState extends State<ImageUploads> {
  final ImageController imageController = Get.find<ImageController>();
  bool isUploading = false;
  double uploadProgress = 0.0;

  Future<void> uploadFiles() async {
    if (imageController.files.isEmpty) return;

    setState(() {
      isUploading = true;
      uploadProgress = 0.0;
    });

    try {
      int totalFiles = imageController.files.length;
      int uploadedFiles = 0;

      for (var file in imageController.files) {
        final fileName = basename(file.path);
        String destination;

        if (fileName.endsWith('.png') || fileName.endsWith('.jpg')) {
          destination = 'images/$fileName';
        } else if (fileName.endsWith('.pdf') || fileName.endsWith('.docx')) {
          destination = 'documents/$fileName';
        } else {
          destination = 'others/$fileName';
        }

        final ref = FirebaseStorage.instance.ref(destination);
        UploadTask uploadTask = ref.putFile(file);

        uploadTask.snapshotEvents.listen((snapshot) {
          setState(() {
            uploadProgress = (snapshot.bytesTransferred / snapshot.totalBytes) * 100;
          });
        });

        await uploadTask;

        uploadedFiles += 1;

        setState(() {
          uploadProgress = (uploadedFiles / totalFiles) * 100;
        });

        print('File uploaded successfully to $destination');
      }

      imageController.files.clear();

      ScaffoldMessenger.of(Get.context!).showSnackBar(
        SnackBar(
          content: Text('Files uploaded successfully'),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 2),
        ),
      );

      Get.back(); // Navigate back to the previous screen
    } catch (e) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(
        SnackBar(
          content: Text('Error occurred: $e'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
        ),
      );
    } finally {
      setState(() {
        isUploading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Upload Files')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            if (isUploading) ...[
              CircularProgressIndicator(value: uploadProgress / 100),
              SizedBox(height: 16),
              Text('Uploading... ${uploadProgress.toStringAsFixed(2)}%'),
            ] else ...[
              ElevatedButton(
                onPressed: () {
                  imageController.getFiles();
                },
                child: Text('Select Files'),
              ),
              SizedBox(height: 16),
              if (imageController.files.isNotEmpty)
                Expanded(
                  child: ListView.builder(
                    itemCount: imageController.files.length,
                    itemBuilder: (context, index) {
                      File file = imageController.files[index];
                      return ListTile(
                        leading: Icon(Icons.insert_drive_file),
                        title: Text(basename(file.path)),
                      );
                    },
                  ),
                ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: imageController.files.isNotEmpty ? uploadFiles : null,
                child: isUploading
                    ? CircularProgressIndicator(value: uploadProgress / 100)
                    : Text('Upload Files'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
