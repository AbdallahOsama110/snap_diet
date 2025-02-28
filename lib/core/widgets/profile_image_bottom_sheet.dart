import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfileImageBottomSheet extends StatelessWidget {
  const ProfileImageBottomSheet({super.key, required this.takePhoto});
  final Function(ImageSource imageSource) takePhoto;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        children: [
          Text(
            'Choose profile photo',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton.icon(
                onPressed: () async {
                  takePhoto(ImageSource.camera);
                  Navigator.of(context).pop();
                },
                icon: Icon(
                  Icons.camera,
                  size: 25,
                ),
                label: Text('Camera'),
              ),
              TextButton.icon(
                onPressed: () async {
                  takePhoto(ImageSource.gallery);
                  Navigator.of(context).pop();
                },
                icon: Icon(
                  Icons.image,
                  size: 25,
                ),
                label: Text('Gallery'),
              ),
            ],
          )
        ],
      ),
    );
  }
}
