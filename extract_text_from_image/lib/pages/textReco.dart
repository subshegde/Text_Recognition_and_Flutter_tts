import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_tts/flutter_tts.dart';


class TextRecognitionScreen extends StatefulWidget {
  @override
  _TextRecognitionScreenState createState() => _TextRecognitionScreenState();
}

class _TextRecognitionScreenState extends State<TextRecognitionScreen> {
  final FlutterTts flutterTts = FlutterTts();
  String _recognizedText = '';
  int _textIndex = 0; 
  bool isWriting = false;

  String selectedLanguageCode = 'en-US';
  String selectedLanguageName = 'English (US)';

    final List<Map<String, String>> languages = [
    {'name': 'English (US)', 'code': 'en-US'},
    {'name': 'English (UK)', 'code': 'en-GB'},
    {'name': 'Spanish', 'code': 'es-ES'},
    {'name': 'French', 'code': 'fr-FR'},
    {'name': 'German', 'code': 'de-DE'},
    {'name': 'Italian', 'code': 'it-IT'},
    {'name': 'Portuguese (Brazil)', 'code': 'pt-BR'},
    {'name': 'Hindi', 'code': 'hi-IN'},
    {'name': 'Arabic', 'code': 'ar-SA'},
    {'name': 'Chinese (Mandarin)', 'code': 'zh-CN'},
    {'name': 'Japanese', 'code': 'ja-JP'},
    {'name': 'Korean', 'code': 'ko-KR'},
    {'name': 'Russian', 'code': 'ru-RU'},
    {'name': 'Kannada', 'code': 'kn-IN'},
  ];

  Future<void> pickAndExtractText() async {
    _recognizedText = '';
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final inputImage = InputImage.fromFilePath(pickedFile.path);
      final textRecognizer = GoogleMlKit.vision.textRecognizer();
      final RecognizedText recognizedText = await textRecognizer.processImage(inputImage);
      startTypingEffect(recognizedText.text);
    }
  }

  void startTypingEffect(String text) {
    Timer.periodic(const Duration(milliseconds: 10), (timer) {
      if (_textIndex < text.length) {
        setState(() {
          isWriting = true;
          _recognizedText += text[_textIndex];
          _textIndex++;
        });
      } else {
        timer.cancel();
        isWriting = false;
      }
    });
  }

  Future<void> speak(String text) async {
    await flutterTts.setLanguage(selectedLanguageCode);
    await flutterTts.setPitch(1); // 0.5 to 1.5
    await flutterTts.speak(text);
  }

  // Future pickPDFText() async {
  //   var filePickerResult = await FilePicker.platform.pickFiles();
  //   if (filePickerResult != null) {
  //     _pdfDoc = await PDFDoc.fromPath(filePickerResult.files.single.path!);
  //     setState(() {});
  //     _readRandomPage(_pdfDoc);
  //   }
  // }

  //  Future _readRandomPage(PDFDoc? _pdfDocReceived) async {
  //   if (_pdfDocReceived == null) {
  //     return;
  //   }
  //   setState(() {
  //     _buttonsEnabled = false;
  //   });

  //   String text =
  //       await _pdfDocReceived!.pageAt(Random().nextInt(_pdfDocReceived!.length) + 1).text;

  //   setState(() {
  //     _recognizedText = text;
  //     _buttonsEnabled = true;
  //   });
  // }

  // /// Reads the whole document
  // Future _readWholeDoc() async {
  //   if (_pdfDoc == null) {
  //     return;
  //   }
  //   setState(() {
  //     _buttonsEnabled = false;
  //   });

  //   String text = await _pdfDoc!.text;

  //   setState(() {
  //     _recognizedText = text;
  //     _buttonsEnabled = true;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        foregroundColor: Colors.grey[200],
        leading: const Icon(Icons.arrow_back),
        title: Text(
          'Text Recognition',
          style: TextStyle(color: Colors.grey[200]),
        ),
        backgroundColor: Colors.grey[850],
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    backgroundColor: Colors.black,
                    title: const Text(
                      'About Text Recognition',
                      style: TextStyle(color: Colors.white),
                    ),
                    content: const Text(
                      'This app uses Google ML Kit to recognize text from images. Simply select an image from your gallery and the recognized text will be displayed below.',
                      style: TextStyle(color: Colors.white),
                    ),
                    actions: <Widget>[
                      Container(
                        height: 35,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green[800],
                            padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text(
                            "Close",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.01),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.only(left: 6, right: 6, bottom: 6, top: 6),
                decoration: BoxDecoration(
                  color: Colors.grey[850],
                  borderRadius: const BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          height: 30,
                          width: 50,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green[800],
                              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                            onPressed:pickAndExtractText,
                            // child: Image.asset('assets/images/image.png',color: Colors.grey[500],)
                            child: const Text(
                              "Pick",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.only(left: 12.0, right: 12.0, top: 12.0),
                        decoration: BoxDecoration(
                          color: Colors.grey[850],
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black45,
                              blurRadius: 5,
                              offset: Offset(2, 2),
                            ),
                          ],
                        ),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _recognizedText.isEmpty ? '' : _recognizedText,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontStyle: FontStyle.normal,
                                ),
                                textAlign: TextAlign.justify,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 6, right: 4, bottom: 0),
                      decoration: BoxDecoration(
                        color: Colors.grey[850],
                        borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
                      ),
                      child: Column(
                        children: [
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                margin: const EdgeInsets.only(bottom: 6),
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                  color: Colors.grey[850],
                                  borderRadius: BorderRadius.circular(12),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Colors.black45,
                                      blurRadius: 4,
                                      offset: Offset(2, 2),
                                    ),
                                  ],
                                ),
                                child: ElevatedButton(
                                  onPressed: () {
                                    if(_recognizedText.isNotEmpty && !isWriting){
                                      speak(_recognizedText);
                                    }else if(isWriting){
                                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(backgroundColor: Colors.grey,content: Text('Please wait while writing!',style: TextStyle(color: Colors.black),)));
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.transparent,
                                    shadowColor: Colors.transparent,
                                    padding: EdgeInsets.zero,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  child: Image.asset(
                                    'assets/images/speaking.png',
                                    height: 20,
                                    width: 20,
                                    color: Colors.grey[500],
                                  ),
                                ),
                              ),
                              const SizedBox(width: 20),
                             Container(
                                  height: 30,
                                  padding: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                      color: Colors.grey[600]!,
                                      width: 1,
                                    ),
                                  ),
                                  child: DropdownButton<String>(
                                    iconEnabledColor: Colors.grey[500],
                                    value: selectedLanguageCode,
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        selectedLanguageCode = newValue!;
                                        selectedLanguageName = languages
                                            .firstWhere((language) => language['code'] == selectedLanguageCode)['name']!;
                                      });
                                    },
                                    menuMaxHeight: 300,
                                    dropdownColor: Colors.black,
                                    style: TextStyle(color: Colors.grey[300]),
                                    underline: const SizedBox.shrink(),
                                    items: languages
                                        .map<DropdownMenuItem<String>>((Map<String, String> language) {
                                      return DropdownMenuItem<String>(
                                        value: language['code'],
                                        child: Text(
                                          language['name']!,
                                          style: TextStyle(color: Colors.grey[300]),
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                )
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
      persistentFooterButtons: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/youtube.png', height: 20, width: 20),
            const SizedBox(width: 4),
            Row(children: [
              Text(
                'Developed by ',
                style: TextStyle(color: Colors.grey[700], fontSize: 12),
              ),
              Text(
                '@SSHegde.Visuals',
                style: TextStyle(color: Colors.grey[600], fontSize: 12),
              )
            ]),
          ],
        )
      ],
    );
  }
}