import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:peckme/model/DocumentResponse.dart';

import '../controller/document_controller.dart';
import '../utils/app_constant.dart';

class DocumentScreen extends StatefulWidget {
  final String clientId;
  const DocumentScreen({Key? key, required this.clientId}) : super(key: key);

  @override
  State<DocumentScreen> createState() => _DocumentScreenState();
}

class _DocumentScreenState extends State<DocumentScreen> {
  late Future<DocumentResponse?> futureDocuments;
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
              print("before client : "+widget.clientId);

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

                    print("Doc: ${doc.docName} |Doc: ${doc.docType} | Clients: $clientIds | WidgetClient: ${widget.clientId} | Match: $belongsToClient");

                    return belongsToClient?ListTile(
                      title: Column(
                        children: [
                          Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                category == "PHOTO" ? Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        doc.docName=="Company Board"?Column(
                                          children: [Stack(
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
                                          ),
                                            Text(doc.docName,style: TextStyle(color: Colors.black,fontSize: 12),),
                                          ],
                                        ):SizedBox.shrink(),
                                        doc.docName=="FE Selfie"?Column(
                                          children: [Stack(
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
                                          ),
                                            Text(doc.docName,style: TextStyle(color: Colors.black,fontSize: 12),),
                                          ],
                                        ):SizedBox.shrink(),
                                        doc.docName == "Front Door"?Column(
                                          children: [Stack(
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
                                                  borderRadius: BorderRadius.circular(50),
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
                                                      : CircleAvatar(
                                                    backgroundImage: FileImage(_companuBoard!),
                                                    radius: 50,
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
                                                          documentList[0] = null;
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
                                          ),
                                            Text(doc.docName,style: TextStyle(color: Colors.black,fontSize: 12),),
                                          ],
                                        ):SizedBox.shrink(),
                                      ],
                                    ),
                                  ],
                                ):SizedBox.shrink(),
                                category == "ADD PROOF" ? Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        doc.docName=="Gas Bill (Pipe line)"?Column(
                                          children: [Stack(
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
                                          ),
                                            Text(doc.docName,style: TextStyle(color: Colors.black,fontSize: 12),),
                                          ],
                                        ):SizedBox.shrink(),
                                      ],
                                    ),
                                  ],
                                ):SizedBox.shrink(),

                              ],
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
