// ignore_for_file: invalid_use_of_visible_for_testing_member, curly_braces_in_flow_control_structures

import 'dart:io';
import 'package:camera/model/camera.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';

class TakePhoto extends StatefulWidget {
  const TakePhoto({super.key});

  @override
  State<TakePhoto> createState() => _TakePhotoState();
}

class _TakePhotoState extends State<TakePhoto> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titles = TextEditingController();
  final TextEditingController _descriptions = TextEditingController();


  XFile? _image;
  String? title;
  String? description;

  getImage() async {
    final image = await ImagePicker.platform
        .getImageFromSource(source: ImageSource.camera);

    setState(() {
      _image = image;
    });
  }

  submitData() async {
    if (_titles.text.isEmpty) {
      showTost(context, 'Pls enter title');
    } else if (_descriptions.text.isEmpty) {
      showTost(context, 'Pls enter description');
    } else {
      Hive.box<Camera>('camera').add(
        Camera(title: title, description: description, imageUrl: _image!.path, ),
      );
      Navigator.of(context).pop();
    }
  }

  showTost(context, message) {
    final snackBar = SnackBar(
      content: Text(message,style: const TextStyle(color: Colors.black),),
      backgroundColor: Colors.red,
      
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add a photo'),
        actions: [
          IconButton(onPressed: submitData, icon: const Icon(Icons.save)),
        ],
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, top: 10, bottom: 5),
                  child: TextFormField(
                    controller: _titles,
                    decoration: const InputDecoration(
                        label: Text('Title'), border: OutlineInputBorder()),
                    autocorrect: false,
                    onChanged: (val) {
                      setState(() {
                        title = val;
                      });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, top: 10, bottom: 5),
                  child: TextFormField(
                    controller: _descriptions,
                    decoration: const InputDecoration(
                        label: Text('Description'),
                        border: OutlineInputBorder()),
                    autocorrect: false,
                    onChanged: (val) {
                      setState(() {
                        description = val;
                      });
                    },
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                _image == null ? Container() : Image.file(File(_image!.path)),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: getImage,
        child: const Icon(Icons.camera),
      ),
    );
  }
}
