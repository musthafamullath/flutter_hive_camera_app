import 'package:camera/model/camera.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

class EditScreen extends StatefulWidget {
  const EditScreen({
    super.key,
    required this.titles,
    required this.decorations,
    required this.imageUrls,
    required this.index,
  });
  final String titles;
  final String decorations;
  final String imageUrls;
  final int index;

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  final TextEditingController _titles = TextEditingController();
  final TextEditingController _descriptions = TextEditingController();
  final TextEditingController _imgeUrlController = TextEditingController();

  @override
  void initState() {
    _titles.text = widget.titles;
    _descriptions.text = widget.decorations;
    _imgeUrlController.text = widget.imageUrls;
    super.initState();
  }

  @override
  void dispose() {
    _titles.dispose();
    _descriptions.dispose();
    _imgeUrlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Details'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: _titles,
                decoration: InputDecoration(
                  labelText: 'title',
                  hintText: widget.titles,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: _descriptions,
                decoration: InputDecoration(
                  labelText: 'description',
                  hintText: widget.decorations,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  final value = Camera(
                    title: _titles.text,
                    description: _descriptions.text,
                    imageUrl: _imgeUrlController.text, 
                  ); 
                   Hive.box<Camera>('camera').putAt(widget.index, value);
                   Navigator.of(context).pop();
                },
                child: const Text('Update'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
