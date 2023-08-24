import 'package:flutter/material.dart';
import 'package:grocery_app/firebase_helper/firebase_auth_helper/auth_helper.dart';
import 'package:grocery_app/screens/change_password/change_password.dart';
import 'package:grocery_app/widgets/primary_button/primary_button.dart';
import 'package:provider/provider.dart';
import '../../constants/routes.dart';
import '../../provider/app_provider.dart';
import '../edit_profile/edit_profile.dart';
import '../favourite/favourite_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title:const Text("Profile Screen",style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            appProvider.getUserInformation.image==null ?
            const Icon(Icons.person, size: 120,):
            CircleAvatar(
              backgroundImage: NetworkImage(appProvider.getUserInformation.image!),
              radius: 70,
            ),
            appProvider.getUserInformation.name==null
            ? const Text("No data Found")
            : Text(
              appProvider.getUserInformation.name!
              , style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 30),),
            const SizedBox(height: 4,),
            Text(
              appProvider.getUserInformation.email!
              , style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 18),),
            const SizedBox(height: 4,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 125.0, vertical: 12),
              child: PrimaryButton(
                title: "Edit Profile",
                onPressed: () {
                  Routes.instance.push(const EditProfile(), context);
                },
              ),
            ),
            ListTile(
              onTap: () {},
              leading: const Icon(Icons.shopping_bag_outlined, size: 24),
              title: const Text("Your Orders", style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20)),
            ),
            ListTile(
              onTap: () {
                Routes.instance.push(const FavouriteScreen(), context);
              },
              leading: const Icon(Icons.favorite_border, size: 24),
              title: const Text("Favourite", style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20)),
            ),
            ListTile(
              onTap: () {},
              leading: const Icon(Icons.info_outlined, size: 24),
              title: const Text("About us", style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20)),
            ),
            ListTile(
              onTap: () {},
              leading: const Icon(Icons.support_outlined, size: 24),
              title: const Text("Support", style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20)),
            ),
            ListTile(
              onTap: () {
                Routes.instance.push(ChangePasswordSC(), context);
              },
              leading: const Icon(Icons.lock_open_rounded, size: 24),
              title: const Text("Change Password", style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20)),
            ),
            ListTile(
              onTap: () {
                FirebaseAuthHelper.instance.signOut();
                setState(() {

                });
              },
              leading: const Icon(Icons.logout_rounded, size: 24),
              title: const Text("logout", style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20)),
            ),
            const SizedBox(height: 14,),
            const Text("version 1.0.2", style: TextStyle(fontWeight: FontWeight.w400, fontSize: 18),),
          ],
        ),
      ),
    );
  }
}
