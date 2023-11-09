import 'package:camera/model/camera.dart';
import 'package:flutter/material.dart';
import 'dart:io';

import 'package:hive_flutter/hive_flutter.dart';

class DisplayImage extends StatelessWidget {
 
  final String? title;
  final String? description;
  final String? imageUrl;
  const DisplayImage({
    super.key,
    
    required this.title,
    required this.description,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: SafeArea(
          child: ValueListenableBuilder(
              valueListenable: Hive.box<Camera>('camera').listenable(),
              builder: (context, Box<Camera> box, _) {
                return ListView.builder(
                    itemCount: 1,
                    itemBuilder: (ctx, i) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children:[
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20, right:170),
                                  child: Column(
                                    children: [
                                      Text(
                                        title.toString(),
                                      ),
                                      Text(
                                        description.toString(),
                                        style: const TextStyle(fontSize: 30),
                                      ),
                                    ],
                                  ),
                                ),
  
                              ],
                            ),
                            
                            const SizedBox(
                              height: 50,
                            ),
                            Image.file(
                              File(imageUrl!),
                            ),
                          ],
                        ),
                      );
                    });
              }),
        ));
  }
}
