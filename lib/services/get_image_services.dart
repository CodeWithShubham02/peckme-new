import 'dart:io';

import 'package:flutter/cupertino.dart' show Navigator;
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class GetImageServices{
  final ImagePicker picker=ImagePicker();

  //photo category
   File? feSelfie;
   File? companuBoard;
   File? billDesk;
   File? frontDoor;
   File? locationSnap;
   File? namePstatic;
   File? premisesInterior;
   File? stock;
   File? photo;
   File? fESelfieWithPerson;
   File? imageOfPersonMet;
   File? billDeskImageofShop;
   File? imageofShopFromOutside;
   File? qRCode;
   File? tentCard;
   File? politicalConnections;
  Future pickImageCompanyBoard(ImageSource source, BuildContext context) async{
    try{
      final image =await ImagePicker().pickImage(source: source);
      if(image==null) return;
      File? img= File(image.path);
      img=await _cropImage(imageFile: img);
      companuBoard=img;
    }on PlatformException catch(e){
      print(e);
      Navigator.of(context).pop();
    }
  }
  Future pickImageFeSelfie(ImageSource source,  BuildContext context) async{
    try{
      final image =await ImagePicker().pickImage(source: source);
      if(image==null) return;
      File? img= File(image.path);
      img=await _cropImage(imageFile: img);
      feSelfie=img;
    }on PlatformException catch(e){
      print(e);
      Navigator.of(context).pop();
    }
  }
  Future pickImageBillDesk(ImageSource source,  BuildContext context) async{
    try{
      final image =await ImagePicker().pickImage(source: source);
      if(image==null) return;
      File? img= File(image.path);
      img=await _cropImage(imageFile: img);
      billDesk=img;
    }on PlatformException catch(e){
      print(e);
      Navigator.of(context).pop();
    }
  }
  Future pickImageFrontDoor(ImageSource source,  BuildContext context) async{
    try{
      final image =await ImagePicker().pickImage(source: source);
      if(image==null) return;
      File? img= File(image.path);
      img=await _cropImage(imageFile: img);
      frontDoor=img;
    }on PlatformException catch(e){
      print(e);
      Navigator.of(context).pop();
    }
  }
  Future pickImageLocationSnap(ImageSource source,  BuildContext context) async{
    try{
      final image =await ImagePicker().pickImage(source: source);
      if(image==null) return;
      File? img= File(image.path);
      img=await _cropImage(imageFile: img);
      locationSnap=img;
    }on PlatformException catch(e){
      print(e);
      Navigator.of(context).pop();
    }
  }
  Future pickImageNamePstatic(ImageSource source,  BuildContext context) async{
    try{
      final image =await ImagePicker().pickImage(source: source);
      if(image==null) return;
      File? img= File(image.path);
      img=await _cropImage(imageFile: img);
      namePstatic=img;
    }on PlatformException catch(e){
      print(e);
      Navigator.of(context).pop();
    }
  }
  Future pickImagePremisesInterior(ImageSource source,  BuildContext context) async{
    try{
      final image =await ImagePicker().pickImage(source: source);
      if(image==null) return;
      File? img= File(image.path);
      img=await _cropImage(imageFile: img);
      premisesInterior=img;
    }on PlatformException catch(e){
      print(e);
      Navigator.of(context).pop();
    }
  }
  Future pickImageStock(ImageSource source,  BuildContext context) async{
    try{
      final image =await ImagePicker().pickImage(source: source);
      if(image==null) return;
      File? img= File(image.path);
      img=await _cropImage(imageFile: img);
      stock=img;
    }on PlatformException catch(e){
      print(e);
      Navigator.of(context).pop();
    }
  }
  Future pickImagePhoto(ImageSource source,  BuildContext context) async{
    try{
      final image =await ImagePicker().pickImage(source: source);
      if(image==null) return;
      File? img= File(image.path);
      img=await _cropImage(imageFile: img);
      photo=img;
    }on PlatformException catch(e){
      print(e);
      Navigator.of(context).pop();
    }
  }
  Future pickImageFESelfieWithPerson(ImageSource source,  BuildContext context) async{
    try{
      final image =await ImagePicker().pickImage(source: source);
      if(image==null) return;
      File? img= File(image.path);
      img=await _cropImage(imageFile: img);
      fESelfieWithPerson=img;
    }on PlatformException catch(e){
      print(e);
      Navigator.of(context).pop();
    }
  }
  Future pickImageImageOfPersonMet(ImageSource source,  BuildContext context) async{
    try{
      final image =await ImagePicker().pickImage(source: source);
      if(image==null) return;
      File? img= File(image.path);
      img=await _cropImage(imageFile: img);
      imageOfPersonMet=img;
    }on PlatformException catch(e){
      print(e);
      Navigator.of(context).pop();
    }
  }
  Future pickImageBillDeskImageofShop(ImageSource source,  BuildContext context) async{
    try{
      final image =await ImagePicker().pickImage(source: source);
      if(image==null) return;
      File? img= File(image.path);
      img=await _cropImage(imageFile: img);
      billDeskImageofShop=img;
    }on PlatformException catch(e){
      print(e);
      Navigator.of(context).pop();
    }
  }
  Future pickImageImageofShopFromOutside(ImageSource source,  BuildContext context) async{
    try{
      final image =await ImagePicker().pickImage(source: source);
      if(image==null) return;
      File? img= File(image.path);
      img=await _cropImage(imageFile: img);
      imageofShopFromOutside=img;
    }on PlatformException catch(e){
      print(e);
      Navigator.of(context).pop();
    }
  }
  Future pickImageQRCode(ImageSource source,  BuildContext context) async{
    try{
      final image =await ImagePicker().pickImage(source: source);
      if(image==null) return;
      File? img= File(image.path);
      img=await _cropImage(imageFile: img);
      qRCode=img;
    }on PlatformException catch(e){
      print(e);
      Navigator.of(context).pop();
    }
  }
  Future pickImageTentCard(ImageSource source,  BuildContext context) async{
    try{
      final image =await ImagePicker().pickImage(source: source);
      if(image==null) return;
      File? img= File(image.path);
      img=await _cropImage(imageFile: img);
      tentCard=img;
    }on PlatformException catch(e){
      print(e);
      Navigator.of(context).pop();
    }
  }
  Future pickImagePoliticalConnections(ImageSource source,  BuildContext context) async{
    try{
      final image =await ImagePicker().pickImage(source: source);
      if(image==null) return;
      File? img= File(image.path);
      img=await _cropImage(imageFile: img);
      politicalConnections=img;
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

}