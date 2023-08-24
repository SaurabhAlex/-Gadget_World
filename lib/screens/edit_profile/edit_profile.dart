import 'dart:io';

import 'package:flutter/material.dart';
import 'package:grocery_app/constants/constants.dart';
import 'package:grocery_app/firebase_helper/firebase_storage/firebase_storage.dart';
import 'package:grocery_app/model/user_model/user_model.dart';
import 'package:grocery_app/widgets/primary_button/primary_button.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../../provider/app_provider.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {

  final _picker = ImagePicker();
  File? image;

  Future takePicture() async{
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery, imageQuality: 80, );

    if(pickedFile!= null){
      image = File(pickedFile.path);
      setState(() {
      });
    }else{
      print("No image selected");
    }
  }
  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    AppProvider appProvider = Provider.of<AppProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title:const Text("Edit Profile",style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            image == null ?
            InkWell(
              onTap: () {
                takePicture();
              },
              child: const CircleAvatar(
                  radius: 80,
                  child:
                  Icon(Icons.camera_alt_outlined, size: 35,)
              ),
            ):
            InkWell(
              onTap: () {
                takePicture();
              },
              child: CircleAvatar(
                radius: 120,
                backgroundImage: FileImage(image!),
              ),
            ),
            const SizedBox(height: 20,),
            TextFormField(
              controller: nameController,
              decoration: InputDecoration(
                hintText: appProvider.getUserInformation.name,
              ),
            ),
            const SizedBox(height: 20,),
            PrimaryButton(
              title: "Update",
              onPressed: () async{
                // String imageUrl = await FirebaseStorageHelper.instance.uploadUserImage(image!);
                UserModel userModel = appProvider.getUserInformation.copyWith(name: nameController.text);
                appProvider.updateUserInfoFirebase(context, userModel, image);
              },
            )
          ],
        ),
      ),
    );
  }
}
