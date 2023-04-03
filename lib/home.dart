import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_tesseract_ocr/flutter_tesseract_ocr.dart';
import 'dart:io';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _ocrText = '';
  String path = "";
  bool converted = false;

  bool bDownloadtessFile = false;
  void runFilePiker() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      _ocr(pickedFile.path);
    }
  }

  void _ocr(url) async {
    path = url;
    converted = true;
    setState(() {});

    _ocrText =
        await FlutterTesseractOcr.extractText(url, language: "eng", args: {
      "preserve_interword_spaces": "1",
    });
    converted = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ectract text from image"),
      ),
      body: Padding(
          padding: const EdgeInsets.all(20),
          child: ListView(
            children: [
              path.isEmpty ? Container() : Image.file(File(path)),
              const SizedBox(height: 20),
              converted
                  ? Column(children: const [CircularProgressIndicator()])
                  : Text(
                      _ocrText,
                    ),
            ],
          )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          runFilePiker();
        },
        tooltip: 'File picker',
        child: const Icon(Icons.add),
      ),
    );
  }
}
