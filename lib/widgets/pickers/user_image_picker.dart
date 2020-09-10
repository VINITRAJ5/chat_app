
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {
  UserImagePicker(this.imagePickFn);
  
  final void Function(File pickedimage) imagePickFn;
  @override
  _UserImagePickerState createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
 File _pickedimage;
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.getImage(
      source: ImageSource.camera,
      imageQuality: 50,
      maxWidth: 150,
      );

    setState(() {
      _pickedimage = File(pickedFile.path);
    });
    widget.imagePickFn (_pickedimage);
  }
 
  @override
  Widget build(BuildContext context) {
    return Column(
      children:<Widget> 
      [
       CircleAvatar(
         radius: 50,
         backgroundColor: Color.fromRGBO(55, 55, 55, 40),
         backgroundImage: _pickedimage != null ? FileImage(_pickedimage) : null,
              ),
              FlatButton.icon(
                textColor: Theme.of(context).primaryColor,
                onPressed: getImage,
                icon: Icon(Icons.image),
                label: Text('Add Image'),
                ), 
      ],
    );
  }
}