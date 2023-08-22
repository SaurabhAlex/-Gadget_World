
import 'package:flutter/material.dart';
import 'package:grocery_app/widgets/primary_button/primary_button.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../provider/app_provider.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {

  // void takePicture() async{
  //   File? image;
  //   XFile? value = await ImagePicker().pickImage(source: ImageSource.gallery);
  //   if(value !=null){
  //     setState(() {
  //       // image = File(value.path);
  //     });
  //   }
  // }
  @override
  Widget build(BuildContext context) {
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
            InkWell(
              onTap: () {
                // takePicture();
              },
              child: const CircleAvatar(
                radius: 50,
                child:
                // image == null ?
                Icon(Icons.camera_alt_outlined, size: 35,),
                // Image.file(image!)
              ),
            ),
            const SizedBox(height: 20,),
            TextFormField(
              decoration: InputDecoration(
                hintText: appProvider.getUserInformation.name,
              ),
            ),
            const SizedBox(height: 20,),
            PrimaryButton(
              title: "Update",
              onPressed: () {},
            )
          ],
        ),
      ),
    );
  }
}
