import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:aws_s3_api/s3-2006-03-01.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:peckme/view/widget/terms_conditions_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../handler/EncryptionHandler.dart';
import '../utils/app_constant.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late String? uid = '';

  //String rolename = '';
  String branchName = '';
  String authId = '';
  late String? profile = '';

  //late String? company_name = '';

  //String address = '';

  void loadUserData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      name = prefs.getString('name') ?? '';
      mobile = prefs.getString('mobile') ?? '';
      uid = prefs.getString('uid') ?? '';
      rolename = prefs.getString('rolename') ?? '';
      branchName = prefs.getString('branch_name') ?? '';
      company_name = prefs.getString('company_name') ?? '';
      authId = prefs.getString('authId') ?? '';
      profile = prefs.getString('image') ?? '';
      address = prefs.getString('address') ?? '';
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadUserData();
    print("-----");
    print(profile);
    print(company_name);
  }

  String formatRoleName(String text) {
    text = text.toLowerCase();

    // "fieldexecutive" ko "field executive" me convert
    text = text.replaceAll("fieldexecutive", "field executive");
    text = text.replaceAll("childexecutive", "child executive");
    // Har word ka pehla letter capital
    return text
        .split(' ')
        .map((word) {
          if (word.isEmpty) return "";
          return word[0].toUpperCase() + word.substring(1);
        })
        .join(' ');
  }

  late String? name = '';

  late String? mobile = '';
  late String? company_name = '';

  late String? rolename = '';

  final String company = '';

  final String subCompany =
      "Fulfillment Services\n(Franchisee of Bizipac Couriers Pvt Ltd)";

  late String? address = '';

  //----------------upload photo------------
  File? _image;

  void _openImageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text("Upload Photo"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _image != null
                      ? Image.file(_image!, height: 150)
                      : const Text("No image selected"),

                  const SizedBox(height: 10),

                  ElevatedButton.icon(
                    icon: const Icon(Icons.camera_alt),
                    label: const Text("click here"),
                    onPressed: () async {
                      final picker = ImagePicker();
                      final pickedFile = await picker.pickImage(
                        source: ImageSource.camera,
                        imageQuality: 70,
                      );

                      if (pickedFile != null) {
                        setState(() {
                          _image = File(pickedFile.path);
                        });
                      }
                    },
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Cancel"),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_image != null) {
                      _uploadImage(_image!);
                    }
                  },
                  child: const Text("Upload"),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Future<void> _uploadImage(File imageFile) async {
    try {
      print("UID: $uid");

      // 1. Convert to bytes
      Uint8List bytes = (await imageFile.readAsBytes());

      // 2. Generate file name
      String fileName =
          "user_${uid}_${DateTime.now().millisecondsSinceEpoch}.jpg";

      // 3. Upload to S3
      String? imageUrl = await uploadImageToS3(
        imageBytes: bytes,
        bucket: "bizipac-s3",
        objectKey: "user_images/$fileName",
      );

      if (imageUrl == null) {
        print("S3 upload failed");
        return;
      }
      print("---------------------");
      print("S3 URL: $imageUrl");

      // 4. Send URL to your PHP API
      await _saveImageUrlToDB(context, uid!, imageUrl);
      //show the snackbar and your profile images updated and please re login first
      Navigator.pop(context);
    } catch (e) {
      print("Error: $e");
    }
  }

  Future<String> uploadImageToS3({
    required Uint8List imageBytes,
    required String bucket,
    required String objectKey,
    String region = 'ap-south-1',
  }) async {
    final s3 = S3(
      region: region,
      credentials: AwsClientCredentials(
        accessKey: decryptFMS(
          "TohPtOvObC8NnBOp/1BM30tSr97U803JZ+gqI3Jf4uM=",
          "QWRTEfnfdys635",
        ),
        secretKey: decryptFMS(
          "Exz2WIEt2w1JRVZREvtIPeRX5Jti2p2mcHqs7Hh87/47BQidFAUAkLOxlzYFlctw",
          "QWRTEfnfdys635",
        ),
      ),
    );

    await s3.putObject(
      bucket: bucket,
      key: objectKey,
      contentType: 'image/jpeg',
    );

    return "https://$bucket.s3.$region.amazonaws.com/$objectKey";
  }

  Future<void> _saveImageUrlToDB(
    BuildContext context,
    String uid,
    String imageUrl,
  ) async {
    var url = Uri.parse(
      "https://fms.bizipac.com/apinew/ws_new/upload_user_image.php",
    );

    try {
      var response = await http.post(
        url,
        body: {"uid": uid, "image_url": imageUrl},
      );

      var data = jsonDecode(response.body);

      print("-----------------------------------------------");
      print(data);
      print("-------------------------------------------------");

      if (!context.mounted) return;

      if (data["success"] == 1) {
        // ✅ Close dialog
        Navigator.pop(context);

        // ✅ Show success snackbar
        Get.snackbar(
          "Profile image updated ✅.",
          " Please re-login. ",
          icon: Image.asset("assets/logo/cmp_logo.png", height: 30, width: 30),
          shouldIconPulse: true,
          backgroundColor: AppConstant.snackBackColor,
          colorText: AppConstant.snackFontColor,
          snackPosition: SnackPosition.BOTTOM,
          borderRadius: 15,
          margin: const EdgeInsets.all(12),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          duration: const Duration(seconds: 4),
          isDismissible: true,
          forwardAnimationCurve: Curves.easeOutBack,
        );
      } else {
        // ❌ Error snackbar
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(data["message"] ?? "Update failed")),
        );
      }
    } catch (e) {
      if (!context.mounted) return;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Error: $e")));
    }
  }

  //---------------------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        backgroundColor: AppConstant.appBarColor,
        title: Text(
          'Profile',
          style: TextStyle(color: AppConstant.appBarWhiteColor, fontSize: 18),
        ),
        iconTheme: IconThemeData(color: AppConstant.appBarWhiteColor),
        actions: [
          IconButton(
            icon: const Icon(Icons.photo_camera),
            onPressed: () {
              _openImageDialog(context);
            },
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: IconButton(
              icon: const Icon(Icons.info_outline),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const TermsAndConditionsScreen(),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      body: Center(
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
          elevation: 6,
          child: Container(
            width: 300,
            height: 525,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: AppConstant.borderColor, width: 2),
              color: Colors.white,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // 🔶 Top Header (Yellow BG with company info)
                Container(
                  width: double.infinity,
                  color: AppConstant.darkButton,
                  padding: const EdgeInsets.symmetric(
                    vertical: 6,
                    horizontal: 4,
                  ),
                  child: Column(
                    children: [
                      Text(
                        company_name!,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        subCompany,
                        style: const TextStyle(
                          fontSize: 11,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),

                // 👤 Profile Image (square like ID card)
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: 100,
                    height: 120,
                    decoration: BoxDecoration(
                      border: Border.all(color: AppConstant.borderColor),
                      image: DecorationImage(
                        image: profile!.startsWith('http')
                            ? NetworkImage(profile!)
                            : AssetImage(profile!) as ImageProvider,
                        // cast needed
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(5),
                  child: Table(
                    border: TableBorder.all(
                      color: AppConstant.borderColor,
                      width: 1,
                    ),
                    // Inner cell borders
                    columnWidths: const {
                      0: FlexColumnWidth(1),
                      1: FlexColumnWidth(2),
                    },
                    children: [
                      TableRow(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: Text(
                              "Name",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: AppConstant.darkButton,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: Text(
                              name!,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      TableRow(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: Text(
                              "User ID ",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: AppConstant.darkButton,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: Text("$uid"),
                          ),
                        ],
                      ),
                      TableRow(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: Text(
                              "Role",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: AppConstant.darkButton,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: Text(formatRoleName(rolename!)),
                          ),
                        ],
                      ),
                      // TableRow(
                      //   children: [
                      //     Padding(
                      //       padding: const EdgeInsets.all(6.0),
                      //       child: Text(
                      //         "Auth ID",
                      //         style: TextStyle(
                      //           fontWeight: FontWeight.bold,
                      //           color: AppConstant.darkButton,
                      //         ),
                      //       ),
                      //     ),
                      //     Padding(
                      //       padding: const EdgeInsets.all(6.0),
                      //       child: Text(
                      //         authId.length > 6
                      //             ? "XXX${authId.substring(authId.length - 6)}"
                      //             : authId,
                      //         style: TextStyle(fontWeight: FontWeight.bold),
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      TableRow(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: Text(
                              "Mobile No.",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: AppConstant.darkButton,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: Text("$mobile"),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 6,
                  ),
                  child: Column(
                    children: [
                      const Divider(thickness: 1),
                      const SizedBox(height: 8),
                      Text(
                        address!,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 11),
                      ),
                      const SizedBox(height: 6),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
