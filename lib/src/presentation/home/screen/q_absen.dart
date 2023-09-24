import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:new_attandance/src/presentation/home/widget/q_alert_failed.dart';

class QAbsen extends StatefulWidget {
  final double latitude;
  final double longitude;
  final String deviceName;

  const QAbsen({
    super.key,
    required this.latitude,
    required this.longitude,
    required this.deviceName,
  });

  @override
  _QAbsenState createState() => _QAbsenState();
}

class _QAbsenState extends State<QAbsen> {
  File? _image;
  String locationImage = "";

  Future _getImageFromGallery() async {
    final imagePicker = ImagePicker();
    final pickedImage = await imagePicker.pickImage(
      source: ImageSource.camera,
    );

    setState(() {
      if (pickedImage != null) {
        _image = File(pickedImage.path);
      } else {}
      locationImage = pickedImage!.path;
    });
  }

  @override
  void initState() {
    super.initState();
    _getImageFromGallery();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Take Image Attandance'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            const SizedBox(
              height: 30.0,
            ),
            _image == null
                ? Container(
                    height: 160.0,
                    width: 160.0,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                            "https://i.ibb.co/S32HNjD/no-image.jpg"),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(
                          8.0,
                        ),
                      ),
                    ),
                  )
                : Image.file(
                    _image!,
                    height: 500,
                  ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _getImageFromGallery,
                  child: const Text('Select Image'),
                ),
                Visibility(
                  visible: _image != null,
                  child: const SizedBox(
                    width: 30.0,
                  ),
                ),
                Visibility(
                  visible: _image != null,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_image == null) {
                        await showDialog<void>(
                          context: context,
                          barrierDismissible: true,
                          builder: (BuildContext context) {
                            return const QAlertFailed(
                                title: "Tolong Pilih Image Terlebih Dahulu");
                          },
                        );
                      } else {
                        // await context.read<AttandanceCubit>().checkIn(
                        //     device: widget.deviceName,
                        //     filePath: locationImage,
                        //     latitude: widget.latitude,
                        //     longitude: widget.longitude);

                        Navigator.of(context).pop();
                      }
                    },
                    child: const Text('Absen'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
