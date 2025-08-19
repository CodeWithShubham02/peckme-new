import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:peckme/model/DocumentResponse.dart';

import '../controller/document_controller.dart';
import '../controller/document_list_controller.dart';
import '../model/document_list_model.dart';
import '../utils/app_constant.dart';

class DocumentScreen extends StatefulWidget {
  final String clientId;
  const DocumentScreen({Key? key, required this.clientId}) : super(key: key);

  @override
  State<DocumentScreen> createState() => _DocumentScreenState();
}

class _DocumentScreenState extends State<DocumentScreen> {
  late Future<DocumentResponse?> futureDocuments;
  //late Future<Document?> _futureDocumentsList;
 // final DocumentService _documentService = DocumentService();
  final ImagePicker picker=ImagePicker();
  List<File?> documentList=[null,null]; // Initialize with nulls to represent two slots
  File? _companuBoard;
  File? _feSelfie;
  Future _pickImageCompanyBoard(ImageSource source) async{
    try{
      final image =await ImagePicker().pickImage(source: source);
      if(image==null) return;
      File? img= File(image.path);
      img=await _cropImage(imageFile: img);
      setState(() {
        _companuBoard=img;
        documentList[0]=img;
        //print("File path : "+img!);
        //Navigator.of(context).pop();
      });
    }on PlatformException catch(e){
      print(e);
      Navigator.of(context).pop();
    }
  }
  Future _pickImageFeSelfie(ImageSource source) async{
    try{
      final image =await ImagePicker().pickImage(source: source);
      if(image==null) return;
      File? img= File(image.path);
      img=await _cropImage(imageFile: img);
      setState(() {
        _feSelfie=img;
        documentList[1]=img;
        //print("File path : "+img!);
        //Navigator.of(context).pop();
      });
    }on PlatformException catch(e){
      print(e);
      Navigator.of(context).pop();
    }
  }
  Future<File?> _cropImage({required File imageFile}) async{
    CroppedFile? cropImage=await ImageCropper().cropImage(sourcePath: imageFile.path);
    if(cropImage==null) return null;
    return File(cropImage.path);
  }

  @override
  void initState() {
    super.initState();
    futureDocuments = DocumentController.fetchDocument();
   // _futureDocumentsList = _documentService.fetchDocuments() as Future<Document?>;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Documents"),
      ),
      body: FutureBuilder<DocumentResponse?>(
        future: futureDocuments,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text("Error: ${snapshot.error}"),
            );
          } else if (!snapshot.hasData || snapshot.data == null) {
            return const Center(
              child: Text("No documents found"),
            );
          }

          final documents = snapshot.data!.doclist;
          // ✅ Group documents by category
          final Map<String, List<Doc>> groupedDocs = {};
          for (var doc in documents) {
            groupedDocs.putIfAbsent(doc.docCategory, () => []).add(doc);
          }
          final data=documents.first.docClient[0].toString();

          print("SSg --------- $data");
           return ListView(
            children: groupedDocs.entries.map((entry) {
              final category = entry.key;
              final docs = entry.value;

              // 👉 Check if any document of this category belongs to the given clientId
              final bool hasMatchingDoc = docs.any((doc) {
                final clientIds = doc.docClient
                    .split(",")
                    .map((id) => id.trim())
                    .toList();
                return clientIds.contains(widget.clientId.toString().trim());
              });

              // ❌ Agar match nahi karta toh category skip
              if (!hasMatchingDoc) {
                return SizedBox.shrink();
              }

              // ✅ Agar match karta hai toh hi ExpansionTile show karo
              return Card(
                margin: const EdgeInsets.all(10),
                child: ExpansionTile(
                  title: Text(
                    category,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  children: docs.map((doc) {
                    final clientIds = doc.docClient
                        .split(",")
                        .map((id) => id.trim())
                        .toList();
                    final bool belongsToClient =
                    clientIds.contains(widget.clientId.toString().trim());

                    // ✅ Sirf matching documents hi show karo
                    if (!belongsToClient) return SizedBox.shrink();

                    return belongsToClient?ListTile(
                      title: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                category == "PHOTO" ? Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [

                                    doc.docName=="Company Board"?Container(
                                      height: MediaQuery.of(context).size.height/10,
                                      width: 500,
                                      color:Colors.white60,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          doc.docName=="Company Board"?Stack(
                                            children: [
                                              Container(
                                                height: 75,
                                                width: 75,
                                                decoration: BoxDecoration(
                                                  color: AppConstant.appSecondaryColor,
                                                  border: Border.all(
                                                    color: Colors.black,
                                                    width: 1.0,
                                                  ),
                                                  borderRadius: BorderRadius.circular(5),
                                                ),
                                                child: Center(
                                                  child: _companuBoard == null
                                                      ? InkWell(
                                                    onTap: (){
                                                      _pickImageCompanyBoard(ImageSource.camera);
                                                    },
                                                    child: const Text(
                                                      "No image selected",
                                                      textAlign: TextAlign.center,
                                                      style: TextStyle(fontSize: 8, color: Colors.white),
                                                    ),
                                                  )
                                                      : Container(
                                                    height: 73,
                                                    width: 73,
                                                    color: Colors.white,
                                                    child: Image.file(_companuBoard!,fit: BoxFit.cover,),
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                top:-2, // Adjust these values to position the icon correctly
                                                right: 2,
                                                child: InkWell( // Consider using InkWell for better tap feedback
                                                  onTap: () async {
                                                    try {
                                                      if (_companuBoard != null) {
                                                        await _companuBoard!.delete();
                                                        setState(() {
                                                          _companuBoard = null;
                                                        });
                                                        print("File deleted successfully!");
                                                      }
                                                    } catch (e) {
                                                      print("Error deleting file: $e");
                                                    }
                                                  },
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      color: Colors.black, // Optional: background color for the icon
                                                      shape: BoxShape.circle,
                                                    ),
                                                    padding: EdgeInsets.all(3), // Adjust padding as needed
                                                    child: Icon(
                                                      Icons.delete_forever_outlined,
                                                      size: 18,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ):SizedBox.shrink(),
                                          doc.docName=="Company Board"?Flexible(
                                            child: Padding(
                                              padding: const EdgeInsets.all(5.0),
                                              child: Text(doc.docName,
                                                textAlign:TextAlign.left,softWrap:true,overflow:TextOverflow.ellipsis,maxLines:3,style: TextStyle(color: Colors.black,fontSize: 12),),
                                            ),
                                          ):SizedBox(),
                                        ],
                                      ),
                                    ):SizedBox.shrink(),
                                    doc.docName=="FE Selfie"?Container(
                                      height: MediaQuery.of(context).size.height/10,
                                      width: 500,
                                      color:Colors.white60,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          doc.docName=="FE Selfie"?Stack(
                                            children: [
                                              Container(
                                                height: 75,
                                                width: 75,
                                                decoration: BoxDecoration(
                                                  color: AppConstant.appSecondaryColor,
                                                  border: Border.all(
                                                    color: Colors.black,
                                                    width: 1.0,
                                                  ),
                                                  borderRadius: BorderRadius.circular(5),
                                                ),
                                                child: Center(
                                                  child: _feSelfie == null
                                                      ? InkWell(
                                                    onTap: (){
                                                      _pickImageFeSelfie(ImageSource.camera);
                                                    },
                                                    child: const Text(
                                                      "No image selected",
                                                      textAlign: TextAlign.center,
                                                      style: TextStyle(fontSize: 8, color: Colors.white),
                                                    ),
                                                  )
                                                      : Container(
                                                    height: 73,
                                                    width: 73,
                                                    color: Colors.white,
                                                    child: Image.file(_feSelfie!,fit: BoxFit.cover,),
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                top:-2, // Adjust these values to position the icon correctly
                                                right: 2,
                                                child: InkWell( // Consider using InkWell for better tap feedback
                                                  onTap: () async {
                                                    try {
                                                      if (_feSelfie != null) {
                                                        await _feSelfie!.delete();
                                                        setState(() {
                                                          _feSelfie = null;
                                                        });
                                                        print("File deleted successfully!");
                                                      }
                                                    } catch (e) {
                                                      print("Error deleting file: $e");
                                                    }
                                                  },
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      color: Colors.black, // Optional: background color for the icon
                                                      shape: BoxShape.circle,
                                                    ),
                                                    padding: EdgeInsets.all(3), // Adjust padding as needed
                                                    child: Icon(
                                                      Icons.delete_forever_outlined,
                                                      size: 18,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ):SizedBox.shrink(),
                                          doc.docName=="FE Selfie"?Flexible(
                                            child: Padding(
                                              padding: const EdgeInsets.all(5.0),
                                              child: Text(doc.docName,
                                                textAlign:TextAlign.left,softWrap:true,overflow:TextOverflow.ellipsis,maxLines:3,style: TextStyle(color: Colors.black,fontSize: 12),),
                                            ),
                                          ):SizedBox(),
                                        ],
                                      ),
                                    ):SizedBox.shrink(),
                                    doc.docName=="Bill Desk"?Container(
                                      height: MediaQuery.of(context).size.height/10,
                                      width: 500,
                                      color:Colors.white60,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          doc.docName=="Bill Desk"?Stack(
                                            children: [
                                              Container(
                                                height: 75,
                                                width: 75,
                                                decoration: BoxDecoration(
                                                  color: AppConstant.appSecondaryColor,
                                                  border: Border.all(
                                                    color: Colors.black,
                                                    width: 1.0,
                                                  ),
                                                  borderRadius: BorderRadius.circular(5),
                                                ),
                                                child: Center(
                                                  child: _feSelfie == null
                                                      ? InkWell(
                                                    onTap: (){
                                                      _pickImageCompanyBoard(ImageSource.camera);
                                                    },
                                                    child: const Text(
                                                      "No image selected",
                                                      textAlign: TextAlign.center,
                                                      style: TextStyle(fontSize: 8, color: Colors.white),
                                                    ),
                                                  )
                                                      : Container(
                                                    height: 75,
                                                    color: Colors.white,
                                                    child: Image.file(_feSelfie!,width: 75,),
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                top:-2, // Adjust these values to position the icon correctly
                                                right: 2,
                                                child: InkWell( // Consider using InkWell for better tap feedback
                                                  onTap: () async {
                                                    try {
                                                      if (_feSelfie != null) {
                                                        await _feSelfie!.delete();
                                                        setState(() {
                                                          _feSelfie = null;
                                                        });
                                                        print("File deleted successfully!");
                                                      }
                                                    } catch (e) {
                                                      print("Error deleting file: $e");
                                                    }
                                                  },
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      color: Colors.black, // Optional: background color for the icon
                                                      shape: BoxShape.circle,
                                                    ),
                                                    padding: EdgeInsets.all(3), // Adjust padding as needed
                                                    child: Icon(
                                                      Icons.delete_forever_outlined,
                                                      size: 18,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ):SizedBox.shrink(),
                                          doc.docName=="Bill Desk"?Flexible(
                                            child: Padding(
                                              padding: const EdgeInsets.all(5.0),
                                              child: Text(doc.docName,
                                                textAlign:TextAlign.left,softWrap:true,overflow:TextOverflow.ellipsis,maxLines:3,style: TextStyle(color: Colors.black,fontSize: 12),),
                                            ),
                                          ):SizedBox(),
                                        ],
                                      ),
                                    ):SizedBox.shrink(),
                                    doc.docName=="FE Selfie With Person Met With Sound Box (Inside Shop)"?Container(
                                      height: MediaQuery.of(context).size.height/10,
                                      width: 500,
                                      color:Colors.white60,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          doc.docName=="FE Selfie With Person Met With Sound Box (Inside Shop)"?Stack(
                                            children: [
                                              Container(
                                                height: 75,
                                                width: 75,
                                                decoration: BoxDecoration(
                                                  color: AppConstant.appSecondaryColor,
                                                  border: Border.all(
                                                    color: Colors.black,
                                                    width: 1.0,
                                                  ),
                                                  borderRadius: BorderRadius.circular(5),
                                                ),
                                                child: Center(
                                                  child: _feSelfie == null
                                                      ? InkWell(
                                                    onTap: (){
                                                      _pickImageCompanyBoard(ImageSource.camera);
                                                    },
                                                    child: const Text(
                                                      "No image selected",
                                                      textAlign: TextAlign.center,
                                                      style: TextStyle(fontSize: 8, color: Colors.white),
                                                    ),
                                                  )
                                                      : Container(
                                                    height: 75,
                                                    color: Colors.white,
                                                    child: Image.file(_feSelfie!,width: 75,),
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                top:-2, // Adjust these values to position the icon correctly
                                                right: 2,
                                                child: InkWell( // Consider using InkWell for better tap feedback
                                                  onTap: () async {
                                                    try {
                                                      if (_feSelfie != null) {
                                                        await _feSelfie!.delete();
                                                        setState(() {
                                                          _feSelfie = null;
                                                        });
                                                        print("File deleted successfully!");
                                                      }
                                                    } catch (e) {
                                                      print("Error deleting file: $e");
                                                    }
                                                  },
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      color: Colors.black, // Optional: background color for the icon
                                                      shape: BoxShape.circle,
                                                    ),
                                                    padding: EdgeInsets.all(3), // Adjust padding as needed
                                                    child: Icon(
                                                      Icons.delete_forever_outlined,
                                                      size: 18,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ):SizedBox.shrink(),
                                          doc.docName=="FE Selfie With Person Met With Sound Box (Inside Shop)"?Flexible(
                                            child: Padding(
                                              padding: const EdgeInsets.all(5.0),
                                              child: Text(doc.docName,
                                                textAlign:TextAlign.left,softWrap:true,overflow:TextOverflow.ellipsis,maxLines:3,style: TextStyle(color: Colors.black,fontSize: 12),),
                                            ),
                                          ):SizedBox(),
                                        ],
                                      ),
                                    ):SizedBox.shrink(),
                                    doc.docName=="Front Door"?Container(
                                      height: MediaQuery.of(context).size.height/10,
                                      width: 500,
                                      color:Colors.white60,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          doc.docName=="Front Door"?Stack(
                                            children: [
                                              Container(
                                                height: 75,
                                                width: 75,
                                                decoration: BoxDecoration(
                                                  color: AppConstant.appSecondaryColor,
                                                  border: Border.all(
                                                    color: Colors.black,
                                                    width: 1.0,
                                                  ),
                                                  borderRadius: BorderRadius.circular(5),
                                                ),
                                                child: Center(
                                                  child: _feSelfie == null
                                                      ? InkWell(
                                                    onTap: (){
                                                      _pickImageCompanyBoard(ImageSource.camera);
                                                    },
                                                    child: const Text(
                                                      "No image selected",
                                                      textAlign: TextAlign.center,
                                                      style: TextStyle(fontSize: 8, color: Colors.white),
                                                    ),
                                                  )
                                                      : Container(
                                                    height: 75,
                                                    color: Colors.white,
                                                    child: Image.file(_feSelfie!,width: 75,),
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                top:-2, // Adjust these values to position the icon correctly
                                                right: 2,
                                                child: InkWell( // Consider using InkWell for better tap feedback
                                                  onTap: () async {
                                                    try {
                                                      if (_feSelfie != null) {
                                                        await _feSelfie!.delete();
                                                        setState(() {
                                                          _feSelfie = null;
                                                        });
                                                        print("File deleted successfully!");
                                                      }
                                                    } catch (e) {
                                                      print("Error deleting file: $e");
                                                    }
                                                  },
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      color: Colors.black, // Optional: background color for the icon
                                                      shape: BoxShape.circle,
                                                    ),
                                                    padding: EdgeInsets.all(3), // Adjust padding as needed
                                                    child: Icon(
                                                      Icons.delete_forever_outlined,
                                                      size: 18,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ):SizedBox.shrink(),
                                          doc.docName=="Front Door"?Flexible(
                                            child: Padding(
                                              padding: const EdgeInsets.all(5.0),
                                              child: Text(doc.docName,
                                                textAlign:TextAlign.left,softWrap:true,overflow:TextOverflow.ellipsis,maxLines:3,style: TextStyle(color: Colors.black,fontSize: 12),),
                                            ),
                                          ):SizedBox(),
                                        ],
                                      ),
                                    ):SizedBox.shrink(),
                                    doc.docName=="Image of Person Met With Sound Box (Inside Shop)"?Container(
                                      height: MediaQuery.of(context).size.height/10,
                                      width: 500,
                                      color:Colors.white60,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          doc.docName=="Image of Person Met With Sound Box (Inside Shop)"?Stack(
                                            children: [
                                              Container(
                                                height: 75,
                                                width: 75,
                                                decoration: BoxDecoration(
                                                  color: AppConstant.appSecondaryColor,
                                                  border: Border.all(
                                                    color: Colors.black,
                                                    width: 1.0,
                                                  ),
                                                  borderRadius: BorderRadius.circular(5),
                                                ),
                                                child: Center(
                                                  child: _feSelfie == null
                                                      ? InkWell(
                                                    onTap: (){
                                                      _pickImageCompanyBoard(ImageSource.camera);
                                                    },
                                                    child: const Text(
                                                      "No image selected",
                                                      textAlign: TextAlign.center,
                                                      style: TextStyle(fontSize: 8, color: Colors.white),
                                                    ),
                                                  )
                                                      : Container(
                                                    height: 75,
                                                    color: Colors.white,
                                                    child: Image.file(_feSelfie!,width: 75,),
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                top:-2, // Adjust these values to position the icon correctly
                                                right: 2,
                                                child: InkWell( // Consider using InkWell for better tap feedback
                                                  onTap: () async {
                                                    try {
                                                      if (_feSelfie != null) {
                                                        await _feSelfie!.delete();
                                                        setState(() {
                                                          _feSelfie = null;
                                                        });
                                                        print("File deleted successfully!");
                                                      }
                                                    } catch (e) {
                                                      print("Error deleting file: $e");
                                                    }
                                                  },
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      color: Colors.black, // Optional: background color for the icon
                                                      shape: BoxShape.circle,
                                                    ),
                                                    padding: EdgeInsets.all(3), // Adjust padding as needed
                                                    child: Icon(
                                                      Icons.delete_forever_outlined,
                                                      size: 18,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ):SizedBox.shrink(),
                                          doc.docName=="Image of Person Met With Sound Box (Inside Shop)"?Flexible(
                                            child: Padding(
                                              padding: const EdgeInsets.all(5.0),
                                              child: Text(doc.docName,
                                                textAlign:TextAlign.left,softWrap:true,overflow:TextOverflow.ellipsis,maxLines:3,style: TextStyle(color: Colors.black,fontSize: 12),),
                                            ),
                                          ):SizedBox(),
                                        ],
                                      ),
                                    ):SizedBox.shrink(),
                                    doc.docName=="Bill DeskImage of Shop From OutsideBill Desk"?Container(
                                      height: MediaQuery.of(context).size.height/10,
                                      width: 500,
                                      color:Colors.white60,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          doc.docName=="Bill DeskImage of Shop From OutsideBill Desk"?Stack(
                                            children: [
                                              Container(
                                                height: 75,
                                                width: 75,
                                                decoration: BoxDecoration(
                                                  color: AppConstant.appSecondaryColor,
                                                  border: Border.all(
                                                    color: Colors.black,
                                                    width: 1.0,
                                                  ),
                                                  borderRadius: BorderRadius.circular(5),
                                                ),
                                                child: Center(
                                                  child: _feSelfie == null
                                                      ? InkWell(
                                                    onTap: (){
                                                      _pickImageCompanyBoard(ImageSource.camera);
                                                    },
                                                    child: const Text(
                                                      "No image selected",
                                                      textAlign: TextAlign.center,
                                                      style: TextStyle(fontSize: 8, color: Colors.white),
                                                    ),
                                                  )
                                                      : Container(
                                                    height: 75,
                                                    color: Colors.white,
                                                    child: Image.file(_feSelfie!,width: 75,),
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                top:-2, // Adjust these values to position the icon correctly
                                                right: 2,
                                                child: InkWell( // Consider using InkWell for better tap feedback
                                                  onTap: () async {
                                                    try {
                                                      if (_feSelfie != null) {
                                                        await _feSelfie!.delete();
                                                        setState(() {
                                                          _feSelfie = null;
                                                        });
                                                        print("File deleted successfully!");
                                                      }
                                                    } catch (e) {
                                                      print("Error deleting file: $e");
                                                    }
                                                  },
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      color: Colors.black, // Optional: background color for the icon
                                                      shape: BoxShape.circle,
                                                    ),
                                                    padding: EdgeInsets.all(3), // Adjust padding as needed
                                                    child: Icon(
                                                      Icons.delete_forever_outlined,
                                                      size: 18,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ):SizedBox.shrink(),
                                          doc.docName=="Bill DeskImage of Shop From OutsideBill Desk"?Flexible(
                                            child: Padding(
                                              padding: const EdgeInsets.all(5.0),
                                              child: Text(doc.docName,
                                                textAlign:TextAlign.left,softWrap:true,overflow:TextOverflow.ellipsis,maxLines:3,style: TextStyle(color: Colors.black,fontSize: 12),),
                                            ),
                                          ):SizedBox(),
                                        ],
                                      ),
                                    ):SizedBox.shrink(),
                                    doc.docName=="Image of Shop From Outside"?Container(
                                      height: MediaQuery.of(context).size.height/10,
                                      width: 500,
                                      color:Colors.white60,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          doc.docName=="Image of Shop From Outside"?Stack(
                                            children: [
                                              Container(
                                                height: 75,
                                                width: 75,
                                                decoration: BoxDecoration(
                                                  color: AppConstant.appSecondaryColor,
                                                  border: Border.all(
                                                    color: Colors.black,
                                                    width: 1.0,
                                                  ),
                                                  borderRadius: BorderRadius.circular(5),
                                                ),
                                                child: Center(
                                                  child: _feSelfie == null
                                                      ? InkWell(
                                                    onTap: (){
                                                      _pickImageCompanyBoard(ImageSource.camera);
                                                    },
                                                    child: const Text(
                                                      "No image selected",
                                                      textAlign: TextAlign.center,
                                                      style: TextStyle(fontSize: 8, color: Colors.white),
                                                    ),
                                                  )
                                                      : Container(
                                                    height: 75,
                                                    color: Colors.white,
                                                    child: Image.file(_feSelfie!,width: 75,),
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                top:-2, // Adjust these values to position the icon correctly
                                                right: 2,
                                                child: InkWell( // Consider using InkWell for better tap feedback
                                                  onTap: () async {
                                                    try {
                                                      if (_feSelfie != null) {
                                                        await _feSelfie!.delete();
                                                        setState(() {
                                                          _feSelfie = null;
                                                        });
                                                        print("File deleted successfully!");
                                                      }
                                                    } catch (e) {
                                                      print("Error deleting file: $e");
                                                    }
                                                  },
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      color: Colors.black, // Optional: background color for the icon
                                                      shape: BoxShape.circle,
                                                    ),
                                                    padding: EdgeInsets.all(3), // Adjust padding as needed
                                                    child: Icon(
                                                      Icons.delete_forever_outlined,
                                                      size: 18,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ):SizedBox.shrink(),
                                          doc.docName=="Image of Shop From Outside"?Flexible(
                                            child: Padding(
                                              padding: const EdgeInsets.all(5.0),
                                              child: Text(doc.docName,
                                                textAlign:TextAlign.left,softWrap:true,overflow:TextOverflow.ellipsis,maxLines:3,style: TextStyle(color: Colors.black,fontSize: 12),),
                                            ),
                                          ):SizedBox(),
                                        ],
                                      ),
                                    ):SizedBox.shrink(),
                                    doc.docName=="Location Snap"?Container(
                                      height: MediaQuery.of(context).size.height/10,
                                      width: 500,
                                      color:Colors.white60,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          doc.docName=="Location Snap"?Stack(
                                            children: [
                                              Container(
                                                height: 75,
                                                width: 75,
                                                decoration: BoxDecoration(
                                                  color: AppConstant.appSecondaryColor,
                                                  border: Border.all(
                                                    color: Colors.black,
                                                    width: 1.0,
                                                  ),
                                                  borderRadius: BorderRadius.circular(5),
                                                ),
                                                child: Center(
                                                  child: _feSelfie == null
                                                      ? InkWell(
                                                    onTap: (){
                                                      _pickImageCompanyBoard(ImageSource.camera);
                                                    },
                                                    child: const Text(
                                                      "No image selected",
                                                      textAlign: TextAlign.center,
                                                      style: TextStyle(fontSize: 8, color: Colors.white),
                                                    ),
                                                  )
                                                      : Container(
                                                    height: 75,
                                                    color: Colors.white,
                                                    child: Image.file(_feSelfie!,width: 75,),
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                top:-2, // Adjust these values to position the icon correctly
                                                right: 2,
                                                child: InkWell( // Consider using InkWell for better tap feedback
                                                  onTap: () async {
                                                    try {
                                                      if (_feSelfie != null) {
                                                        await _feSelfie!.delete();
                                                        setState(() {
                                                          _feSelfie = null;
                                                        });
                                                        print("File deleted successfully!");
                                                      }
                                                    } catch (e) {
                                                      print("Error deleting file: $e");
                                                    }
                                                  },
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      color: Colors.black, // Optional: background color for the icon
                                                      shape: BoxShape.circle,
                                                    ),
                                                    padding: EdgeInsets.all(3), // Adjust padding as needed
                                                    child: Icon(
                                                      Icons.delete_forever_outlined,
                                                      size: 18,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ):SizedBox.shrink(),
                                          doc.docName=="Location Snap"?Flexible(
                                            child: Padding(
                                              padding: const EdgeInsets.all(5.0),
                                              child: Text(doc.docName,
                                                textAlign:TextAlign.left,softWrap:true,overflow:TextOverflow.ellipsis,maxLines:3,style: TextStyle(color: Colors.black,fontSize: 12),),
                                            ),
                                          ):SizedBox(),
                                        ],
                                      ),
                                    ):SizedBox.shrink(),
                                    doc.docName=="Name Plate"?Container(
                                      height: MediaQuery.of(context).size.height/10,
                                      width: 500,
                                      color:Colors.white60,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          doc.docName=="Name Plate"?Stack(
                                            children: [
                                              Container(
                                                height: 75,
                                                width: 75,
                                                decoration: BoxDecoration(
                                                  color: AppConstant.appSecondaryColor,
                                                  border: Border.all(
                                                    color: Colors.black,
                                                    width: 1.0,
                                                  ),
                                                  borderRadius: BorderRadius.circular(5),
                                                ),
                                                child: Center(
                                                  child: _feSelfie == null
                                                      ? InkWell(
                                                    onTap: (){
                                                      _pickImageCompanyBoard(ImageSource.camera);
                                                    },
                                                    child: const Text(
                                                      "No image selected",
                                                      textAlign: TextAlign.center,
                                                      style: TextStyle(fontSize: 8, color: Colors.white),
                                                    ),
                                                  )
                                                      : Container(
                                                    height: 75,
                                                    color: Colors.white,
                                                    child: Image.file(_feSelfie!,width: 75,),
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                top:-2, // Adjust these values to position the icon correctly
                                                right: 2,
                                                child: InkWell( // Consider using InkWell for better tap feedback
                                                  onTap: () async {
                                                    try {
                                                      if (_feSelfie != null) {
                                                        await _feSelfie!.delete();
                                                        setState(() {
                                                          _feSelfie = null;
                                                        });
                                                        print("File deleted successfully!");
                                                      }
                                                    } catch (e) {
                                                      print("Error deleting file: $e");
                                                    }
                                                  },
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      color: Colors.black, // Optional: background color for the icon
                                                      shape: BoxShape.circle,
                                                    ),
                                                    padding: EdgeInsets.all(3), // Adjust padding as needed
                                                    child: Icon(
                                                      Icons.delete_forever_outlined,
                                                      size: 18,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ):SizedBox.shrink(),
                                          doc.docName=="Name Plate"?Flexible(
                                            child: Padding(
                                              padding: const EdgeInsets.all(5.0),
                                              child: Text(doc.docName,
                                                textAlign:TextAlign.left,softWrap:true,overflow:TextOverflow.ellipsis,maxLines:3,style: TextStyle(color: Colors.black,fontSize: 12),),
                                            ),
                                          ):SizedBox(),
                                        ],
                                      ),
                                    ):SizedBox.shrink(),
                                    doc.docName=="Photo"?Container(
                                      height: MediaQuery.of(context).size.height/10,
                                      width: 500,
                                      color:Colors.white60,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          doc.docName=="Photo"?Stack(
                                            children: [
                                              Container(
                                                height: 75,
                                                width: 75,
                                                decoration: BoxDecoration(
                                                  color: AppConstant.appSecondaryColor,
                                                  border: Border.all(
                                                    color: Colors.black,
                                                    width: 1.0,
                                                  ),
                                                  borderRadius: BorderRadius.circular(5),
                                                ),
                                                child: Center(
                                                  child: _feSelfie == null
                                                      ? InkWell(
                                                    onTap: (){
                                                      _pickImageCompanyBoard(ImageSource.camera);
                                                    },
                                                    child: const Text(
                                                      "No image selected",
                                                      textAlign: TextAlign.center,
                                                      style: TextStyle(fontSize: 8, color: Colors.white),
                                                    ),
                                                  )
                                                      : Container(
                                                    height: 75,
                                                    color: Colors.white,
                                                    child: Image.file(_feSelfie!,width: 75,),
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                top:-2, // Adjust these values to position the icon correctly
                                                right: 2,
                                                child: InkWell( // Consider using InkWell for better tap feedback
                                                  onTap: () async {
                                                    try {
                                                      if (_feSelfie != null) {
                                                        await _feSelfie!.delete();
                                                        setState(() {
                                                          _feSelfie = null;
                                                        });
                                                        print("File deleted successfully!");
                                                      }
                                                    } catch (e) {
                                                      print("Error deleting file: $e");
                                                    }
                                                  },
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      color: Colors.black, // Optional: background color for the icon
                                                      shape: BoxShape.circle,
                                                    ),
                                                    padding: EdgeInsets.all(3), // Adjust padding as needed
                                                    child: Icon(
                                                      Icons.delete_forever_outlined,
                                                      size: 18,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ):SizedBox.shrink(),
                                          doc.docName=="Photo"?Flexible(
                                            child: Padding(
                                              padding: const EdgeInsets.all(5.0),
                                              child: Text(doc.docName,
                                                textAlign:TextAlign.left,softWrap:true,overflow:TextOverflow.ellipsis,maxLines:3,style: TextStyle(color: Colors.black,fontSize: 12),),
                                            ),
                                          ):SizedBox(),
                                        ],
                                      ),
                                    ):SizedBox.shrink(),
                                    doc.docName=="Premises Interior"?Container(
                                      height: MediaQuery.of(context).size.height/10,
                                      width: 500,
                                      color:Colors.white60,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          doc.docName=="Premises Interior"?Stack(
                                            children: [
                                              Container(
                                                height: 75,
                                                width: 75,
                                                decoration: BoxDecoration(
                                                  color: AppConstant.appSecondaryColor,
                                                  border: Border.all(
                                                    color: Colors.black,
                                                    width: 1.0,
                                                  ),
                                                  borderRadius: BorderRadius.circular(5),
                                                ),
                                                child: Center(
                                                  child: _feSelfie == null
                                                      ? InkWell(
                                                    onTap: (){
                                                      _pickImageCompanyBoard(ImageSource.camera);
                                                    },
                                                    child: const Text(
                                                      "No image selected",
                                                      textAlign: TextAlign.center,
                                                      style: TextStyle(fontSize: 8, color: Colors.white),
                                                    ),
                                                  )
                                                      : Container(
                                                    height: 75,
                                                    color: Colors.white,
                                                    child: Image.file(_feSelfie!,width: 75,),
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                top:-2, // Adjust these values to position the icon correctly
                                                right: 2,
                                                child: InkWell( // Consider using InkWell for better tap feedback
                                                  onTap: () async {
                                                    try {
                                                      if (_feSelfie != null) {
                                                        await _feSelfie!.delete();
                                                        setState(() {
                                                          _feSelfie = null;
                                                        });
                                                        print("File deleted successfully!");
                                                      }
                                                    } catch (e) {
                                                      print("Error deleting file: $e");
                                                    }
                                                  },
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      color: Colors.black, // Optional: background color for the icon
                                                      shape: BoxShape.circle,
                                                    ),
                                                    padding: EdgeInsets.all(3), // Adjust padding as needed
                                                    child: Icon(
                                                      Icons.delete_forever_outlined,
                                                      size: 18,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ):SizedBox.shrink(),
                                          doc.docName=="Premises Interior"?Flexible(
                                            child: Padding(
                                              padding: const EdgeInsets.all(5.0),
                                              child: Text(doc.docName,
                                                textAlign:TextAlign.left,softWrap:true,overflow:TextOverflow.ellipsis,maxLines:3,style: TextStyle(color: Colors.black,fontSize: 12),),
                                            ),
                                          ):SizedBox(),
                                        ],
                                      ),
                                    ):SizedBox.shrink(),
                                    doc.docName=="QR Code"?Container(
                                      height: MediaQuery.of(context).size.height/10,
                                      width: 500,
                                      color:Colors.white60,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          doc.docName=="QR Code"?Stack(
                                            children: [
                                              Container(
                                                height: 75,
                                                width: 75,
                                                decoration: BoxDecoration(
                                                  color: AppConstant.appSecondaryColor,
                                                  border: Border.all(
                                                    color: Colors.black,
                                                    width: 1.0,
                                                  ),
                                                  borderRadius: BorderRadius.circular(5),
                                                ),
                                                child: Center(
                                                  child: _feSelfie == null
                                                      ? InkWell(
                                                    onTap: (){
                                                      _pickImageCompanyBoard(ImageSource.camera);
                                                    },
                                                    child: const Text(
                                                      "No image selected",
                                                      textAlign: TextAlign.center,
                                                      style: TextStyle(fontSize: 8, color: Colors.white),
                                                    ),
                                                  )
                                                      : Container(
                                                    height: 75,
                                                    color: Colors.white,
                                                    child: Image.file(_feSelfie!,width: 75,),
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                top:-2, // Adjust these values to position the icon correctly
                                                right: 2,
                                                child: InkWell( // Consider using InkWell for better tap feedback
                                                  onTap: () async {
                                                    try {
                                                      if (_feSelfie != null) {
                                                        await _feSelfie!.delete();
                                                        setState(() {
                                                          _feSelfie = null;
                                                        });
                                                        print("File deleted successfully!");
                                                      }
                                                    } catch (e) {
                                                      print("Error deleting file: $e");
                                                    }
                                                  },
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      color: Colors.black, // Optional: background color for the icon
                                                      shape: BoxShape.circle,
                                                    ),
                                                    padding: EdgeInsets.all(3), // Adjust padding as needed
                                                    child: Icon(
                                                      Icons.delete_forever_outlined,
                                                      size: 18,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ):SizedBox.shrink(),
                                          doc.docName=="QR Code"?Flexible(
                                            child: Padding(
                                              padding: const EdgeInsets.all(5.0),
                                              child: Text(doc.docName,
                                                textAlign:TextAlign.left,softWrap:true,overflow:TextOverflow.ellipsis,maxLines:3,style: TextStyle(color: Colors.black,fontSize: 12),),
                                            ),
                                          ):SizedBox(),
                                        ],
                                      ),
                                    ):SizedBox.shrink(),
                                    doc.docName=="Stock"?Container(
                                      height: MediaQuery.of(context).size.height/10,
                                      width: 500,
                                      color:Colors.white60,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          doc.docName=="Stock"?Stack(
                                            children: [
                                              Container(
                                                height: 75,
                                                width: 75,
                                                decoration: BoxDecoration(
                                                  color: AppConstant.appSecondaryColor,
                                                  border: Border.all(
                                                    color: Colors.black,
                                                    width: 1.0,
                                                  ),
                                                  borderRadius: BorderRadius.circular(5),
                                                ),
                                                child: Center(
                                                  child: _feSelfie == null
                                                      ? InkWell(
                                                    onTap: (){
                                                      _pickImageCompanyBoard(ImageSource.camera);
                                                    },
                                                    child: const Text(
                                                      "No image selected",
                                                      textAlign: TextAlign.center,
                                                      style: TextStyle(fontSize: 8, color: Colors.white),
                                                    ),
                                                  )
                                                      : Container(
                                                    height: 75,
                                                    color: Colors.white,
                                                    child: Image.file(_feSelfie!,width: 75,),
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                top:-2, // Adjust these values to position the icon correctly
                                                right: 2,
                                                child: InkWell( // Consider using InkWell for better tap feedback
                                                  onTap: () async {
                                                    try {
                                                      if (_feSelfie != null) {
                                                        await _feSelfie!.delete();
                                                        setState(() {
                                                          _feSelfie = null;
                                                        });
                                                        print("File deleted successfully!");
                                                      }
                                                    } catch (e) {
                                                      print("Error deleting file: $e");
                                                    }
                                                  },
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      color: Colors.black, // Optional: background color for the icon
                                                      shape: BoxShape.circle,
                                                    ),
                                                    padding: EdgeInsets.all(3), // Adjust padding as needed
                                                    child: Icon(
                                                      Icons.delete_forever_outlined,
                                                      size: 18,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ):SizedBox.shrink(),
                                          doc.docName=="Stock"?Flexible(
                                            child: Padding(
                                              padding: const EdgeInsets.all(5.0),
                                              child: Text(doc.docName,
                                                textAlign:TextAlign.left,softWrap:true,overflow:TextOverflow.ellipsis,maxLines:3,style: TextStyle(color: Colors.black,fontSize: 12),),
                                            ),
                                          ):SizedBox(),
                                        ],
                                      ),
                                    ):SizedBox.shrink(),
                                    doc.docName=="Tent Card"?Container(
                                      height: MediaQuery.of(context).size.height/10,
                                      width: 500,
                                      color:Colors.white60,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          doc.docName=="Tent Card"?Stack(
                                            children: [
                                              Container(
                                                height: 75,
                                                width: 75,
                                                decoration: BoxDecoration(
                                                  color: AppConstant.appSecondaryColor,
                                                  border: Border.all(
                                                    color: Colors.black,
                                                    width: 1.0,
                                                  ),
                                                  borderRadius: BorderRadius.circular(5),
                                                ),
                                                child: Center(
                                                  child: _feSelfie == null
                                                      ? InkWell(
                                                    onTap: (){
                                                      _pickImageCompanyBoard(ImageSource.camera);
                                                    },
                                                    child: const Text(
                                                      "No image selected",
                                                      textAlign: TextAlign.center,
                                                      style: TextStyle(fontSize: 8, color: Colors.white),
                                                    ),
                                                  )
                                                      : Container(
                                                    height: 75,
                                                    color: Colors.white,
                                                    child: Image.file(_feSelfie!,width: 75,),
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                top:-2, // Adjust these values to position the icon correctly
                                                right: 2,
                                                child: InkWell( // Consider using InkWell for better tap feedback
                                                  onTap: () async {
                                                    try {
                                                      if (_feSelfie != null) {
                                                        await _feSelfie!.delete();
                                                        setState(() {
                                                          _feSelfie = null;
                                                        });
                                                        print("File deleted successfully!");
                                                      }
                                                    } catch (e) {
                                                      print("Error deleting file: $e");
                                                    }
                                                  },
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      color: Colors.black, // Optional: background color for the icon
                                                      shape: BoxShape.circle,
                                                    ),
                                                    padding: EdgeInsets.all(3), // Adjust padding as needed
                                                    child: Icon(
                                                      Icons.delete_forever_outlined,
                                                      size: 18,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ):SizedBox.shrink(),
                                          doc.docName=="Tent Card"?Flexible(
                                            child: Padding(
                                              padding: const EdgeInsets.all(5.0),
                                              child: Text(doc.docName,
                                                textAlign:TextAlign.left,softWrap:true,overflow:TextOverflow.ellipsis,maxLines:3,style: TextStyle(color: Colors.black,fontSize: 12),),
                                            ),
                                          ):SizedBox(),
                                        ],
                                      ),
                                    ):SizedBox.shrink(),
                                    doc.docName=="Political Connections"?Container(
                                      height: MediaQuery.of(context).size.height/10,
                                      width: 500,
                                      color:Colors.white60,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          doc.docName=="Political Connections"?Stack(
                                            children: [
                                              Container(
                                                height: 75,
                                                width: 75,
                                                decoration: BoxDecoration(
                                                  color: AppConstant.appSecondaryColor,
                                                  border: Border.all(
                                                    color: Colors.black,
                                                    width: 1.0,
                                                  ),
                                                  borderRadius: BorderRadius.circular(5),
                                                ),
                                                child: Center(
                                                  child: _feSelfie == null
                                                      ? InkWell(
                                                    onTap: (){
                                                      _pickImageCompanyBoard(ImageSource.camera);
                                                    },
                                                    child: const Text(
                                                      "No image selected",
                                                      textAlign: TextAlign.center,
                                                      style: TextStyle(fontSize: 8, color: Colors.white),
                                                    ),
                                                  )
                                                      : Container(
                                                    height: 75,
                                                    color: Colors.white,
                                                    child: Image.file(_feSelfie!,width: 75,),
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                top:-2, // Adjust these values to position the icon correctly
                                                right: 2,
                                                child: InkWell( // Consider using InkWell for better tap feedback
                                                  onTap: () async {
                                                    try {
                                                      if (_feSelfie != null) {
                                                        await _feSelfie!.delete();
                                                        setState(() {
                                                          _feSelfie = null;
                                                        });
                                                        print("File deleted successfully!");
                                                      }
                                                    } catch (e) {
                                                      print("Error deleting file: $e");
                                                    }
                                                  },
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      color: Colors.black, // Optional: background color for the icon
                                                      shape: BoxShape.circle,
                                                    ),
                                                    padding: EdgeInsets.all(3), // Adjust padding as needed
                                                    child: Icon(
                                                      Icons.delete_forever_outlined,
                                                      size: 18,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ):SizedBox.shrink(),
                                          doc.docName=="Political Connections"?Flexible(
                                            child: Padding(
                                              padding: const EdgeInsets.all(5.0),
                                              child: Text(doc.docName,
                                                textAlign:TextAlign.left,softWrap:true,overflow:TextOverflow.ellipsis,maxLines:3,style: TextStyle(color: Colors.black,fontSize: 12),),
                                            ),
                                          ):SizedBox(),
                                        ],
                                      ),
                                    ):SizedBox.shrink(),
                                  ],
                                ):SizedBox.shrink(),
                                category == "ID PROOF" ? Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    doc.docName=="ID Proof of Person Met"?Container(
                                      height: MediaQuery.of(context).size.height/10,
                                      width: MediaQuery.of(context).size.width,
                                      color:Colors.white60,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          doc.docName=="ID Proof of Person Met"?Stack(
                                            children: [
                                              Container(
                                                height: 75,
                                                width: 75,
                                                decoration: BoxDecoration(
                                                  color: AppConstant.appSecondaryColor,
                                                  border: Border.all(
                                                    color: Colors.black,
                                                    width: 1.0,
                                                  ),
                                                  borderRadius: BorderRadius.circular(5),
                                                ),
                                                child: Center(
                                                  child: _companuBoard == null
                                                      ? InkWell(
                                                    onTap: (){
                                                      _pickImageCompanyBoard(ImageSource.camera);
                                                    },
                                                    child: const Text(
                                                      "No image selected",
                                                      textAlign: TextAlign.center,
                                                      style: TextStyle(fontSize: 8, color: Colors.white),
                                                    ),
                                                  )
                                                      : Container(
                                                    height: 75,
                                                    color: Colors.white,
                                                    child: Image.file(_companuBoard!,width: 75,),
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                top:-2, // Adjust these values to position the icon correctly
                                                right: 2,
                                                child: InkWell( // Consider using InkWell for better tap feedback
                                                  onTap: () async {
                                                    try {
                                                      if (_companuBoard != null) {
                                                        await _companuBoard!.delete();
                                                        setState(() {
                                                          _companuBoard = null;
                                                        });
                                                        print("File deleted successfully!");
                                                      }
                                                    } catch (e) {
                                                      print("Error deleting file: $e");
                                                    }
                                                  },
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      color: Colors.black, // Optional: background color for the icon
                                                      shape: BoxShape.circle,
                                                    ),
                                                    padding: EdgeInsets.all(3), // Adjust padding as needed
                                                    child: Icon(
                                                      Icons.delete_forever_outlined,
                                                      size: 18,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ):SizedBox.shrink(),
                                          doc.docName=="ID Proof of Person Met"?Flexible(
                                            child: Padding(
                                              padding: const EdgeInsets.all(5.0),
                                              child: Text(doc.docName,
                                                textAlign:TextAlign.left,softWrap:true,overflow:TextOverflow.ellipsis,maxLines:3,style: TextStyle(color: Colors.black,fontSize: 12),),
                                            ),
                                          ):SizedBox(),
                                        ],
                                      ),
                                    ):SizedBox.shrink(),
                                    doc.docName=="Pancard"?Container(
                                      height: MediaQuery.of(context).size.height/10,
                                      width: MediaQuery.of(context).size.width,
                                      color:Colors.white60,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          doc.docName=="ID Proof of Person Met"?Stack(
                                            children: [
                                              Container(
                                                height: 75,
                                                width: 75,
                                                decoration: BoxDecoration(
                                                  color: AppConstant.appSecondaryColor,
                                                  border: Border.all(
                                                    color: Colors.black,
                                                    width: 1.0,
                                                  ),
                                                  borderRadius: BorderRadius.circular(5),
                                                ),
                                                child: Center(
                                                  child: _companuBoard == null
                                                      ? InkWell(
                                                    onTap: (){
                                                      _pickImageCompanyBoard(ImageSource.camera);
                                                    },
                                                    child: const Text(
                                                      "No image selected",
                                                      textAlign: TextAlign.center,
                                                      style: TextStyle(fontSize: 8, color: Colors.white),
                                                    ),
                                                  )
                                                      : Container(
                                                    height: 75,
                                                    color: Colors.white,
                                                    child: Image.file(_companuBoard!,width: 75,),
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                top:-2, // Adjust these values to position the icon correctly
                                                right: 2,
                                                child: InkWell( // Consider using InkWell for better tap feedback
                                                  onTap: () async {
                                                    try {
                                                      if (_companuBoard != null) {
                                                        await _companuBoard!.delete();
                                                        setState(() {
                                                          _companuBoard = null;
                                                        });
                                                        print("File deleted successfully!");
                                                      }
                                                    } catch (e) {
                                                      print("Error deleting file: $e");
                                                    }
                                                  },
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      color: Colors.black, // Optional: background color for the icon
                                                      shape: BoxShape.circle,
                                                    ),
                                                    padding: EdgeInsets.all(3), // Adjust padding as needed
                                                    child: Icon(
                                                      Icons.delete_forever_outlined,
                                                      size: 18,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ):SizedBox.shrink(),
                                          doc.docName=="Pancard"?Flexible(
                                            child: Padding(
                                              padding: const EdgeInsets.all(5.0),
                                              child: Text(doc.docName,
                                                textAlign:TextAlign.left,softWrap:true,overflow:TextOverflow.ellipsis,maxLines:3,style: TextStyle(color: Colors.black,fontSize: 12),),
                                            ),
                                          ):SizedBox(),
                                        ],
                                      ),
                                    ):SizedBox.shrink(),
                                  ],
                                ):SizedBox.shrink(),
                                category == "OTHERS" ? Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    doc.docName=="Annexure"?Container(
                                      height: MediaQuery.of(context).size.height/10,
                                      width: MediaQuery.of(context).size.width,
                                      color:Colors.white60,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          doc.docName=="Annexure"?Stack(
                                            children: [
                                              Container(
                                                height: 75,
                                                width: 75,
                                                decoration: BoxDecoration(
                                                  color: AppConstant.appSecondaryColor,
                                                  border: Border.all(
                                                    color: Colors.black,
                                                    width: 1.0,
                                                  ),
                                                  borderRadius: BorderRadius.circular(5),
                                                ),
                                                child: Center(
                                                  child: _companuBoard == null
                                                      ? InkWell(
                                                    onTap: (){
                                                      _pickImageCompanyBoard(ImageSource.camera);
                                                    },
                                                    child: const Text(
                                                      "No image selected",
                                                      textAlign: TextAlign.center,
                                                      style: TextStyle(fontSize: 8, color: Colors.white),
                                                    ),
                                                  )
                                                      : Container(
                                                    height: 75,
                                                    color: Colors.white,
                                                    child: Image.file(_companuBoard!,width: 75,),
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                top:-2, // Adjust these values to position the icon correctly
                                                right: 2,
                                                child: InkWell( // Consider using InkWell for better tap feedback
                                                  onTap: () async {
                                                    try {
                                                      if (_companuBoard != null) {
                                                        await _companuBoard!.delete();
                                                        setState(() {
                                                          _companuBoard = null;
                                                        });
                                                        print("File deleted successfully!");
                                                      }
                                                    } catch (e) {
                                                      print("Error deleting file: $e");
                                                    }
                                                  },
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      color: Colors.black, // Optional: background color for the icon
                                                      shape: BoxShape.circle,
                                                    ),
                                                    padding: EdgeInsets.all(3), // Adjust padding as needed
                                                    child: Icon(
                                                      Icons.delete_forever_outlined,
                                                      size: 18,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ):SizedBox.shrink(),
                                          doc.docName=="Annexure"?Flexible(
                                            child: Padding(
                                              padding: const EdgeInsets.all(5.0),
                                              child: Text(doc.docName,
                                                textAlign:TextAlign.left,softWrap:true,overflow:TextOverflow.ellipsis,maxLines:3,style: TextStyle(color: Colors.black,fontSize: 12),),
                                            ),
                                          ):SizedBox(),
                                        ],
                                      ),
                                    ):SizedBox.shrink(),
                                    doc.docName=="Pancard"?Container(
                                      height: MediaQuery.of(context).size.height/10,
                                      width: MediaQuery.of(context).size.width,
                                      color:Colors.white60,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          doc.docName=="ID Proof of Person Met"?Stack(
                                            children: [
                                              Container(
                                                height: 75,
                                                width: 75,
                                                decoration: BoxDecoration(
                                                  color: AppConstant.appSecondaryColor,
                                                  border: Border.all(
                                                    color: Colors.black,
                                                    width: 1.0,
                                                  ),
                                                  borderRadius: BorderRadius.circular(5),
                                                ),
                                                child: Center(
                                                  child: _companuBoard == null
                                                      ? InkWell(
                                                    onTap: (){
                                                      _pickImageCompanyBoard(ImageSource.camera);
                                                    },
                                                    child: const Text(
                                                      "No image selected",
                                                      textAlign: TextAlign.center,
                                                      style: TextStyle(fontSize: 8, color: Colors.white),
                                                    ),
                                                  )
                                                      : Container(
                                                    height: 75,
                                                    color: Colors.white,
                                                    child: Image.file(_companuBoard!,width: 75,),
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                top:-2, // Adjust these values to position the icon correctly
                                                right: 2,
                                                child: InkWell( // Consider using InkWell for better tap feedback
                                                  onTap: () async {
                                                    try {
                                                      if (_companuBoard != null) {
                                                        await _companuBoard!.delete();
                                                        setState(() {
                                                          _companuBoard = null;
                                                        });
                                                        print("File deleted successfully!");
                                                      }
                                                    } catch (e) {
                                                      print("Error deleting file: $e");
                                                    }
                                                  },
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      color: Colors.black, // Optional: background color for the icon
                                                      shape: BoxShape.circle,
                                                    ),
                                                    padding: EdgeInsets.all(3), // Adjust padding as needed
                                                    child: Icon(
                                                      Icons.delete_forever_outlined,
                                                      size: 18,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ):SizedBox.shrink(),
                                          doc.docName=="Pancard"?Flexible(
                                            child: Padding(
                                              padding: const EdgeInsets.all(5.0),
                                              child: Text(doc.docName,
                                                textAlign:TextAlign.left,softWrap:true,overflow:TextOverflow.ellipsis,maxLines:3,style: TextStyle(color: Colors.black,fontSize: 12),),
                                            ),
                                          ):SizedBox(),
                                        ],
                                      ),
                                    ):SizedBox.shrink(),
                                  ],
                                ):SizedBox.shrink(),
                              ],
                            ),
                          ),
                        ],
                      ),

                    ):SizedBox.shrink();
                  }).toList(),
                ),
              );
            }).toList(),
          );


        },
      ),
    );
  }
}
