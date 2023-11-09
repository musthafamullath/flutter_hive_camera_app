import 'dart:io';

import 'package:camera/displayimage.dart';
import 'package:camera/editscreen.dart';
import 'package:camera/model/camera.dart';
import 'package:camera/takephoto.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ImageGallery extends StatefulWidget {
  const ImageGallery({super.key});

  @override
  State<ImageGallery> createState() => _ImageGalleryState();
}

class _ImageGalleryState extends State<ImageGallery> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gallery'),
      ),
      body: SafeArea(
        child: ValueListenableBuilder(
          valueListenable: Hive.box<Camera>('camera').listenable(),
          builder: (context, Box<Camera> box, _) {
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemCount: box.length,
              itemBuilder: (ctx, index) {
                final camera = box.getAt(index) as Camera;
                return Padding(
                  padding: const EdgeInsets.all(6),
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (ctx) => DisplayImage(
                            title: camera.title,
                            description: camera.description,
                            imageUrl: camera.imageUrl,
                          ),
                        ),
                      );
                    },
                    child: Stack(
                      children: [
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.white10,
                                  style: BorderStyle.solid,
                                  width: 5),
                              borderRadius: BorderRadius.circular(10)),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.file(
                              File(
                                camera.imageUrl.toString(),
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              IconButton(
                                onPressed: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => EditScreen(
                                        titles: camera.title!,
                                        decorations: camera.description!,
                                        imageUrls: camera.imageUrl!,
                                        index: index,
                                      ),
                                    ),
                                  );
                                },
                                icon: Container(
                                    height: 32,
                                    width: 32,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16),
                                      color: Colors.white.withOpacity(.8),
                                    ),
                                    child: const Icon(
                                      Icons.edit,
                                      color: Colors.blueAccent,
                                    )),
                              ),
                              IconButton(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    useSafeArea: true,
                                    builder: (context) => AlertDialog(
                                      scrollable: true,
                                      title: const Text('Delete !'),
                                      content:
                                          const Text('Do you want delete it ?'),
                                      actions: [
                                        ElevatedButton(
                                          onPressed: () {
                                            box.deleteAt(index);
                                            Navigator.pop(context);
                                          },
                                          child: const Text('Delete'),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: const Text('Return'),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                                icon: Container(
                                    height: 32,
                                    width: 32,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16),
                                      color: Colors.white.withOpacity(.8),
                                    ),
                                    child: const Icon(
                                      Icons.delete,
                                      color: Colors.redAccent,
                                    )),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (ctx) => const TakePhoto(),
              ),
            );
          },
          label: const Text('Add photo')),
    );
  }
}
