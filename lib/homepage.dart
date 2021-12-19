// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:cloudstorage/helper/storage_helper.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  var results;
  Storage storage = Storage();

  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () async {
                  results = await FilePicker.platform.pickFiles(
                    type: FileType.custom,
                    allowedExtensions: ['pdf', 'jpeg', 'png', 'jpg'],
                  );
                  setState(() {
                    results = results;
                  });
                  if (results == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("No file sleevted"),
                      ),
                    );
                    return null;
                  }
                  final pathname = results.files.single.path;
                  final filename = results.files.single.name;
                  storage.uploadFile(pathname, filename);
                },
                child: Text("Upload File")),
            if (results != null)
              Container(
                child: Image.file(
                  File(results.files.single.path),
                ),
              )
          ],
        ),
      ),
    );
  }
}
