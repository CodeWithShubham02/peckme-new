// import 'dart:io';
//
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:image_cropper/image_cropper.dart';
// import 'package:image_picker/image_picker.dart';
//
// import 'package:peckme/model/DocumentResponse.dart';
// import 'package:peckme/view/lead_detail_screen.dart';
// import '../../controller/document_controller.dart';
// import '../../controller/document_list_controller.dart';
// import '../../model/document_list_model.dart';
//
// import '../../services/upload_pdf_server.dart';
// import '../../utils/app_constant.dart';
// import '../../services/image_to_pdf.dart';
//
// class DocumentScreen extends StatefulWidget {
//   final String clientName;
//   final String clientId;
//   final String leadId;
//   const DocumentScreen({Key? key, required this.clientName,required this.leadId,required this.clientId}) : super(key: key);
//
//   @override
//   State<DocumentScreen> createState() => _DocumentScreenState();
// }
//
// class _DocumentScreenState extends State<DocumentScreen> {
//   late Future<DocumentResponse?> futureDocuments;
//   late Future<Document?> _futureDocumentsList;
//   final DocumentService _documentService = DocumentService();
//
//   // List<File?> get documentList => [companuBoard, feSelfie,billDesk,frontDoor,locationSnap,namePstatic,premisesInterior,stock,photo,fESelfieWithPerson,qRCode,imageOfPersonMet,billDeskImageofShop,imageofShopFromOutside,tentCard,politicalConnections];
//   List<String> collectedDocs = [];
//
//   bool isLoading = false;
//   //photo category
//   File? feSelfie;
//   File? companuBoard;
//   File? billDesk;
//   File? frontDoor;
//   File? locationSnap;
//   File? namePstatic;
//   File? premisesInterior;
//   File? stock;
//   File? photo;
//   File? fESelfieWithPerson;
//   File? imageOfPersonMet;
//   File? billDeskImageofShop;
//   File? imageofShopFromOutside;
//   File? qRCode;
//   File? tentCard;
//   File? politicalConnections;
//   Future pickImageCompanyBoard(ImageSource source, String docname) async {
//     try {
//       final image = await ImagePicker().pickImage(source: source);
//       if (image == null) return;
//       if (!collectedDocs.contains(docname)) {
//         setState(() {
//           collectedDocs.add(docname);
//         });
//       }
//       File? img = File(image.path);
//       img = await _cropImage(imageFile: img);
//
//       // 🔹 Loader start
//       setState(() {
//         isLoading = true;
//       });
//
//       final url = await convertImageToPdfAndSave(
//         img!,
//         docname,
//         widget.clientName,
//         widget.leadId,
//       );
//
//       // 🔹 Loader stop
//       setState(() {
//         isLoading = false;
//         companuBoard = File(url!); // agar url local file path hai
//       });
//
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("✅ Image upload success: $url")),
//       );
//     } on PlatformException catch (e) {
//       print(e);
//       setState(() {
//         isLoading = false; // 🔹 Error pe loader band karo
//       });
//       Navigator.of(context).pop();
//     }
//   }
//   Future pickImageFeSelfie(ImageSource source,String docname) async{
//     try {
//       final image = await ImagePicker().pickImage(source: source);
//       if (image == null) return;
//       if (!collectedDocs.contains(docname)) {
//         setState(() {
//           collectedDocs.add(docname);
//         });
//       }
//       File? img = File(image.path);
//       img = await _cropImage(imageFile: img);
//
//       // 🔹 Loader start
//       setState(() {
//         isLoading = true;
//       });
//
//       final url = await convertImageToPdfAndSave(
//         img!,
//         docname,
//         widget.clientName,
//         widget.leadId,
//       );
//
//       // 🔹 Loader stop
//       setState(() {
//         isLoading = false;
//         feSelfie = File(url!); // agar url local file path hai
//       });
//
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("✅ Image upload success: $url")),
//       );
//     } on PlatformException catch (e) {
//       print(e);
//       setState(() {
//         isLoading = false; // 🔹 Error pe loader band karo
//       });
//       Navigator.of(context).pop();
//     }
//   }
//   Future pickImageBillDesk(ImageSource source,String docname) async{
//     try {
//       final image = await ImagePicker().pickImage(source: source);
//       if (image == null) return;
//       if (!collectedDocs.contains(docname)) {
//         setState(() {
//           collectedDocs.add(docname);
//         });
//       }
//       File? img = File(image.path);
//       img = await _cropImage(imageFile: img);
//
//       // 🔹 Loader start
//       setState(() {
//         isLoading = true;
//       });
//
//       final url = await convertImageToPdfAndSave(
//         img!,
//         docname,
//         widget.clientName,
//         widget.leadId,
//       );
//
//       // 🔹 Loader stop
//       setState(() {
//         isLoading = false;
//         billDesk = File(url!); // agar url local file path hai
//       });
//
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("✅ Image upload success: $url")),
//       );
//     } on PlatformException catch (e) {
//       print(e);
//       setState(() {
//         isLoading = false; // 🔹 Error pe loader band karo
//       });
//       Navigator.of(context).pop();
//     }
//   }
//   Future pickImageFrontDoor(ImageSource source,String docname) async{
//     try {
//       final image = await ImagePicker().pickImage(source: source);
//       if (image == null) return;
//       if (!collectedDocs.contains(docname)) {
//         setState(() {
//           collectedDocs.add(docname);
//         });
//       }
//       File? img = File(image.path);
//       img = await _cropImage(imageFile: img);
//
//       // 🔹 Loader start
//       setState(() {
//         isLoading = true;
//       });
//
//       final url = await convertImageToPdfAndSave(
//         img!,
//         docname,
//         widget.clientName,
//         widget.leadId,
//       );
//
//       // 🔹 Loader stop
//       setState(() {
//         isLoading = false;
//         frontDoor = File(url!); // agar url local file path hai
//       });
//
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("✅ Image upload success: $url")),
//       );
//     } on PlatformException catch (e) {
//       print(e);
//       setState(() {
//         isLoading = false; // 🔹 Error pe loader band karo
//       });
//       Navigator.of(context).pop();
//     }
//   }
//   Future pickImageLocationSnap(ImageSource source,String docname) async{
//     try {
//       final image = await ImagePicker().pickImage(source: source);
//       if (image == null) return;
//       if (!collectedDocs.contains(docname)) {
//         setState(() {
//           collectedDocs.add(docname);
//         });
//       }
//       File? img = File(image.path);
//       img = await _cropImage(imageFile: img);
//
//       // 🔹 Loader start
//       setState(() {
//         isLoading = true;
//       });
//
//       final url = await convertImageToPdfAndSave(
//         img!,
//         docname,
//         widget.clientName,
//         widget.leadId,
//       );
//
//       // 🔹 Loader stop
//       setState(() {
//         isLoading = false;
//         locationSnap = File(url!); // agar url local file path hai
//       });
//
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("✅ Image upload success: $url")),
//       );
//     } on PlatformException catch (e) {
//       print(e);
//       setState(() {
//         isLoading = false; // 🔹 Error pe loader band karo
//       });
//       Navigator.of(context).pop();
//     }
//   }
//   Future pickImageNamePstatic(ImageSource source,String docname) async{
//     try {
//       final image = await ImagePicker().pickImage(source: source);
//       if (image == null) return;
//       if (!collectedDocs.contains(docname)) {
//         setState(() {
//           collectedDocs.add(docname);
//         });
//       }
//       File? img = File(image.path);
//       img = await _cropImage(imageFile: img);
//
//       // 🔹 Loader start
//       setState(() {
//         isLoading = true;
//       });
//
//       final url = await convertImageToPdfAndSave(
//         img!,
//         docname,
//         widget.clientName,
//         widget.leadId,
//       );
//
//       // 🔹 Loader stop
//       setState(() {
//         isLoading = false;
//         namePstatic = File(url!); // agar url local file path hai
//       });
//
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("✅ Image upload success: $url")),
//       );
//     } on PlatformException catch (e) {
//       print(e);
//       setState(() {
//         isLoading = false; // 🔹 Error pe loader band karo
//       });
//       Navigator.of(context).pop();
//     }
//   }
//   Future pickImagePremisesInterior(ImageSource source,String docname) async{
//     try {
//       final image = await ImagePicker().pickImage(source: source);
//       if (image == null) return;
//
//       File? img = File(image.path);
//       img = await _cropImage(imageFile: img);
//
//       // 🔹 Loader start
//       setState(() {
//         isLoading = true;
//       });
//
//       final url = await convertImageToPdfAndSave(
//         img!,
//         docname,
//         widget.clientName,
//         widget.leadId,
//       );
//
//       // 🔹 Loader stop
//       setState(() {
//         isLoading = false;
//         premisesInterior = File(url!); // agar url local file path hai
//       });
//
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("✅ Image upload success: $url")),
//       );
//     } on PlatformException catch (e) {
//       print(e);
//       setState(() {
//         isLoading = false; // 🔹 Error pe loader band karo
//       });
//       Navigator.of(context).pop();
//     }
//   }
//   Future pickImageStock(ImageSource source,String docname) async{
//     try {
//       final image = await ImagePicker().pickImage(source: source);
//       if (image == null) return;
//
//       File? img = File(image.path);
//       img = await _cropImage(imageFile: img);
//
//       // 🔹 Loader start
//       setState(() {
//         isLoading = true;
//       });
//
//       final url = await convertImageToPdfAndSave(
//         img!,
//         docname,
//         widget.clientName,
//         widget.leadId,
//       );
//
//       // 🔹 Loader stop
//       setState(() {
//         isLoading = false;
//         stock = File(url!); // agar url local file path hai
//       });
//
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("✅ Image upload success: $url")),
//       );
//     } on PlatformException catch (e) {
//       print(e);
//       setState(() {
//         isLoading = false; // 🔹 Error pe loader band karo
//       });
//       Navigator.of(context).pop();
//     }
//   }
//
//   Future pickImagePhoto(ImageSource source, String docname) async {
//     try {
//       final image = await ImagePicker().pickImage(source: source);
//       if (image == null) return;
//       // 🔹 Doc name add karo agar pehle nahi hai
//       if (!collectedDocs.contains(docname)) {
//         setState(() {
//           collectedDocs.add(docname);
//         });
//       }
//
//       File? img = File(image.path);
//       img = await _cropImage(imageFile: img);
//       setState(() {
//         isLoading = true; // 🔹 Start loader
//       });
//       // final url = await convertImageToPdfAndSave(
//       //   img!,
//       //   docname,
//       //   widget.clientName,
//       //   widget.leadId,
//       // );
//       setState(() {
//         isLoading = false; // 🔹 Stop loader
//         photo = img!;
//
//
//       });
//       ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text("✅ Uploaded!"),
//             duration: Duration(seconds: 5),
//           )
//       );
//
//     } on PlatformException catch (e) {
//       print(e);
//       setState(() {
//         isLoading = false; // Error aaya to loader band karo
//       });
//       Navigator.of(context).pop();
//     }
//   }
//
//   Future pickImageFESelfieWithPerson(ImageSource source,String docname) async{
//     try {
//       final image = await ImagePicker().pickImage(source: source);
//       if (image == null) return;
//
//       File? img = File(image.path);
//       img = await _cropImage(imageFile: img);
//
//       // 🔹 Loader start
//       setState(() {
//         isLoading = true;
//       });
//
//       final url = await convertImageToPdfAndSave(
//         img!,
//         docname,
//         widget.clientName,
//         widget.leadId,
//       );
//
//       // 🔹 Loader stop
//       setState(() {
//         isLoading = false;
//         fESelfieWithPerson = File(url!); // agar url local file path hai
//       });
//
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("✅ Image upload success: $url")),
//       );
//     } on PlatformException catch (e) {
//       print(e);
//       setState(() {
//         isLoading = false; // 🔹 Error pe loader band karo
//       });
//       Navigator.of(context).pop();
//     }
//   }
//   Future pickImageImageOfPersonMet(ImageSource source,String docname) async{
//     try {
//       final image = await ImagePicker().pickImage(source: source);
//       if (image == null) return;
//
//       File? img = File(image.path);
//       img = await _cropImage(imageFile: img);
//
//       // 🔹 Loader start
//       setState(() {
//         isLoading = true;
//       });
//
//       final url = await convertImageToPdfAndSave(
//         img!,
//         docname,
//         widget.clientName,
//         widget.leadId,
//       );
//
//       // 🔹 Loader stop
//       setState(() {
//         isLoading = false;
//         imageOfPersonMet = File(url!); // agar url local file path hai
//       });
//
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("✅ Image upload success: $url")),
//       );
//     } on PlatformException catch (e) {
//       print(e);
//       setState(() {
//         isLoading = false; // 🔹 Error pe loader band karo
//       });
//       Navigator.of(context).pop();
//     }
//   }
//   Future pickImageBillDeskImageofShop(ImageSource source,String docname) async{
//     try {
//       final image = await ImagePicker().pickImage(source: source);
//       if (image == null) return;
//
//       File? img = File(image.path);
//       img = await _cropImage(imageFile: img);
//
//       // 🔹 Loader start
//       setState(() {
//         isLoading = true;
//       });
//
//       final url = await convertImageToPdfAndSave(
//         img!,
//         docname,
//         widget.clientName,
//         widget.leadId,
//       );
//
//       // 🔹 Loader stop
//       setState(() {
//         isLoading = false;
//         billDeskImageofShop = File(url!); // agar url local file path hai
//       });
//
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("✅ Image upload success: $url")),
//       );
//     } on PlatformException catch (e) {
//       print(e);
//       setState(() {
//         isLoading = false; // 🔹 Error pe loader band karo
//       });
//       Navigator.of(context).pop();
//     }
//   }
//   Future pickImageImageofShopFromOutside(ImageSource source,String docname) async{
//     try {
//       final image = await ImagePicker().pickImage(source: source);
//       if (image == null) return;
//
//       File? img = File(image.path);
//       img = await _cropImage(imageFile: img);
//
//       // 🔹 Loader start
//       setState(() {
//         isLoading = true;
//       });
//
//       final url = await convertImageToPdfAndSave(
//         img!,
//         docname,
//         widget.clientName,
//         widget.leadId,
//       );
//
//       // 🔹 Loader stop
//       setState(() {
//         isLoading = false;
//         imageofShopFromOutside = File(url!); // agar url local file path hai
//       });
//
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("✅ Image upload success: $url")),
//       );
//     } on PlatformException catch (e) {
//       print(e);
//       setState(() {
//         isLoading = false; // 🔹 Error pe loader band karo
//       });
//       Navigator.of(context).pop();
//     }
//   }
//   Future pickImageQRCode(ImageSource source,String docname) async{
//     try {
//       final image = await ImagePicker().pickImage(source: source);
//       if (image == null) return;
//
//       File? img = File(image.path);
//       img = await _cropImage(imageFile: img);
//
//       // 🔹 Loader start
//       setState(() {
//         isLoading = true;
//       });
//
//       final url = await convertImageToPdfAndSave(
//         img!,
//         docname,
//         widget.clientName,
//         widget.leadId,
//       );
//
//       // 🔹 Loader stop
//       setState(() {
//         isLoading = false;
//         qRCode = File(url!); // agar url local file path hai
//       });
//
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("✅ Image upload success: $url")),
//       );
//     } on PlatformException catch (e) {
//       print(e);
//       setState(() {
//         isLoading = false; // 🔹 Error pe loader band karo
//       });
//       Navigator.of(context).pop();
//     }
//   }
//   Future pickImageTentCard(ImageSource source,String docname) async{
//     try {
//       final image = await ImagePicker().pickImage(source: source);
//       if (image == null) return;
//
//       File? img = File(image.path);
//       img = await _cropImage(imageFile: img);
//
//       // 🔹 Loader start
//       setState(() {
//         isLoading = true;
//       });
//
//       final url = await convertImageToPdfAndSave(
//         img!,
//         docname,
//         widget.clientName,
//         widget.leadId,
//       );
//
//       // 🔹 Loader stop
//       setState(() {
//         isLoading = false;
//         tentCard = File(url!); // agar url local file path hai
//       });
//
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("✅ Image upload success: $url")),
//       );
//     } on PlatformException catch (e) {
//       print(e);
//       setState(() {
//         isLoading = false; // 🔹 Error pe loader band karo
//       });
//       Navigator.of(context).pop();
//     }
//   }
//   Future pickImagePoliticalConnections(ImageSource source,String docname) async{
//     try {
//       final image = await ImagePicker().pickImage(source: source);
//       if (image == null) return;
//
//       File? img = File(image.path);
//       img = await _cropImage(imageFile: img);
//
//       // 🔹 Loader start
//       setState(() {
//         isLoading = true;
//       });
//
//       final url = await convertImageToPdfAndSave(
//         img!,
//         docname,
//         widget.clientName,
//         widget.leadId,
//       );
//
//       // 🔹 Loader stop
//       setState(() {
//         isLoading = false;
//         politicalConnections = File(url!); // agar url local file path hai
//       });
//
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("✅ Image upload success: $url")),
//       );
//     } on PlatformException catch (e) {
//       print(e);
//       setState(() {
//         isLoading = false; // 🔹 Error pe loader band karo
//       });
//       Navigator.of(context).pop();
//     }
//   }
//   Future<File?> _cropImage({required File imageFile}) async{
//     CroppedFile? cropImage=await ImageCropper().cropImage(sourcePath: imageFile.path,
//       uiSettings: [
//         AndroidUiSettings(
//           toolbarTitle: 'Crop Image',
//           toolbarColor: const Color(0xFF0A73FF),
//           toolbarWidgetColor: Colors.white,
//           lockAspectRatio: false,
//         ),
//         IOSUiSettings(
//           title: 'Crop Image',
//         ),
//       ],
//     );
//     if(cropImage==null) return null;
//     return File(cropImage.path);
//   }
//   @override
//   void initState() {
//     super.initState();
//     futureDocuments = DocumentController.fetchDocument();
//     _futureDocumentsList = _documentService.fetchDocuments();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         iconTheme: IconThemeData(color: Colors.black),
//         backgroundColor: AppConstant.appInsideColor,
//         title: const Text("Documents",style: TextStyle(color: AppConstant.appTextColor,),),
//
//       ),
//       body: FutureBuilder<DocumentResponse?>(
//         future: futureDocuments,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(
//               child: Text("Error: ${snapshot.error}"),
//             );
//           } else if (!snapshot.hasData || snapshot.data == null) {
//             return const Center(
//               child: Text("No documents found"),
//             );
//           }
//
//           final documents = snapshot.data!.doclist;
//           // ✅ Group documents by category
//           final Map<String, List<Doc>> groupedDocs = {};
//           for (var doc in documents) {
//             groupedDocs.putIfAbsent(doc.docCategory, () => []).add(doc);
//           }
//           final data=documents.first.docClient[0].toString();
//
//           return ListView(
//             children: groupedDocs.entries.map((entry) {
//               final category = entry.key;
//               final docs = entry.value;
//
//               // 👉 Check if category should be visible
//               final bool categoryHasAccess = docs.any((doc) {
//                 final clientIds = doc.docClient.split(",").map((id) => id.trim()).toList();
//                 return clientIds.contains(widget.clientId.toString().trim()) ||
//                     clientIds.contains("0");   // ✅ अगर "0" हो तो भी category show होगी
//               });
//
//               if (!categoryHasAccess) {
//                 return const SizedBox.shrink(); // Category ही मत दिखाओ
//               }
//
//               return Card(
//                 margin: const EdgeInsets.all(10),
//                 child: ExpansionTile(
//                   title: Text(
//                     category,
//                     style: const TextStyle(fontWeight: FontWeight.bold),
//                   ),
//                   children: docs.map((doc) {
//                     final clientIds = doc.docClient.split(",").map((id) => id.trim()).toList();
//
//                     final bool belongsToClient = clientIds.contains(widget.clientId.toString().trim());
//                     final bool isPublicDoc = clientIds.contains("0"); // ✅ extra condition
//
//                     if (!belongsToClient && !isPublicDoc) {
//                       return const SizedBox.shrink(); // ❌ doc छुपा दो
//                     }
//
//                     // ✅ अब यहां आपका UI render होगा
//                     return ListTile(
//                       title: Column(
//                         children: [
//                           Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//
//                                 category == "PHOTO" ? Column(
//                                   mainAxisAlignment: MainAxisAlignment.start,
//                                   children: [
//                                     doc.docName=="Company Board"?Container(
//                                       height: MediaQuery.of(context).size.height/10,
//                                       width: 500,
//                                       color:Colors.white60,
//                                       child: Row(
//                                         mainAxisAlignment: MainAxisAlignment.start,
//                                         crossAxisAlignment: CrossAxisAlignment.start,
//                                         children: [
//                                           doc.docName=="Company Board"?Stack(
//                                             children: [
//                                               Container(
//                                                 height: 75,
//                                                 width: 75,
//                                                 decoration: BoxDecoration(
//                                                   color: AppConstant.appSecondaryColor,
//                                                   border: Border.all(
//                                                     color: Colors.black,
//                                                     width: 1.0,
//                                                   ),
//                                                   borderRadius: BorderRadius.circular(5),
//                                                 ),
//                                                 child: Center(
//                                                   child: isLoading
//                                                       ? const CircularProgressIndicator( // 🔹 Loader dikhayenge
//                                                     color: Colors.white,
//                                                     strokeWidth: 2,
//                                                   )
//                                                       : companuBoard == null
//                                                       ? InkWell(
//                                                     onTap: () {
//                                                       pickImageCompanyBoard(ImageSource.camera, doc.docName);
//                                                     },
//                                                     child: const Text(
//                                                       "No image selected",
//                                                       textAlign: TextAlign.center,
//                                                       style: TextStyle(fontSize: 8, color: Colors.white),
//                                                     ),
//                                                   )
//                                                       : Container(
//                                                     height: 73,
//                                                     width: 73,
//                                                     color: Colors.white,
//                                                     child: Image.file(
//                                                       companuBoard!,
//                                                       fit: BoxFit.cover,
//                                                     ),
//                                                   ),
//                                                 ),
//                                               ),
//                                               Positioned(
//                                                 top:-2, // Adjust these values to position the icon correctly
//                                                 right: 2,
//                                                 child: InkWell( // Consider using InkWell for better tap feedback
//                                                   onTap: () async {
//                                                     try {
//                                                       if (companuBoard != null) {
//                                                         await companuBoard!.delete();
//                                                         setState(() {
//                                                           companuBoard = null;
//                                                         });
//                                                         print("File deleted successfully!");
//                                                       }
//                                                     } catch (e) {
//                                                       print("Error deleting file: $e");
//                                                     }
//                                                   },
//                                                   child: Container(
//                                                     decoration: BoxDecoration(
//                                                       color: Colors.black, // Optional: background color for the icon
//                                                       shape: BoxShape.circle,
//                                                     ),
//                                                     padding: EdgeInsets.all(3), // Adjust padding as needed
//                                                     child: Icon(
//                                                       Icons.delete_forever_outlined,
//                                                       size: 18,
//                                                       color: Colors.white,
//                                                     ),
//                                                   ),
//                                                 ),
//                                               ),
//                                             ],
//                                           ):SizedBox.shrink(),
//                                           doc.docName=="Company Board"?Flexible(
//                                             child: Padding(
//                                               padding: const EdgeInsets.all(5.0),
//                                               child: Text(doc.docName,
//                                                 textAlign:TextAlign.left,softWrap:true,overflow:TextOverflow.ellipsis,maxLines:3,style: TextStyle(color: Colors.black,fontSize: 12),),
//                                             ),
//                                           ):SizedBox(),
//                                         ],
//                                       ),
//                                     ):SizedBox.shrink(),
//                                     doc.docName=="FE Selfie"?Container(
//                                       height: MediaQuery.of(context).size.height/10,
//                                       width: 500,
//                                       color:Colors.white60,
//                                       child: Row(
//                                         mainAxisAlignment: MainAxisAlignment.start,
//                                         crossAxisAlignment: CrossAxisAlignment.start,
//                                         children: [
//                                           doc.docName=="FE Selfie"?Stack(
//                                             children: [
//                                               Container(
//                                                 height: 75,
//                                                 width: 75,
//                                                 decoration: BoxDecoration(
//                                                   color: AppConstant.appSecondaryColor,
//                                                   border: Border.all(
//                                                     color: Colors.black,
//                                                     width: 1.0,
//                                                   ),
//                                                   borderRadius: BorderRadius.circular(5),
//                                                 ),
//                                                 child: Center(
//                                                   child: feSelfie == null
//                                                       ? InkWell(
//                                                     onTap: (){
//                                                       pickImageFeSelfie(ImageSource.camera,doc.docName);
//                                                     },
//                                                     child: const Text(
//                                                       "No image selected",
//                                                       textAlign: TextAlign.center,
//                                                       style: TextStyle(fontSize: 8, color: Colors.white),
//                                                     ),
//                                                   )
//                                                       : Container(
//                                                     height: 73,
//                                                     width: 73,
//                                                     color: Colors.white,
//                                                     child: Image.file(feSelfie!,fit: BoxFit.cover,),
//                                                   ),
//                                                 ),
//                                               ),
//                                               Positioned(
//                                                 top:-2, // Adjust these values to position the icon correctly
//                                                 right: 2,
//                                                 child: InkWell( // Consider using InkWell for better tap feedback
//                                                   onTap: () async {
//                                                     try {
//                                                       if (feSelfie != null) {
//                                                         await feSelfie!.delete();
//                                                         setState(() {
//                                                           feSelfie = null;
//                                                         });
//                                                         print("File deleted successfully!");
//                                                       }
//                                                     } catch (e) {
//                                                       print("Error deleting file: $e");
//                                                     }
//                                                   },
//                                                   child: Container(
//                                                     decoration: BoxDecoration(
//                                                       color: Colors.black, // Optional: background color for the icon
//                                                       shape: BoxShape.circle,
//                                                     ),
//                                                     padding: EdgeInsets.all(3), // Adjust padding as needed
//                                                     child: Icon(
//                                                       Icons.delete_forever_outlined,
//                                                       size: 18,
//                                                       color: Colors.white,
//                                                     ),
//                                                   ),
//                                                 ),
//                                               ),
//                                             ],
//                                           ):SizedBox.shrink(),
//                                           doc.docName=="FE Selfie"?Flexible(
//                                             child: Padding(
//                                               padding: const EdgeInsets.all(5.0),
//                                               child: Text(doc.docName,
//                                                 textAlign:TextAlign.left,softWrap:true,overflow:TextOverflow.ellipsis,maxLines:3,style: TextStyle(color: Colors.black,fontSize: 12),),
//                                             ),
//                                           ):SizedBox(),
//                                         ],
//                                       ),
//                                     ):SizedBox.shrink(),
//                                     doc.docName=="Bill Desk"?Container(
//                                       height: MediaQuery.of(context).size.height/10,
//                                       width: 500,
//                                       color:Colors.white60,
//                                       child: Row(
//                                         mainAxisAlignment: MainAxisAlignment.start,
//                                         crossAxisAlignment: CrossAxisAlignment.start,
//                                         children: [
//                                           doc.docName=="Bill Desk"?Stack(
//                                             children: [
//                                               Container(
//                                                 height: 75,
//                                                 width: 75,
//                                                 decoration: BoxDecoration(
//                                                   color: AppConstant.appSecondaryColor,
//                                                   border: Border.all(
//                                                     color: Colors.black,
//                                                     width: 1.0,
//                                                   ),
//                                                   borderRadius: BorderRadius.circular(5),
//                                                 ),
//                                                 child: Center(
//                                                   child:billDesk == null
//                                                       ? InkWell(
//                                                     onTap: (){
//                                                       pickImageBillDesk(ImageSource.camera,doc.docName);
//                                                     },
//                                                     child: const Text(
//                                                       "No image selected",
//                                                       textAlign: TextAlign.center,
//                                                       style: TextStyle(fontSize: 8, color: Colors.white),
//                                                     ),
//                                                   )
//                                                       : Container(
//                                                     height: 73,
//                                                     width: 73,
//                                                     color: Colors.white,
//                                                     child: Image.file(billDesk!,fit: BoxFit.cover,),
//                                                   ),
//                                                 ),
//                                               ),
//                                               Positioned(
//                                                 top:-2, // Adjust these values to position the icon correctly
//                                                 right: 2,
//                                                 child: InkWell( // Consider using InkWell for better tap feedback
//                                                   onTap: () async {
//                                                     try {
//                                                       if (billDesk != null) {
//                                                         await billDesk!.delete();
//                                                         setState(() {
//                                                           billDesk = null;
//                                                         });
//                                                         print("File deleted successfully!");
//                                                       }
//                                                     } catch (e) {
//                                                       print("Error deleting file: $e");
//                                                     }
//                                                   },
//                                                   child: Container(
//                                                     decoration: BoxDecoration(
//                                                       color: Colors.black, // Optional: background color for the icon
//                                                       shape: BoxShape.circle,
//                                                     ),
//                                                     padding: EdgeInsets.all(3), // Adjust padding as needed
//                                                     child: Icon(
//                                                       Icons.delete_forever_outlined,
//                                                       size: 18,
//                                                       color: Colors.white,
//                                                     ),
//                                                   ),
//                                                 ),
//                                               ),
//                                             ],
//                                           ):SizedBox.shrink(),
//                                           doc.docName=="Bill Desk"?Flexible(
//                                             child: Padding(
//                                               padding: const EdgeInsets.all(5.0),
//                                               child: Text(doc.docName,
//                                                 textAlign:TextAlign.left,softWrap:true,overflow:TextOverflow.ellipsis,maxLines:3,style: TextStyle(color: Colors.black,fontSize: 12),),
//                                             ),
//                                           ):SizedBox(),
//                                         ],
//                                       ),
//                                     ):SizedBox.shrink(),
//                                     doc.docName=="FE Selfie With Person Met With Sound Box (Inside Shop)"?Container(
//                                       height: MediaQuery.of(context).size.height/10,
//                                       width: 500,
//                                       color:Colors.white60,
//                                       child: Row(
//                                         mainAxisAlignment: MainAxisAlignment.start,
//                                         crossAxisAlignment: CrossAxisAlignment.start,
//                                         children: [
//                                           doc.docName=="FE Selfie With Person Met With Sound Box (Inside Shop)"?Stack(
//                                             children: [
//                                               Container(
//                                                 height: 75,
//                                                 width: 75,
//                                                 decoration: BoxDecoration(
//                                                   color: AppConstant.appSecondaryColor,
//                                                   border: Border.all(
//                                                     color: Colors.black,
//                                                     width: 1.0,
//                                                   ),
//                                                   borderRadius: BorderRadius.circular(5),
//                                                 ),
//                                                 child: Center(
//                                                   child: fESelfieWithPerson == null
//                                                       ? InkWell(
//                                                     onTap: (){
//                                                       pickImageFESelfieWithPerson(ImageSource.camera,doc.docName);
//                                                     },
//                                                     child: const Text(
//                                                       "No image selected",
//                                                       textAlign: TextAlign.center,
//                                                       style: TextStyle(fontSize: 8, color: Colors.white),
//                                                     ),
//                                                   )
//                                                       : Container(
//                                                     height: 73,
//                                                     width: 73,
//                                                     color: Colors.white,
//                                                     child: Image.file(fESelfieWithPerson!,fit: BoxFit.cover,),
//                                                   ),
//                                                 ),
//                                               ),
//                                               Positioned(
//                                                 top:-2, // Adjust these values to position the icon correctly
//                                                 right: 2,
//                                                 child: InkWell( // Consider using InkWell for better tap feedback
//                                                   onTap: () async {
//                                                     try {
//                                                       if (fESelfieWithPerson != null) {
//                                                         await fESelfieWithPerson!.delete();
//                                                         setState(() {
//                                                           fESelfieWithPerson = null;
//                                                         });
//                                                         print("File deleted successfully!");
//                                                       }
//                                                     } catch (e) {
//                                                       print("Error deleting file: $e");
//                                                     }
//                                                   },
//                                                   child: Container(
//                                                     decoration: BoxDecoration(
//                                                       color: Colors.black, // Optional: background color for the icon
//                                                       shape: BoxShape.circle,
//                                                     ),
//                                                     padding: EdgeInsets.all(3), // Adjust padding as needed
//                                                     child: Icon(
//                                                       Icons.delete_forever_outlined,
//                                                       size: 18,
//                                                       color: Colors.white,
//                                                     ),
//                                                   ),
//                                                 ),
//                                               ),
//                                             ],
//                                           ):SizedBox.shrink(),
//                                           doc.docName=="FE Selfie With Person Met With Sound Box (Inside Shop)"?Flexible(
//                                             child: Padding(
//                                               padding: const EdgeInsets.all(5.0),
//                                               child: Text(doc.docName,
//                                                 textAlign:TextAlign.left,softWrap:true,overflow:TextOverflow.ellipsis,maxLines:3,style: TextStyle(color: Colors.black,fontSize: 12),),
//                                             ),
//                                           ):SizedBox(),
//                                         ],
//                                       ),
//                                     ):SizedBox.shrink(),
//                                     doc.docName=="Front Door"?Container(
//                                       height: MediaQuery.of(context).size.height/10,
//                                       width: 500,
//                                       color:Colors.white60,
//                                       child: Row(
//                                         mainAxisAlignment: MainAxisAlignment.start,
//                                         crossAxisAlignment: CrossAxisAlignment.start,
//                                         children: [
//                                           doc.docName=="Front Door"?Stack(
//                                             children: [
//                                               Container(
//                                                 height: 75,
//                                                 width: 75,
//                                                 decoration: BoxDecoration(
//                                                   color: AppConstant.appSecondaryColor,
//                                                   border: Border.all(
//                                                     color: Colors.black,
//                                                     width: 1.0,
//                                                   ),
//                                                   borderRadius: BorderRadius.circular(5),
//                                                 ),
//                                                 child: Center(
//                                                   child: frontDoor == null
//                                                       ? InkWell(
//                                                     onTap: (){
//                                                       pickImageFrontDoor(ImageSource.camera,doc.docName);
//                                                     },
//                                                     child: const Text(
//                                                       "No image selected",
//                                                       textAlign: TextAlign.center,
//                                                       style: TextStyle(fontSize: 8, color: Colors.white),
//                                                     ),
//                                                   )
//                                                       : Container(
//                                                     height: 73,
//                                                     width: 73,
//                                                     color: Colors.white,
//                                                     child: Image.file(frontDoor!,fit: BoxFit.cover,),
//                                                   ),
//                                                 ),
//                                               ),
//                                               Positioned(
//                                                 top:-2, // Adjust these values to position the icon correctly
//                                                 right: 2,
//                                                 child: InkWell( // Consider using InkWell for better tap feedback
//                                                   onTap: () async {
//                                                     try {
//                                                       if (frontDoor != null) {
//                                                         await frontDoor!.delete();
//                                                         setState(() {
//                                                           frontDoor = null;
//                                                         });
//                                                         print("File deleted successfully!");
//                                                       }
//                                                     } catch (e) {
//                                                       print("Error deleting file: $e");
//                                                     }
//                                                   },
//                                                   child: Container(
//                                                     decoration: BoxDecoration(
//                                                       color: Colors.black, // Optional: background color for the icon
//                                                       shape: BoxShape.circle,
//                                                     ),
//                                                     padding: EdgeInsets.all(3), // Adjust padding as needed
//                                                     child: Icon(
//                                                       Icons.delete_forever_outlined,
//                                                       size: 18,
//                                                       color: Colors.white,
//                                                     ),
//                                                   ),
//                                                 ),
//                                               ),
//                                             ],
//                                           ):SizedBox.shrink(),
//                                           doc.docName=="Front Door"?Flexible(
//                                             child: Padding(
//                                               padding: const EdgeInsets.all(5.0),
//                                               child: Text(doc.docName,
//                                                 textAlign:TextAlign.left,softWrap:true,overflow:TextOverflow.ellipsis,maxLines:3,style: TextStyle(color: Colors.black,fontSize: 12),),
//                                             ),
//                                           ):SizedBox(),
//                                         ],
//                                       ),
//                                     ):SizedBox.shrink(),
//                                     doc.docName=="Image of Person Met With Sound Box (Inside Shop)"?Container(
//                                       height: MediaQuery.of(context).size.height/10,
//                                       width: 500,
//                                       color:Colors.white60,
//                                       child: Row(
//                                         mainAxisAlignment: MainAxisAlignment.start,
//                                         crossAxisAlignment: CrossAxisAlignment.start,
//                                         children: [
//                                           doc.docName=="Image of Person Met With Sound Box (Inside Shop)"?Stack(
//                                             children: [
//                                               Container(
//                                                 height: 75,
//                                                 width: 75,
//                                                 decoration: BoxDecoration(
//                                                   color: AppConstant.appSecondaryColor,
//                                                   border: Border.all(
//                                                     color: Colors.black,
//                                                     width: 1.0,
//                                                   ),
//                                                   borderRadius: BorderRadius.circular(5),
//                                                 ),
//                                                 child: Center(
//                                                   child: imageOfPersonMet == null
//                                                       ? InkWell(
//                                                     onTap: (){
//                                                       pickImageImageOfPersonMet(ImageSource.camera,doc.docName);
//                                                     },
//                                                     child: const Text(
//                                                       "No image selected",
//                                                       textAlign: TextAlign.center,
//                                                       style: TextStyle(fontSize: 8, color: Colors.white),
//                                                     ),
//                                                   )
//                                                       : Container(
//                                                     height: 73,
//                                                     width: 73,
//                                                     color: Colors.white,
//                                                     child: Image.file(imageOfPersonMet!,fit: BoxFit.cover,),
//                                                   ),
//                                                 ),
//                                               ),
//                                               Positioned(
//                                                 top:-2, // Adjust these values to position the icon correctly
//                                                 right: 2,
//                                                 child: InkWell( // Consider using InkWell for better tap feedback
//                                                   onTap: () async {
//                                                     try {
//                                                       if (imageOfPersonMet != null) {
//                                                         await imageOfPersonMet!.delete();
//                                                         setState(() {
//                                                           imageOfPersonMet = null;
//                                                         });
//                                                         print("File deleted successfully!");
//                                                       }
//                                                     } catch (e) {
//                                                       print("Error deleting file: $e");
//                                                     }
//                                                   },
//                                                   child: Container(
//                                                     decoration: BoxDecoration(
//                                                       color: Colors.black, // Optional: background color for the icon
//                                                       shape: BoxShape.circle,
//                                                     ),
//                                                     padding: EdgeInsets.all(3), // Adjust padding as needed
//                                                     child: Icon(
//                                                       Icons.delete_forever_outlined,
//                                                       size: 18,
//                                                       color: Colors.white,
//                                                     ),
//                                                   ),
//                                                 ),
//                                               ),
//                                             ],
//                                           ):SizedBox.shrink(),
//                                           doc.docName=="Image of Person Met With Sound Box (Inside Shop)"?Flexible(
//                                             child: Padding(
//                                               padding: const EdgeInsets.all(5.0),
//                                               child: Text(doc.docName,
//                                                 textAlign:TextAlign.left,softWrap:true,overflow:TextOverflow.ellipsis,maxLines:3,style: TextStyle(color: Colors.black,fontSize: 12),),
//                                             ),
//                                           ):SizedBox(),
//                                         ],
//                                       ),
//                                     ):SizedBox.shrink(),
//                                     doc.docName=="Bill DeskImage of Shop From OutsideBill Desk"?Container(
//                                       height: MediaQuery.of(context).size.height/10,
//                                       width: 500,
//                                       color:Colors.white60,
//                                       child: Row(
//                                         mainAxisAlignment: MainAxisAlignment.start,
//                                         crossAxisAlignment: CrossAxisAlignment.start,
//                                         children: [
//                                           doc.docName=="Bill DeskImage of Shop From OutsideBill Desk"?Stack(
//                                             children: [
//                                               Container(
//                                                 height: 75,
//                                                 width: 75,
//                                                 decoration: BoxDecoration(
//                                                   color: AppConstant.appSecondaryColor,
//                                                   border: Border.all(
//                                                     color: Colors.black,
//                                                     width: 1.0,
//                                                   ),
//                                                   borderRadius: BorderRadius.circular(5),
//                                                 ),
//                                                 child: Center(
//                                                   child: billDeskImageofShop == null
//                                                       ? InkWell(
//                                                     onTap: (){
//                                                       pickImageBillDeskImageofShop(ImageSource.camera,doc.docName);
//                                                     },
//                                                     child: const Text(
//                                                       "No image selected",
//                                                       textAlign: TextAlign.center,
//                                                       style: TextStyle(fontSize: 8, color: Colors.white),
//                                                     ),
//                                                   )
//                                                       : Container(
//                                                     height: 73,
//                                                     width: 73,
//                                                     color: Colors.white,
//                                                     child: Image.file(billDeskImageofShop!,fit: BoxFit.cover,),
//                                                   ),
//                                                 ),
//                                               ),
//                                               Positioned(
//                                                 top:-2, // Adjust these values to position the icon correctly
//                                                 right: 2,
//                                                 child: InkWell( // Consider using InkWell for better tap feedback
//                                                   onTap: () async {
//                                                     try {
//                                                       if (billDeskImageofShop != null) {
//                                                         await billDeskImageofShop!.delete();
//                                                         setState(() {
//                                                           billDeskImageofShop = null;
//                                                         });
//                                                         print("File deleted successfully!");
//                                                       }
//                                                     } catch (e) {
//                                                       print("Error deleting file: $e");
//                                                     }
//                                                   },
//                                                   child: Container(
//                                                     decoration: BoxDecoration(
//                                                       color: Colors.black, // Optional: background color for the icon
//                                                       shape: BoxShape.circle,
//                                                     ),
//                                                     padding: EdgeInsets.all(3), // Adjust padding as needed
//                                                     child: Icon(
//                                                       Icons.delete_forever_outlined,
//                                                       size: 18,
//                                                       color: Colors.white,
//                                                     ),
//                                                   ),
//                                                 ),
//                                               ),
//                                             ],
//                                           ):SizedBox.shrink(),
//                                           doc.docName=="Bill DeskImage of Shop From OutsideBill Desk"?Flexible(
//                                             child: Padding(
//                                               padding: const EdgeInsets.all(5.0),
//                                               child: Text(doc.docName,
//                                                 textAlign:TextAlign.left,softWrap:true,overflow:TextOverflow.ellipsis,maxLines:3,style: TextStyle(color: Colors.black,fontSize: 12),),
//                                             ),
//                                           ):SizedBox(),
//                                         ],
//                                       ),
//                                     ):SizedBox.shrink(),
//                                     doc.docName=="Image of Shop From Outside"?Container(
//                                       height: MediaQuery.of(context).size.height/10,
//                                       width: 500,
//                                       color:Colors.white60,
//                                       child: Row(
//                                         mainAxisAlignment: MainAxisAlignment.start,
//                                         crossAxisAlignment: CrossAxisAlignment.start,
//                                         children: [
//                                           doc.docName=="Image of Shop From Outside"?Stack(
//                                             children: [
//                                               Container(
//                                                 height: 75,
//                                                 width: 75,
//                                                 decoration: BoxDecoration(
//                                                   color: AppConstant.appSecondaryColor,
//                                                   border: Border.all(
//                                                     color: Colors.black,
//                                                     width: 1.0,
//                                                   ),
//                                                   borderRadius: BorderRadius.circular(5),
//                                                 ),
//                                                 child: Center(
//                                                   child: imageofShopFromOutside == null
//                                                       ? InkWell(
//                                                     onTap: (){
//                                                       pickImageImageofShopFromOutside(ImageSource.camera,doc.docName);
//                                                     },
//                                                     child: const Text(
//                                                       "No image selected",
//                                                       textAlign: TextAlign.center,
//                                                       style: TextStyle(fontSize: 8, color: Colors.white),
//                                                     ),
//                                                   )
//                                                       : Container(
//                                                     height: 73,
//                                                     width: 73,
//                                                     color: Colors.white,
//                                                     child: Image.file(imageofShopFromOutside!,fit: BoxFit.cover,),
//                                                   ),
//                                                 ),
//                                               ),
//                                               Positioned(
//                                                 top:-2, // Adjust these values to position the icon correctly
//                                                 right: 2,
//                                                 child: InkWell( // Consider using InkWell for better tap feedback
//                                                   onTap: () async {
//                                                     try {
//                                                       if (imageofShopFromOutside != null) {
//                                                         await imageofShopFromOutside!.delete();
//                                                         setState(() {
//                                                           imageofShopFromOutside = null;
//                                                         });
//                                                         print("File deleted successfully!");
//                                                       }
//                                                     } catch (e) {
//                                                       print("Error deleting file: $e");
//                                                     }
//                                                   },
//                                                   child: Container(
//                                                     decoration: BoxDecoration(
//                                                       color: Colors.black, // Optional: background color for the icon
//                                                       shape: BoxShape.circle,
//                                                     ),
//                                                     padding: EdgeInsets.all(3), // Adjust padding as needed
//                                                     child: Icon(
//                                                       Icons.delete_forever_outlined,
//                                                       size: 18,
//                                                       color: Colors.white,
//                                                     ),
//                                                   ),
//                                                 ),
//                                               ),
//                                             ],
//                                           ):SizedBox.shrink(),
//                                           doc.docName=="Image of Shop From Outside"?Flexible(
//                                             child: Padding(
//                                               padding: const EdgeInsets.all(5.0),
//                                               child: Text(doc.docName,
//                                                 textAlign:TextAlign.left,softWrap:true,overflow:TextOverflow.ellipsis,maxLines:3,style: TextStyle(color: Colors.black,fontSize: 12),),
//                                             ),
//                                           ):SizedBox(),
//                                         ],
//                                       ),
//                                     ):SizedBox.shrink(),
//                                     doc.docName=="Location Snap"?Container(
//                                       height: MediaQuery.of(context).size.height/10,
//                                       width: 500,
//                                       color:Colors.white60,
//                                       child: Row(
//                                         mainAxisAlignment: MainAxisAlignment.start,
//                                         crossAxisAlignment: CrossAxisAlignment.start,
//                                         children: [
//                                           doc.docName=="Location Snap"?Stack(
//                                             children: [
//                                               Container(
//                                                 height: 75,
//                                                 width: 75,
//                                                 decoration: BoxDecoration(
//                                                   color: AppConstant.appSecondaryColor,
//                                                   border: Border.all(
//                                                     color: Colors.black,
//                                                     width: 1.0,
//                                                   ),
//                                                   borderRadius: BorderRadius.circular(5),
//                                                 ),
//                                                 child: Center(
//                                                   child: locationSnap == null
//                                                       ? InkWell(
//                                                     onTap: (){
//                                                       pickImageLocationSnap(ImageSource.camera,doc.docName);
//                                                     },
//                                                     child: const Text(
//                                                       "No image selected",
//                                                       textAlign: TextAlign.center,
//                                                       style: TextStyle(fontSize: 8, color: Colors.white),
//                                                     ),
//                                                   )
//                                                       : Container(
//                                                     height: 73,
//                                                     width: 73,
//                                                     color: Colors.white,
//                                                     child: Image.file(locationSnap!,fit: BoxFit.cover,),
//                                                   ),
//                                                 ),
//                                               ),
//                                               Positioned(
//                                                 top:-2, // Adjust these values to position the icon correctly
//                                                 right: 2,
//                                                 child: InkWell( // Consider using InkWell for better tap feedback
//                                                   onTap: () async {
//                                                     try {
//                                                       if (locationSnap!= null) {
//                                                         await locationSnap!.delete();
//                                                         setState(() {
//                                                           locationSnap = null;
//                                                         });
//                                                         print("File deleted successfully!");
//                                                       }
//                                                     } catch (e) {
//                                                       print("Error deleting file: $e");
//                                                     }
//                                                   },
//                                                   child: Container(
//                                                     decoration: BoxDecoration(
//                                                       color: Colors.black, // Optional: background color for the icon
//                                                       shape: BoxShape.circle,
//                                                     ),
//                                                     padding: EdgeInsets.all(3), // Adjust padding as needed
//                                                     child: Icon(
//                                                       Icons.delete_forever_outlined,
//                                                       size: 18,
//                                                       color: Colors.white,
//                                                     ),
//                                                   ),
//                                                 ),
//                                               ),
//                                             ],
//                                           ):SizedBox.shrink(),
//                                           doc.docName=="Location Snap"?Flexible(
//                                             child: Padding(
//                                               padding: const EdgeInsets.all(5.0),
//                                               child: Text(doc.docName,
//                                                 textAlign:TextAlign.left,softWrap:true,overflow:TextOverflow.ellipsis,maxLines:3,style: TextStyle(color: Colors.black,fontSize: 12),),
//                                             ),
//                                           ):SizedBox(),
//                                         ],
//                                       ),
//                                     ):SizedBox.shrink(),
//                                     doc.docName=="Name Plate"?Container(
//                                       height: MediaQuery.of(context).size.height/10,
//                                       width: 500,
//                                       color:Colors.white60,
//                                       child: Row(
//                                         mainAxisAlignment: MainAxisAlignment.start,
//                                         crossAxisAlignment: CrossAxisAlignment.start,
//                                         children: [
//                                           doc.docName=="Name Plate"?Stack(
//                                             children: [
//                                               Container(
//                                                 height: 75,
//                                                 width: 75,
//                                                 decoration: BoxDecoration(
//                                                   color: AppConstant.appSecondaryColor,
//                                                   border: Border.all(
//                                                     color: Colors.black,
//                                                     width: 1.0,
//                                                   ),
//                                                   borderRadius: BorderRadius.circular(5),
//                                                 ),
//                                                 child: Center(
//                                                   child: namePstatic == null
//                                                       ? InkWell(
//                                                     onTap: (){
//                                                       pickImageNamePstatic(ImageSource.camera,doc.docName);
//                                                     },
//                                                     child: const Text(
//                                                       "No image selected",
//                                                       textAlign: TextAlign.center,
//                                                       style: TextStyle(fontSize: 8, color: Colors.white),
//                                                     ),
//                                                   )
//                                                       : Container(
//                                                     height: 73,
//                                                     width: 73,
//                                                     color: Colors.white,
//                                                     child: Image.file(namePstatic!,fit: BoxFit.cover,),
//                                                   ),
//                                                 ),
//                                               ),
//                                               Positioned(
//                                                 top:-2, // Adjust these values to position the icon correctly
//                                                 right: 2,
//                                                 child: InkWell( // Consider using InkWell for better tap feedback
//                                                   onTap: () async {
//                                                     try {
//                                                       if (namePstatic != null) {
//                                                         await namePstatic!.delete();
//                                                         setState(() {
//                                                           namePstatic = null;
//                                                         });
//                                                         print("File deleted successfully!");
//                                                       }
//                                                     } catch (e) {
//                                                       print("Error deleting file: $e");
//                                                     }
//                                                   },
//                                                   child: Container(
//                                                     decoration: BoxDecoration(
//                                                       color: Colors.black, // Optional: background color for the icon
//                                                       shape: BoxShape.circle,
//                                                     ),
//                                                     padding: EdgeInsets.all(3), // Adjust padding as needed
//                                                     child: Icon(
//                                                       Icons.delete_forever_outlined,
//                                                       size: 18,
//                                                       color: Colors.white,
//                                                     ),
//                                                   ),
//                                                 ),
//                                               ),
//                                             ],
//                                           ):SizedBox.shrink(),
//                                           doc.docName=="Name Plate"?Flexible(
//                                             child: Padding(
//                                               padding: const EdgeInsets.all(5.0),
//                                               child: Text(doc.docName,
//                                                 textAlign:TextAlign.left,softWrap:true,overflow:TextOverflow.ellipsis,maxLines:3,style: TextStyle(color: Colors.black,fontSize: 12),),
//                                             ),
//                                           ):SizedBox(),
//                                         ],
//                                       ),
//                                     ):SizedBox.shrink(),
//                                     doc.docName=="Photo"?Container(
//                                       height: MediaQuery.of(context).size.height/10,
//                                       width: 500,
//                                       color:Colors.white60,
//                                       child: Row(
//                                         mainAxisAlignment: MainAxisAlignment.start,
//                                         crossAxisAlignment: CrossAxisAlignment.start,
//                                         children: [
//                                           doc.docName=="Photo"?Stack(
//                                             children: [
//                                               Container(
//                                                 height: 75,
//                                                 width: 75,
//                                                 decoration: BoxDecoration(
//                                                   color: AppConstant.appSecondaryColor,
//                                                   border: Border.all(
//                                                     color: Colors.black,
//                                                     width: 1.0,
//                                                   ),
//                                                   borderRadius: BorderRadius.circular(5),
//                                                 ),
//                                                 child: Center(
//                                                   child: isLoading
//                                                       ? const CircularProgressIndicator(  // 🔹 Loader
//                                                     strokeWidth: 2,
//                                                     valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
//                                                   )
//                                                       : photo == null
//                                                       ? InkWell(
//                                                     onTap: () {
//                                                       pickImagePhoto(ImageSource.camera, doc.docName);
//                                                     },
//                                                     child: const Text(
//                                                       "No image selected",
//                                                       textAlign: TextAlign.center,
//                                                       style: TextStyle(fontSize: 8, color: Colors.white),
//                                                     ),
//                                                   )
//                                                       : Container(
//                                                     height: 73,
//                                                     width: 73,
//                                                     color: Colors.white,
//                                                     child: Image.file(
//                                                       photo!,
//                                                       fit: BoxFit.cover,
//                                                     ),
//                                                   ),
//                                                 ),
//                                               ),
//                                               Positioned(
//                                                 top:-2, // Adjust these values to position the icon correctly
//                                                 right: 2,
//                                                 child: InkWell( // Consider using InkWell for better tap feedback
//                                                   onTap: () async {
//                                                     try {
//                                                       if (photo != null) {
//                                                         await photo!.delete();
//                                                         setState(() {
//                                                           photo = null;
//                                                         });
//                                                         print("File deleted successfully!");
//                                                       }
//                                                     } catch (e) {
//                                                       print("Error deleting file: $e");
//                                                     }
//                                                   },
//                                                   child: Container(
//                                                     decoration: BoxDecoration(
//                                                       color: Colors.black, // Optional: background color for the icon
//                                                       shape: BoxShape.circle,
//                                                     ),
//                                                     padding: EdgeInsets.all(3), // Adjust padding as needed
//                                                     child: Icon(
//                                                       Icons.delete_forever_outlined,
//                                                       size: 18,
//                                                       color: Colors.white,
//                                                     ),
//                                                   ),
//                                                 ),
//                                               ),
//                                             ],
//                                           ):SizedBox.shrink(),
//                                           doc.docName=="Photo"?Flexible(
//                                             child: Padding(
//                                               padding: const EdgeInsets.all(5.0),
//                                               child: Text(doc.docName,
//                                                 textAlign:TextAlign.left,softWrap:true,overflow:TextOverflow.ellipsis,maxLines:3,style: TextStyle(color: Colors.black,fontSize: 12),),
//                                             ),
//                                           ):SizedBox(),
//                                         ],
//                                       ),
//                                     ):SizedBox.shrink(),
//                                     doc.docName=="Premises Interior"?Container(
//                                       height: MediaQuery.of(context).size.height/10,
//                                       width: 500,
//                                       color:Colors.white60,
//                                       child: Row(
//                                         mainAxisAlignment: MainAxisAlignment.start,
//                                         crossAxisAlignment: CrossAxisAlignment.start,
//                                         children: [
//                                           doc.docName=="Premises Interior"?Stack(
//                                             children: [
//                                               Container(
//                                                 height: 75,
//                                                 width: 75,
//                                                 decoration: BoxDecoration(
//                                                   color: AppConstant.appSecondaryColor,
//                                                   border: Border.all(
//                                                     color: Colors.black,
//                                                     width: 1.0,
//                                                   ),
//                                                   borderRadius: BorderRadius.circular(5),
//                                                 ),
//                                                 child: Center(
//                                                   child: premisesInterior == null
//                                                       ? InkWell(
//                                                     onTap: (){
//                                                       pickImagePremisesInterior(ImageSource.camera,doc.docName);
//                                                     },
//                                                     child: const Text(
//                                                       "No image selected",
//                                                       textAlign: TextAlign.center,
//                                                       style: TextStyle(fontSize: 8, color: Colors.white),
//                                                     ),
//                                                   )
//                                                       : Container(
//                                                     height: 73,
//                                                     width: 73,
//                                                     color: Colors.white,
//                                                     child: Image.file(premisesInterior!,fit: BoxFit.cover,),
//                                                   ),
//                                                 ),
//                                               ),
//                                               Positioned(
//                                                 top:-2, // Adjust these values to position the icon correctly
//                                                 right: 2,
//                                                 child: InkWell( // Consider using InkWell for better tap feedback
//                                                   onTap: () async {
//                                                     try {
//                                                       if (premisesInterior != null) {
//                                                         await premisesInterior!.delete();
//                                                         setState(() {
//                                                           premisesInterior = null;
//                                                         });
//                                                         print("File deleted successfully!");
//                                                       }
//                                                     } catch (e) {
//                                                       print("Error deleting file: $e");
//                                                     }
//                                                   },
//                                                   child: Container(
//                                                     decoration: BoxDecoration(
//                                                       color: Colors.black, // Optional: background color for the icon
//                                                       shape: BoxShape.circle,
//                                                     ),
//                                                     padding: EdgeInsets.all(3), // Adjust padding as needed
//                                                     child: Icon(
//                                                       Icons.delete_forever_outlined,
//                                                       size: 18,
//                                                       color: Colors.white,
//                                                     ),
//                                                   ),
//                                                 ),
//                                               ),
//                                             ],
//                                           ):SizedBox.shrink(),
//                                           doc.docName=="Premises Interior"?Flexible(
//                                             child: Padding(
//                                               padding: const EdgeInsets.all(5.0),
//                                               child: Text(doc.docName,
//                                                 textAlign:TextAlign.left,softWrap:true,overflow:TextOverflow.ellipsis,maxLines:3,style: TextStyle(color: Colors.black,fontSize: 12),),
//                                             ),
//                                           ):SizedBox(),
//                                         ],
//                                       ),
//                                     ):SizedBox.shrink(),
//                                     doc.docName=="QR Code"?Container(
//                                       height: MediaQuery.of(context).size.height/10,
//                                       width: 500,
//                                       color:Colors.white60,
//                                       child: Row(
//                                         mainAxisAlignment: MainAxisAlignment.start,
//                                         crossAxisAlignment: CrossAxisAlignment.start,
//                                         children: [
//                                           doc.docName=="QR Code"?Stack(
//                                             children: [
//                                               Container(
//                                                 height: 75,
//                                                 width: 75,
//                                                 decoration: BoxDecoration(
//                                                   color: AppConstant.appSecondaryColor,
//                                                   border: Border.all(
//                                                     color: Colors.black,
//                                                     width: 1.0,
//                                                   ),
//                                                   borderRadius: BorderRadius.circular(5),
//                                                 ),
//                                                 child: Center(
//                                                   child: qRCode == null
//                                                       ? InkWell(
//                                                     onTap: (){
//                                                       pickImageQRCode(ImageSource.camera,doc.docName);
//                                                     },
//                                                     child: const Text(
//                                                       "No image selected",
//                                                       textAlign: TextAlign.center,
//                                                       style: TextStyle(fontSize: 8, color: Colors.white),
//                                                     ),
//                                                   )
//                                                       : Container(
//                                                     height: 73,
//                                                     width: 73,
//                                                     color: Colors.white,
//                                                     child: Image.file(qRCode!,fit: BoxFit.cover,),
//                                                   ),
//                                                 ),
//                                               ),
//                                               Positioned(
//                                                 top:-2, // Adjust these values to position the icon correctly
//                                                 right: 2,
//                                                 child: InkWell( // Consider using InkWell for better tap feedback
//                                                   onTap: () async {
//                                                     try {
//                                                       if (qRCode != null) {
//                                                         await qRCode!.delete();
//                                                         setState(() {
//                                                           qRCode = null;
//                                                         });
//                                                         print("File deleted successfully!");
//                                                       }
//                                                     } catch (e) {
//                                                       print("Error deleting file: $e");
//                                                     }
//                                                   },
//                                                   child: Container(
//                                                     decoration: BoxDecoration(
//                                                       color: Colors.black, // Optional: background color for the icon
//                                                       shape: BoxShape.circle,
//                                                     ),
//                                                     padding: EdgeInsets.all(3), // Adjust padding as needed
//                                                     child: Icon(
//                                                       Icons.delete_forever_outlined,
//                                                       size: 18,
//                                                       color: Colors.white,
//                                                     ),
//                                                   ),
//                                                 ),
//                                               ),
//                                             ],
//                                           ):SizedBox.shrink(),
//                                           doc.docName=="QR Code"?Flexible(
//                                             child: Padding(
//                                               padding: const EdgeInsets.all(5.0),
//                                               child: Text(doc.docName,
//                                                 textAlign:TextAlign.left,softWrap:true,overflow:TextOverflow.ellipsis,maxLines:3,style: TextStyle(color: Colors.black,fontSize: 12),),
//                                             ),
//                                           ):SizedBox(),
//                                         ],
//                                       ),
//                                     ):SizedBox.shrink(),
//                                     doc.docName=="Stock"?Container(
//                                       height: MediaQuery.of(context).size.height/10,
//                                       width: 500,
//                                       color:Colors.white60,
//                                       child: Row(
//                                         mainAxisAlignment: MainAxisAlignment.start,
//                                         crossAxisAlignment: CrossAxisAlignment.start,
//                                         children: [
//                                           doc.docName=="Stock"?Stack(
//                                             children: [
//                                               Container(
//                                                 height: 75,
//                                                 width: 75,
//                                                 decoration: BoxDecoration(
//                                                   color: AppConstant.appSecondaryColor,
//                                                   border: Border.all(
//                                                     color: Colors.black,
//                                                     width: 1.0,
//                                                   ),
//                                                   borderRadius: BorderRadius.circular(5),
//                                                 ),
//                                                 child: Center(
//                                                   child: stock == null
//                                                       ? InkWell(
//                                                     onTap: (){
//                                                       pickImageStock(ImageSource.camera,doc.docName);
//                                                     },
//                                                     child: const Text(
//                                                       "No image selected",
//                                                       textAlign: TextAlign.center,
//                                                       style: TextStyle(fontSize: 8, color: Colors.white),
//                                                     ),
//                                                   )
//                                                       : Container(
//                                                     height: 73,
//                                                     width: 73,
//                                                     color: Colors.white,
//                                                     child: Image.file(stock!,fit: BoxFit.cover,),
//                                                   ),
//                                                 ),
//                                               ),
//                                               Positioned(
//                                                 top:-2, // Adjust these values to position the icon correctly
//                                                 right: 2,
//                                                 child: InkWell( // Consider using InkWell for better tap feedback
//                                                   onTap: () async {
//                                                     try {
//                                                       if (stock != null) {
//                                                         await stock!.delete();
//                                                         setState(() {
//                                                           stock = null;
//                                                         });
//                                                         print("File deleted successfully!");
//                                                       }
//                                                     } catch (e) {
//                                                       print("Error deleting file: $e");
//                                                     }
//                                                   },
//                                                   child: Container(
//                                                     decoration: BoxDecoration(
//                                                       color: Colors.black, // Optional: background color for the icon
//                                                       shape: BoxShape.circle,
//                                                     ),
//                                                     padding: EdgeInsets.all(3), // Adjust padding as needed
//                                                     child: Icon(
//                                                       Icons.delete_forever_outlined,
//                                                       size: 18,
//                                                       color: Colors.white,
//                                                     ),
//                                                   ),
//                                                 ),
//                                               ),
//                                             ],
//                                           ):SizedBox.shrink(),
//                                           doc.docName=="Stock"?Flexible(
//                                             child: Padding(
//                                               padding: const EdgeInsets.all(5.0),
//                                               child: Text(doc.docName,
//                                                 textAlign:TextAlign.left,softWrap:true,overflow:TextOverflow.ellipsis,maxLines:3,style: TextStyle(color: Colors.black,fontSize: 12),),
//                                             ),
//                                           ):SizedBox(),
//                                         ],
//                                       ),
//                                     ):SizedBox.shrink(),
//                                     doc.docName=="Tent Card"?Container(
//                                       height: MediaQuery.of(context).size.height/10,
//                                       width: 500,
//                                       color:Colors.white60,
//                                       child: Row(
//                                         mainAxisAlignment: MainAxisAlignment.start,
//                                         crossAxisAlignment: CrossAxisAlignment.start,
//                                         children: [
//                                           doc.docName=="Tent Card"?Stack(
//                                             children: [
//                                               Container(
//                                                 height: 75,
//                                                 width: 75,
//                                                 decoration: BoxDecoration(
//                                                   color: AppConstant.appSecondaryColor,
//                                                   border: Border.all(
//                                                     color: Colors.black,
//                                                     width: 1.0,
//                                                   ),
//                                                   borderRadius: BorderRadius.circular(5),
//                                                 ),
//                                                 child: Center(
//                                                   child: tentCard == null
//                                                       ? InkWell(
//                                                     onTap: (){
//                                                       pickImageTentCard(ImageSource.camera,doc.docName);
//                                                     },
//                                                     child: const Text(
//                                                       "No image selected",
//                                                       textAlign: TextAlign.center,
//                                                       style: TextStyle(fontSize: 8, color: Colors.white),
//                                                     ),
//                                                   )
//                                                       : Container(
//                                                     height: 73,
//                                                     width: 73,
//                                                     color: Colors.white,
//                                                     child: Image.file(tentCard!,fit: BoxFit.cover,),
//                                                   ),
//                                                 ),
//                                               ),
//                                               Positioned(
//                                                 top:-2, // Adjust these values to position the icon correctly
//                                                 right: 2,
//                                                 child: InkWell( // Consider using InkWell for better tap feedback
//                                                   onTap: () async {
//                                                     try {
//                                                       if (tentCard != null) {
//                                                         await tentCard!.delete();
//                                                         setState(() {
//                                                           tentCard = null;
//                                                         });
//                                                         print("File deleted successfully!");
//                                                       }
//                                                     } catch (e) {
//                                                       print("Error deleting file: $e");
//                                                     }
//                                                   },
//                                                   child: Container(
//                                                     decoration: BoxDecoration(
//                                                       color: Colors.black, // Optional: background color for the icon
//                                                       shape: BoxShape.circle,
//                                                     ),
//                                                     padding: EdgeInsets.all(3), // Adjust padding as needed
//                                                     child: Icon(
//                                                       Icons.delete_forever_outlined,
//                                                       size: 18,
//                                                       color: Colors.white,
//                                                     ),
//                                                   ),
//                                                 ),
//                                               ),
//                                             ],
//                                           ):SizedBox.shrink(),
//                                           doc.docName=="Tent Card"?Flexible(
//                                             child: Padding(
//                                               padding: const EdgeInsets.all(5.0),
//                                               child: Text(doc.docName,
//                                                 textAlign:TextAlign.left,softWrap:true,overflow:TextOverflow.ellipsis,maxLines:3,style: TextStyle(color: Colors.black,fontSize: 12),),
//                                             ),
//                                           ):SizedBox(),
//                                         ],
//                                       ),
//                                     ):SizedBox.shrink(),
//                                     doc.docName=="Political Connections"?Container(
//                                       height: MediaQuery.of(context).size.height/10,
//                                       width: 500,
//                                       color:Colors.white60,
//                                       child: Row(
//                                         mainAxisAlignment: MainAxisAlignment.start,
//                                         crossAxisAlignment: CrossAxisAlignment.start,
//                                         children: [
//                                           doc.docName=="Political Connections"?Stack(
//                                             children: [
//                                               Container(
//                                                 height: 75,
//                                                 width: 75,
//                                                 decoration: BoxDecoration(
//                                                   color: AppConstant.appSecondaryColor,
//                                                   border: Border.all(
//                                                     color: Colors.black,
//                                                     width: 1.0,
//                                                   ),
//                                                   borderRadius: BorderRadius.circular(5),
//                                                 ),
//                                                 child: Center(
//                                                   child: politicalConnections == null
//                                                       ? InkWell(
//                                                     onTap: (){
//                                                       pickImagePoliticalConnections(ImageSource.camera,doc.docName);
//                                                     },
//                                                     child: const Text(
//                                                       "No image selected",
//                                                       textAlign: TextAlign.center,
//                                                       style: TextStyle(fontSize: 8, color: Colors.white),
//                                                     ),
//                                                   )
//                                                       : Container(
//                                                     height: 73,
//                                                     width: 73,
//                                                     color: Colors.white,
//                                                     child: Image.file(politicalConnections!,fit: BoxFit.cover,),
//                                                   ),
//                                                 ),
//                                               ),
//                                               Positioned(
//                                                 top:-2, // Adjust these values to position the icon correctly
//                                                 right: 2,
//                                                 child: InkWell( // Consider using InkWell for better tap feedback
//                                                   onTap: () async {
//                                                     try {
//                                                       if (politicalConnections != null) {
//                                                         await politicalConnections!.delete();
//                                                         setState(() {
//                                                           politicalConnections= null;
//                                                         });
//                                                         print("File deleted successfully!");
//                                                       }
//                                                     } catch (e) {
//                                                       print("Error deleting file: $e");
//                                                     }
//                                                   },
//                                                   child: Container(
//                                                     decoration: BoxDecoration(
//                                                       color: Colors.black, // Optional: background color for the icon
//                                                       shape: BoxShape.circle,
//                                                     ),
//                                                     padding: EdgeInsets.all(3), // Adjust padding as needed
//                                                     child: Icon(
//                                                       Icons.delete_forever_outlined,
//                                                       size: 18,
//                                                       color: Colors.white,
//                                                     ),
//                                                   ),
//                                                 ),
//                                               ),
//                                             ],
//                                           ):SizedBox.shrink(),
//                                           doc.docName=="Political Connections"?Flexible(
//                                             child: Padding(
//                                               padding: const EdgeInsets.all(5.0),
//                                               child: Text(doc.docName,
//                                                 textAlign:TextAlign.left,softWrap:true,overflow:TextOverflow.ellipsis,maxLines:3,style: TextStyle(color: Colors.black,fontSize: 12),),
//                                             ),
//                                           ):SizedBox(),
//                                         ],
//                                       ),
//                                     ):SizedBox.shrink(),
//                                   ],
//                                 ):SizedBox.shrink(),
//                                 category == "ID PROOF" ? Column(
//                                   mainAxisAlignment: MainAxisAlignment.start,
//                                   children: [
//                                     doc.docName=="ID Proof of Person Met"?Container(
//                                       height: MediaQuery.of(context).size.height/10,
//                                       width: MediaQuery.of(context).size.width,
//                                       color:Colors.white60,
//                                       child: Row(
//                                         mainAxisAlignment: MainAxisAlignment.start,
//                                         crossAxisAlignment: CrossAxisAlignment.start,
//                                         children: [
//                                           doc.docName=="ID Proof of Person Met"?Stack(
//                                             children: [
//                                               Container(
//                                                 height: 75,
//                                                 width: 75,
//                                                 decoration: BoxDecoration(
//                                                   color: AppConstant.appSecondaryColor,
//                                                   border: Border.all(
//                                                     color: Colors.black,
//                                                     width: 1.0,
//                                                   ),
//                                                   borderRadius: BorderRadius.circular(5),
//                                                 ),
//                                                 child: Center(
//                                                   child: companuBoard == null
//                                                       ? InkWell(
//                                                     onTap: (){
//                                                       pickImageCompanyBoard(ImageSource.camera,doc.docName);
//                                                     },
//                                                     child: const Text(
//                                                       "No image selected",
//                                                       textAlign: TextAlign.center,
//                                                       style: TextStyle(fontSize: 8, color: Colors.white),
//                                                     ),
//                                                   )
//                                                       : Container(
//                                                     height: 73,
//                                                     width: 73,
//                                                     color: Colors.white,
//                                                     child: Image.file(companuBoard!,fit: BoxFit.cover,),
//                                                   ),
//                                                 ),
//                                               ),
//                                               Positioned(
//                                                 top:-2, // Adjust these values to position the icon correctly
//                                                 right: 2,
//                                                 child: InkWell( // Consider using InkWell for better tap feedback
//                                                   onTap: () async {
//                                                     try {
//                                                       if (companuBoard != null) {
//                                                         await companuBoard!.delete();
//                                                         setState(() {
//                                                           companuBoard = null;
//                                                         });
//                                                         print("File deleted successfully!");
//                                                       }
//                                                     } catch (e) {
//                                                       print("Error deleting file: $e");
//                                                     }
//                                                   },
//                                                   child: Container(
//                                                     decoration: BoxDecoration(
//                                                       color: Colors.black, // Optional: background color for the icon
//                                                       shape: BoxShape.circle,
//                                                     ),
//                                                     padding: EdgeInsets.all(3), // Adjust padding as needed
//                                                     child: Icon(
//                                                       Icons.delete_forever_outlined,
//                                                       size: 18,
//                                                       color: Colors.white,
//                                                     ),
//                                                   ),
//                                                 ),
//                                               ),
//                                             ],
//                                           ):SizedBox.shrink(),
//                                           doc.docName=="ID Proof of Person Met"?Flexible(
//                                             child: Padding(
//                                               padding: const EdgeInsets.all(5.0),
//                                               child: Text(doc.docName,
//                                                 textAlign:TextAlign.left,softWrap:true,overflow:TextOverflow.ellipsis,maxLines:3,style: TextStyle(color: Colors.black,fontSize: 12),),
//                                             ),
//                                           ):SizedBox(),
//                                         ],
//                                       ),
//                                     ):SizedBox.shrink(),
//                                     doc.docName=="Pancard"?Container(
//                                       height: MediaQuery.of(context).size.height/10,
//                                       width: MediaQuery.of(context).size.width,
//                                       color:Colors.white60,
//                                       child: Row(
//                                         mainAxisAlignment: MainAxisAlignment.start,
//                                         crossAxisAlignment: CrossAxisAlignment.start,
//                                         children: [
//                                           doc.docName=="ID Proof of Person Met"?Stack(
//                                             children: [
//                                               Container(
//                                                 height: 75,
//                                                 width: 75,
//                                                 decoration: BoxDecoration(
//                                                   color: AppConstant.appSecondaryColor,
//                                                   border: Border.all(
//                                                     color: Colors.black,
//                                                     width: 1.0,
//                                                   ),
//                                                   borderRadius: BorderRadius.circular(5),
//                                                 ),
//                                                 child: Center(
//                                                   child: companuBoard == null
//                                                       ? InkWell(
//                                                     onTap: (){
//                                                       pickImageCompanyBoard(ImageSource.camera,doc.docName);
//                                                     },
//                                                     child: const Text(
//                                                       "No image selected",
//                                                       textAlign: TextAlign.center,
//                                                       style: TextStyle(fontSize: 8, color: Colors.white),
//                                                     ),
//                                                   )
//                                                       : Container(
//                                                     height: 73,
//                                                     width: 73,
//                                                     color: Colors.white,
//                                                     child: Image.file(companuBoard!,fit: BoxFit.cover,),
//                                                   ),
//                                                 ),
//                                               ),
//                                               Positioned(
//                                                 top:-2, // Adjust these values to position the icon correctly
//                                                 right: 2,
//                                                 child: InkWell( // Consider using InkWell for better tap feedback
//                                                   onTap: () async {
//                                                     try {
//                                                       if (companuBoard != null) {
//                                                         await companuBoard!.delete();
//                                                         setState(() {
//                                                           companuBoard = null;
//                                                         });
//                                                         print("File deleted successfully!");
//                                                       }
//                                                     } catch (e) {
//                                                       print("Error deleting file: $e");
//                                                     }
//                                                   },
//                                                   child: Container(
//                                                     decoration: BoxDecoration(
//                                                       color: Colors.black, // Optional: background color for the icon
//                                                       shape: BoxShape.circle,
//                                                     ),
//                                                     padding: EdgeInsets.all(3), // Adjust padding as needed
//                                                     child: Icon(
//                                                       Icons.delete_forever_outlined,
//                                                       size: 18,
//                                                       color: Colors.white,
//                                                     ),
//                                                   ),
//                                                 ),
//                                               ),
//                                             ],
//                                           ):SizedBox.shrink(),
//                                           doc.docName=="Pancard"?Flexible(
//                                             child: Padding(
//                                               padding: const EdgeInsets.all(5.0),
//                                               child: Text(doc.docName,
//                                                 textAlign:TextAlign.left,softWrap:true,overflow:TextOverflow.ellipsis,maxLines:3,style: TextStyle(color: Colors.black,fontSize: 12),),
//                                             ),
//                                           ):SizedBox(),
//                                         ],
//                                       ),
//                                     ):SizedBox.shrink(),
//                                   ],
//                                 ):SizedBox.shrink(),
//                                 category == "OTHERS" ? Column(
//                                   mainAxisAlignment: MainAxisAlignment.start,
//                                   children: [
//                                     doc.docName=="Annexure"?Container(
//                                       height: MediaQuery.of(context).size.height/10,
//                                       width: MediaQuery.of(context).size.width,
//                                       color:Colors.white60,
//                                       child: Row(
//                                         mainAxisAlignment: MainAxisAlignment.start,
//                                         crossAxisAlignment: CrossAxisAlignment.start,
//                                         children: [
//                                           doc.docName=="Annexure"?Stack(
//                                             children: [
//                                               Container(
//                                                 height: 75,
//                                                 width: 75,
//                                                 decoration: BoxDecoration(
//                                                   color: AppConstant.appSecondaryColor,
//                                                   border: Border.all(
//                                                     color: Colors.black,
//                                                     width: 1.0,
//                                                   ),
//                                                   borderRadius: BorderRadius.circular(5),
//                                                 ),
//                                                 child: Center(
//                                                   child: companuBoard == null
//                                                       ? InkWell(
//                                                     onTap: (){
//                                                       pickImageCompanyBoard(ImageSource.camera,doc.docName);
//                                                     },
//                                                     child: const Text(
//                                                       "No image selected",
//                                                       textAlign: TextAlign.center,
//                                                       style: TextStyle(fontSize: 8, color: Colors.white),
//                                                     ),
//                                                   )
//                                                       : Container(
//                                                     height: 73,
//                                                     width: 73,
//                                                     color: Colors.white,
//                                                     child: Image.file(companuBoard!,fit: BoxFit.cover,),
//                                                   ),
//                                                 ),
//                                               ),
//                                               Positioned(
//                                                 top:-2, // Adjust these values to position the icon correctly
//                                                 right: 2,
//                                                 child: InkWell( // Consider using InkWell for better tap feedback
//                                                   onTap: () async {
//                                                     try {
//                                                       if (companuBoard != null) {
//                                                         await companuBoard!.delete();
//                                                         setState(() {
//                                                           companuBoard = null;
//                                                         });
//                                                         print("File deleted successfully!");
//                                                       }
//                                                     } catch (e) {
//                                                       print("Error deleting file: $e");
//                                                     }
//                                                   },
//                                                   child: Container(
//                                                     decoration: BoxDecoration(
//                                                       color: Colors.black, // Optional: background color for the icon
//                                                       shape: BoxShape.circle,
//                                                     ),
//                                                     padding: EdgeInsets.all(3), // Adjust padding as needed
//                                                     child: Icon(
//                                                       Icons.delete_forever_outlined,
//                                                       size: 18,
//                                                       color: Colors.white,
//                                                     ),
//                                                   ),
//                                                 ),
//                                               ),
//                                             ],
//                                           ):SizedBox.shrink(),
//                                           doc.docName=="Annexure"?Flexible(
//                                             child: Padding(
//                                               padding: const EdgeInsets.all(5.0),
//                                               child: Text(doc.docName,
//                                                 textAlign:TextAlign.left,softWrap:true,overflow:TextOverflow.ellipsis,maxLines:3,style: TextStyle(color: Colors.black,fontSize: 12),),
//                                             ),
//                                           ):SizedBox(),
//                                         ],
//                                       ),
//                                     ):SizedBox.shrink(),
//                                     doc.docName=="Others"?Container(
//                                       height: MediaQuery.of(context).size.height/10,
//                                       width: MediaQuery.of(context).size.width,
//                                       color:Colors.white60,
//                                       child: Row(
//                                         mainAxisAlignment: MainAxisAlignment.start,
//                                         crossAxisAlignment: CrossAxisAlignment.start,
//                                         children: [
//                                           doc.docName=="Others"?Stack(
//                                             children: [
//                                               Container(
//                                                 height: 75,
//                                                 width: 75,
//                                                 decoration: BoxDecoration(
//                                                   color: AppConstant.appSecondaryColor,
//                                                   border: Border.all(
//                                                     color: Colors.black,
//                                                     width: 1.0,
//                                                   ),
//                                                   borderRadius: BorderRadius.circular(5),
//                                                 ),
//                                                 child: Center(
//                                                   child: companuBoard == null
//                                                       ? InkWell(
//                                                     onTap: (){
//                                                       pickImageCompanyBoard(ImageSource.camera,doc.docName);
//                                                     },
//                                                     child: const Text(
//                                                       "No image selected",
//                                                       textAlign: TextAlign.center,
//                                                       style: TextStyle(fontSize: 8, color: Colors.white),
//                                                     ),
//                                                   )
//                                                       : Container(
//                                                     height: 73,
//                                                     width: 73,
//                                                     color: Colors.white,
//                                                     child: Image.file(companuBoard!,fit: BoxFit.cover,),
//                                                   ),
//                                                 ),
//                                               ),
//                                               Positioned(
//                                                 top:-2, // Adjust these values to position the icon correctly
//                                                 right: 2,
//                                                 child: InkWell( // Consider using InkWell for better tap feedback
//                                                   onTap: () async {
//                                                     try {
//                                                       if (companuBoard != null) {
//                                                         await companuBoard!.delete();
//                                                         setState(() {
//                                                           companuBoard = null;
//                                                         });
//                                                         print("File deleted successfully!");
//                                                       }
//                                                     } catch (e) {
//                                                       print("Error deleting file: $e");
//                                                     }
//                                                   },
//                                                   child: Container(
//                                                     decoration: BoxDecoration(
//                                                       color: Colors.black, // Optional: background color for the icon
//                                                       shape: BoxShape.circle,
//                                                     ),
//                                                     padding: EdgeInsets.all(3), // Adjust padding as needed
//                                                     child: Icon(
//                                                       Icons.delete_forever_outlined,
//                                                       size: 18,
//                                                       color: Colors.white,
//                                                     ),
//                                                   ),
//                                                 ),
//                                               ),
//                                             ],
//                                           ):SizedBox.shrink(),
//                                           doc.docName=="Others"?Flexible(
//                                             child: Padding(
//                                               padding: const EdgeInsets.all(5.0),
//                                               child: Text(doc.docName,
//                                                 textAlign:TextAlign.left,softWrap:true,overflow:TextOverflow.ellipsis,maxLines:3,style: TextStyle(color: Colors.black,fontSize: 12),),
//                                             ),
//                                           ):SizedBox(),
//                                         ],
//                                       ),
//                                     ):SizedBox.shrink(),
//                                     doc.docName=="1 month Bank Statement"?Container(
//                                       height: MediaQuery.of(context).size.height/10,
//                                       width: MediaQuery.of(context).size.width,
//                                       color:Colors.white60,
//                                       child: Row(
//                                         mainAxisAlignment: MainAxisAlignment.start,
//                                         crossAxisAlignment: CrossAxisAlignment.start,
//                                         children: [
//                                           doc.docName=="1 month Bank Statement"?Stack(
//                                             children: [
//                                               Container(
//                                                 height: 75,
//                                                 width: 75,
//                                                 decoration: BoxDecoration(
//                                                   color: AppConstant.appSecondaryColor,
//                                                   border: Border.all(
//                                                     color: Colors.black,
//                                                     width: 1.0,
//                                                   ),
//                                                   borderRadius: BorderRadius.circular(5),
//                                                 ),
//                                                 child: Center(
//                                                   child: companuBoard == null
//                                                       ? InkWell(
//                                                     onTap: (){
//                                                       pickImageCompanyBoard(ImageSource.camera,doc.docName);
//                                                     },
//                                                     child: const Text(
//                                                       "No image selected",
//                                                       textAlign: TextAlign.center,
//                                                       style: TextStyle(fontSize: 8, color: Colors.white),
//                                                     ),
//                                                   )
//                                                       : Container(
//                                                     height: 73,
//                                                     width: 73,
//                                                     color: Colors.white,
//                                                     child: Image.file(companuBoard!,fit: BoxFit.cover,),
//                                                   ),
//                                                 ),
//                                               ),
//                                               Positioned(
//                                                 top:-2, // Adjust these values to position the icon correctly
//                                                 right: 2,
//                                                 child: InkWell( // Consider using InkWell for better tap feedback
//                                                   onTap: () async {
//                                                     try {
//                                                       if (companuBoard != null) {
//                                                         await companuBoard!.delete();
//                                                         setState(() {
//                                                           companuBoard = null;
//                                                         });
//                                                         print("File deleted successfully!");
//                                                       }
//                                                     } catch (e) {
//                                                       print("Error deleting file: $e");
//                                                     }
//                                                   },
//                                                   child: Container(
//                                                     decoration: BoxDecoration(
//                                                       color: Colors.black, // Optional: background color for the icon
//                                                       shape: BoxShape.circle,
//                                                     ),
//                                                     padding: EdgeInsets.all(3), // Adjust padding as needed
//                                                     child: Icon(
//                                                       Icons.delete_forever_outlined,
//                                                       size: 18,
//                                                       color: Colors.white,
//                                                     ),
//                                                   ),
//                                                 ),
//                                               ),
//                                             ],
//                                           ):SizedBox.shrink(),
//                                           doc.docName=="1 month Bank Statement"?Flexible(
//                                             child: Padding(
//                                               padding: const EdgeInsets.all(5.0),
//                                               child: Text(doc.docName,
//                                                 textAlign:TextAlign.left,softWrap:true,overflow:TextOverflow.ellipsis,maxLines:3,style: TextStyle(color: Colors.black,fontSize: 12),),
//                                             ),
//                                           ):SizedBox(),
//                                         ],
//                                       ),
//                                     ):SizedBox.shrink(),
//                                     doc.docName=="Cancelled Cheque"?Container(
//                                       height: MediaQuery.of(context).size.height/10,
//                                       width: MediaQuery.of(context).size.width,
//                                       color:Colors.white60,
//                                       child: Row(
//                                         mainAxisAlignment: MainAxisAlignment.start,
//                                         crossAxisAlignment: CrossAxisAlignment.start,
//                                         children: [
//                                           doc.docName=="Cancelled Cheque"?Stack(
//                                             children: [
//                                               Container(
//                                                 height: 75,
//                                                 width: 75,
//                                                 decoration: BoxDecoration(
//                                                   color: AppConstant.appSecondaryColor,
//                                                   border: Border.all(
//                                                     color: Colors.black,
//                                                     width: 1.0,
//                                                   ),
//                                                   borderRadius: BorderRadius.circular(5),
//                                                 ),
//                                                 child: Center(
//                                                   child: companuBoard == null
//                                                       ? InkWell(
//                                                     onTap: (){
//                                                       pickImageCompanyBoard(ImageSource.camera,doc.docName);
//                                                     },
//                                                     child: const Text(
//                                                       "No image selected",
//                                                       textAlign: TextAlign.center,
//                                                       style: TextStyle(fontSize: 8, color: Colors.white),
//                                                     ),
//                                                   )
//                                                       : Container(
//                                                     height: 73,
//                                                     width: 73,
//                                                     color: Colors.white,
//                                                     child: Image.file(companuBoard!,fit: BoxFit.cover,),
//                                                   ),
//                                                 ),
//                                               ),
//                                               Positioned(
//                                                 top:-2, // Adjust these values to position the icon correctly
//                                                 right: 2,
//                                                 child: InkWell( // Consider using InkWell for better tap feedback
//                                                   onTap: () async {
//                                                     try {
//                                                       if (companuBoard != null) {
//                                                         await companuBoard!.delete();
//                                                         setState(() {
//                                                           companuBoard = null;
//                                                         });
//                                                         print("File deleted successfully!");
//                                                       }
//                                                     } catch (e) {
//                                                       print("Error deleting file: $e");
//                                                     }
//                                                   },
//                                                   child: Container(
//                                                     decoration: BoxDecoration(
//                                                       color: Colors.black, // Optional: background color for the icon
//                                                       shape: BoxShape.circle,
//                                                     ),
//                                                     padding: EdgeInsets.all(3), // Adjust padding as needed
//                                                     child: Icon(
//                                                       Icons.delete_forever_outlined,
//                                                       size: 18,
//                                                       color: Colors.white,
//                                                     ),
//                                                   ),
//                                                 ),
//                                               ),
//                                             ],
//                                           ):SizedBox.shrink(),
//                                           doc.docName=="Cancelled Cheque"?Flexible(
//                                             child: Padding(
//                                               padding: const EdgeInsets.all(5.0),
//                                               child: Text(doc.docName,
//                                                 textAlign:TextAlign.left,softWrap:true,overflow:TextOverflow.ellipsis,maxLines:3,style: TextStyle(color: Colors.black,fontSize: 12),),
//                                             ),
//                                           ):SizedBox(),
//                                         ],
//                                       ),
//                                     ):SizedBox.shrink(),
//                                     doc.docName=="Company ID"?Container(
//                                       height: MediaQuery.of(context).size.height/10,
//                                       width: MediaQuery.of(context).size.width,
//                                       color:Colors.white60,
//                                       child: Row(
//                                         mainAxisAlignment: MainAxisAlignment.start,
//                                         crossAxisAlignment: CrossAxisAlignment.start,
//                                         children: [
//                                           doc.docName=="Company ID"?Stack(
//                                             children: [
//                                               Container(
//                                                 height: 75,
//                                                 width: 75,
//                                                 decoration: BoxDecoration(
//                                                   color: AppConstant.appSecondaryColor,
//                                                   border: Border.all(
//                                                     color: Colors.black,
//                                                     width: 1.0,
//                                                   ),
//                                                   borderRadius: BorderRadius.circular(5),
//                                                 ),
//                                                 child: Center(
//                                                   child: companuBoard == null
//                                                       ? InkWell(
//                                                     onTap: (){
//                                                       pickImageCompanyBoard(ImageSource.camera,doc.docName);
//                                                     },
//                                                     child: const Text(
//                                                       "No image selected",
//                                                       textAlign: TextAlign.center,
//                                                       style: TextStyle(fontSize: 8, color: Colors.white),
//                                                     ),
//                                                   )
//                                                       : Container(
//                                                     height: 73,
//                                                     width: 73,
//                                                     color: Colors.white,
//                                                     child: Image.file(companuBoard!,fit: BoxFit.cover,),
//                                                   ),
//                                                 ),
//                                               ),
//                                               Positioned(
//                                                 top:-2, // Adjust these values to position the icon correctly
//                                                 right: 2,
//                                                 child: InkWell( // Consider using InkWell for better tap feedback
//                                                   onTap: () async {
//                                                     try {
//                                                       if (companuBoard != null) {
//                                                         await companuBoard!.delete();
//                                                         setState(() {
//                                                           companuBoard = null;
//                                                         });
//                                                         print("File deleted successfully!");
//                                                       }
//                                                     } catch (e) {
//                                                       print("Error deleting file: $e");
//                                                     }
//                                                   },
//                                                   child: Container(
//                                                     decoration: BoxDecoration(
//                                                       color: Colors.black, // Optional: background color for the icon
//                                                       shape: BoxShape.circle,
//                                                     ),
//                                                     padding: EdgeInsets.all(3), // Adjust padding as needed
//                                                     child: Icon(
//                                                       Icons.delete_forever_outlined,
//                                                       size: 18,
//                                                       color: Colors.white,
//                                                     ),
//                                                   ),
//                                                 ),
//                                               ),
//                                             ],
//                                           ):SizedBox.shrink(),
//                                           doc.docName=="Company ID"?Flexible(
//                                             child: Padding(
//                                               padding: const EdgeInsets.all(5.0),
//                                               child: Text(doc.docName,
//                                                 textAlign:TextAlign.left,softWrap:true,overflow:TextOverflow.ellipsis,maxLines:3,style: TextStyle(color: Colors.black,fontSize: 12),),
//                                             ),
//                                           ):SizedBox(),
//                                         ],
//                                       ),
//                                     ):SizedBox.shrink(),
//                                     doc.docName=="Completely Filled Job Sheet Image"?Container(
//                                       height: MediaQuery.of(context).size.height/10,
//                                       width: MediaQuery.of(context).size.width,
//                                       color:Colors.white60,
//                                       child: Row(
//                                         mainAxisAlignment: MainAxisAlignment.start,
//                                         crossAxisAlignment: CrossAxisAlignment.start,
//                                         children: [
//                                           doc.docName=="Completely Filled Job Sheet Image"?Stack(
//                                             children: [
//                                               Container(
//                                                 height: 75,
//                                                 width: 75,
//                                                 decoration: BoxDecoration(
//                                                   color: AppConstant.appSecondaryColor,
//                                                   border: Border.all(
//                                                     color: Colors.black,
//                                                     width: 1.0,
//                                                   ),
//                                                   borderRadius: BorderRadius.circular(5),
//                                                 ),
//                                                 child: Center(
//                                                   child: companuBoard == null
//                                                       ? InkWell(
//                                                     onTap: (){
//                                                       pickImageCompanyBoard(ImageSource.camera,doc.docName);
//                                                     },
//                                                     child: const Text(
//                                                       "No image selected",
//                                                       textAlign: TextAlign.center,
//                                                       style: TextStyle(fontSize: 8, color: Colors.white),
//                                                     ),
//                                                   )
//                                                       : Container(
//                                                     height: 73,
//                                                     width: 73,
//                                                     color: Colors.white,
//                                                     child: Image.file(companuBoard!,fit: BoxFit.cover,),
//                                                   ),
//                                                 ),
//                                               ),
//                                               Positioned(
//                                                 top:-2, // Adjust these values to position the icon correctly
//                                                 right: 2,
//                                                 child: InkWell( // Consider using InkWell for better tap feedback
//                                                   onTap: () async {
//                                                     try {
//                                                       if (companuBoard != null) {
//                                                         await companuBoard!.delete();
//                                                         setState(() {
//                                                           companuBoard = null;
//                                                         });
//                                                         print("File deleted successfully!");
//                                                       }
//                                                     } catch (e) {
//                                                       print("Error deleting file: $e");
//                                                     }
//                                                   },
//                                                   child: Container(
//                                                     decoration: BoxDecoration(
//                                                       color: Colors.black, // Optional: background color for the icon
//                                                       shape: BoxShape.circle,
//                                                     ),
//                                                     padding: EdgeInsets.all(3), // Adjust padding as needed
//                                                     child: Icon(
//                                                       Icons.delete_forever_outlined,
//                                                       size: 18,
//                                                       color: Colors.white,
//                                                     ),
//                                                   ),
//                                                 ),
//                                               ),
//                                             ],
//                                           ):SizedBox.shrink(),
//                                           doc.docName=="Completely Filled Job Sheet Image"?Flexible(
//                                             child: Padding(
//                                               padding: const EdgeInsets.all(5.0),
//                                               child: Text(doc.docName,
//                                                 textAlign:TextAlign.left,softWrap:true,overflow:TextOverflow.ellipsis,maxLines:3,style: TextStyle(color: Colors.black,fontSize: 12),),
//                                             ),
//                                           ):SizedBox(),
//                                         ],
//                                       ),
//                                     ):SizedBox.shrink(),
//                                     doc.docName=="Due Diligence Form"?Container(
//                                       height: MediaQuery.of(context).size.height/10,
//                                       width: MediaQuery.of(context).size.width,
//                                       color:Colors.white60,
//                                       child: Row(
//                                         mainAxisAlignment: MainAxisAlignment.start,
//                                         crossAxisAlignment: CrossAxisAlignment.start,
//                                         children: [
//                                           doc.docName=="Due Diligence Form"?Stack(
//                                             children: [
//                                               Container(
//                                                 height: 75,
//                                                 width: 75,
//                                                 decoration: BoxDecoration(
//                                                   color: AppConstant.appSecondaryColor,
//                                                   border: Border.all(
//                                                     color: Colors.black,
//                                                     width: 1.0,
//                                                   ),
//                                                   borderRadius: BorderRadius.circular(5),
//                                                 ),
//                                                 child: Center(
//                                                   child: companuBoard == null
//                                                       ? InkWell(
//                                                     onTap: (){
//                                                       pickImageCompanyBoard(ImageSource.camera,doc.docName);
//                                                     },
//                                                     child: const Text(
//                                                       "No image selected",
//                                                       textAlign: TextAlign.center,
//                                                       style: TextStyle(fontSize: 8, color: Colors.white),
//                                                     ),
//                                                   )
//                                                       : Container(
//                                                     height: 73,
//                                                     width: 73,
//                                                     color: Colors.white,
//                                                     child: Image.file(companuBoard!,fit: BoxFit.cover,),
//                                                   ),
//                                                 ),
//                                               ),
//                                               Positioned(
//                                                 top:-2, // Adjust these values to position the icon correctly
//                                                 right: 2,
//                                                 child: InkWell( // Consider using InkWell for better tap feedback
//                                                   onTap: () async {
//                                                     try {
//                                                       if (companuBoard != null) {
//                                                         await companuBoard!.delete();
//                                                         setState(() {
//                                                           companuBoard = null;
//                                                         });
//                                                         print("File deleted successfully!");
//                                                       }
//                                                     } catch (e) {
//                                                       print("Error deleting file: $e");
//                                                     }
//                                                   },
//                                                   child: Container(
//                                                     decoration: BoxDecoration(
//                                                       color: Colors.black, // Optional: background color for the icon
//                                                       shape: BoxShape.circle,
//                                                     ),
//                                                     padding: EdgeInsets.all(3), // Adjust padding as needed
//                                                     child: Icon(
//                                                       Icons.delete_forever_outlined,
//                                                       size: 18,
//                                                       color: Colors.white,
//                                                     ),
//                                                   ),
//                                                 ),
//                                               ),
//                                             ],
//                                           ):SizedBox.shrink(),
//                                           doc.docName=="Due Diligence Form"?Flexible(
//                                             child: Padding(
//                                               padding: const EdgeInsets.all(5.0),
//                                               child: Text(doc.docName,
//                                                 textAlign:TextAlign.left,softWrap:true,overflow:TextOverflow.ellipsis,maxLines:3,style: TextStyle(color: Colors.black,fontSize: 12),),
//                                             ),
//                                           ):SizedBox(),
//                                         ],
//                                       ),
//                                     ):SizedBox.shrink(),
//                                     doc.docName=="Form 26AS"?Container(
//                                       height: MediaQuery.of(context).size.height/10,
//                                       width: MediaQuery.of(context).size.width,
//                                       color:Colors.white60,
//                                       child: Row(
//                                         mainAxisAlignment: MainAxisAlignment.start,
//                                         crossAxisAlignment: CrossAxisAlignment.start,
//                                         children: [
//                                           doc.docName=="Form 26AS"?Stack(
//                                             children: [
//                                               Container(
//                                                 height: 75,
//                                                 width: 75,
//                                                 decoration: BoxDecoration(
//                                                   color: AppConstant.appSecondaryColor,
//                                                   border: Border.all(
//                                                     color: Colors.black,
//                                                     width: 1.0,
//                                                   ),
//                                                   borderRadius: BorderRadius.circular(5),
//                                                 ),
//                                                 child: Center(
//                                                   child: companuBoard == null
//                                                       ? InkWell(
//                                                     onTap: (){
//                                                       pickImageCompanyBoard(ImageSource.camera,doc.docName);
//                                                     },
//                                                     child: const Text(
//                                                       "No image selected",
//                                                       textAlign: TextAlign.center,
//                                                       style: TextStyle(fontSize: 8, color: Colors.white),
//                                                     ),
//                                                   )
//                                                       : Container(
//                                                     height: 73,
//                                                     width: 73,
//                                                     color: Colors.white,
//                                                     child: Image.file(companuBoard!,fit: BoxFit.cover,),
//                                                   ),
//                                                 ),
//                                               ),
//                                               Positioned(
//                                                 top:-2, // Adjust these values to position the icon correctly
//                                                 right: 2,
//                                                 child: InkWell( // Consider using InkWell for better tap feedback
//                                                   onTap: () async {
//                                                     try {
//                                                       if (companuBoard != null) {
//                                                         await companuBoard!.delete();
//                                                         setState(() {
//                                                           companuBoard = null;
//                                                         });
//                                                         print("File deleted successfully!");
//                                                       }
//                                                     } catch (e) {
//                                                       print("Error deleting file: $e");
//                                                     }
//                                                   },
//                                                   child: Container(
//                                                     decoration: BoxDecoration(
//                                                       color: Colors.black, // Optional: background color for the icon
//                                                       shape: BoxShape.circle,
//                                                     ),
//                                                     padding: EdgeInsets.all(3), // Adjust padding as needed
//                                                     child: Icon(
//                                                       Icons.delete_forever_outlined,
//                                                       size: 18,
//                                                       color: Colors.white,
//                                                     ),
//                                                   ),
//                                                 ),
//                                               ),
//                                             ],
//                                           ):SizedBox.shrink(),
//                                           doc.docName=="Form 26AS"?Flexible(
//                                             child: Padding(
//                                               padding: const EdgeInsets.all(5.0),
//                                               child: Text(doc.docName,
//                                                 textAlign:TextAlign.left,softWrap:true,overflow:TextOverflow.ellipsis,maxLines:3,style: TextStyle(color: Colors.black,fontSize: 12),),
//                                             ),
//                                           ):SizedBox(),
//                                         ],
//                                       ),
//                                     ):SizedBox.shrink(),
//                                     doc.docName=="Form 60"?Container(
//                                       height: MediaQuery.of(context).size.height/10,
//                                       width: MediaQuery.of(context).size.width,
//                                       color:Colors.white60,
//                                       child: Row(
//                                         mainAxisAlignment: MainAxisAlignment.start,
//                                         crossAxisAlignment: CrossAxisAlignment.start,
//                                         children: [
//                                           doc.docName=="Form 60"?Stack(
//                                             children: [
//                                               Container(
//                                                 height: 75,
//                                                 width: 75,
//                                                 decoration: BoxDecoration(
//                                                   color: AppConstant.appSecondaryColor,
//                                                   border: Border.all(
//                                                     color: Colors.black,
//                                                     width: 1.0,
//                                                   ),
//                                                   borderRadius: BorderRadius.circular(5),
//                                                 ),
//                                                 child: Center(
//                                                   child: companuBoard == null
//                                                       ? InkWell(
//                                                     onTap: (){
//                                                       pickImageCompanyBoard(ImageSource.camera,doc.docName);
//                                                     },
//                                                     child: const Text(
//                                                       "No image selected",
//                                                       textAlign: TextAlign.center,
//                                                       style: TextStyle(fontSize: 8, color: Colors.white),
//                                                     ),
//                                                   )
//                                                       : Container(
//                                                     height: 73,
//                                                     width: 73,
//                                                     color: Colors.white,
//                                                     child: Image.file(companuBoard!,fit: BoxFit.cover,),
//                                                   ),
//                                                 ),
//                                               ),
//                                               Positioned(
//                                                 top:-2, // Adjust these values to position the icon correctly
//                                                 right: 2,
//                                                 child: InkWell( // Consider using InkWell for better tap feedback
//                                                   onTap: () async {
//                                                     try {
//                                                       if (companuBoard != null) {
//                                                         await companuBoard!.delete();
//                                                         setState(() {
//                                                           companuBoard = null;
//                                                         });
//                                                         print("File deleted successfully!");
//                                                       }
//                                                     } catch (e) {
//                                                       print("Error deleting file: $e");
//                                                     }
//                                                   },
//                                                   child: Container(
//                                                     decoration: BoxDecoration(
//                                                       color: Colors.black, // Optional: background color for the icon
//                                                       shape: BoxShape.circle,
//                                                     ),
//                                                     padding: EdgeInsets.all(3), // Adjust padding as needed
//                                                     child: Icon(
//                                                       Icons.delete_forever_outlined,
//                                                       size: 18,
//                                                       color: Colors.white,
//                                                     ),
//                                                   ),
//                                                 ),
//                                               ),
//                                             ],
//                                           ):SizedBox.shrink(),
//                                           doc.docName=="Form 60"?Flexible(
//                                             child: Padding(
//                                               padding: const EdgeInsets.all(5.0),
//                                               child: Text(doc.docName,
//                                                 textAlign:TextAlign.left,softWrap:true,overflow:TextOverflow.ellipsis,maxLines:3,style: TextStyle(color: Colors.black,fontSize: 12),),
//                                             ),
//                                           ):SizedBox(),
//                                         ],
//                                       ),
//                                     ):SizedBox.shrink(),
//                                     doc.docName=="Gazette Certificate"?Container(
//                                       height: MediaQuery.of(context).size.height/10,
//                                       width: MediaQuery.of(context).size.width,
//                                       color:Colors.white60,
//                                       child: Row(
//                                         mainAxisAlignment: MainAxisAlignment.start,
//                                         crossAxisAlignment: CrossAxisAlignment.start,
//                                         children: [
//                                           doc.docName=="Gazette Certificate"?Stack(
//                                             children: [
//                                               Container(
//                                                 height: 75,
//                                                 width: 75,
//                                                 decoration: BoxDecoration(
//                                                   color: AppConstant.appSecondaryColor,
//                                                   border: Border.all(
//                                                     color: Colors.black,
//                                                     width: 1.0,
//                                                   ),
//                                                   borderRadius: BorderRadius.circular(5),
//                                                 ),
//                                                 child: Center(
//                                                   child: companuBoard == null
//                                                       ? InkWell(
//                                                     onTap: (){
//                                                       pickImageCompanyBoard(ImageSource.camera,doc.docName);
//                                                     },
//                                                     child: const Text(
//                                                       "No image selected",
//                                                       textAlign: TextAlign.center,
//                                                       style: TextStyle(fontSize: 8, color: Colors.white),
//                                                     ),
//                                                   )
//                                                       : Container(
//                                                     height: 73,
//                                                     width: 73,
//                                                     color: Colors.white,
//                                                     child: Image.file(companuBoard!,fit: BoxFit.cover,),
//                                                   ),
//                                                 ),
//                                               ),
//                                               Positioned(
//                                                 top:-2, // Adjust these values to position the icon correctly
//                                                 right: 2,
//                                                 child: InkWell( // Consider using InkWell for better tap feedback
//                                                   onTap: () async {
//                                                     try {
//                                                       if (companuBoard != null) {
//                                                         await companuBoard!.delete();
//                                                         setState(() {
//                                                           companuBoard = null;
//                                                         });
//                                                         print("File deleted successfully!");
//                                                       }
//                                                     } catch (e) {
//                                                       print("Error deleting file: $e");
//                                                     }
//                                                   },
//                                                   child: Container(
//                                                     decoration: BoxDecoration(
//                                                       color: Colors.black, // Optional: background color for the icon
//                                                       shape: BoxShape.circle,
//                                                     ),
//                                                     padding: EdgeInsets.all(3), // Adjust padding as needed
//                                                     child: Icon(
//                                                       Icons.delete_forever_outlined,
//                                                       size: 18,
//                                                       color: Colors.white,
//                                                     ),
//                                                   ),
//                                                 ),
//                                               ),
//                                             ],
//                                           ):SizedBox.shrink(),
//                                           doc.docName=="Gazette Certificate"?Flexible(
//                                             child: Padding(
//                                               padding: const EdgeInsets.all(5.0),
//                                               child: Text(doc.docName,
//                                                 textAlign:TextAlign.left,softWrap:true,overflow:TextOverflow.ellipsis,maxLines:3,style: TextStyle(color: Colors.black,fontSize: 12),),
//                                             ),
//                                           ):SizedBox(),
//                                         ],
//                                       ),
//                                     ):SizedBox.shrink(),
//                                     doc.docName=="GST Annex - A"?Container(
//                                       height: MediaQuery.of(context).size.height/10,
//                                       width: MediaQuery.of(context).size.width,
//                                       color:Colors.white60,
//                                       child: Row(
//                                         mainAxisAlignment: MainAxisAlignment.start,
//                                         crossAxisAlignment: CrossAxisAlignment.start,
//                                         children: [
//                                           doc.docName=="GST Annex - A"?Stack(
//                                             children: [
//                                               Container(
//                                                 height: 75,
//                                                 width: 75,
//                                                 decoration: BoxDecoration(
//                                                   color: AppConstant.appSecondaryColor,
//                                                   border: Border.all(
//                                                     color: Colors.black,
//                                                     width: 1.0,
//                                                   ),
//                                                   borderRadius: BorderRadius.circular(5),
//                                                 ),
//                                                 child: Center(
//                                                   child: companuBoard == null
//                                                       ? InkWell(
//                                                     onTap: (){
//                                                       pickImageCompanyBoard(ImageSource.camera,doc.docName);
//                                                     },
//                                                     child: const Text(
//                                                       "No image selected",
//                                                       textAlign: TextAlign.center,
//                                                       style: TextStyle(fontSize: 8, color: Colors.white),
//                                                     ),
//                                                   )
//                                                       : Container(
//                                                     height: 73,
//                                                     width: 73,
//                                                     color: Colors.white,
//                                                     child: Image.file(companuBoard!,fit: BoxFit.cover,),
//                                                   ),
//                                                 ),
//                                               ),
//                                               Positioned(
//                                                 top:-2, // Adjust these values to position the icon correctly
//                                                 right: 2,
//                                                 child: InkWell( // Consider using InkWell for better tap feedback
//                                                   onTap: () async {
//                                                     try {
//                                                       if (companuBoard != null) {
//                                                         await companuBoard!.delete();
//                                                         setState(() {
//                                                           companuBoard = null;
//                                                         });
//                                                         print("File deleted successfully!");
//                                                       }
//                                                     } catch (e) {
//                                                       print("Error deleting file: $e");
//                                                     }
//                                                   },
//                                                   child: Container(
//                                                     decoration: BoxDecoration(
//                                                       color: Colors.black, // Optional: background color for the icon
//                                                       shape: BoxShape.circle,
//                                                     ),
//                                                     padding: EdgeInsets.all(3), // Adjust padding as needed
//                                                     child: Icon(
//                                                       Icons.delete_forever_outlined,
//                                                       size: 18,
//                                                       color: Colors.white,
//                                                     ),
//                                                   ),
//                                                 ),
//                                               ),
//                                             ],
//                                           ):SizedBox.shrink(),
//                                           doc.docName=="GST Annex - A"?Flexible(
//                                             child: Padding(
//                                               padding: const EdgeInsets.all(5.0),
//                                               child: Text(doc.docName,
//                                                 textAlign:TextAlign.left,softWrap:true,overflow:TextOverflow.ellipsis,maxLines:3,style: TextStyle(color: Colors.black,fontSize: 12),),
//                                             ),
//                                           ):SizedBox(),
//                                         ],
//                                       ),
//                                     ):SizedBox.shrink(),
//                                     doc.docName=="GST Annex - B"?Container(
//                                       height: MediaQuery.of(context).size.height/10,
//                                       width: MediaQuery.of(context).size.width,
//                                       color:Colors.white60,
//                                       child: Row(
//                                         mainAxisAlignment: MainAxisAlignment.start,
//                                         crossAxisAlignment: CrossAxisAlignment.start,
//                                         children: [
//                                           doc.docName=="GST Annex - B"?Stack(
//                                             children: [
//                                               Container(
//                                                 height: 75,
//                                                 width: 75,
//                                                 decoration: BoxDecoration(
//                                                   color: AppConstant.appSecondaryColor,
//                                                   border: Border.all(
//                                                     color: Colors.black,
//                                                     width: 1.0,
//                                                   ),
//                                                   borderRadius: BorderRadius.circular(5),
//                                                 ),
//                                                 child: Center(
//                                                   child: companuBoard == null
//                                                       ? InkWell(
//                                                     onTap: (){
//                                                       pickImageCompanyBoard(ImageSource.camera,doc.docName);
//                                                     },
//                                                     child: const Text(
//                                                       "No image selected",
//                                                       textAlign: TextAlign.center,
//                                                       style: TextStyle(fontSize: 8, color: Colors.white),
//                                                     ),
//                                                   )
//                                                       : Container(
//                                                     height: 73,
//                                                     width: 73,
//                                                     color: Colors.white,
//                                                     child: Image.file(companuBoard!,fit: BoxFit.cover,),
//                                                   ),
//                                                 ),
//                                               ),
//                                               Positioned(
//                                                 top:-2, // Adjust these values to position the icon correctly
//                                                 right: 2,
//                                                 child: InkWell( // Consider using InkWell for better tap feedback
//                                                   onTap: () async {
//                                                     try {
//                                                       if (companuBoard != null) {
//                                                         await companuBoard!.delete();
//                                                         setState(() {
//                                                           companuBoard = null;
//                                                         });
//                                                         print("File deleted successfully!");
//                                                       }
//                                                     } catch (e) {
//                                                       print("Error deleting file: $e");
//                                                     }
//                                                   },
//                                                   child: Container(
//                                                     decoration: BoxDecoration(
//                                                       color: Colors.black, // Optional: background color for the icon
//                                                       shape: BoxShape.circle,
//                                                     ),
//                                                     padding: EdgeInsets.all(3), // Adjust padding as needed
//                                                     child: Icon(
//                                                       Icons.delete_forever_outlined,
//                                                       size: 18,
//                                                       color: Colors.white,
//                                                     ),
//                                                   ),
//                                                 ),
//                                               ),
//                                             ],
//                                           ):SizedBox.shrink(),
//                                           doc.docName=="GST Annex - B"?Flexible(
//                                             child: Padding(
//                                               padding: const EdgeInsets.all(5.0),
//                                               child: Text(doc.docName,
//                                                 textAlign:TextAlign.left,softWrap:true,overflow:TextOverflow.ellipsis,maxLines:3,style: TextStyle(color: Colors.black,fontSize: 12),),
//                                             ),
//                                           ):SizedBox(),
//                                         ],
//                                       ),
//                                     ):SizedBox.shrink(),
//                                     doc.docName=="Loan Agreement"?Container(
//                                       height: MediaQuery.of(context).size.height/10,
//                                       width: MediaQuery.of(context).size.width,
//                                       color:Colors.white60,
//                                       child: Row(
//                                         mainAxisAlignment: MainAxisAlignment.start,
//                                         crossAxisAlignment: CrossAxisAlignment.start,
//                                         children: [
//                                           doc.docName=="Loan Agreement"?Stack(
//                                             children: [
//                                               Container(
//                                                 height: 75,
//                                                 width: 75,
//                                                 decoration: BoxDecoration(
//                                                   color: AppConstant.appSecondaryColor,
//                                                   border: Border.all(
//                                                     color: Colors.black,
//                                                     width: 1.0,
//                                                   ),
//                                                   borderRadius: BorderRadius.circular(5),
//                                                 ),
//                                                 child: Center(
//                                                   child: companuBoard == null
//                                                       ? InkWell(
//                                                     onTap: (){
//                                                       pickImageCompanyBoard(ImageSource.camera,doc.docName);
//                                                     },
//                                                     child: const Text(
//                                                       "No image selected",
//                                                       textAlign: TextAlign.center,
//                                                       style: TextStyle(fontSize: 8, color: Colors.white),
//                                                     ),
//                                                   )
//                                                       : Container(
//                                                     height: 73,
//                                                     width: 73,
//                                                     color: Colors.white,
//                                                     child: Image.file(companuBoard!,fit: BoxFit.cover,),
//                                                   ),
//                                                 ),
//                                               ),
//                                               Positioned(
//                                                 top:-2, // Adjust these values to position the icon correctly
//                                                 right: 2,
//                                                 child: InkWell( // Consider using InkWell for better tap feedback
//                                                   onTap: () async {
//                                                     try {
//                                                       if (companuBoard != null) {
//                                                         await companuBoard!.delete();
//                                                         setState(() {
//                                                           companuBoard = null;
//                                                         });
//                                                         print("File deleted successfully!");
//                                                       }
//                                                     } catch (e) {
//                                                       print("Error deleting file: $e");
//                                                     }
//                                                   },
//                                                   child: Container(
//                                                     decoration: BoxDecoration(
//                                                       color: Colors.black, // Optional: background color for the icon
//                                                       shape: BoxShape.circle,
//                                                     ),
//                                                     padding: EdgeInsets.all(3), // Adjust padding as needed
//                                                     child: Icon(
//                                                       Icons.delete_forever_outlined,
//                                                       size: 18,
//                                                       color: Colors.white,
//                                                     ),
//                                                   ),
//                                                 ),
//                                               ),
//                                             ],
//                                           ):SizedBox.shrink(),
//                                           doc.docName=="Loan Agreement"?Flexible(
//                                             child: Padding(
//                                               padding: const EdgeInsets.all(5.0),
//                                               child: Text(doc.docName,
//                                                 textAlign:TextAlign.left,softWrap:true,overflow:TextOverflow.ellipsis,maxLines:3,style: TextStyle(color: Colors.black,fontSize: 12),),
//                                             ),
//                                           ):SizedBox(),
//                                         ],
//                                       ),
//                                     ):SizedBox.shrink(),
//                                     doc.docName=="Marriage Certificate"?Container(
//                                       height: MediaQuery.of(context).size.height/10,
//                                       width: MediaQuery.of(context).size.width,
//                                       color:Colors.white60,
//                                       child: Row(
//                                         mainAxisAlignment: MainAxisAlignment.start,
//                                         crossAxisAlignment: CrossAxisAlignment.start,
//                                         children: [
//                                           doc.docName=="Marriage Certificate"?Stack(
//                                             children: [
//                                               Container(
//                                                 height: 75,
//                                                 width: 75,
//                                                 decoration: BoxDecoration(
//                                                   color: AppConstant.appSecondaryColor,
//                                                   border: Border.all(
//                                                     color: Colors.black,
//                                                     width: 1.0,
//                                                   ),
//                                                   borderRadius: BorderRadius.circular(5),
//                                                 ),
//                                                 child: Center(
//                                                   child: companuBoard == null
//                                                       ? InkWell(
//                                                     onTap: (){
//                                                       pickImageCompanyBoard(ImageSource.camera,doc.docName);
//                                                     },
//                                                     child: const Text(
//                                                       "No image selected",
//                                                       textAlign: TextAlign.center,
//                                                       style: TextStyle(fontSize: 8, color: Colors.white),
//                                                     ),
//                                                   )
//                                                       : Container(
//                                                     height: 73,
//                                                     width: 73,
//                                                     color: Colors.white,
//                                                     child: Image.file(companuBoard!,fit: BoxFit.cover,),
//                                                   ),
//                                                 ),
//                                               ),
//                                               Positioned(
//                                                 top:-2, // Adjust these values to position the icon correctly
//                                                 right: 2,
//                                                 child: InkWell( // Consider using InkWell for better tap feedback
//                                                   onTap: () async {
//                                                     try {
//                                                       if (companuBoard != null) {
//                                                         await companuBoard!.delete();
//                                                         setState(() {
//                                                           companuBoard = null;
//                                                         });
//                                                         print("File deleted successfully!");
//                                                       }
//                                                     } catch (e) {
//                                                       print("Error deleting file: $e");
//                                                     }
//                                                   },
//                                                   child: Container(
//                                                     decoration: BoxDecoration(
//                                                       color: Colors.black, // Optional: background color for the icon
//                                                       shape: BoxShape.circle,
//                                                     ),
//                                                     padding: EdgeInsets.all(3), // Adjust padding as needed
//                                                     child: Icon(
//                                                       Icons.delete_forever_outlined,
//                                                       size: 18,
//                                                       color: Colors.white,
//                                                     ),
//                                                   ),
//                                                 ),
//                                               ),
//                                             ],
//                                           ):SizedBox.shrink(),
//                                           doc.docName=="Marriage Certificate"?Flexible(
//                                             child: Padding(
//                                               padding: const EdgeInsets.all(5.0),
//                                               child: Text(doc.docName,
//                                                 textAlign:TextAlign.left,softWrap:true,overflow:TextOverflow.ellipsis,maxLines:3,style: TextStyle(color: Colors.black,fontSize: 12),),
//                                             ),
//                                           ):SizedBox(),
//                                         ],
//                                       ),
//                                     ):SizedBox.shrink(),
//                                     doc.docName=="Nach Only"?Container(
//                                       height: MediaQuery.of(context).size.height/10,
//                                       width: MediaQuery.of(context).size.width,
//                                       color:Colors.white60,
//                                       child: Row(
//                                         mainAxisAlignment: MainAxisAlignment.start,
//                                         crossAxisAlignment: CrossAxisAlignment.start,
//                                         children: [
//                                           doc.docName=="Nach Only"?Stack(
//                                             children: [
//                                               Container(
//                                                 height: 75,
//                                                 width: 75,
//                                                 decoration: BoxDecoration(
//                                                   color: AppConstant.appSecondaryColor,
//                                                   border: Border.all(
//                                                     color: Colors.black,
//                                                     width: 1.0,
//                                                   ),
//                                                   borderRadius: BorderRadius.circular(5),
//                                                 ),
//                                                 child: Center(
//                                                   child: companuBoard == null
//                                                       ? InkWell(
//                                                     onTap: (){
//                                                       pickImageCompanyBoard(ImageSource.camera,doc.docName);
//                                                     },
//                                                     child: const Text(
//                                                       "No image selected",
//                                                       textAlign: TextAlign.center,
//                                                       style: TextStyle(fontSize: 8, color: Colors.white),
//                                                     ),
//                                                   )
//                                                       : Container(
//                                                     height: 73,
//                                                     width: 73,
//                                                     color: Colors.white,
//                                                     child: Image.file(companuBoard!,fit: BoxFit.cover,),
//                                                   ),
//                                                 ),
//                                               ),
//                                               Positioned(
//                                                 top:-2, // Adjust these values to position the icon correctly
//                                                 right: 2,
//                                                 child: InkWell( // Consider using InkWell for better tap feedback
//                                                   onTap: () async {
//                                                     try {
//                                                       if (companuBoard != null) {
//                                                         await companuBoard!.delete();
//                                                         setState(() {
//                                                           companuBoard = null;
//                                                         });
//                                                         print("File deleted successfully!");
//                                                       }
//                                                     } catch (e) {
//                                                       print("Error deleting file: $e");
//                                                     }
//                                                   },
//                                                   child: Container(
//                                                     decoration: BoxDecoration(
//                                                       color: Colors.black, // Optional: background color for the icon
//                                                       shape: BoxShape.circle,
//                                                     ),
//                                                     padding: EdgeInsets.all(3), // Adjust padding as needed
//                                                     child: Icon(
//                                                       Icons.delete_forever_outlined,
//                                                       size: 18,
//                                                       color: Colors.white,
//                                                     ),
//                                                   ),
//                                                 ),
//                                               ),
//                                             ],
//                                           ):SizedBox.shrink(),
//                                           doc.docName=="Nach Only"?Flexible(
//                                             child: Padding(
//                                               padding: const EdgeInsets.all(5.0),
//                                               child: Text(doc.docName,
//                                                 textAlign:TextAlign.left,softWrap:true,overflow:TextOverflow.ellipsis,maxLines:3,style: TextStyle(color: Colors.black,fontSize: 12),),
//                                             ),
//                                           ):SizedBox(),
//                                         ],
//                                       ),
//                                     ):SizedBox.shrink(),
//                                     doc.docName=="OVD Declaration"?Container(
//                                       height: MediaQuery.of(context).size.height/10,
//                                       width: MediaQuery.of(context).size.width,
//                                       color:Colors.white60,
//                                       child: Row(
//                                         mainAxisAlignment: MainAxisAlignment.start,
//                                         crossAxisAlignment: CrossAxisAlignment.start,
//                                         children: [
//                                           doc.docName=="OVD Declaration"?Stack(
//                                             children: [
//                                               Container(
//                                                 height: 75,
//                                                 width: 75,
//                                                 decoration: BoxDecoration(
//                                                   color: AppConstant.appSecondaryColor,
//                                                   border: Border.all(
//                                                     color: Colors.black,
//                                                     width: 1.0,
//                                                   ),
//                                                   borderRadius: BorderRadius.circular(5),
//                                                 ),
//                                                 child: Center(
//                                                   child: companuBoard == null
//                                                       ? InkWell(
//                                                     onTap: (){
//                                                       pickImageCompanyBoard(ImageSource.camera,doc.docName);
//                                                     },
//                                                     child: const Text(
//                                                       "No image selected",
//                                                       textAlign: TextAlign.center,
//                                                       style: TextStyle(fontSize: 8, color: Colors.white),
//                                                     ),
//                                                   )
//                                                       : Container(
//                                                     height: 73,
//                                                     width: 73,
//                                                     color: Colors.white,
//                                                     child: Image.file(companuBoard!,fit: BoxFit.cover,),
//                                                   ),
//                                                 ),
//                                               ),
//                                               Positioned(
//                                                 top:-2, // Adjust these values to position the icon correctly
//                                                 right: 2,
//                                                 child: InkWell( // Consider using InkWell for better tap feedback
//                                                   onTap: () async {
//                                                     try {
//                                                       if (companuBoard != null) {
//                                                         await companuBoard!.delete();
//                                                         setState(() {
//                                                           companuBoard = null;
//                                                         });
//                                                         print("File deleted successfully!");
//                                                       }
//                                                     } catch (e) {
//                                                       print("Error deleting file: $e");
//                                                     }
//                                                   },
//                                                   child: Container(
//                                                     decoration: BoxDecoration(
//                                                       color: Colors.black, // Optional: background color for the icon
//                                                       shape: BoxShape.circle,
//                                                     ),
//                                                     padding: EdgeInsets.all(3), // Adjust padding as needed
//                                                     child: Icon(
//                                                       Icons.delete_forever_outlined,
//                                                       size: 18,
//                                                       color: Colors.white,
//                                                     ),
//                                                   ),
//                                                 ),
//                                               ),
//                                             ],
//                                           ):SizedBox.shrink(),
//                                           doc.docName=="OVD Declaration"?Flexible(
//                                             child: Padding(
//                                               padding: const EdgeInsets.all(5.0),
//                                               child: Text(doc.docName,
//                                                 textAlign:TextAlign.left,softWrap:true,overflow:TextOverflow.ellipsis,maxLines:3,style: TextStyle(color: Colors.black,fontSize: 12),),
//                                             ),
//                                           ):SizedBox(),
//                                         ],
//                                       ),
//                                     ):SizedBox.shrink(),
//                                     doc.docName=="POD Image"?Container(
//                                       height: MediaQuery.of(context).size.height/10,
//                                       width: MediaQuery.of(context).size.width,
//                                       color:Colors.white60,
//                                       child: Row(
//                                         mainAxisAlignment: MainAxisAlignment.start,
//                                         crossAxisAlignment: CrossAxisAlignment.start,
//                                         children: [
//                                           doc.docName=="POD Image"?Stack(
//                                             children: [
//                                               Container(
//                                                 height: 75,
//                                                 width: 75,
//                                                 decoration: BoxDecoration(
//                                                   color: AppConstant.appSecondaryColor,
//                                                   border: Border.all(
//                                                     color: Colors.black,
//                                                     width: 1.0,
//                                                   ),
//                                                   borderRadius: BorderRadius.circular(5),
//                                                 ),
//                                                 child: Center(
//                                                   child: companuBoard == null
//                                                       ? InkWell(
//                                                     onTap: (){
//                                                       pickImageCompanyBoard(ImageSource.camera,doc.docName);
//                                                     },
//                                                     child: const Text(
//                                                       "No image selected",
//                                                       textAlign: TextAlign.center,
//                                                       style: TextStyle(fontSize: 8, color: Colors.white),
//                                                     ),
//                                                   )
//                                                       : Container(
//                                                     height: 73,
//                                                     width: 73,
//                                                     color: Colors.white,
//                                                     child: Image.file(companuBoard!,fit: BoxFit.cover,),
//                                                   ),
//                                                 ),
//                                               ),
//                                               Positioned(
//                                                 top:-2, // Adjust these values to position the icon correctly
//                                                 right: 2,
//                                                 child: InkWell( // Consider using InkWell for better tap feedback
//                                                   onTap: () async {
//                                                     try {
//                                                       if (companuBoard != null) {
//                                                         await companuBoard!.delete();
//                                                         setState(() {
//                                                           companuBoard = null;
//                                                         });
//                                                         print("File deleted successfully!");
//                                                       }
//                                                     } catch (e) {
//                                                       print("Error deleting file: $e");
//                                                     }
//                                                   },
//                                                   child: Container(
//                                                     decoration: BoxDecoration(
//                                                       color: Colors.black, // Optional: background color for the icon
//                                                       shape: BoxShape.circle,
//                                                     ),
//                                                     padding: EdgeInsets.all(3), // Adjust padding as needed
//                                                     child: Icon(
//                                                       Icons.delete_forever_outlined,
//                                                       size: 18,
//                                                       color: Colors.white,
//                                                     ),
//                                                   ),
//                                                 ),
//                                               ),
//                                             ],
//                                           ):SizedBox.shrink(),
//                                           doc.docName=="POD Image"?Flexible(
//                                             child: Padding(
//                                               padding: const EdgeInsets.all(5.0),
//                                               child: Text(doc.docName,
//                                                 textAlign:TextAlign.left,softWrap:true,overflow:TextOverflow.ellipsis,maxLines:3,style: TextStyle(color: Colors.black,fontSize: 12),),
//                                             ),
//                                           ):SizedBox(),
//                                         ],
//                                       ),
//                                     ):SizedBox.shrink(),
//                                     doc.docName=="Cheques (THREE)"?Container(
//                                       height: MediaQuery.of(context).size.height/10,
//                                       width: MediaQuery.of(context).size.width,
//                                       color:Colors.white60,
//                                       child: Row(
//                                         mainAxisAlignment: MainAxisAlignment.start,
//                                         crossAxisAlignment: CrossAxisAlignment.start,
//                                         children: [
//                                           doc.docName=="POD Image"?Stack(
//                                             children: [
//                                               Container(
//                                                 height: 75,
//                                                 width: 75,
//                                                 decoration: BoxDecoration(
//                                                   color: AppConstant.appSecondaryColor,
//                                                   border: Border.all(
//                                                     color: Colors.black,
//                                                     width: 1.0,
//                                                   ),
//                                                   borderRadius: BorderRadius.circular(5),
//                                                 ),
//                                                 child: Center(
//                                                   child: companuBoard == null
//                                                       ? InkWell(
//                                                     onTap: (){
//                                                       pickImageCompanyBoard(ImageSource.camera,doc.docName);
//                                                     },
//                                                     child: const Text(
//                                                       "No image selected",
//                                                       textAlign: TextAlign.center,
//                                                       style: TextStyle(fontSize: 8, color: Colors.white),
//                                                     ),
//                                                   )
//                                                       : Container(
//                                                     height: 73,
//                                                     width: 73,
//                                                     color: Colors.white,
//                                                     child: Image.file(companuBoard!,fit: BoxFit.cover,),
//                                                   ),
//                                                 ),
//                                               ),
//                                               Positioned(
//                                                 top:-2, // Adjust these values to position the icon correctly
//                                                 right: 2,
//                                                 child: InkWell( // Consider using InkWell for better tap feedback
//                                                   onTap: () async {
//                                                     try {
//                                                       if (companuBoard != null) {
//                                                         await companuBoard!.delete();
//                                                         setState(() {
//                                                           companuBoard = null;
//                                                         });
//                                                         print("File deleted successfully!");
//                                                       }
//                                                     } catch (e) {
//                                                       print("Error deleting file: $e");
//                                                     }
//                                                   },
//                                                   child: Container(
//                                                     decoration: BoxDecoration(
//                                                       color: Colors.black, // Optional: background color for the icon
//                                                       shape: BoxShape.circle,
//                                                     ),
//                                                     padding: EdgeInsets.all(3), // Adjust padding as needed
//                                                     child: Icon(
//                                                       Icons.delete_forever_outlined,
//                                                       size: 18,
//                                                       color: Colors.white,
//                                                     ),
//                                                   ),
//                                                 ),
//                                               ),
//                                             ],
//                                           ):SizedBox.shrink(),
//                                           doc.docName=="POD Image"?Flexible(
//                                             child: Padding(
//                                               padding: const EdgeInsets.all(5.0),
//                                               child: Text(doc.docName,
//                                                 textAlign:TextAlign.left,softWrap:true,overflow:TextOverflow.ellipsis,maxLines:3,style: TextStyle(color: Colors.black,fontSize: 12),),
//                                             ),
//                                           ):SizedBox(),
//                                         ],
//                                       ),
//                                     ):SizedBox.shrink(),
//                                     doc.docName=="Auth Sign Form"?Container(
//                                       height: MediaQuery.of(context).size.height/10,
//                                       width: MediaQuery.of(context).size.width,
//                                       color:Colors.white60,
//                                       child: Row(
//                                         mainAxisAlignment: MainAxisAlignment.start,
//                                         crossAxisAlignment: CrossAxisAlignment.start,
//                                         children: [
//                                           doc.docName=="POD Image"?Stack(
//                                             children: [
//                                               Container(
//                                                 height: 75,
//                                                 width: 75,
//                                                 decoration: BoxDecoration(
//                                                   color: AppConstant.appSecondaryColor,
//                                                   border: Border.all(
//                                                     color: Colors.black,
//                                                     width: 1.0,
//                                                   ),
//                                                   borderRadius: BorderRadius.circular(5),
//                                                 ),
//                                                 child: Center(
//                                                   child: companuBoard == null
//                                                       ? InkWell(
//                                                     onTap: (){
//                                                       pickImageCompanyBoard(ImageSource.camera,doc.docName);
//                                                     },
//                                                     child: const Text(
//                                                       "No image selected",
//                                                       textAlign: TextAlign.center,
//                                                       style: TextStyle(fontSize: 8, color: Colors.white),
//                                                     ),
//                                                   )
//                                                       : Container(
//                                                     height: 73,
//                                                     width: 73,
//                                                     color: Colors.white,
//                                                     child: Image.file(companuBoard!,fit: BoxFit.cover,),
//                                                   ),
//                                                 ),
//                                               ),
//                                               Positioned(
//                                                 top:-2, // Adjust these values to position the icon correctly
//                                                 right: 2,
//                                                 child: InkWell( // Consider using InkWell for better tap feedback
//                                                   onTap: () async {
//                                                     try {
//                                                       if (companuBoard != null) {
//                                                         await companuBoard!.delete();
//                                                         setState(() {
//                                                           companuBoard = null;
//                                                         });
//                                                         print("File deleted successfully!");
//                                                       }
//                                                     } catch (e) {
//                                                       print("Error deleting file: $e");
//                                                     }
//                                                   },
//                                                   child: Container(
//                                                     decoration: BoxDecoration(
//                                                       color: Colors.black, // Optional: background color for the icon
//                                                       shape: BoxShape.circle,
//                                                     ),
//                                                     padding: EdgeInsets.all(3), // Adjust padding as needed
//                                                     child: Icon(
//                                                       Icons.delete_forever_outlined,
//                                                       size: 18,
//                                                       color: Colors.white,
//                                                     ),
//                                                   ),
//                                                 ),
//                                               ),
//                                             ],
//                                           ):SizedBox.shrink(),
//                                           doc.docName=="POD Image"?Flexible(
//                                             child: Padding(
//                                               padding: const EdgeInsets.all(5.0),
//                                               child: Text(doc.docName,
//                                                 textAlign:TextAlign.left,softWrap:true,overflow:TextOverflow.ellipsis,maxLines:3,style: TextStyle(color: Colors.black,fontSize: 12),),
//                                             ),
//                                           ):SizedBox(),
//                                         ],
//                                       ),
//                                     ):SizedBox.shrink(),
//                                     doc.docName=="Shop & Establishment Certificate"?Container(
//                                       height: MediaQuery.of(context).size.height/10,
//                                       width: MediaQuery.of(context).size.width,
//                                       color:Colors.white60,
//                                       child: Row(
//                                         mainAxisAlignment: MainAxisAlignment.start,
//                                         crossAxisAlignment: CrossAxisAlignment.start,
//                                         children: [
//                                           doc.docName=="Shop & Establishment Certificate"?Stack(
//                                             children: [
//                                               Container(
//                                                 height: 75,
//                                                 width: 75,
//                                                 decoration: BoxDecoration(
//                                                   color: AppConstant.appSecondaryColor,
//                                                   border: Border.all(
//                                                     color: Colors.black,
//                                                     width: 1.0,
//                                                   ),
//                                                   borderRadius: BorderRadius.circular(5),
//                                                 ),
//                                                 child: Center(
//                                                   child: companuBoard == null
//                                                       ? InkWell(
//                                                     onTap: (){
//                                                       pickImageCompanyBoard(ImageSource.camera,doc.docName);
//                                                     },
//                                                     child: const Text(
//                                                       "No image selected",
//                                                       textAlign: TextAlign.center,
//                                                       style: TextStyle(fontSize: 8, color: Colors.white),
//                                                     ),
//                                                   )
//                                                       : Container(
//                                                     height: 73,
//                                                     width: 73,
//                                                     color: Colors.white,
//                                                     child: Image.file(companuBoard!,fit: BoxFit.cover,),
//                                                   ),
//                                                 ),
//                                               ),
//                                               Positioned(
//                                                 top:-2, // Adjust these values to position the icon correctly
//                                                 right: 2,
//                                                 child: InkWell( // Consider using InkWell for better tap feedback
//                                                   onTap: () async {
//                                                     try {
//                                                       if (companuBoard != null) {
//                                                         await companuBoard!.delete();
//                                                         setState(() {
//                                                           companuBoard = null;
//                                                         });
//                                                         print("File deleted successfully!");
//                                                       }
//                                                     } catch (e) {
//                                                       print("Error deleting file: $e");
//                                                     }
//                                                   },
//                                                   child: Container(
//                                                     decoration: BoxDecoration(
//                                                       color: Colors.black, // Optional: background color for the icon
//                                                       shape: BoxShape.circle,
//                                                     ),
//                                                     padding: EdgeInsets.all(3), // Adjust padding as needed
//                                                     child: Icon(
//                                                       Icons.delete_forever_outlined,
//                                                       size: 18,
//                                                       color: Colors.white,
//                                                     ),
//                                                   ),
//                                                 ),
//                                               ),
//                                             ],
//                                           ):SizedBox.shrink(),
//                                           doc.docName=="Shop & Establishment Certificate"?Flexible(
//                                             child: Padding(
//                                               padding: const EdgeInsets.all(5.0),
//                                               child: Text(doc.docName,
//                                                 textAlign:TextAlign.left,softWrap:true,overflow:TextOverflow.ellipsis,maxLines:3,style: TextStyle(color: Colors.black,fontSize: 12),),
//                                             ),
//                                           ):SizedBox(),
//                                         ],
//                                       ),
//                                     ):SizedBox.shrink(),
//
//                                   ],
//                                 ):SizedBox.shrink(),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//
//                     );
//                   }).toList(),
//                 ),
//               );
//             }).toList(),
//
//           );
//
//         },
//       ),
//       bottomNavigationBar: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: SizedBox(
//             width: double.infinity, // 👈 full width
//             height: 50,             // 👈 fixed height
//             child: ElevatedButton(
//               onPressed: () async{
//                 //await convertImageToPdfAndSave(documentList as F
//                 Navigator.pop(context);
//                 // 🔹 Yahan collectedDocs ka data use karo
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   SnackBar(
//                     content: Text(
//                       "You have collected following documents:[${collectedDocs.join(", ")}]",
//                       style: TextStyle(fontSize: 12, color: Colors.white),
//                     ),
//                     duration: Duration(seconds: 10),
//                   ),
//                 );
//
//               },
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: AppConstant.appBattonBack, // 👈 button color
//                 foregroundColor: AppConstant.appTextColor,      // 👈 text color
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(12), // 👈 rounded corners
//                 ),
//                 elevation: 4, // 👈 shadow
//               ),
//               child: const Text(
//                 "Upload Docs",
//                 style: TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.normal,
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
