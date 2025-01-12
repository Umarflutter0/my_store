import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppUtils {
  static void changeStatusBarColor() {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    );
  }

  static void setPortrait() {
    changeStatusBarColor();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  // static Future<void> checkConnection({required BuildContext context}) async {
  //   final connectionList = await Connectivity().checkConnectivity();
  //   if (connectionList.contains(ConnectivityResult.none)) {
  //     context.go(RoutesName.connectivityScreen);
  //   } else {
  //     UserInfoService.checkUserStatus(context);
  //   }
  // }

  // void toastMessage(String message) {
  //   Fluttertoast.showToast(
  //       msg: message,
  //       toastLength: Toast.LENGTH_SHORT,
  //       gravity: ToastGravity.BOTTOM,
  //       timeInSecForIosWeb: 1,
  //       backgroundColor: AppColors.primaryColor,
  //       textColor: Colors.white,
  //       fontSize: 16.0);
  // }

  // String formatTimeH(String dateTimeString) {
  //   DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(int.tryParse(dateTimeString)!);
  //   String formattedTime = DateFormat('h:mm a').format(dateTime);
  //
  //   return formattedTime;
  // }
  //
  // static String getUid() {
  //   return FirebaseAuth.instance.currentUser?.uid ?? '';
  // }
  //
  // String formatTimeDMY(String timestamp) {
  //   DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(int.tryParse(timestamp)!);
  //   String formattedTime = DateFormat('MMM dd yyyy (EEE)').format(dateTime);
  //
  //   return formattedTime;
  // }
  //
  // Future<String?> showDatePick(BuildContext context) async {
  //   DateTime? pickedDate = await showDatePicker(
  //     context: context,
  //     initialDate: DateTime.now(),
  //     firstDate: DateTime(2000),
  //     lastDate: DateTime(2101),
  //     builder: (BuildContext context, Widget? child) {
  //       return Theme(
  //         data: ThemeData.light().copyWith(
  //           primaryColor: AppColors.primaryColor,
  //           colorScheme: const ColorScheme.light(
  //             primary: AppColors.primaryColor,
  //             onPrimary: Colors.white,
  //             onSurface: Colors.black,
  //           ),
  //           dialogBackgroundColor: Colors.white,
  //           textButtonTheme: TextButtonThemeData(
  //             style: TextButton.styleFrom(
  //               foregroundColor: AppColors.primaryColor,
  //             ),
  //           ),
  //         ),
  //         child: child!,
  //       );
  //     },
  //   );
  //
  //   if (pickedDate != null) {
  //     // Format the picked date
  //     String formattedDate = DateFormat('d MMMM, y').format(pickedDate);
  //     return formattedDate;
  //   }
  //   return null; // In case the user cancels the date picker
  // }
  //
  // void saveNotification({
  //   required String title,
  //   required String body,
  //   String? uid,
  // }) async {
  //   final userUID = FirebaseAuth.instance.currentUser?.uid.toString();
  //   final createdAt = DateTime.now().toString();
  //   await FirebaseFirestore.instance.collection("users").doc(uid ?? userUID).collection('notifications').add({
  //     'title': title,
  //     'body': body,
  //     'createdAt': createdAt,
  //     'isRead': false,
  //   });
  // }
  //
  // Map<String, String> getFirstAndLastName(String fullName) {
  //   final lastSpaceIndex = fullName.lastIndexOf(' ');
  //
  //   if (lastSpaceIndex == -1) {
  //     // If there is no space, treat the fullName as the first name
  //     return {'firstName': fullName, 'lastName': ''};
  //   }
  //
  //   final firstName = fullName.substring(0, lastSpaceIndex).trim();
  //   final lastName = fullName.substring(lastSpaceIndex + 1).trim();
  //
  //   return {'firstName': firstName, 'lastName': lastName};
  // }
  //
  // Future<void> pickImage(GeneralProvider imageProvider) async {
  //   final ImagePicker picker = ImagePicker();
  //   final XFile? image = await picker.pickImage(source: ImageSource.gallery);
  //
  //   if (image != null) {
  //     imageProvider.updateImage(image.path, File(image.path));
  //   }
  // }

  // void toastMessage(String message) {
  //   Fluttertoast.showToast(
  //       msg: message,
  //       toastLength: Toast.LENGTH_SHORT,
  //       gravity: ToastGravity.BOTTOM,
  //       timeInSecForIosWeb: 1,
  //       backgroundColor: AppColors.primaryColor,
  //       textColor: Colors.white,
  //       fontSize: 16.0);
  // }

  // void setFirstLastName(userName, EditProfileProvider editProfile) {
  //   List<String> nameParts = userName.split(" ");
  //   String fName = nameParts[0];
  //   String lastName =
  //       nameParts.length > 1 ? nameParts.sublist(1).join(" ") : "";
  //   editProfile.fNameController.text = fName;
  //   editProfile.lNameController.text = lastName;
  // }

  // DateTime parseTimestamp(String timestamp) {
  //   try {
  //     return DateTime.fromMillisecondsSinceEpoch(timestamp as int);
  //   } catch (e) {
  //     if (kDebugMode) {
  //       print("Invalid timestamp: $e");
  //     }
  //     return DateTime.now(); // Fallback to current date if invalid
  //   }
  // }

  // String capitalizeEachWord(String input) {
  //   if (input.isEmpty) {
  //     return input; // Return the original input if it's empty
  //   }
  //
  //   // Split the input into words, capitalize the first letter of each word,
  //   // and join them back together with spaces
  //   return input
  //       .split(' ')
  //       .map((word) => word.isNotEmpty ? word[0].toUpperCase() + word.substring(1).toLowerCase() : '')
  //       .join(' ');
  // }

  // String convertTime(int timestamp) {
  //   final DateTime now = DateTime.now();
  //   final DateTime date = DateTime.fromMillisecondsSinceEpoch(timestamp);
  //   final Duration diff = now.difference(date);
  //
  //   if (diff.inSeconds < 60) {
  //     return 'just now';
  //   } else if (diff.inMinutes < 60) {
  //     return '${diff.inMinutes} minute${diff.inMinutes == 1 ? '' : 's'} ago';
  //   } else if (diff.inHours < 24) {
  //     return '${diff.inHours} hour${diff.inHours == 1 ? '' : 's'} ago';
  //   } else if (diff.inDays == 1) {
  //     return 'yesterday';
  //   } else if (diff.inDays < 7) {
  //     return '${diff.inDays} day${diff.inDays == 1 ? '' : 's'} ago';
  //   } else if (diff.inDays < 30) {
  //     return '${(diff.inDays / 7).floor()} week${(diff.inDays / 7).floor() == 1 ? '' : 's'} ago';
  //   } else if (diff.inDays < 365) {
  //     return '${(diff.inDays / 30).floor()} month${(diff.inDays / 30).floor() == 1 ? '' : 's'} ago';
  //   } else {
  //     return '${(diff.inDays / 365).floor()} year${(diff.inDays / 365).floor() == 1 ? '' : 's'} ago';
  //   }
  // }

  // void scrollToBottom(ScrollController scrollC, {int extraHeight = 80}) {
  //   scrollC.animateTo(
  //     scrollC.position.maxScrollExtent + extraHeight,
  //     duration: const Duration(milliseconds: 300),
  //     curve: Curves.easeOut,
  //   );
  // }
  //
  // void scrollToTop(ScrollController scrollC) {
  //   scrollC.animateTo(
  //     scrollC.position.minScrollExtent,
  //     duration: const Duration(milliseconds: 300),
  //     curve: Curves.easeOut,
  //   );
  // }

  // static String sanitizeName(String name) {
  //   // Replace all occurrences of 'none' with an empty string, ignoring case
  //   return name.replaceAll(RegExp(r'\bnone\b', caseSensitive: false), '').trim();
  // }

  static Color getColorWithOpacity(
      {required Color color, required double opacity}) {
    return color.withAlpha((opacity * 255).toInt());
  }
}
