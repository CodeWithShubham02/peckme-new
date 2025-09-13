import 'dart:io';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/app_constant.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String name = '';
  String mobile = '';
  String uid = '';
  String rolename = '';
  String branchName = '';
  String authId = '';
  String image = '';
  String address = '';

  void loadUserData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      name = prefs.getString('name') ?? '';
      mobile = prefs.getString('mobile') ?? '';
      uid = prefs.getString('uid') ?? '';
      rolename = prefs.getString('rolename') ?? '';
      branchName = prefs.getString('branch_name') ?? '';
      authId = prefs.getString('authId') ?? '';
      image = prefs.getString('image') ?? '';
      address = prefs.getString('address') ?? '';
    });
  }

  @override
  void initState() {
    super.initState();
    loadUserData();
  }

  Future<void> generatePdf() async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Container(
            padding: const pw.EdgeInsets.all(20),
            decoration: pw.BoxDecoration(
              border: pw.Border.all(color: PdfColors.blue, width: 2),
              borderRadius: pw.BorderRadius.circular(15),
            ),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.center,
              children: [
                pw.Container(
                  width: 100,
                  height: 100,
                  decoration: pw.BoxDecoration(
                    shape: pw.BoxShape.circle,
                    color: PdfColors.blue200,
                  ),
                  child: pw.Center(
                    child: pw.Icon(
                      pw.IconData(0xe491), // Person icon codepoint
                      size: 50,
                      color: PdfColors.black,
                    ),
                  ),
                ),
                pw.SizedBox(height: 15),
                pw.Text(name.toUpperCase(),
                    style: pw.TextStyle(
                        fontSize: 22, fontWeight: pw.FontWeight.bold)),
                pw.Divider(),
                buildPdfRow("User ID", uid),
                buildPdfRow("Mobile", mobile),
                buildPdfRow("Address", address),
                buildPdfRow("Branch", branchName),
                buildPdfRow("Role", rolename),
                buildPdfRow("Auth ID", authId),
              ],
            ),
          );
        },
      ),
    );

    // Save PDF to local storage
    final downloadsDir = Directory("/storage/emulated/0/Download/idcard");

    if (!(await downloadsDir.exists())) {
      await downloadsDir.create(recursive: true);
    }

    final file = File("${downloadsDir.path}/id_card.pdf");
    await file.writeAsBytes(await pdf.save());

    // final output = await getExternalStorageDirectory();
    // final file = File("${output!.path}/id_card.pdf");
    // await file.writeAsBytes(await pdf.save());

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("PDF Saved at ${file.path}"),duration: Duration(seconds: 2),),
    );
  }

  pw.Widget buildPdfRow(String title, String value) {
    return pw.Padding(
      padding: const pw.EdgeInsets.symmetric(vertical: 6),
      child: pw.Row(
        children: [
          pw.Text("$title: ",
              style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
          pw.Expanded(child: pw.Text(value)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppConstant.appInsideColor,
        title: const Text(
          'Profile',
          style: TextStyle(color: AppConstant.appTextColor),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              icon: const Icon(Icons.download, color: AppConstant.appTextColor),
              onPressed: generatePdf, // 📌 generate PDF on click
            ),
          ),
        ],
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Center(
          child: Card(
            elevation: 12,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Container(
              width: double.infinity,
              height: double.infinity,
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundColor: AppConstant.appBatton1,
                    child: const Icon(Icons.person,
                        size: 70, color: Colors.black),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    name.toUpperCase(),
                    style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.5),
                  ),
                  const SizedBox(height: 10),
                  const Divider(thickness: 1.2),
                  const SizedBox(height: 10),
                  buildInfoRow(Icons.badge, "User ID", uid),
                  buildInfoRow(Icons.phone, "Mobile", mobile),
                  buildInfoRow(Icons.location_on, "Address", address.toUpperCase()),
                  buildInfoRow(Icons.apartment, "Branch", branchName.toUpperCase()),
                  buildInfoRow(Icons.work, "Role", rolename.toUpperCase()),
                  buildInfoRow(Icons.vpn_key, "Auth ID", authId),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, color: Colors.blueAccent, size: 22),
          const SizedBox(width: 10),
          Text(
            "$label: ",
            style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.black87),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
