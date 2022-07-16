import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class DemoClass extends StatefulWidget {
  @override
  _DemoClassState createState() => _DemoClassState();
}

class _DemoClassState extends State<DemoClass> {
  late var pickedImage = null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Demo"),
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.all(29),
            child: Center(
              //button to open camera or gallery
              child: ElevatedButton(
                onPressed: () => {openDialog(context)},
                child: Text("Picture Take"),
              ),
            ),
          ),

          //to show the selected image
          Container(
              child: pickedImage != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.file(
                        pickedImage,
                        width: 100,
                        height: 100,
                        fit: BoxFit.fitHeight,
                      ),
                    )
                  : null),
        ],
      ),
    );
  }

  //show a dialog to open camera or from gallary
  void openDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: Column(
                children: [
                  ListTile(
                    title: Text("Open Camera"),
                    onTap: () {
                      OpenPicker(ImageSource.camera);
                    },
                  ),
                  ListTile(
                    title: Text("Take From Gallery"),
                    onTap: () {
                      OpenPicker(ImageSource.gallery);
                    },
                  ),
                ],
              ),
            ));
  }

  //open picker after selectiong option
  OpenPicker(ImageSource source) async {
    pickedImage = (await ImagePicker.pickImage(source: source)) as File;
    String base64String = base64Encode(pickedImage.readAsBytesSync());
    print(base64String);
    Navigator.pop(context);
    setState(() {

    });
  }

//image cropper method

}
