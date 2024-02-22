import 'dart:io';

import 'package:elarise/feature_account_setting/presentation/account_setting/setting_state_notifier.dart';
import 'package:elarise/feature_account_setting/presentation/account_setting/widget/elarise_edit_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/domain/entities/user_preferences.dart';
import '../../../di/repositories/user_datastore_repository/user_datastore_repository_provider.dart';
import '../../../router/router_provider.dart';
import '../../../theme/colors.dart';
import '../../../theme/style.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileScreen extends ConsumerStatefulWidget {
  const EditProfileScreen({super.key});

  @override
  ConsumerState<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends ConsumerState<EditProfileScreen> {
  late TextEditingController nameController;
  late TextEditingController emailController;
  XFile? xfile;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    emailController = TextEditingController();
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<UserPreferences?>(
      future: ref.read(userDatastoreRepositoryProvider).getUser(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasData && snapshot.data?.token != null) {
          if (nameController.text.isEmpty) {
            final userName = snapshot.data!.name ?? "User";
            nameController.text = userName;
          }

          if (emailController.text.isEmpty) {
            final userEmail = snapshot.data!.email ?? "user@mail.com";
            emailController.text = userEmail;
          }
          return editProfileScreenContent(context, ref, snapshot.data!);
        } else {
          // No valid session, redirect to SignInScreen
          WidgetsBinding.instance.addPostFrameCallback((_) {
            ref.read(routerProvider).goNamed('login');
          });
          return const SizedBox
              .shrink(); // Return an empty widget or a loading indicator as needed
        }
      },
    );
  }

  Widget editProfileScreenContent(
      BuildContext context, WidgetRef ref, UserPreferences userPreferences) {
    final photoUrl = userPreferences.photoProfile ??
        "https://firebasestorage.googleapis.com/v0/b/conversation-app-e3566.appspot.com/o/profileImage%2Fuser_placeholder.png?alt=media&token=b59b54f9-84c0-47e0-a900-60bfa9b05ae9";

    ImageProvider imageProvider;
    if (xfile != null) {
      // If an image is selected, use it
      imageProvider = FileImage(File(xfile!.path));
    } else {
      // Otherwise, use the default network image
      imageProvider = NetworkImage(photoUrl);
    }

    Widget appBar() {
      return AppBar(
        backgroundColor: neutralOneAlt,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_rounded, color: neutralFour),
          onPressed: () {
            ref.read(routerProvider).goNamed('setting');
          },
        ),
        title: Text("Edit Profile",
            style: getSansFranciscoSemiBold20(color: neutralFour)),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: ElevatedButton(
              onPressed: () {
                // Add your save functionality here
                if (_formKey.currentState!.validate()) {
                  ref.read(settingStateNotifierProvider.notifier).updateProfile(
                        name: nameController.text,
                        photoPath: xfile != null ? File(xfile!.path) : null,
                      );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: primary, // Your primary color
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(20), // Adjust for rounded corners
                ),
                padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 6), // Adjust padding to control the button size
                minimumSize: const Size(0, 0), // Set minimum size to zero
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: Text(
                "Save",
                style: getSansFranciscoBold16(
                    color: neutralFour), // Your text style
              ),
            ),
          )
        ],
      );
    }

    Widget profileField() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Profile Image",
              style: getSansFranciscoMedium16(color: neutralFour)),
          const SizedBox(height: 10),
          Row(
            children: [
              Column(
                children: [
                  GestureDetector(
                    onTap: () async {
                      // Use ImagePicker to let the user select an image
                      XFile? selectedFile = await ImagePicker()
                          .pickImage(source: ImageSource.gallery);

                      // If an image is selected, update the state with the new image
                      if (selectedFile != null) {
                        setState(() {
                          xfile = selectedFile;
                        });
                      }
                    },
                    child: Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                          ),
                        )),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Add a pic",
                    style: getSansFranciscoRegular14(color: neutralFour),
                  ),
                ],
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 46.0),
                  child: Text(
                    "Put your best pic! It's your time to shine and show the world who you are.",
                    style: getSansFranciscoRegular14(color: neutralFour),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 32),
          ElariseEditTextField(
            labelText: "Name",
            controller: nameController,
            isEnabled: true,
          ),
          const SizedBox(height: 40),
          ElariseEditTextField(
            labelText: "Email",
            controller: emailController,
            isEnabled: false,
          ),
        ],
      );
    }

    return Scaffold(
        backgroundColor: neutralOneAlt,
        body: Column(
          children: [
            appBar(),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    profileField(),
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
