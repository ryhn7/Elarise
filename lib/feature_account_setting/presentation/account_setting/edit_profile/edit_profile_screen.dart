import 'dart:io';

import 'package:elarise/feature_account_setting/presentation/account_setting/edit_profile/edit_profile_state_notifier.dart';
import 'package:elarise/feature_account_setting/presentation/account_setting/widget/elarise_edit_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/domain/entities/user_preferences.dart';
import '../../../../router/router_provider.dart';
import '../../../../theme/colors.dart';
import '../../../../theme/style.dart';

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
    final editProfileState = ref.watch(editProfileStateNotifierProvider);

    if (editProfileState.isLoading) {
      return editProfileScreenContent(
          context, ref, null, editProfileState.isLoading);
    } else if (editProfileState.userPreferences != null &&
        editProfileState.userPreferences!.token != null) {
      if (nameController.text.isEmpty) {
        final userName = editProfileState.userPreferences!.name ?? "User";
        nameController.text = userName;
      }

      if (emailController.text.isEmpty) {
        final userEmail =
            editProfileState.userPreferences!.email ?? "user@mail.com";
        emailController.text = userEmail;
      }
      return editProfileScreenContent(
          context, ref, editProfileState.userPreferences!);
    } else {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref.read(routerProvider).goNamed('login');
      });
      return const SizedBox.shrink();
    }
  }

  Widget editProfileScreenContent(
      BuildContext context, WidgetRef ref, UserPreferences? userPreferences,
      [bool isLoading = false]) {
    final photoUrl = userPreferences?.photoProfile ??
        "https://firebasestorage.googleapis.com/v0/b/conversation-app-e3566.appspot.com/o/profileImage%2Fuser_placeholder.png?alt=media&token=b59b54f9-84c0-47e0-a900-60bfa9b05ae9";

    ImageProvider imageProvider;
    if (xfile != null) {
      // If an image is selected, use it
      imageProvider = FileImage(File(xfile!.path));
    } else if (userPreferences?.photoProfile != null &&
        userPreferences!.photoProfile!.isNotEmpty) {
      // Use existing profile photo if available and no new photo has been selected
      imageProvider = NetworkImage(userPreferences.photoProfile!);
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
              onPressed: () async {
                // Add your save functionality here
                if (_formKey.currentState!.validate()) {
                  ref
                      .read(editProfileStateNotifierProvider.notifier)
                      .updateProfile(
                        name: nameController.text,
                        photoPath: xfile != null ? File(xfile!.path) : null,
                      );

                  // After updateProfile completes, check the state for errors
                  final currentState =
                      ref.read(editProfileStateNotifierProvider);

                  if (currentState.error == null) {
                    // No error in the state, indicating success
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text('Update Successful',
                            style:
                                getSansFranciscoSemiBold16(color: neutralFour)),
                        content: Text('Profile updated successfully.',
                            style:
                                getSansFranciscoRegular14(color: neutralFour)),
                        actions: <Widget>[
                          TextButton(
                              onPressed: () {
                                ref.read(routerProvider).goNamed('setting');
                              },
                              child: Text('OKAY',
                                  style: getSansFranciscoSemiBold14(
                                      color: primary))),
                        ],
                      ),
                    );
                  } else {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text('Update Failed',
                            style:
                                getSansFranciscoSemiBold16(color: neutralFour)),
                        content: Text('Failed to update profile.',
                            style:
                                getSansFranciscoRegular14(color: neutralFour)),
                        actions: <Widget>[
                          TextButton(
                              onPressed: () {
                                ref.read(routerProvider).goNamed('setting');
                              },
                              child: Text('OKAY',
                                  style: getSansFranciscoSemiBold14(
                                      color: primary))),
                        ],
                      ),
                    );
                  }
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
              child: isLoading
                  ? SizedBox(
                      width: 28, // Adjust the size to fit your design
                      height: 28, // Adjust the size to fit your design
                      child: CircularProgressIndicator(
                        strokeWidth: 2, // Makes the spinner thinner
                        valueColor: AlwaysStoppedAnimation<Color>(neutralFour),
                      ),
                    )
                  : Text(
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
