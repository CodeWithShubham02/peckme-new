import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as docs;
import 'package:peckme/model/DocumentResponse.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../controller/document_controller.dart';
import '../../controller/document_list_controller.dart';
import '../../model/document_list_model.dart';
import '../../utils/app_constant.dart';
import '../../services/image_to_pdf.dart';
import '../dashboard_screen.dart';
import 'custom_crop_image_widget.dart';
import 'custome_crop_screen.dart';

class DocumentScreenTest extends StatefulWidget {
  final String clientName;
  final String clientId;
  final String leadId;
  const DocumentScreenTest({Key? key, required this.clientName,required this.leadId,required this.clientId}) : super(key: key);

  @override
  State<DocumentScreenTest> createState() => _DocumentScreenTestState();
}

class _DocumentScreenTestState extends State<DocumentScreenTest> {
  late Future<DocumentResponse?> futureDocuments;
  late Future<Document?> _futureDocumentsList;

  final DocumentService _documentService = DocumentService();
  String uid = '';



  void loadUserData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      uid = prefs.getString('uid') ?? '';
    });
  }

 // List<File?> get documentList => [companuBoard, feSelfie,billDesk,frontDoor,locationSnap,namePstatic,premisesInterior,stock,photo,fESelfieWithPerson,qRCode,imageOfPersonMet,billDeskImageofShop,imageofShopFromOutside,tentCard,politicalConnections];
  List<String> collectedDocs = [];

  //category=="PHOTO" START CODE
  bool isLoadingPhoto = false;
  bool isLoadingfeSelfie=false;
  bool isLoadingfESelfieWithPerson=false;
  bool isLoadingcompanuBoard=false;
  bool isLoadingbillDesk=false;
  bool isLoadingfrontDoor=false;
  bool isLoadinglocationSnap=false;
  bool isLoadingnamePstatic=false;
  bool isLoadingpremisesInterior=false;
  bool isLoadingstock=false;
  bool isLoadingimageOfPersonMet=false;
  bool isLoadingbillDeskImageofShop=false;
  bool isLoadingimageofShopFromOutside=false;
  bool isLoadingqRCode=false;
  bool isLoadingtentCard=false;
  bool isLoadingpoliticalConnections=false;

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
  Future pickImageCompanyBoard(ImageSource source, String docname) async {
    setState(() => isLoadingcompanuBoard = true);
    final img = await _pickAndUploadImage(source, docname);
    setState(() {
      isLoadingcompanuBoard = false;
      if (img != null) companuBoard = img;
    });
  }
  Future pickImageFeSelfie(ImageSource source, String docname) async {
    setState(() => isLoadingfeSelfie = true);
    final img = await _pickAndUploadImage(source, docname);
    setState(() {
      isLoadingfeSelfie = false;
      if (img != null) feSelfie = img;
    });
  }
  Future pickImageBillDesk(ImageSource source, String docname) async {
    setState(() => isLoadingbillDesk = true);
    final img = await _pickAndUploadImage(source, docname);
    setState(() {
      isLoadingbillDesk = false;
      if (img != null) billDesk = img;
    });
  }
  Future pickImageFrontDoor(ImageSource source, String docname) async {
    setState(() => isLoadingfrontDoor = true);
    final img = await _pickAndUploadImage(source, docname);
    setState(() {
      isLoadingfrontDoor = false;
      if (img != null) frontDoor = img;
    });
  }
  Future pickImageLocationSnap(ImageSource source, String docname) async {
    setState(() => isLoadinglocationSnap = true);
    final img = await _pickAndUploadImage(source, docname);
    setState(() {
      isLoadinglocationSnap = false;
      if (img != null) locationSnap = img;
    });
  }
  Future pickImageNamePstatic(ImageSource source, String docname) async {
    setState(() => isLoadingnamePstatic = true);
    final img = await _pickAndUploadImage(source, docname);
    setState(() {
      isLoadingnamePstatic = false;
      if (img != null) namePstatic = img;
    });
  }
  Future pickImagePremisesInterior(ImageSource source, String docname) async {
    setState(() => isLoadingpremisesInterior = true);
    final img = await _pickAndUploadImage(source, docname);
    setState(() {
      isLoadingpremisesInterior = false;
      if (img != null) premisesInterior = img;
    });
  }
  Future pickImageStock(ImageSource source, String docname) async {
    setState(() => isLoadingstock = true);
    final img = await _pickAndUploadImage(source, docname);
    setState(() {
      isLoadingstock = false;
      if (img != null) stock = img;
    });
  }
  Future pickImagePhoto1(ImageSource source, String docname) async {
    setState(() => isLoadingPhoto = true);
    final img = await _pickAndUploadImage(source, docname);
    setState(() {
      isLoadingPhoto = false;
      if (img != null) photo = img;
    });
  }
  Future pickImageFESelfieWithPerson1(ImageSource source, String docname) async {
    setState(() => isLoadingfESelfieWithPerson = true);
    final img = await _pickAndUploadImage(source, docname);
    setState(() {
      isLoadingfESelfieWithPerson = false;
      if (img != null) fESelfieWithPerson = img;
    });
  }
  Future pickImageImageOfPersonMet(ImageSource source, String docname) async {
    setState(() => isLoadingimageOfPersonMet = true);
    final img = await _pickAndUploadImage(source, docname);
    setState(() {
      isLoadingimageOfPersonMet = false;
      if (img != null) imageOfPersonMet = img;
    });
  }
  Future pickImageBillDeskImageofShop(ImageSource source, String docname) async {
    setState(() => isLoadingbillDeskImageofShop = true);
    final img = await _pickAndUploadImage(source, docname);
    setState(() {
      isLoadingbillDeskImageofShop = false;
      if (img != null) billDeskImageofShop = img;
    });
  }
  Future pickImageImageofShopFromOutside(ImageSource source, String docname) async {
    setState(() => isLoadingimageofShopFromOutside = true);
    final img = await _pickAndUploadImage(source, docname);
    setState(() {
      isLoadingimageofShopFromOutside = false;
      if (img != null) imageofShopFromOutside = img;
    });
  }
  Future pickImageQRCode(ImageSource source, String docname) async {
    setState(() => isLoadingqRCode = true);
    final img = await _pickAndUploadImage(source, docname);
    setState(() {
      isLoadingqRCode = false;
      if (img != null) qRCode = img;
    });
  }
  Future pickImageTentCard(ImageSource source, String docname) async {
    setState(() => isLoadingtentCard = true);
    final img = await _pickAndUploadImage(source, docname);
    setState(() {
      isLoadingtentCard = false;
      if (img != null) tentCard = img;
    });
  }
  Future pickImagePoliticalConnections(ImageSource source, String docname) async {
    setState(() => isLoadingpoliticalConnections = true);
    final img = await _pickAndUploadImage(source, docname);
    setState(() {
      isLoadingpoliticalConnections = false;
      if (img != null) politicalConnections = img;
    });
  }

  //category=="PHOTO" END CODE
  //category=="ID PROOF" START CODE
  bool isLoadingiDProofofPersonMet=false;
  bool isLoadingpancard=false;

  File? iDProofofPersonMet;
  File? pancard;
  Future pickImageIDProofofPersonMet(ImageSource source, String docname) async {
    setState(() => isLoadingiDProofofPersonMet = true);
    final img = await _pickAndUploadImage(source, docname);
    setState(() {
      isLoadingiDProofofPersonMet = false;
      if (img != null) iDProofofPersonMet = img;
    });
  }
  Future pickImagePancard(ImageSource source, String docname) async {
    setState(() => isLoadingpancard = true);
    final img = await _pickAndUploadImage(source, docname);
    setState(() {
      isLoadingpancard = false;
      if (img != null) pancard = img;
    });
  }
  //category=="ID PROOF" END CODE
  //category=="OTHERS" START CODE
  bool isLoadingAnnexure=false;
  bool isLoadingOthers=false;
  bool isLoading1monthBankStatement=false;
  bool isLoadingCancelledCheque=false;
  bool isLoadingCompanyID=false;
  bool isLoadingCompletelyFilledJob=false;
  bool isLoadingDueDiligenceForm=false;
  bool isLoadingForm26AS=false;
  bool isLoadingForm60=false;
  bool isLoadingGazetteCertificate=false;
  bool isLoadingGSTAnnexA=false;
  bool isLoadingGSTAnnexB=false;
  bool isLoadingLoanAgreement=false;
  bool isLoadingMarriageCertificate=false;
  bool isLoadingNachOnly=false;
  bool isLoadingOVDDeclaration=false;
  bool isLoadingPODImage=false;
  bool isLoadingCheques=false;
  bool isLoadingAuthSignForm=false;
  bool isLoadingShopEstablishmentCertificate=false;

  File? annexure;
  File? others;
  File? oneMonthBankStatement;
  File? cancelledCheque;
  File? companyID;
  File? completelyFilledJob;
  File? dueDiligenceForm;
  File? form26AS;
  File? form60;
  File? gazetteCertificate;
  File? gSTAnnexA;
  File? gSTAnnexB;
  File? loanAgreement;
  File? marriageCertificate;
  File? nachOnly;
  File? oVDDeclaration;
  File? pODImage;
  File? cheques;
  File? authSignForm;
  File? shopEstablishmentCertificate;
  Future pickImageAnnexure(ImageSource source, String docname) async {
    setState(() => isLoadingAnnexure = true);
    final img = await _pickAndUploadImage(source, docname);
    setState(() {
      isLoadingAnnexure = false;
      if (img != null) annexure = img;
    });
  }
  Future pickImageOthers(ImageSource source, String docname) async {
    setState(() => isLoadingOthers = true);
    final img = await _pickAndUploadImage(source, docname);
    setState(() {
      isLoadingOthers = false;
      if (img != null) others = img;
    });
  }
  Future pickImage1monthBankStatement(ImageSource source, String docname) async {
    setState(() => isLoading1monthBankStatement = true);
    final img = await _pickAndUploadImage(source, docname);
    setState(() {
      isLoading1monthBankStatement = false;
      if (img != null) oneMonthBankStatement = img;
    });
  }
  Future pickImageCancelledCheque(ImageSource source, String docname) async {
    setState(() => isLoadingCancelledCheque = true);
    final img = await _pickAndUploadImage(source, docname);
    setState(() {
      isLoadingCancelledCheque = false;
      if (img != null) cancelledCheque = img;
    });
  }
  Future pickImageCompanyID(ImageSource source, String docname) async {
    setState(() => isLoadingCompanyID = true);
    final img = await _pickAndUploadImage(source, docname);
    setState(() {
      isLoadingCompanyID = false;
      if (img != null) companyID = img;
    });
  }
  Future pickImageCompletelyFilledJob(ImageSource source, String docname) async {
    setState(() => isLoadingCompletelyFilledJob = true);
    final img = await _pickAndUploadImage(source, docname);
    setState(() {
      isLoadingCompletelyFilledJob = false;
      if (img != null) completelyFilledJob = img;
    });
  }
  Future pickImageDueDiligenceForm(ImageSource source, String docname) async {
    setState(() => isLoadingDueDiligenceForm = true);
    final img = await _pickAndUploadImage(source, docname);
    setState(() {
      isLoadingDueDiligenceForm = false;
      if (img != null) dueDiligenceForm = img;
    });
  }
  Future pickImageForm26AS(ImageSource source, String docname) async {
    setState(() => isLoadingForm26AS = true);
    final img = await _pickAndUploadImage(source, docname);
    setState(() {
      isLoadingForm26AS = false;
      if (img != null) form26AS = img;
    });
  }
  Future pickImageForm60(ImageSource source, String docname) async {
    setState(() => isLoadingForm60 = true);
    final img = await _pickAndUploadImage(source, docname);
    setState(() {
      isLoadingForm60 = false;
      if (img != null) form60 = img;
    });
  }
  Future pickImageGazetteCertificate(ImageSource source, String docname) async {
    setState(() => isLoadingGazetteCertificate = true);
    final img = await _pickAndUploadImage(source, docname);
    setState(() {
      isLoadingGazetteCertificate = false;
      if (img != null) gazetteCertificate = img;
    });
  }
  Future pickImageGSTAnnexA(ImageSource source, String docname) async {
    setState(() => isLoadingGSTAnnexA = true);
    final img = await _pickAndUploadImage(source, docname);
    setState(() {
      isLoadingGSTAnnexA = false;
      if (img != null) gSTAnnexA = img;
    });
  }
  Future pickImageGSTAnnexB(ImageSource source, String docname) async {
    setState(() => isLoadingGSTAnnexB = true);
    final img = await _pickAndUploadImage(source, docname);
    setState(() {
      isLoadingGSTAnnexB = false;
      if (img != null) gSTAnnexB = img;
    });
  }
  Future pickImageLoanAgreement(ImageSource source, String docname) async {
    setState(() => isLoadingLoanAgreement = true);
    final img = await _pickAndUploadImage(source, docname);
    setState(() {
      isLoadingLoanAgreement = false;
      if (img != null) loanAgreement = img;
    });
  }
  Future pickImageMarriageCertificate(ImageSource source, String docname) async {
    setState(() => isLoadingMarriageCertificate = true);
    final img = await _pickAndUploadImage(source, docname);
    setState(() {
      isLoadingMarriageCertificate = false;
      if (img != null) marriageCertificate = img;
    });
  }
  Future pickImageNachOnly(ImageSource source, String docname) async {
    setState(() => isLoadingNachOnly = true);
    final img = await _pickAndUploadImage(source, docname);
    setState(() {
      isLoadingNachOnly = false;
      if (img != null) nachOnly = img;
    });
  }
  Future pickImageOVDDeclaration(ImageSource source, String docname) async {
    setState(() => isLoadingOVDDeclaration = true);
    final img = await _pickAndUploadImage(source, docname);
    setState(() {
      isLoadingOVDDeclaration = false;
      if (img != null) oVDDeclaration = img;
    });
  }
  Future pickImagePODImage(ImageSource source, String docname) async {
    setState(() => isLoadingPODImage = true);
    final img = await _pickAndUploadImage(source, docname);
    setState(() {
      isLoadingPODImage = false;
      if (img != null) pODImage = img;
    });
  }
  Future pickImageCheques(ImageSource source, String docname) async {
    setState(() => isLoadingCheques = true);
    final img = await _pickAndUploadImage(source, docname);
    setState(() {
      isLoadingCheques = false;
      if (img != null) cheques = img;
    });
  }
  Future pickImageAuthSignForm(ImageSource source, String docname) async {
    setState(() => isLoadingAuthSignForm = true);
    final img = await _pickAndUploadImage(source, docname);
    setState(() {
      isLoadingAuthSignForm = false;
      if (img != null) authSignForm = img;
    });
  }
  Future pickImageShopEstablishmentCertificate(ImageSource source, String docname) async {
    setState(() => isLoadingShopEstablishmentCertificate = true);
    final img = await _pickAndUploadImage(source, docname);
    setState(() {
      isLoadingShopEstablishmentCertificate = false;
      if (img != null) shopEstablishmentCertificate = img;
    });
  }
  //category=="OTHERS" END CODE
  //category=="ADD PROOF" START CODE
  bool isLoadingAadhaarBack=false;
  bool isLoadingAadhaarFront=false;
  bool isLoadingAllotmentLetter=false;
  bool isLoadingDrivingLicense=false;
  bool isLoadingElectricityBill=false;
  bool isLoadingGasBill=false;
  bool isLoadingLandLineBill=false;
  bool isLoadingMaintainanceReceipt=false;
  bool isLoadingMobileBill=false;
  bool isLoadingMunicipalityWaterBill=false;
  bool isLoadingPassport=false;
  bool isLoadingPostOfficeSB=false;
  bool isLoadingRegisteredRent=false;
  bool isLoadingRegisteredSales=false;
  bool isLoadingRentAgreement=false;
  bool isLoadingVoterCard=false;

  File? aadhaarBack;
  File? aadhaarFront;
  File? allotmentLetter;
  File? drivingLicense;
  File? electricityBill;
  File? gasBill;
  File? landLineBill;
  File? maintainanceReceipt;
  File? mobileBill;
  File? municipalityWaterBill;
  File? passport;
  File? postOfficeSB;
  File? registeredRent;
  File? registeredSales;
  File? rentAgreement;
  File? voterCard;
  Future pickImageAadhaarBack(ImageSource source, String docname) async {
    setState(() => isLoadingAadhaarBack = true);
    final img = await _pickAndUploadImage(source, docname);
    setState(() {
      isLoadingAadhaarBack = false;
      if (img != null) aadhaarBack = img;
    });
  }
  Future pickImageAadhaarFront(ImageSource source, String docname) async {
    setState(() => isLoadingAadhaarFront = true);
    final img = await _pickAndUploadImage(source, docname);
    setState(() {
      isLoadingAadhaarFront = false;
      if (img != null) aadhaarFront = img;
    });
  }
  Future pickImageAllotmentLetter(ImageSource source, String docname) async {
    setState(() => isLoadingAllotmentLetter = true);
    final img = await _pickAndUploadImage(source, docname);
    setState(() {
      isLoadingAllotmentLetter = false;
      if (img != null) allotmentLetter = img;
    });
  }
  Future pickImageDrivingLicense(ImageSource source, String docname) async {
    setState(() => isLoadingDrivingLicense = true);
    final img = await _pickAndUploadImage(source, docname);
    setState(() {
      isLoadingDrivingLicense = false;
      if (img != null) drivingLicense = img;
    });
  }
  Future pickImageElectricityBill(ImageSource source, String docname) async {
    setState(() => isLoadingElectricityBill = true);
    final img = await _pickAndUploadImage(source, docname);
    setState(() {
      isLoadingElectricityBill = false;
      if (img != null) electricityBill = img;
    });
  }
  Future pickImageGasBill(ImageSource source, String docname) async {
    setState(() => isLoadingGasBill = true);
    final img = await _pickAndUploadImage(source, docname);
    setState(() {
      isLoadingGasBill = false;
      if (img != null) gasBill = img;
    });
  }
  Future pickImageLandLineBill(ImageSource source, String docname) async {
    setState(() => isLoadingLandLineBill = true);
    final img = await _pickAndUploadImage(source, docname);
    setState(() {
      isLoadingLandLineBill = false;
      if (img != null) landLineBill = img;
    });
  }
  Future pickImageMaintainanceReceipt(ImageSource source, String docname) async {
    setState(() => isLoadingMaintainanceReceipt = true);
    final img = await _pickAndUploadImage(source, docname);
    setState(() {
      isLoadingMaintainanceReceipt = false;
      if (img != null) maintainanceReceipt = img;
    });
  }
  Future pickImageMobileBill(ImageSource source, String docname) async {
    setState(() => isLoadingMobileBill = true);
    final img = await _pickAndUploadImage(source, docname);
    setState(() {
      isLoadingMobileBill = false;
      if (img != null) mobileBill = img;
    });
  }
  Future pickImageMunicipalityWaterBill(ImageSource source, String docname) async {
    setState(() => isLoadingMunicipalityWaterBill = true);
    final img = await _pickAndUploadImage(source, docname);
    setState(() {
      isLoadingMunicipalityWaterBill = false;
      if (img != null) municipalityWaterBill = img;
    });
  }
  Future pickImagePassport(ImageSource source, String docname) async {
    setState(() => isLoadingPassport= true);
    final img = await _pickAndUploadImage(source, docname);
    setState(() {
      isLoadingPassport = false;
      if (img != null) passport = img;
    });
  }
  Future pickImagePostOfficeSB(ImageSource source, String docname) async {
    setState(() => isLoadingPostOfficeSB= true);
    final img = await _pickAndUploadImage(source, docname);
    setState(() {
      isLoadingPostOfficeSB = false;
      if (img != null) postOfficeSB = img;
    });
  }
  Future pickImageRegisteredRent(ImageSource source, String docname) async {
    setState(() => isLoadingRegisteredRent= true);
    final img = await _pickAndUploadImage(source, docname);
    setState(() {
      isLoadingRegisteredRent = false;
      if (img != null) registeredRent = img;
    });
  }
  Future pickImageRegisteredSales(ImageSource source, String docname) async {
    setState(() => isLoadingRegisteredSales= true);
    final img = await _pickAndUploadImage(source, docname);
    setState(() {
      isLoadingRegisteredSales = false;
      if (img != null) registeredSales = img;
    });
  }
  Future pickImageRentAgreement(ImageSource source, String docname) async {
    setState(() => isLoadingRentAgreement= true);
    final img = await _pickAndUploadImage(source, docname);
    setState(() {
      isLoadingRentAgreement = false;
      if (img != null) rentAgreement = img;
    });
  }
  Future pickImageVoterCard(ImageSource source, String docname) async {
    setState(() => isLoadingVoterCard= true);
    final img = await _pickAndUploadImage(source, docname);
    setState(() {
      isLoadingVoterCard = false;
      if (img != null) voterCard = img;
    });
  }
  //category=="ADD PROOF" END CODE

  //START CODE CATEGORY=="INCOME PROOF"
  bool isLoadingCreditCardCopy=false;
  bool isLoadingITRComputation=false;
  bool isLoadingLatestCreditCard=false;
  bool isLoadingLatestSalarySlip=false;
  bool isLoadingSalarySlip=false;

  File? creditCardCopy;
  File? iTRComputation;
  File? latestCreditCard;
  File? latestSalarySlip;
  File? salarySlip;
  Future pickImageCreditCardCopy(ImageSource source, String docname) async {
    setState(() => isLoadingCreditCardCopy = true);
    final img = await _pickAndUploadImage(source, docname);
    setState(() {
      isLoadingCreditCardCopy = false;
      if (img != null) creditCardCopy = img;
    });
  }
  Future pickImageITRComputation(ImageSource source, String docname) async {
    setState(() => isLoadingITRComputation = true);
    final img = await _pickAndUploadImage(source, docname);
    setState(() {
      isLoadingITRComputation = false;
      if (img != null) iTRComputation = img;
    });
  }
  Future pickImageLatestCreditCard(ImageSource source, String docname) async {
    setState(() => isLoadingLatestCreditCard = true);
    final img = await _pickAndUploadImage(source, docname);
    setState(() {
      isLoadingLatestCreditCard = false;
      if (img != null) latestCreditCard = img;
    });
  }
  Future pickImageLatestSalarySlip(ImageSource source, String docname) async {
    setState(() => isLoadingLatestSalarySlip = true);
    final img = await _pickAndUploadImage(source, docname);
    setState(() {
      isLoadingLatestSalarySlip= false;
      if (img != null) latestSalarySlip = img;
    });
  }
  Future pickImageSalarySlip(ImageSource source, String docname) async {
    setState(() => isLoadingSalarySlip = true);
    final img = await _pickAndUploadImage(source, docname);
    setState(() {
      isLoadingSalarySlip= false;
      if (img != null) salarySlip = img;
    });
  }
  //END CODE CATEGORY=="INCOME PROOF"
  //START CODE CATEGORY=="ADD AND INCOME PROOF"
  bool isLoading3MonthsBankStatement=false;
  bool isLoadingBankPassbook=false;

  File? threeMonthsBankStatement;
  File? bankPassbook;

  Future pickImage3MonthsBankStatement(ImageSource source, String docname) async {
    setState(() => isLoading3MonthsBankStatement = true);
    final img = await _pickAndUploadImage(source, docname);
    setState(() {
      isLoading3MonthsBankStatement = false;
      if (img != null) threeMonthsBankStatement = img;
    });
  }
  Future pickImageBankPassbook(ImageSource source, String docname) async {
    setState(() => isLoadingBankPassbook = true);
    final img = await _pickAndUploadImage(source, docname);
    setState(() {
      isLoadingBankPassbook = false;
      if (img != null) bankPassbook = img;
    });
  }

  //END CODE CATEGORY=="ADD AND INCOME PROOF"
  //START CODE CATEGORY=="ID AND ADD PROOF"
  bool isLoadingDrivingLicenseAddProof=false;
  bool isLoadingNREGACard=false;
  bool isLoadingPassportAddProof=false;

  File? drivingLicenseAddProof;
  File? nREGACard;
  File? passportAddProof;

  Future pickImageDrivingLicenseAddProof(ImageSource source, String docname) async {
    setState(() => isLoadingDrivingLicenseAddProof = true);
    final img = await _pickAndUploadImage(source, docname);
    setState(() {
      isLoadingDrivingLicenseAddProof = false;
      if (img != null) drivingLicenseAddProof = img;
    });
  }
  Future pickImageNREGACard(ImageSource source, String docname) async {
    setState(() => isLoadingNREGACard = true);
    final img = await _pickAndUploadImage(source, docname);
    setState(() {
      isLoadingNREGACard = false;
      if (img != null) nREGACard = img;
    });
  }
  Future pickImagePassportAddProof(ImageSource source, String docname) async {
    setState(() => isLoadingPassportAddProof = true);
    final img = await _pickAndUploadImage(source, docname);
    setState(() {
      isLoadingPassportAddProof = false;
      if (img != null) passportAddProof = img;
    });
  }

  //END CODE CATEGORY=="ID AND ADD PROOF"



  Future<File?> _pickAndUploadImage(
      ImageSource source,
      String docname,
      ) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return null;

      if (!collectedDocs.contains(docname.trim().toLowerCase())) {
        setState(() {
          collectedDocs.add(docname.trim().toLowerCase());
        });
        await _saveOrUpdateDoc(docname);
      }

      File? img = File(image.path);

      // // Wait for cropped image from CustomCropScreen
      File? cropped = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CustomCropScreen(imageFile: img,),
        ),
      );

      if (cropped == null) {
        print("⚠️ Cropping cancelled");
        return null;
      }

      //img = await _cropImage(imageFile: img);

      final url = await convertImageToPdfAndSave(
        cropped!,
        docname,
        widget.clientName,
        widget.leadId,
        uid,
      );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("✅ $url !!"),
          duration: Duration(seconds: 5),
        ),
      );
      return img;
    } catch (e) {
      print("❌ Error: $e");
      return null;
    }
  }
  Future<void> _saveOrUpdateDoc(String docname) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> savedDocs = prefs.getStringList('collectedDocs') ?? [];

    String doc = docname.trim().toLowerCase();

    // Check agar already exist hai
    int index = savedDocs.indexOf(doc);
    if (index == -1) {
      // Agar nahi hai to add karo
      savedDocs.add(doc);
    } else {
      // Agar already hai to usi index pe update kar do
      savedDocs[index] = doc;
    }

    // Save back
    await prefs.setStringList('collectedDocs', savedDocs);

    // Also update UI list
    setState(() {
      collectedDocs = savedDocs;
    });
  }



  Future<File?> _cropImage({required File imageFile}) async{
    CroppedFile? cropImage=await ImageCropper().cropImage(sourcePath: imageFile.path,
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Crop Image',
          toolbarColor: const Color(0xFF0A73FF),
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.ratio7x5,
          lockAspectRatio: false,
          hideBottomControls: true, // 🔹 Allow default bottom controls
          cropFrameStrokeWidth: 2,
          statusBarColor: const Color(0xFF0A73FF),
          backgroundColor: Colors.black, // Better contrast
        ),
        IOSUiSettings(
          title: 'Crop Image',
        ),
      ],
    );
    if(cropImage==null) return null;
    return File(cropImage.path);
  }
  Timer? _timer;
  @override
  void initState() {
    super.initState();
    // हर 1 सेकंड में check करेगा
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      checkInternetSpeed();
    });
    loadUserData();
    futureDocuments = DocumentController.fetchDocument();
    _futureDocumentsList = _documentService.fetchDocuments();
  }
  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
  Future<void> checkInternetSpeed() async {
    final url = Uri.parse("https://www.google.com/generate_204");
    final stopwatch = Stopwatch()..start();

    String? msg;

    try {
      final response = await http.get(url).timeout(const Duration(seconds: 5));
      stopwatch.stop();

      if (response.statusCode == 204 || response.statusCode == 200) {
        final ms = stopwatch.elapsedMilliseconds;

        if (ms >= 500) {
          msg = "🐌 Internet Slow (${ms}ms)";
        } else {
          msg = null; // 🚫 Fast/Average पर कुछ मत दिखाओ
        }
      } else {
        msg = "❌ No Internet / Error";
      }
    } catch (e) {
      msg = "❌ No Internet / Timeout";
    }

    // ✅ सिर्फ Slow/No Internet पर ही दिखाओ
    if (mounted && msg != null) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(msg),
          duration: const Duration(seconds: 1),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: AppConstant.appInsideColor,
        title: Text("Documents Screen",style: const TextStyle(color: AppConstant.appTextColor,),),

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

          return ListView(
            children: groupedDocs.entries.map((entry) {
              final category = entry.key;
              final docs = entry.value;

              // 👉 Check if category should be visible
              final bool categoryHasAccess = docs.any((doc) {
                final clientIds = doc.docClient.split(",").map((id) => id.trim()).toList();
                return clientIds.contains(widget.clientId.toString().trim()) ||
                    clientIds.contains("0");   // ✅ अगर "0" हो तो भी category show होगी
              });

              if (!categoryHasAccess) {
                return const SizedBox.shrink(); // Category ही मत दिखाओ
              }

              return Card(
                margin: const EdgeInsets.all(10),
                child: ExpansionTile(
                  title: Text(
                    category,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  children: docs.map((doc) {
                    final clientIds = doc.docClient.split(",").map((id) => id.trim()).toList();
                    final bool belongsToClient = clientIds.contains(widget.clientId.toString().trim());
                    final bool isPublicDoc = clientIds.contains("0"); // ✅ extra condition
                    if (!belongsToClient && !isPublicDoc) {
                      return const SizedBox.shrink(); // ❌ doc छुपा दो
                    }
                    // ✅ अब यहां आपका UI render होगा
                    return ListTile(
                      title: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                //START CODE CATEGORY=="PHOTO"
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
                                                  child:isLoadingcompanuBoard
                                                      ? const CircularProgressIndicator()
                                                      : companuBoard == null
                                                      ? InkWell(
                                                    onTap: ()async{
                                                     await pickImageCompanyBoard(ImageSource.camera,doc.docName);
                                                     // pickImageCompanyBoard(ImageSource.camera);
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
                                                    child: Image.file(companuBoard!,fit: BoxFit.cover,),
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                top:-2, // Adjust these values to position the icon correctly
                                                right: 2,
                                                child: InkWell( // Consider using InkWell for better tap feedback
                                                  onTap: () async {
                                                    try {
                                                      if (companuBoard != null) {
                                                        await companuBoard!.delete();
                                                        setState(() {
                                                          companuBoard = null;
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
                                                  child:isLoadingfeSelfie
                                                      ? const CircularProgressIndicator(  // 🔹 Loader
                                                  )
                                                      : feSelfie == null
                                                      ? InkWell(
                                                    onTap: () async{
                                                      await pickImageFeSelfie(ImageSource.camera,doc.docName);
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
                                                    child: Image.file(feSelfie!,fit: BoxFit.cover,),
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                top:-2, // Adjust these values to position the icon correctly
                                                right: 2,
                                                child: InkWell( // Consider using InkWell for better tap feedback
                                                  onTap: () async {
                                                    try {
                                                      if (feSelfie != null) {
                                                        await feSelfie!.delete();
                                                        setState(() {
                                                          feSelfie = null;
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
                                                  child:isLoadingbillDesk
                                                      ? const CircularProgressIndicator(  // 🔹 Loader
                                                  )
                                                      :billDesk == null
                                                      ? InkWell(
                                                    onTap: () async{
                                                    await pickImageBillDesk(ImageSource.camera,doc.docName);
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
                                                    child: Image.file(billDesk!,fit: BoxFit.cover,),
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                top:-2, // Adjust these values to position the icon correctly
                                                right: 2,
                                                child: InkWell( // Consider using InkWell for better tap feedback
                                                  onTap: () async {
                                                    try {
                                                      if (billDesk != null) {
                                                        await billDesk!.delete();
                                                        setState(() {
                                                          billDesk = null;
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
                                                  child: isLoadingfESelfieWithPerson
                                                      ? const CircularProgressIndicator()
                                                      : fESelfieWithPerson == null
                                                      ? InkWell(
                                                    onTap: () async {
                                                      //pickImageFESelfieWithPerson(ImageSource.camera, doc.docName);
                                                      await pickImageFESelfieWithPerson1(ImageSource.camera, "FE Selfie With Person Met With Sound Box (Inside Shop)");
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
                                                    child: Image.file(
                                                      fESelfieWithPerson!,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                top:-2, // Adjust these values to position the icon correctly
                                                right: 2,
                                                child: InkWell( // Consider using InkWell for better tap feedback
                                                  onTap: () async {
                                                    try {
                                                      if (fESelfieWithPerson != null) {
                                                        await fESelfieWithPerson!.delete();
                                                        setState(() {
                                                          fESelfieWithPerson = null;
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
                                                  child: isLoadingfrontDoor
                                                      ? const CircularProgressIndicator(  // 🔹 Loader
                                                  )
                                                      :frontDoor == null
                                                      ? InkWell(
                                                    onTap: ()async{
                                                    await pickImageFrontDoor(ImageSource.camera,doc.docName);
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
                                                    child: Image.file(frontDoor!,fit: BoxFit.cover,),
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                top:-2, // Adjust these values to position the icon correctly
                                                right: 2,
                                                child: InkWell( // Consider using InkWell for better tap feedback
                                                  onTap: () async {
                                                    try {
                                                      if (frontDoor != null) {
                                                        await frontDoor!.delete();
                                                        setState(() {
                                                          frontDoor = null;
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
                                                  child:isLoadingimageOfPersonMet
                                                      ? const CircularProgressIndicator(  // 🔹 Loader
                                                  )
                                                      : imageOfPersonMet == null
                                                      ? InkWell(
                                                    onTap: ()async{
                                                     await pickImageImageOfPersonMet(ImageSource.camera,doc.docName);
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
                                                    child: Image.file(imageOfPersonMet!,fit: BoxFit.cover,),
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                top:-2, // Adjust these values to position the icon correctly
                                                right: 2,
                                                child: InkWell( // Consider using InkWell for better tap feedback
                                                  onTap: () async {
                                                    try {
                                                      if (imageOfPersonMet != null) {
                                                        await imageOfPersonMet!.delete();
                                                        setState(() {
                                                          imageOfPersonMet = null;
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
                                                  child:isLoadingbillDeskImageofShop
                                                      ? const CircularProgressIndicator(  // 🔹 Loader
                                                  )
                                                      : billDeskImageofShop == null
                                                      ? InkWell(
                                                    onTap: ()async{
                                                      await pickImageBillDeskImageofShop(ImageSource.camera,doc.docName);
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
                                                    child: Image.file(billDeskImageofShop!,fit: BoxFit.cover,),
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                top:-2, // Adjust these values to position the icon correctly
                                                right: 2,
                                                child: InkWell( // Consider using InkWell for better tap feedback
                                                  onTap: () async {
                                                    try {
                                                      if (billDeskImageofShop != null) {
                                                        await billDeskImageofShop!.delete();
                                                        setState(() {
                                                          billDeskImageofShop = null;
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
                                                  child:isLoadingimageofShopFromOutside
                                                      ? const CircularProgressIndicator(  // 🔹 Loader
                                                  )
                                                      : imageofShopFromOutside == null
                                                      ? InkWell(
                                                    onTap: ()async{
                                                     await pickImageImageofShopFromOutside(ImageSource.camera,doc.docName);
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
                                                    child: Image.file(imageofShopFromOutside!,fit: BoxFit.cover,),
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                top:-2, // Adjust these values to position the icon correctly
                                                right: 2,
                                                child: InkWell( // Consider using InkWell for better tap feedback
                                                  onTap: () async {
                                                    try {
                                                      if (imageofShopFromOutside != null) {
                                                        await imageofShopFromOutside!.delete();
                                                        setState(() {
                                                          imageofShopFromOutside = null;
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
                                                  child:isLoadinglocationSnap
                                                      ? const CircularProgressIndicator(  // 🔹 Loader
                                                  )
                                                      : locationSnap == null
                                                      ? InkWell(
                                                    onTap: () async{
                                                     await pickImageLocationSnap(ImageSource.camera,doc.docName);
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
                                                    child: Image.file(locationSnap!,fit: BoxFit.cover,),
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                top:-2, // Adjust these values to position the icon correctly
                                                right: 2,
                                                child: InkWell( // Consider using InkWell for better tap feedback
                                                  onTap: () async {
                                                    try {
                                                      if (locationSnap!= null) {
                                                        await locationSnap!.delete();
                                                        setState(() {
                                                          locationSnap = null;
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
                                                  child: isLoadingnamePstatic
                                                      ? const CircularProgressIndicator(  // 🔹 Loader
                                                  )
                                                      :namePstatic == null
                                                      ? InkWell(
                                                    onTap: ()async{
                                                     await pickImageNamePstatic(ImageSource.camera,doc.docName);
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
                                                    child: Image.file(namePstatic!,fit: BoxFit.cover,),
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                top:-2, // Adjust these values to position the icon correctly
                                                right: 2,
                                                child: InkWell( // Consider using InkWell for better tap feedback
                                                  onTap: () async {
                                                    try {
                                                      if (namePstatic != null) {
                                                        await namePstatic!.delete();
                                                        setState(() {
                                                          namePstatic = null;
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
                                                  child: isLoadingPhoto
                                                      ? const CircularProgressIndicator(  // 🔹 Loader
                                                  )
                                                      : photo == null
                                                      ? InkWell(
                                                    onTap: () async{
                                                      //pickImagePhoto(ImageSource.camera, doc.docName);
                                                      await pickImagePhoto1(ImageSource.camera, doc.docName);

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
                                                    child: Image.file(
                                                      photo!,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                top:-2, // Adjust these values to position the icon correctly
                                                right: 2,
                                                child: InkWell( // Consider using InkWell for better tap feedback
                                                  onTap: () async {
                                                    try {
                                                      if (photo != null) {
                                                        await photo!.delete();
                                                        setState(() {
                                                          photo = null;
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
                                                  child:isLoadingpremisesInterior
                                                      ? const CircularProgressIndicator(  // 🔹 Loader
                                                  )
                                                      : premisesInterior == null
                                                      ? InkWell(
                                                    onTap: ()async{
                                                    await  pickImagePremisesInterior(ImageSource.camera,doc.docName);
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
                                                    child: Image.file(premisesInterior!,fit: BoxFit.cover,),
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                top:-2, // Adjust these values to position the icon correctly
                                                right: 2,
                                                child: InkWell( // Consider using InkWell for better tap feedback
                                                  onTap: () async {
                                                    try {
                                                      if (premisesInterior != null) {
                                                        await premisesInterior!.delete();
                                                        setState(() {
                                                          premisesInterior = null;
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
                                                  child:isLoadingqRCode
                                                      ? const CircularProgressIndicator(  // 🔹 Loader
                                                  )
                                                      : qRCode == null
                                                      ? InkWell(
                                                    onTap: ()async{
                                                     await pickImageQRCode(ImageSource.camera,doc.docName);
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
                                                    child: Image.file(qRCode!,fit: BoxFit.cover,),
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                top:-2, // Adjust these values to position the icon correctly
                                                right: 2,
                                                child: InkWell( // Consider using InkWell for better tap feedback
                                                  onTap: () async {
                                                    try {
                                                      if (qRCode != null) {
                                                        await qRCode!.delete();
                                                        setState(() {
                                                          qRCode = null;
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
                                                  child:isLoadingstock
                                                      ? const CircularProgressIndicator(  // 🔹 Loader
                                                  )
                                                      : stock == null
                                                      ? InkWell(
                                                    onTap: ()async{
                                                    await pickImageStock(ImageSource.camera,doc.docName);
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
                                                    child: Image.file(stock!,fit: BoxFit.cover,),
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                top:-2, // Adjust these values to position the icon correctly
                                                right: 2,
                                                child: InkWell( // Consider using InkWell for better tap feedback
                                                  onTap: () async {
                                                    try {
                                                      if (stock != null) {
                                                        await stock!.delete();
                                                        setState(() {
                                                          stock = null;
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
                                                  child:isLoadingtentCard
                                                      ? const CircularProgressIndicator(  // 🔹 Loader
                                                  )
                                                      : tentCard == null
                                                      ? InkWell(
                                                    onTap: ()async{
                                                     await pickImageTentCard(ImageSource.camera,doc.docName);
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
                                                    child: Image.file(tentCard!,fit: BoxFit.cover,),
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                top:-2, // Adjust these values to position the icon correctly
                                                right: 2,
                                                child: InkWell( // Consider using InkWell for better tap feedback
                                                  onTap: () async {
                                                    try {
                                                      if (tentCard != null) {
                                                        await tentCard!.delete();
                                                        setState(() {
                                                          tentCard = null;
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
                                                  child:isLoadingpoliticalConnections
                                                      ? const CircularProgressIndicator(  // 🔹 Loader
                                                  )
                                                      : politicalConnections == null
                                                      ? InkWell(
                                                    onTap: ()async{
                                                    await  pickImagePoliticalConnections(ImageSource.camera,doc.docName);
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
                                                    child: Image.file(politicalConnections!,fit: BoxFit.cover,),
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                top:-2, // Adjust these values to position the icon correctly
                                                right: 2,
                                                child: InkWell( // Consider using InkWell for better tap feedback
                                                  onTap: () async {
                                                    try {
                                                      if (politicalConnections != null) {
                                                        await politicalConnections!.delete();
                                                        setState(() {
                                                          politicalConnections= null;
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
                                //END CODE CATEGORY=="PHOTO"

                                //START CODE CATEGORY=="ID PROOF"
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
                                                  child:isLoadingiDProofofPersonMet
                                                      ? const CircularProgressIndicator(  // 🔹 Loader
                                                  )
                                                      : iDProofofPersonMet == null
                                                      ? InkWell(
                                                    onTap: ()async{
                                                      await pickImageIDProofofPersonMet(ImageSource.camera,doc.docName);
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
                                                    child: Image.file(iDProofofPersonMet!,fit: BoxFit.cover,),
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                top:-2, // Adjust these values to position the icon correctly
                                                right: 2,
                                                child: InkWell( // Consider using InkWell for better tap feedback
                                                  onTap: () async {
                                                    try {
                                                      if (iDProofofPersonMet != null) {
                                                        await iDProofofPersonMet!.delete();
                                                        setState(() {
                                                          iDProofofPersonMet = null;
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
                                          doc.docName=="Pancard"?Stack(
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
                                                  child:isLoadingpancard
                                                      ? const CircularProgressIndicator(  // 🔹 Loader
                                                  )
                                                      : pancard == null
                                                      ? InkWell(
                                                    onTap: () async{
                                                    await pickImagePancard(ImageSource.camera,doc.docName);
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
                                                    child: Image.file(pancard!,fit: BoxFit.cover,),
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                top:-2, // Adjust these values to position the icon correctly
                                                right: 2,
                                                child: InkWell( // Consider using InkWell for better tap feedback
                                                  onTap: () async {
                                                    try {
                                                      if (pancard != null) {
                                                        await pancard!.delete();
                                                        setState(() {
                                                          pancard = null;
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
                                //END CODE CATEGORY=="ID PROOF"

                                //START CODE CATEGORY=="OTHERS"
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
                                                  child:isLoadingAnnexure
                                                      ? const CircularProgressIndicator(  // 🔹 Loader
                                                  )
                                                      : annexure == null
                                                      ? InkWell(
                                                    onTap: ()async{
                                                   await pickImageAnnexure(ImageSource.camera,doc.docName);
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
                                                    child: Image.file(annexure!,fit: BoxFit.cover,),
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                top:-2, // Adjust these values to position the icon correctly
                                                right: 2,
                                                child: InkWell( // Consider using InkWell for better tap feedback
                                                  onTap: () async {
                                                    try {
                                                      if (annexure != null) {
                                                        await annexure!.delete();
                                                        setState(() {
                                                          annexure = null;
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
                                    doc.docName=="Others"?Container(
                                      height: MediaQuery.of(context).size.height/10,
                                      width: MediaQuery.of(context).size.width,
                                      color:Colors.white60,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          doc.docName=="Others"?Stack(
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
                                                  child: isLoadingOthers
                                                      ? const CircularProgressIndicator(  // 🔹 Loader
                                                  )
                                                      : others == null
                                                      ? InkWell(
                                                    onTap: () async{
                                                     await pickImageOthers(ImageSource.camera,doc.docName);
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
                                                    child: Image.file(others!,fit: BoxFit.cover,),
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                top:-2, // Adjust these values to position the icon correctly
                                                right: 2,
                                                child: InkWell( // Consider using InkWell for better tap feedback
                                                  onTap: () async {
                                                    try {
                                                      if (others != null) {
                                                        await others!.delete();
                                                        setState(() {
                                                          others = null;
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
                                          doc.docName=="Others"?Flexible(
                                            child: Padding(
                                              padding: const EdgeInsets.all(5.0),
                                              child: Text(doc.docName,
                                                textAlign:TextAlign.left,softWrap:true,overflow:TextOverflow.ellipsis,maxLines:3,style: TextStyle(color: Colors.black,fontSize: 12),),
                                            ),
                                          ):SizedBox(),
                                        ],
                                      ),
                                    ):SizedBox.shrink(),
                                    doc.docName=="1 month Bank Statement"?Container(
                                      height: MediaQuery.of(context).size.height/10,
                                      width: MediaQuery.of(context).size.width,
                                      color:Colors.white60,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          doc.docName=="1 month Bank Statement"?Stack(
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
                                                  child:isLoading1monthBankStatement
                                                      ? const CircularProgressIndicator(  // 🔹 Loader
                                                  )
                                                      :  oneMonthBankStatement == null
                                                      ? InkWell(
                                                    onTap: ()async{
                                                    await  pickImage1monthBankStatement(ImageSource.camera,doc.docName);
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
                                                    child: Image.file(oneMonthBankStatement!,fit: BoxFit.cover,),
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                top:-2, // Adjust these values to position the icon correctly
                                                right: 2,
                                                child: InkWell( // Consider using InkWell for better tap feedback
                                                  onTap: () async {
                                                    try {
                                                      if (oneMonthBankStatement != null) {
                                                        await oneMonthBankStatement!.delete();
                                                        setState(() {
                                                          oneMonthBankStatement = null;
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
                                          doc.docName=="1 month Bank Statement"?Flexible(
                                            child: Padding(
                                              padding: const EdgeInsets.all(5.0),
                                              child: Text(doc.docName,
                                                textAlign:TextAlign.left,softWrap:true,overflow:TextOverflow.ellipsis,maxLines:3,style: TextStyle(color: Colors.black,fontSize: 12),),
                                            ),
                                          ):SizedBox(),
                                        ],
                                      ),
                                    ):SizedBox.shrink(),
                                    doc.docName=="Cancelled Cheque"?Container(
                                      height: MediaQuery.of(context).size.height/10,
                                      width: MediaQuery.of(context).size.width,
                                      color:Colors.white60,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          doc.docName=="Cancelled Cheque"?Stack(
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
                                                  child:isLoadingCancelledCheque
                                                      ? const CircularProgressIndicator(  // 🔹 Loader
                                                  )
                                                      :  cancelledCheque == null
                                                      ? InkWell(
                                                    onTap: ()async{
                                                     await pickImageCancelledCheque(ImageSource.camera,doc.docName);
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
                                                    child: Image.file(cancelledCheque!,fit: BoxFit.cover,),
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                top:-2, // Adjust these values to position the icon correctly
                                                right: 2,
                                                child: InkWell( // Consider using InkWell for better tap feedback
                                                  onTap: () async {
                                                    try {
                                                      if (cancelledCheque != null) {
                                                        await cancelledCheque!.delete();
                                                        setState(() {
                                                          cancelledCheque = null;
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
                                          doc.docName=="Cancelled Cheque"?Flexible(
                                            child: Padding(
                                              padding: const EdgeInsets.all(5.0),
                                              child: Text(doc.docName,
                                                textAlign:TextAlign.left,softWrap:true,overflow:TextOverflow.ellipsis,maxLines:3,style: TextStyle(color: Colors.black,fontSize: 12),),
                                            ),
                                          ):SizedBox(),
                                        ],
                                      ),
                                    ):SizedBox.shrink(),
                                    doc.docName=="Company ID"?Container(
                                      height: MediaQuery.of(context).size.height/10,
                                      width: MediaQuery.of(context).size.width,
                                      color:Colors.white60,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          doc.docName=="Company ID"?Stack(
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
                                                  child:isLoadingCompanyID
                                                      ? const CircularProgressIndicator(  // 🔹 Loader
                                                  )
                                                      :  companyID == null
                                                      ? InkWell(
                                                    onTap: ()async{
                                                     await pickImageCompanyID(ImageSource.camera,doc.docName);
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
                                                    child: Image.file(companyID!,fit: BoxFit.cover,),
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                top:-2, // Adjust these values to position the icon correctly
                                                right: 2,
                                                child: InkWell( // Consider using InkWell for better tap feedback
                                                  onTap: () async {
                                                    try {
                                                      if (companyID != null) {
                                                        await companyID!.delete();
                                                        setState(() {
                                                          companyID = null;
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
                                          doc.docName=="Company ID"?Flexible(
                                            child: Padding(
                                              padding: const EdgeInsets.all(5.0),
                                              child: Text(doc.docName,
                                                textAlign:TextAlign.left,softWrap:true,overflow:TextOverflow.ellipsis,maxLines:3,style: TextStyle(color: Colors.black,fontSize: 12),),
                                            ),
                                          ):SizedBox(),
                                        ],
                                      ),
                                    ):SizedBox.shrink(),
                                    doc.docName=="Completely Filled Job Sheet Image"?Container(
                                      height: MediaQuery.of(context).size.height/10,
                                      width: MediaQuery.of(context).size.width,
                                      color:Colors.white60,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          doc.docName=="Completely Filled Job Sheet Image"?Stack(
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
                                                  child: isLoadingCompletelyFilledJob
                                                      ? const CircularProgressIndicator(  // 🔹 Loader
                                                  )
                                                      : completelyFilledJob == null
                                                      ? InkWell(
                                                    onTap: ()async{
                                                    await pickImageCompletelyFilledJob(ImageSource.camera,doc.docName);
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
                                                    child: Image.file(completelyFilledJob!,fit: BoxFit.cover,),
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                top:-2, // Adjust these values to position the icon correctly
                                                right: 2,
                                                child: InkWell( // Consider using InkWell for better tap feedback
                                                  onTap: () async {
                                                    try {
                                                      if (completelyFilledJob != null) {
                                                        await completelyFilledJob!.delete();
                                                        setState(() {
                                                          completelyFilledJob = null;
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
                                          doc.docName=="Completely Filled Job Sheet Image"?Flexible(
                                            child: Padding(
                                              padding: const EdgeInsets.all(5.0),
                                              child: Text(doc.docName,
                                                textAlign:TextAlign.left,softWrap:true,overflow:TextOverflow.ellipsis,maxLines:3,style: TextStyle(color: Colors.black,fontSize: 12),),
                                            ),
                                          ):SizedBox(),
                                        ],
                                      ),
                                    ):SizedBox.shrink(),
                                    doc.docName=="Due Diligence Form"?Container(
                                      height: MediaQuery.of(context).size.height/10,
                                      width: MediaQuery.of(context).size.width,
                                      color:Colors.white60,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          doc.docName=="Due Diligence Form"?Stack(
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
                                                  child: isLoadingDueDiligenceForm
                                                      ? const CircularProgressIndicator(  // 🔹 Loader
                                                  )
                                                      : dueDiligenceForm == null
                                                      ? InkWell(
                                                    onTap: ()async{
                                                     await  pickImageDueDiligenceForm(ImageSource.camera,doc.docName);
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
                                                    child: Image.file(dueDiligenceForm!,fit: BoxFit.cover,),
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                top:-2, // Adjust these values to position the icon correctly
                                                right: 2,
                                                child: InkWell( // Consider using InkWell for better tap feedback
                                                  onTap: () async {
                                                    try {
                                                      if (dueDiligenceForm != null) {
                                                        await dueDiligenceForm!.delete();
                                                        setState(() {
                                                          dueDiligenceForm = null;
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
                                          doc.docName=="Due Diligence Form"?Flexible(
                                            child: Padding(
                                              padding: const EdgeInsets.all(5.0),
                                              child: Text(doc.docName,
                                                textAlign:TextAlign.left,softWrap:true,overflow:TextOverflow.ellipsis,maxLines:3,style: TextStyle(color: Colors.black,fontSize: 12),),
                                            ),
                                          ):SizedBox(),
                                        ],
                                      ),
                                    ):SizedBox.shrink(),
                                    doc.docName=="Form 26AS"?Container(
                                      height: MediaQuery.of(context).size.height/10,
                                      width: MediaQuery.of(context).size.width,
                                      color:Colors.white60,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          doc.docName=="Form 26AS"?Stack(
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
                                                  child:isLoadingForm26AS
                                                      ? const CircularProgressIndicator(  // 🔹 Loader
                                                  )
                                                      :  form26AS == null
                                                      ? InkWell(
                                                    onTap: ()async{
                                                    await  pickImageForm26AS(ImageSource.camera,doc.docName);
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
                                                    child: Image.file(form26AS!,fit: BoxFit.cover,),
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                top:-2, // Adjust these values to position the icon correctly
                                                right: 2,
                                                child: InkWell( // Consider using InkWell for better tap feedback
                                                  onTap: () async {
                                                    try {
                                                      if (form26AS != null) {
                                                        await form26AS!.delete();
                                                        setState(() {
                                                          form26AS = null;
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
                                          doc.docName=="Form 26AS"?Flexible(
                                            child: Padding(
                                              padding: const EdgeInsets.all(5.0),
                                              child: Text(doc.docName,
                                                textAlign:TextAlign.left,softWrap:true,overflow:TextOverflow.ellipsis,maxLines:3,style: TextStyle(color: Colors.black,fontSize: 12),),
                                            ),
                                          ):SizedBox(),
                                        ],
                                      ),
                                    ):SizedBox.shrink(),
                                    doc.docName=="Form 60"?Container(
                                      height: MediaQuery.of(context).size.height/10,
                                      width: MediaQuery.of(context).size.width,
                                      color:Colors.white60,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          doc.docName=="Form 60"?Stack(
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
                                                  child:isLoadingForm60
                                                      ? const CircularProgressIndicator(  // 🔹 Loader
                                                  )
                                                      :  form60 == null
                                                      ? InkWell(
                                                    onTap: ()async{
                                                     await pickImageForm60(ImageSource.camera,doc.docName);
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
                                                    child: Image.file(form60!,fit: BoxFit.cover,),
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                top:-2, // Adjust these values to position the icon correctly
                                                right: 2,
                                                child: InkWell( // Consider using InkWell for better tap feedback
                                                  onTap: () async {
                                                    try {
                                                      if (form60 != null) {
                                                        await form60!.delete();
                                                        setState(() {
                                                          form60 = null;
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
                                          doc.docName=="Form 60"?Flexible(
                                            child: Padding(
                                              padding: const EdgeInsets.all(5.0),
                                              child: Text(doc.docName,
                                                textAlign:TextAlign.left,softWrap:true,overflow:TextOverflow.ellipsis,maxLines:3,style: TextStyle(color: Colors.black,fontSize: 12),),
                                            ),
                                          ):SizedBox(),
                                        ],
                                      ),
                                    ):SizedBox.shrink(),
                                    doc.docName=="Gazette Certificate"?Container(
                                      height: MediaQuery.of(context).size.height/10,
                                      width: MediaQuery.of(context).size.width,
                                      color:Colors.white60,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          doc.docName=="Gazette Certificate"?Stack(
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
                                                  child:isLoadingGazetteCertificate
                                                      ? const CircularProgressIndicator(  // 🔹 Loader
                                                  )
                                                      :  gazetteCertificate == null
                                                      ? InkWell(
                                                    onTap: ()async{
                                                    await  pickImageGazetteCertificate(ImageSource.camera,doc.docName);
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
                                                    child: Image.file(gazetteCertificate!,fit: BoxFit.cover,),
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                top:-2, // Adjust these values to position the icon correctly
                                                right: 2,
                                                child: InkWell( // Consider using InkWell for better tap feedback
                                                  onTap: () async {
                                                    try {
                                                      if (gazetteCertificate != null) {
                                                        await gazetteCertificate!.delete();
                                                        setState(() {
                                                          gazetteCertificate = null;
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
                                          doc.docName=="Gazette Certificate"?Flexible(
                                            child: Padding(
                                              padding: const EdgeInsets.all(5.0),
                                              child: Text(doc.docName,
                                                textAlign:TextAlign.left,softWrap:true,overflow:TextOverflow.ellipsis,maxLines:3,style: TextStyle(color: Colors.black,fontSize: 12),),
                                            ),
                                          ):SizedBox(),
                                        ],
                                      ),
                                    ):SizedBox.shrink(),
                                    doc.docName=="GST Annex - A"?Container(
                                      height: MediaQuery.of(context).size.height/10,
                                      width: MediaQuery.of(context).size.width,
                                      color:Colors.white60,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          doc.docName=="GST Annex - A"?Stack(
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
                                                  child:isLoadingGSTAnnexA
                                                      ? const CircularProgressIndicator()
                                                      :  gSTAnnexA == null
                                                      ? InkWell(
                                                    onTap: ()async{
                                                     await pickImageGSTAnnexA(ImageSource.camera,doc.docName);
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
                                                    child: Image.file(gSTAnnexA!,fit: BoxFit.cover,),
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                top:-2, // Adjust these values to position the icon correctly
                                                right: 2,
                                                child: InkWell( // Consider using InkWell for better tap feedback
                                                  onTap: () async {
                                                    try {
                                                      if (gSTAnnexA != null) {
                                                        await gSTAnnexA!.delete();
                                                        setState(() {
                                                          gSTAnnexA = null;
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
                                          doc.docName=="GST Annex - A"?Flexible(
                                            child: Padding(
                                              padding: const EdgeInsets.all(5.0),
                                              child: Text(doc.docName,
                                                textAlign:TextAlign.left,softWrap:true,overflow:TextOverflow.ellipsis,maxLines:3,style: TextStyle(color: Colors.black,fontSize: 12),),
                                            ),
                                          ):SizedBox(),
                                        ],
                                      ),
                                    ):SizedBox.shrink(),
                                    doc.docName=="GST Annex - B"?Container(
                                      height: MediaQuery.of(context).size.height/10,
                                      width: MediaQuery.of(context).size.width,
                                      color:Colors.white60,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          doc.docName=="GST Annex - B"?Stack(
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
                                                  child:isLoadingGSTAnnexB
                                                      ? const CircularProgressIndicator()
                                                      :  gSTAnnexB == null
                                                      ? InkWell(
                                                    onTap: () async{
                                                   await  pickImageGSTAnnexB(ImageSource.camera,doc.docName);
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
                                                    child: Image.file(gSTAnnexB!,fit: BoxFit.cover,),
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                top:-2, // Adjust these values to position the icon correctly
                                                right: 2,
                                                child: InkWell( // Consider using InkWell for better tap feedback
                                                  onTap: () async {
                                                    try {
                                                      if (gSTAnnexB != null) {
                                                        await gSTAnnexB!.delete();
                                                        setState(() {
                                                          gSTAnnexB = null;
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
                                          doc.docName=="GST Annex - B"?Flexible(
                                            child: Padding(
                                              padding: const EdgeInsets.all(5.0),
                                              child: Text(doc.docName,
                                                textAlign:TextAlign.left,softWrap:true,overflow:TextOverflow.ellipsis,maxLines:3,style: TextStyle(color: Colors.black,fontSize: 12),),
                                            ),
                                          ):SizedBox(),
                                        ],
                                      ),
                                    ):SizedBox.shrink(),
                                    doc.docName=="Loan Agreement"?Container(
                                      height: MediaQuery.of(context).size.height/10,
                                      width: MediaQuery.of(context).size.width,
                                      color:Colors.white60,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          doc.docName=="Loan Agreement"?Stack(
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
                                                  child:isLoadingLoanAgreement
                                                      ? const CircularProgressIndicator()
                                                      :  loanAgreement == null
                                                      ? InkWell(
                                                    onTap: ()async{
                                                    await pickImageLoanAgreement(ImageSource.camera,doc.docName);
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
                                                    child: Image.file(loanAgreement!,fit: BoxFit.cover,),
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                top:-2, // Adjust these values to position the icon correctly
                                                right: 2,
                                                child: InkWell( // Consider using InkWell for better tap feedback
                                                  onTap: () async {
                                                    try {
                                                      if (loanAgreement != null) {
                                                        await loanAgreement!.delete();
                                                        setState(() {
                                                          loanAgreement = null;
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
                                          doc.docName=="Loan Agreement"?Flexible(
                                            child: Padding(
                                              padding: const EdgeInsets.all(5.0),
                                              child: Text(doc.docName,
                                                textAlign:TextAlign.left,softWrap:true,overflow:TextOverflow.ellipsis,maxLines:3,style: TextStyle(color: Colors.black,fontSize: 12),),
                                            ),
                                          ):SizedBox(),
                                        ],
                                      ),
                                    ):SizedBox.shrink(),
                                    doc.docName=="Marriage Certificate"?Container(
                                      height: MediaQuery.of(context).size.height/10,
                                      width: MediaQuery.of(context).size.width,
                                      color:Colors.white60,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          doc.docName=="Marriage Certificate"?Stack(
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
                                                  child: isLoadingMarriageCertificate
                                                      ? const CircularProgressIndicator()
                                                      : marriageCertificate == null
                                                      ? InkWell(
                                                    onTap: ()async{
                                                    await pickImageMarriageCertificate(ImageSource.camera,doc.docName);
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
                                                    child: Image.file(marriageCertificate!,fit: BoxFit.cover,),
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                top:-2, // Adjust these values to position the icon correctly
                                                right: 2,
                                                child: InkWell( // Consider using InkWell for better tap feedback
                                                  onTap: () async {
                                                    try {
                                                      if (marriageCertificate != null) {
                                                        await marriageCertificate!.delete();
                                                        setState(() {
                                                          marriageCertificate = null;
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
                                          doc.docName=="Marriage Certificate"?Flexible(
                                            child: Padding(
                                              padding: const EdgeInsets.all(5.0),
                                              child: Text(doc.docName,
                                                textAlign:TextAlign.left,softWrap:true,overflow:TextOverflow.ellipsis,maxLines:3,style: TextStyle(color: Colors.black,fontSize: 12),),
                                            ),
                                          ):SizedBox(),
                                        ],
                                      ),
                                    ):SizedBox.shrink(),
                                    doc.docName=="Nach Only"?Container(
                                      height: MediaQuery.of(context).size.height/10,
                                      width: MediaQuery.of(context).size.width,
                                      color:Colors.white60,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          doc.docName=="Nach Only"?Stack(
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
                                                  child:isLoadingNachOnly
                                                      ? const CircularProgressIndicator()
                                                      :  nachOnly == null
                                                      ? InkWell(
                                                    onTap: ()async{
                                                     await pickImageNachOnly(ImageSource.camera,doc.docName);
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
                                                    child: Image.file(nachOnly!,fit: BoxFit.cover,),
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                top:-2, // Adjust these values to position the icon correctly
                                                right: 2,
                                                child: InkWell( // Consider using InkWell for better tap feedback
                                                  onTap: () async {
                                                    try {
                                                      if (nachOnly != null) {
                                                        await nachOnly!.delete();
                                                        setState(() {
                                                          nachOnly = null;
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
                                          doc.docName=="Nach Only"?Flexible(
                                            child: Padding(
                                              padding: const EdgeInsets.all(5.0),
                                              child: Text(doc.docName,
                                                textAlign:TextAlign.left,softWrap:true,overflow:TextOverflow.ellipsis,maxLines:3,style: TextStyle(color: Colors.black,fontSize: 12),),
                                            ),
                                          ):SizedBox(),
                                        ],
                                      ),
                                    ):SizedBox.shrink(),
                                    doc.docName=="OVD Declaration"?Container(
                                      height: MediaQuery.of(context).size.height/10,
                                      width: MediaQuery.of(context).size.width,
                                      color:Colors.white60,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          doc.docName=="OVD Declaration"?Stack(
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
                                                  child:isLoadingOVDDeclaration
                                                      ? const CircularProgressIndicator()
                                                      :  oVDDeclaration == null
                                                      ? InkWell(
                                                    onTap: ()async{
                                                     await pickImageOVDDeclaration(ImageSource.camera,doc.docName);
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
                                                    child: Image.file(oVDDeclaration!,fit: BoxFit.cover,),
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                top:-2, // Adjust these values to position the icon correctly
                                                right: 2,
                                                child: InkWell( // Consider using InkWell for better tap feedback
                                                  onTap: () async {
                                                    try {
                                                      if (oVDDeclaration != null) {
                                                        await oVDDeclaration!.delete();
                                                        setState(() {
                                                          oVDDeclaration = null;
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
                                          doc.docName=="OVD Declaration"?Flexible(
                                            child: Padding(
                                              padding: const EdgeInsets.all(5.0),
                                              child: Text(doc.docName,
                                                textAlign:TextAlign.left,softWrap:true,overflow:TextOverflow.ellipsis,maxLines:3,style: TextStyle(color: Colors.black,fontSize: 12),),
                                            ),
                                          ):SizedBox(),
                                        ],
                                      ),
                                    ):SizedBox.shrink(),
                                    doc.docName=="POD Image"?Container(
                                      height: MediaQuery.of(context).size.height/10,
                                      width: MediaQuery.of(context).size.width,
                                      color:Colors.white60,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          doc.docName=="POD Image"?Stack(
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
                                                  child:isLoadingPODImage
                                                      ? const CircularProgressIndicator()
                                                      :  pODImage == null
                                                      ? InkWell(
                                                    onTap: ()async{
                                                    await pickImagePODImage(ImageSource.camera,doc.docName);
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
                                                    child: Image.file(pODImage!,fit: BoxFit.cover,),
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                top:-2, // Adjust these values to position the icon correctly
                                                right: 2,
                                                child: InkWell( // Consider using InkWell for better tap feedback
                                                  onTap: () async {
                                                    try {
                                                      if (pODImage != null) {
                                                        await pODImage!.delete();
                                                        setState(() {
                                                          pODImage = null;
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
                                          doc.docName=="POD Image"?Flexible(
                                            child: Padding(
                                              padding: const EdgeInsets.all(5.0),
                                              child: Text(doc.docName,
                                                textAlign:TextAlign.left,softWrap:true,overflow:TextOverflow.ellipsis,maxLines:3,style: TextStyle(color: Colors.black,fontSize: 12),),
                                            ),
                                          ):SizedBox(),
                                        ],
                                      ),
                                    ):SizedBox.shrink(),
                                    doc.docName=="Cheques (THREE)"?Container(
                                      height: MediaQuery.of(context).size.height/10,
                                      width: MediaQuery.of(context).size.width,
                                      color:Colors.white60,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          doc.docName=="Cheques (THREE)"?Stack(
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
                                                  child:isLoadingCheques
                                                      ? const CircularProgressIndicator()
                                                      :  cheques == null
                                                      ? InkWell(
                                                    onTap: ()async{
                                                     await pickImageCheques(ImageSource.camera,doc.docName);
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
                                                    child: Image.file(cheques!,fit: BoxFit.cover,),
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                top:-2, // Adjust these values to position the icon correctly
                                                right: 2,
                                                child: InkWell( // Consider using InkWell for better tap feedback
                                                  onTap: () async {
                                                    try {
                                                      if (cheques != null) {
                                                        await cheques!.delete();
                                                        setState(() {
                                                          cheques = null;
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
                                          doc.docName=="Cheques (THREE)"?Flexible(
                                            child: Padding(
                                              padding: const EdgeInsets.all(5.0),
                                              child: Text(doc.docName,
                                                textAlign:TextAlign.left,softWrap:true,overflow:TextOverflow.ellipsis,maxLines:3,style: TextStyle(color: Colors.black,fontSize: 12),),
                                            ),
                                          ):SizedBox(),
                                        ],
                                      ),
                                    ):SizedBox.shrink(),
                                    doc.docName=="Auth Sign Form"?Container(
                                      height: MediaQuery.of(context).size.height/10,
                                      width: MediaQuery.of(context).size.width,
                                      color:Colors.white60,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          doc.docName=="Auth Sign Form"?Stack(
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
                                                  child:isLoadingAuthSignForm
                                                      ? const CircularProgressIndicator()
                                                      :  authSignForm == null
                                                      ? InkWell(
                                                    onTap: ()async{
                                                    await pickImageAuthSignForm(ImageSource.camera,doc.docName);
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
                                                    child: Image.file(authSignForm!,fit: BoxFit.cover,),
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                top:-2, // Adjust these values to position the icon correctly
                                                right: 2,
                                                child: InkWell( // Consider using InkWell for better tap feedback
                                                  onTap: () async {
                                                    try {
                                                      if (authSignForm != null) {
                                                        await authSignForm!.delete();
                                                        setState(() {
                                                          authSignForm = null;
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
                                          doc.docName=="Auth Sign Form"?Flexible(
                                            child: Padding(
                                              padding: const EdgeInsets.all(5.0),
                                              child: Text(doc.docName,
                                                textAlign:TextAlign.left,softWrap:true,overflow:TextOverflow.ellipsis,maxLines:3,style: TextStyle(color: Colors.black,fontSize: 12),),
                                            ),
                                          ):SizedBox(),
                                        ],
                                      ),
                                    ):SizedBox.shrink(),
                                    doc.docName=="Shop & Establishment Certificate"?Container(
                                      height: MediaQuery.of(context).size.height/10,
                                      width: MediaQuery.of(context).size.width,
                                      color:Colors.white60,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          doc.docName=="Shop & Establishment Certificate"?Stack(
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
                                                  child: isLoadingShopEstablishmentCertificate
                                                      ? const CircularProgressIndicator()
                                                      : shopEstablishmentCertificate == null
                                                      ? InkWell(
                                                    onTap: ()async{
                                                     await  pickImageShopEstablishmentCertificate(ImageSource.camera,doc.docName);
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
                                                    child: Image.file(shopEstablishmentCertificate!,fit: BoxFit.cover,),
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                top:-2, // Adjust these values to position the icon correctly
                                                right: 2,
                                                child: InkWell( // Consider using InkWell for better tap feedback
                                                  onTap: () async {
                                                    try {
                                                      if (shopEstablishmentCertificate != null) {
                                                        await shopEstablishmentCertificate!.delete();
                                                        setState(() {
                                                          shopEstablishmentCertificate = null;
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
                                          doc.docName=="Shop & Establishment Certificate"?Flexible(
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
                                //END CODE CATEGORY=="OTHERS"

                                //START CODE CATEGORY=="ADD PROOF"
                                category == "ADD PROOF" ? Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    doc.docName=="Aadhaar Back"?Container(
                                      height: MediaQuery.of(context).size.height/10,
                                      width: MediaQuery.of(context).size.width,
                                      color:Colors.white60,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          doc.docName=="Aadhaar Back"?Stack(
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
                                                  child:isLoadingAadhaarBack
                                                      ? const CircularProgressIndicator(  // 🔹 Loader
                                                  )
                                                      : aadhaarBack == null
                                                      ? InkWell(
                                                    onTap: ()async{
                                                      await pickImageAadhaarBack(ImageSource.camera,doc.docName);
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
                                                    child: Image.file(aadhaarBack!,fit: BoxFit.cover,),
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                top:-2, // Adjust these values to position the icon correctly
                                                right: 2,
                                                child: InkWell( // Consider using InkWell for better tap feedback
                                                  onTap: () async {
                                                    try {
                                                      if (aadhaarBack != null) {
                                                        await aadhaarBack!.delete();
                                                        setState(() {
                                                          aadhaarBack = null;
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
                                          doc.docName=="Aadhaar Back"?Flexible(
                                            child: Padding(
                                              padding: const EdgeInsets.all(5.0),
                                              child: Text(doc.docName,
                                                textAlign:TextAlign.left,softWrap:true,overflow:TextOverflow.ellipsis,maxLines:3,style: TextStyle(color: Colors.black,fontSize: 12),),
                                            ),
                                          ):SizedBox(),
                                        ],
                                      ),
                                    ):SizedBox.shrink(),
                                    doc.docName=="Aadhaar Front"?Container(
                                      height: MediaQuery.of(context).size.height/10,
                                      width: MediaQuery.of(context).size.width,
                                      color:Colors.white60,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          doc.docName=="Aadhaar Front"?Stack(
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
                                                  child:isLoadingAadhaarFront
                                                      ? const CircularProgressIndicator(  // 🔹 Loader
                                                  )
                                                      : aadhaarFront  == null
                                                      ? InkWell(
                                                    onTap: () async{
                                                      await pickImageAadhaarFront(ImageSource.camera,doc.docName) ;
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
                                                    child: Image.file(aadhaarFront !,fit: BoxFit.cover,),
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                top:-2, // Adjust these values to position the icon correctly
                                                right: 2,
                                                child: InkWell( // Consider using InkWell for better tap feedback
                                                  onTap: () async {
                                                    try {
                                                      if (aadhaarFront  != null) {
                                                        await aadhaarFront !.delete();
                                                        setState(() {
                                                          aadhaarFront  = null;
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
                                          doc.docName=="Aadhaar Front"?Flexible(
                                            child: Padding(
                                              padding: const EdgeInsets.all(5.0),
                                              child: Text(doc.docName,
                                                textAlign:TextAlign.left,softWrap:true,overflow:TextOverflow.ellipsis,maxLines:3,style: TextStyle(color: Colors.black,fontSize: 12),),
                                            ),
                                          ):SizedBox(),
                                        ],
                                      ),
                                    ):SizedBox.shrink(),
                                    doc.docName=="Allotment Letter"?Container(
                                      height: MediaQuery.of(context).size.height/10,
                                      width: MediaQuery.of(context).size.width,
                                      color:Colors.white60,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          doc.docName=="Allotment Letter"?Stack(
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
                                                  child:isLoadingAllotmentLetter
                                                      ? const CircularProgressIndicator(  // 🔹 Loader
                                                  )
                                                      : allotmentLetter  == null
                                                      ? InkWell(
                                                    onTap: ()async{
                                                      await pickImageAllotmentLetter(ImageSource.camera,doc.docName) ;
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
                                                    child: Image.file(allotmentLetter!,fit: BoxFit.cover,),
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                top:-2, // Adjust these values to position the icon correctly
                                                right: 2,
                                                child: InkWell( // Consider using InkWell for better tap feedback
                                                  onTap: () async {
                                                    try {
                                                      if (allotmentLetter  != null) {
                                                        await allotmentLetter !.delete();
                                                        setState(() {
                                                          allotmentLetter  = null;
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
                                          doc.docName=="Allotment Letter"?Flexible(
                                            child: Padding(
                                              padding: const EdgeInsets.all(5.0),
                                              child: Text(doc.docName,
                                                textAlign:TextAlign.left,softWrap:true,overflow:TextOverflow.ellipsis,maxLines:3,style: TextStyle(color: Colors.black,fontSize: 12),),
                                            ),
                                          ):SizedBox(),
                                        ],
                                      ),
                                    ):SizedBox.shrink(),
                                    doc.docName=="Driving License ( card Type only)"?Container(
                                      height: MediaQuery.of(context).size.height/10,
                                      width: MediaQuery.of(context).size.width,
                                      color:Colors.white60,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          doc.docName=="Driving License ( card Type only)"?Stack(
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
                                                  child:isLoadingDrivingLicense
                                                      ? const CircularProgressIndicator(  // 🔹 Loader
                                                  )
                                                      : drivingLicense  == null
                                                      ? InkWell(
                                                    onTap: () async{
                                                      await pickImageDrivingLicense(ImageSource.camera,doc.docName) ;
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
                                                    child: Image.file(drivingLicense !,fit: BoxFit.cover,),
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                top:-2, // Adjust these values to position the icon correctly
                                                right: 2,
                                                child: InkWell( // Consider using InkWell for better tap feedback
                                                  onTap: () async {
                                                    try {
                                                      if (drivingLicense  != null) {
                                                        await drivingLicense!.delete();
                                                        setState(() {
                                                          drivingLicense = null;
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
                                          doc.docName=="Driving License ( card Type only)"?Flexible(
                                            child: Padding(
                                              padding: const EdgeInsets.all(5.0),
                                              child: Text(doc.docName,
                                                textAlign:TextAlign.left,softWrap:true,overflow:TextOverflow.ellipsis,maxLines:3,style: TextStyle(color: Colors.black,fontSize: 12),),
                                            ),
                                          ):SizedBox(),
                                        ],
                                      ),
                                    ):SizedBox.shrink(),
                                    doc.docName=="Electricity Bill"?Container(
                                      height: MediaQuery.of(context).size.height/10,
                                      width: MediaQuery.of(context).size.width,
                                      color:Colors.white60,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          doc.docName=="Electricity Bill"?Stack(
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
                                                  child:isLoadingElectricityBill
                                                      ? const CircularProgressIndicator(  // 🔹 Loader
                                                  )
                                                      : electricityBill  == null
                                                      ? InkWell(
                                                    onTap: ()async{
                                                      await pickImageElectricityBill(ImageSource.camera,doc.docName) ;
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
                                                    child: Image.file(electricityBill!,fit: BoxFit.cover,),
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                top:-2, // Adjust these values to position the icon correctly
                                                right: 2,
                                                child: InkWell( // Consider using InkWell for better tap feedback
                                                  onTap: () async {
                                                    try {
                                                      if (electricityBill != null) {
                                                        await electricityBill!.delete();
                                                        setState(() {
                                                          electricityBill = null;
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
                                          doc.docName=="Electricity Bill"?Flexible(
                                            child: Padding(
                                              padding: const EdgeInsets.all(5.0),
                                              child: Text(doc.docName,
                                                textAlign:TextAlign.left,softWrap:true,overflow:TextOverflow.ellipsis,maxLines:3,style: TextStyle(color: Colors.black,fontSize: 12),),
                                            ),
                                          ):SizedBox(),
                                        ],
                                      ),
                                    ):SizedBox.shrink(),
                                    doc.docName=="Gas Bill (Pipe line)"?Container(
                                      height: MediaQuery.of(context).size.height/10,
                                      width: MediaQuery.of(context).size.width,
                                      color:Colors.white60,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          doc.docName=="Gas Bill (Pipe line)"?Stack(
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
                                                  child:isLoadingGasBill
                                                      ? const CircularProgressIndicator(  // 🔹 Loader
                                                  )
                                                      : gasBill  == null
                                                      ? InkWell(
                                                    onTap: () async{
                                                      await pickImageGasBill(ImageSource.camera,doc.docName) ;
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
                                                    child: Image.file(gasBill !,fit: BoxFit.cover,),
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                top:-2, // Adjust these values to position the icon correctly
                                                right: 2,
                                                child: InkWell( // Consider using InkWell for better tap feedback
                                                  onTap: () async {
                                                    try {
                                                      if (gasBill  != null) {
                                                        await gasBill !.delete();
                                                        setState(() {
                                                          gasBill  = null;
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
                                          doc.docName=="Gas Bill (Pipe line)"?Flexible(
                                            child: Padding(
                                              padding: const EdgeInsets.all(5.0),
                                              child: Text(doc.docName,
                                                textAlign:TextAlign.left,softWrap:true,overflow:TextOverflow.ellipsis,maxLines:3,style: TextStyle(color: Colors.black,fontSize: 12),),
                                            ),
                                          ):SizedBox(),
                                        ],
                                      ),
                                    ):SizedBox.shrink(),
                                    doc.docName=="Land Line Bill"?Container(
                                      height: MediaQuery.of(context).size.height/10,
                                      width: MediaQuery.of(context).size.width,
                                      color:Colors.white60,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          doc.docName=="Land Line Bill"?Stack(
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
                                                  child:isLoadingLandLineBill
                                                      ? const CircularProgressIndicator(  // 🔹 Loader
                                                  )
                                                      : landLineBill == null
                                                      ? InkWell(
                                                    onTap: ()async{
                                                      await pickImageLandLineBill(ImageSource.camera,doc.docName);
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
                                                    child: Image.file(landLineBill!,fit: BoxFit.cover,),
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                top:-2, // Adjust these values to position the icon correctly
                                                right: 2,
                                                child: InkWell( // Consider using InkWell for better tap feedback
                                                  onTap: () async {
                                                    try {
                                                      if (landLineBill != null) {
                                                        await landLineBill!.delete();
                                                        setState(() {
                                                          landLineBill = null;
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
                                          doc.docName=="Land Line Bill"?Flexible(
                                            child: Padding(
                                              padding: const EdgeInsets.all(5.0),
                                              child: Text(doc.docName,
                                                textAlign:TextAlign.left,softWrap:true,overflow:TextOverflow.ellipsis,maxLines:3,style: TextStyle(color: Colors.black,fontSize: 12),),
                                            ),
                                          ):SizedBox(),
                                        ],
                                      ),
                                    ):SizedBox.shrink(),
                                    doc.docName=="Maintainance Receipt"?Container(
                                      height: MediaQuery.of(context).size.height/10,
                                      width: MediaQuery.of(context).size.width,
                                      color:Colors.white60,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          doc.docName=="Maintainance Receipt"?Stack(
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
                                                  child:isLoadingMaintainanceReceipt
                                                      ? const CircularProgressIndicator(  // 🔹 Loader
                                                  )
                                                      : maintainanceReceipt == null
                                                      ? InkWell(
                                                    onTap: () async{
                                                      await pickImageMaintainanceReceipt(ImageSource.camera,doc.docName);
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
                                                    child: Image.file(maintainanceReceipt!,fit: BoxFit.cover,),
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                top:-2, // Adjust these values to position the icon correctly
                                                right: 2,
                                                child: InkWell( // Consider using InkWell for better tap feedback
                                                  onTap: () async {
                                                    try {
                                                      if (maintainanceReceipt != null) {
                                                        await maintainanceReceipt!.delete();
                                                        setState(() {
                                                          maintainanceReceipt = null;
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
                                          doc.docName=="Maintainance Receipt"?Flexible(
                                            child: Padding(
                                              padding: const EdgeInsets.all(5.0),
                                              child: Text(doc.docName,
                                                textAlign:TextAlign.left,softWrap:true,overflow:TextOverflow.ellipsis,maxLines:3,style: TextStyle(color: Colors.black,fontSize: 12),),
                                            ),
                                          ):SizedBox(),
                                        ],
                                      ),
                                    ):SizedBox.shrink(),
                                    doc.docName=="Mobile Bill"?Container(
                                      height: MediaQuery.of(context).size.height/10,
                                      width: MediaQuery.of(context).size.width,
                                      color:Colors.white60,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          doc.docName=="Mobile Bill"?Stack(
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
                                                  child:isLoadingMobileBill
                                                      ? const CircularProgressIndicator(  // 🔹 Loader
                                                  )
                                                      : mobileBill == null
                                                      ? InkWell(
                                                    onTap: ()async{
                                                      await pickImageMobileBill(ImageSource.camera,doc.docName);
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
                                                    child: Image.file(mobileBill!,fit: BoxFit.cover,),
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                top:-2, // Adjust these values to position the icon correctly
                                                right: 2,
                                                child: InkWell( // Consider using InkWell for better tap feedback
                                                  onTap: () async {
                                                    try {
                                                      if (mobileBill != null) {
                                                        await mobileBill!.delete();
                                                        setState(() {
                                                          mobileBill = null;
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
                                          doc.docName=="Mobile Bill"?Flexible(
                                            child: Padding(
                                              padding: const EdgeInsets.all(5.0),
                                              child: Text(doc.docName,
                                                textAlign:TextAlign.left,softWrap:true,overflow:TextOverflow.ellipsis,maxLines:3,style: TextStyle(color: Colors.black,fontSize: 12),),
                                            ),
                                          ):SizedBox(),
                                        ],
                                      ),
                                    ):SizedBox.shrink(),
                                    doc.docName=="Municipality Water Bill"?Container(
                                      height: MediaQuery.of(context).size.height/10,
                                      width: MediaQuery.of(context).size.width,
                                      color:Colors.white60,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          doc.docName=="Municipality Water Bill"?Stack(
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
                                                  child:isLoadingMunicipalityWaterBill
                                                      ? const CircularProgressIndicator(  // 🔹 Loader
                                                  )
                                                      : municipalityWaterBill == null
                                                      ? InkWell(
                                                    onTap: () async{
                                                      await pickImageMunicipalityWaterBill(ImageSource.camera,doc.docName);
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
                                                    child: Image.file(municipalityWaterBill!,fit: BoxFit.cover,),
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                top:-2, // Adjust these values to position the icon correctly
                                                right: 2,
                                                child: InkWell( // Consider using InkWell for better tap feedback
                                                  onTap: () async {
                                                    try {
                                                      if (municipalityWaterBill != null) {
                                                        await municipalityWaterBill!.delete();
                                                        setState(() {
                                                          municipalityWaterBill = null;
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
                                          doc.docName=="Municipality Water Bill"?Flexible(
                                            child: Padding(
                                              padding: const EdgeInsets.all(5.0),
                                              child: Text(doc.docName,
                                                textAlign:TextAlign.left,softWrap:true,overflow:TextOverflow.ellipsis,maxLines:3,style: TextStyle(color: Colors.black,fontSize: 12),),
                                            ),
                                          ):SizedBox(),
                                        ],
                                      ),
                                    ):SizedBox.shrink(),
                                    doc.docName=="Passport"?Container(
                                      height: MediaQuery.of(context).size.height/10,
                                      width: MediaQuery.of(context).size.width,
                                      color:Colors.white60,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          doc.docName=="Passport"?Stack(
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
                                                  child:isLoadingPassport
                                                      ? const CircularProgressIndicator(  // 🔹 Loader
                                                  )
                                                      : passport == null
                                                      ? InkWell(
                                                    onTap: ()async{
                                                      await pickImagePassport(ImageSource.camera,doc.docName);
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
                                                    child: Image.file(passport!,fit: BoxFit.cover,),
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                top:-2, // Adjust these values to position the icon correctly
                                                right: 2,
                                                child: InkWell( // Consider using InkWell for better tap feedback
                                                  onTap: () async {
                                                    try {
                                                      if (passport != null) {
                                                        await passport!.delete();
                                                        setState(() {
                                                          passport = null;
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
                                          doc.docName=="Passport"?Flexible(
                                            child: Padding(
                                              padding: const EdgeInsets.all(5.0),
                                              child: Text(doc.docName,
                                                textAlign:TextAlign.left,softWrap:true,overflow:TextOverflow.ellipsis,maxLines:3,style: TextStyle(color: Colors.black,fontSize: 12),),
                                            ),
                                          ):SizedBox(),
                                        ],
                                      ),
                                    ):SizedBox.shrink(),
                                    doc.docName=="Post Office SB Acc Statement"?Container(
                                      height: MediaQuery.of(context).size.height/10,
                                      width: MediaQuery.of(context).size.width,
                                      color:Colors.white60,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          doc.docName=="Post Office SB Acc Statement"?Stack(
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
                                                  child:isLoadingPostOfficeSB
                                                      ? const CircularProgressIndicator(  // 🔹 Loader
                                                  )
                                                      : postOfficeSB == null
                                                      ? InkWell(
                                                    onTap: () async{
                                                      await pickImagePostOfficeSB(ImageSource.camera,doc.docName);
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
                                                    child: Image.file(postOfficeSB!,fit: BoxFit.cover,),
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                top:-2, // Adjust these values to position the icon correctly
                                                right: 2,
                                                child: InkWell( // Consider using InkWell for better tap feedback
                                                  onTap: () async {
                                                    try {
                                                      if (postOfficeSB != null) {
                                                        await postOfficeSB!.delete();
                                                        setState(() {
                                                          postOfficeSB = null;
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
                                          doc.docName=="Post Office SB Acc Statement"?Flexible(
                                            child: Padding(
                                              padding: const EdgeInsets.all(5.0),
                                              child: Text(doc.docName,
                                                textAlign:TextAlign.left,softWrap:true,overflow:TextOverflow.ellipsis,maxLines:3,style: TextStyle(color: Colors.black,fontSize: 12),),
                                            ),
                                          ):SizedBox(),
                                        ],
                                      ),
                                    ):SizedBox.shrink(),
                                    doc.docName=="Registered Rent Agreement + Owners E-Bill"?Container(
                                      height: MediaQuery.of(context).size.height/10,
                                      width: MediaQuery.of(context).size.width,
                                      color:Colors.white60,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          doc.docName=="Registered Rent Agreement + Owners E-Bill"?Stack(
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
                                                  child:isLoadingRegisteredRent
                                                      ? const CircularProgressIndicator(  // 🔹 Loader
                                                  )
                                                      : registeredRent  == null
                                                      ? InkWell(
                                                    onTap: ()async{
                                                      await pickImageRegisteredRent(ImageSource.camera,doc.docName);
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
                                                    child: Image.file(registeredRent!,fit: BoxFit.cover,),
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                top:-2, // Adjust these values to position the icon correctly
                                                right: 2,
                                                child: InkWell( // Consider using InkWell for better tap feedback
                                                  onTap: () async {
                                                    try {
                                                      if (registeredRent != null) {
                                                        await registeredRent!.delete();
                                                        setState(() {
                                                          registeredRent = null;
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
                                          doc.docName=="Registered Rent Agreement + Owners E-Bill"?Flexible(
                                            child: Padding(
                                              padding: const EdgeInsets.all(5.0),
                                              child: Text(doc.docName,
                                                textAlign:TextAlign.left,softWrap:true,overflow:TextOverflow.ellipsis,maxLines:3,style: TextStyle(color: Colors.black,fontSize: 12),),
                                            ),
                                          ):SizedBox(),
                                        ],
                                      ),
                                    ):SizedBox.shrink(),
                                    doc.docName=="Registered Sales Deed"?Container(
                                      height: MediaQuery.of(context).size.height/10,
                                      width: MediaQuery.of(context).size.width,
                                      color:Colors.white60,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          doc.docName=="Registered Sales Deed"?Stack(
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
                                                  child:isLoadingRegisteredSales
                                                      ? const CircularProgressIndicator(  // 🔹 Loader
                                                  )
                                                      : registeredSales == null
                                                      ? InkWell(
                                                    onTap: () async{
                                                      await pickImageRegisteredSales(ImageSource.camera,doc.docName);
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
                                                    child: Image.file(registeredSales!,fit: BoxFit.cover,),
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                top:-2, // Adjust these values to position the icon correctly
                                                right: 2,
                                                child: InkWell( // Consider using InkWell for better tap feedback
                                                  onTap: () async {
                                                    try {
                                                      if (registeredSales != null) {
                                                        await registeredSales!.delete();
                                                        setState(() {
                                                          registeredSales = null;
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
                                          doc.docName=="Registered Sales Deed"?Flexible(
                                            child: Padding(
                                              padding: const EdgeInsets.all(5.0),
                                              child: Text(doc.docName,
                                                textAlign:TextAlign.left,softWrap:true,overflow:TextOverflow.ellipsis,maxLines:3,style: TextStyle(color: Colors.black,fontSize: 12),),
                                            ),
                                          ):SizedBox(),
                                        ],
                                      ),
                                    ):SizedBox.shrink(),
                                    doc.docName=="Rent Agreement"?Container(
                                      height: MediaQuery.of(context).size.height/10,
                                      width: MediaQuery.of(context).size.width,
                                      color:Colors.white60,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          doc.docName=="Rent Agreement"?Stack(
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
                                                  child:isLoadingRentAgreement
                                                      ? const CircularProgressIndicator(  // 🔹 Loader
                                                  )
                                                      : rentAgreement == null
                                                      ? InkWell(
                                                    onTap: ()async{
                                                      await pickImageRentAgreement(ImageSource.camera,doc.docName);
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
                                                    child: Image.file(rentAgreement!,fit: BoxFit.cover,),
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                top:-2, // Adjust these values to position the icon correctly
                                                right: 2,
                                                child: InkWell( // Consider using InkWell for better tap feedback
                                                  onTap: () async {
                                                    try {
                                                      if (rentAgreement != null) {
                                                        await rentAgreement!.delete();
                                                        setState(() {
                                                          rentAgreement = null;
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
                                          doc.docName=="Rent Agreement"?Flexible(
                                            child: Padding(
                                              padding: const EdgeInsets.all(5.0),
                                              child: Text(doc.docName,
                                                textAlign:TextAlign.left,softWrap:true,overflow:TextOverflow.ellipsis,maxLines:3,style: TextStyle(color: Colors.black,fontSize: 12),),
                                            ),
                                          ):SizedBox(),
                                        ],
                                      ),
                                    ):SizedBox.shrink(),
                                    doc.docName=="Voter Card"?Container(
                                      height: MediaQuery.of(context).size.height/10,
                                      width: MediaQuery.of(context).size.width,
                                      color:Colors.white60,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          doc.docName=="Voter Card"?Stack(
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
                                                  child:isLoadingVoterCard
                                                      ? const CircularProgressIndicator(  // 🔹 Loader
                                                  )
                                                      : voterCard  == null
                                                      ? InkWell(
                                                    onTap: () async{
                                                      await pickImageVoterCard(ImageSource.camera,doc.docName);
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
                                                    child: Image.file(voterCard !,fit: BoxFit.cover,),
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                top:-2, // Adjust these values to position the icon correctly
                                                right: 2,
                                                child: InkWell( // Consider using InkWell for better tap feedback
                                                  onTap: () async {
                                                    try {
                                                      if (voterCard  != null) {
                                                        await voterCard!.delete();
                                                        setState(() {
                                                          voterCard = null;
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
                                          doc.docName=="Voter Card"?Flexible(
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
                                //END CODE CATEGORY=="ADD PROOF"

                                //START CODE CATEGORY=="INCOME PROOF"
                                category == "INCOME PROOF" ? Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    doc.docName=="Credit Card Copy"?Container(
                                      height: MediaQuery.of(context).size.height/10,
                                      width: MediaQuery.of(context).size.width,
                                      color:Colors.white60,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          doc.docName=="Credit Card Copy"?Stack(
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
                                                  child:isLoadingCreditCardCopy
                                                      ? const CircularProgressIndicator(  // 🔹 Loader
                                                  )
                                                      : creditCardCopy == null
                                                      ? InkWell(
                                                    onTap: ()async{
                                                      await pickImageCreditCardCopy(ImageSource.camera,doc.docName);
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
                                                    child: Image.file(creditCardCopy!,fit: BoxFit.cover,),
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                top:-2, // Adjust these values to position the icon correctly
                                                right: 2,
                                                child: InkWell( // Consider using InkWell for better tap feedback
                                                  onTap: () async {
                                                    try {
                                                      if (creditCardCopy != null) {
                                                        await creditCardCopy!.delete();
                                                        setState(() {
                                                          creditCardCopy = null;
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
                                          doc.docName=="Credit Card Copy"?Flexible(
                                            child: Padding(
                                              padding: const EdgeInsets.all(5.0),
                                              child: Text(doc.docName,
                                                textAlign:TextAlign.left,softWrap:true,overflow:TextOverflow.ellipsis,maxLines:3,style: TextStyle(color: Colors.black,fontSize: 12),),
                                            ),
                                          ):SizedBox(),
                                        ],
                                      ),
                                    ):SizedBox.shrink(),
                                    doc.docName=="ITR+Computation of Income"?Container(
                                      height: MediaQuery.of(context).size.height/10,
                                      width: MediaQuery.of(context).size.width,
                                      color:Colors.white60,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          doc.docName=="ITR+Computation of Income"?Stack(
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
                                                  child:isLoadingITRComputation
                                                      ? const CircularProgressIndicator(  // 🔹 Loader
                                                  )
                                                      : iTRComputation == null
                                                      ? InkWell(
                                                    onTap: () async{
                                                      await pickImageITRComputation(ImageSource.camera,doc.docName);
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
                                                    child: Image.file(iTRComputation!,fit: BoxFit.cover,),
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                top:-2, // Adjust these values to position the icon correctly
                                                right: 2,
                                                child: InkWell( // Consider using InkWell for better tap feedback
                                                  onTap: () async {
                                                    try {
                                                      if (iTRComputation != null) {
                                                        await iTRComputation!.delete();
                                                        setState(() {
                                                          iTRComputation = null;
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
                                          doc.docName=="ITR+Computation of Income"?Flexible(
                                            child: Padding(
                                              padding: const EdgeInsets.all(5.0),
                                              child: Text(doc.docName,
                                                textAlign:TextAlign.left,softWrap:true,overflow:TextOverflow.ellipsis,maxLines:3,style: TextStyle(color: Colors.black,fontSize: 12),),
                                            ),
                                          ):SizedBox(),
                                        ],
                                      ),
                                    ):SizedBox.shrink(),
                                    doc.docName=="Latest Credit Card Statement"?Container(
                                      height: MediaQuery.of(context).size.height/10,
                                      width: MediaQuery.of(context).size.width,
                                      color:Colors.white60,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          doc.docName=="Latest Credit Card Statement"?Stack(
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
                                                  child:isLoadingLatestCreditCard
                                                      ? const CircularProgressIndicator(  // 🔹 Loader
                                                  )
                                                      : latestCreditCard == null
                                                      ? InkWell(
                                                    onTap: ()async{
                                                      await pickImageLatestCreditCard(ImageSource.camera,doc.docName);
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
                                                    child: Image.file(latestCreditCard!,fit: BoxFit.cover,),
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                top:-2, // Adjust these values to position the icon correctly
                                                right: 2,
                                                child: InkWell( // Consider using InkWell for better tap feedback
                                                  onTap: () async {
                                                    try {
                                                      if (latestCreditCard != null) {
                                                        await latestCreditCard!.delete();
                                                        setState(() {
                                                          latestCreditCard = null;
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
                                          doc.docName=="Latest Credit Card Statement"?Flexible(
                                            child: Padding(
                                              padding: const EdgeInsets.all(5.0),
                                              child: Text(doc.docName,
                                                textAlign:TextAlign.left,softWrap:true,overflow:TextOverflow.ellipsis,maxLines:3,style: TextStyle(color: Colors.black,fontSize: 12),),
                                            ),
                                          ):SizedBox(),
                                        ],
                                      ),
                                    ):SizedBox.shrink(),
                                    doc.docName=="Latest Salary Slip + 3 Months Salary Bank Statement"?Container(
                                      height: MediaQuery.of(context).size.height/10,
                                      width: MediaQuery.of(context).size.width,
                                      color:Colors.white60,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          doc.docName=="Latest Salary Slip + 3 Months Salary Bank Statement"?Stack(
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
                                                  child:isLoadingLatestSalarySlip
                                                      ? const CircularProgressIndicator(  // 🔹 Loader
                                                  )
                                                      : latestSalarySlip == null
                                                      ? InkWell(
                                                    onTap: () async{
                                                      await pickImageLatestSalarySlip(ImageSource.camera,doc.docName);
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
                                                    child: Image.file(latestSalarySlip!,fit: BoxFit.cover,),
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                top:-2, // Adjust these values to position the icon correctly
                                                right: 2,
                                                child: InkWell( // Consider using InkWell for better tap feedback
                                                  onTap: () async {
                                                    try {
                                                      if (latestSalarySlip != null) {
                                                        await latestSalarySlip!.delete();
                                                        setState(() {
                                                          latestSalarySlip = null;
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
                                          doc.docName=="Latest Salary Slip + 3 Months Salary Bank Statement"?Flexible(
                                            child: Padding(
                                              padding: const EdgeInsets.all(5.0),
                                              child: Text(doc.docName,
                                                textAlign:TextAlign.left,softWrap:true,overflow:TextOverflow.ellipsis,maxLines:3,style: TextStyle(color: Colors.black,fontSize: 12),),
                                            ),
                                          ):SizedBox(),
                                        ],
                                      ),
                                    ):SizedBox.shrink(),
                                    doc.docName=="Salary Slip"?Container(
                                      height: MediaQuery.of(context).size.height/10,
                                      width: MediaQuery.of(context).size.width,
                                      color:Colors.white60,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          doc.docName=="Salary Slip"?Stack(
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
                                                  child:isLoadingSalarySlip
                                                      ? const CircularProgressIndicator(  // 🔹 Loader
                                                  )
                                                      : salarySlip == null
                                                      ? InkWell(
                                                    onTap: ()async{
                                                      await pickImageSalarySlip(ImageSource.camera,doc.docName);
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
                                                    child: Image.file(salarySlip!,fit: BoxFit.cover,),
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                top:-2, // Adjust these values to position the icon correctly
                                                right: 2,
                                                child: InkWell( // Consider using InkWell for better tap feedback
                                                  onTap: () async {
                                                    try {
                                                      if (salarySlip != null) {
                                                        await salarySlip!.delete();
                                                        setState(() {
                                                          salarySlip = null;
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
                                          doc.docName=="Salary Slip"?Flexible(
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
                                //END CODE CATEGORY=="INCOME PROOF"

                                //START CODE CATEGORY=="ADD AND INCOME PROOF"
                                category == "ADD AND INCOME PROOF" ? Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    doc.docName=="3 Months Bank Statement"?Container(
                                      height: MediaQuery.of(context).size.height/10,
                                      width: MediaQuery.of(context).size.width,
                                      color:Colors.white60,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          doc.docName=="3 Months Bank Statement"?Stack(
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
                                                  child:isLoading3MonthsBankStatement
                                                      ? const CircularProgressIndicator(  // 🔹 Loader
                                                  )
                                                      : threeMonthsBankStatement == null
                                                      ? InkWell(
                                                    onTap: ()async{
                                                      await pickImage3MonthsBankStatement(ImageSource.camera,doc.docName);
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
                                                    child: Image.file(threeMonthsBankStatement!,fit: BoxFit.cover,),
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                top:-2, // Adjust these values to position the icon correctly
                                                right: 2,
                                                child: InkWell( // Consider using InkWell for better tap feedback
                                                  onTap: () async {
                                                    try {
                                                      if (threeMonthsBankStatement != null) {
                                                        await threeMonthsBankStatement!.delete();
                                                        setState(() {
                                                          threeMonthsBankStatement = null;
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
                                          doc.docName=="3 Months Bank Statement"?Flexible(
                                            child: Padding(
                                              padding: const EdgeInsets.all(5.0),
                                              child: Text(doc.docName,
                                                textAlign:TextAlign.left,softWrap:true,overflow:TextOverflow.ellipsis,maxLines:3,style: TextStyle(color: Colors.black,fontSize: 12),),
                                            ),
                                          ):SizedBox(),
                                        ],
                                      ),
                                    ):SizedBox.shrink(),
                                    doc.docName=="Bank Passbook"?Container(
                                      height: MediaQuery.of(context).size.height/10,
                                      width: MediaQuery.of(context).size.width,
                                      color:Colors.white60,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          doc.docName=="Bank Passbook"?Stack(
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
                                                  child:isLoadingBankPassbook
                                                      ? const CircularProgressIndicator(  // 🔹 Loader
                                                  )
                                                      : bankPassbook == null
                                                      ? InkWell(
                                                    onTap: () async{
                                                      await pickImageBankPassbook(ImageSource.camera,doc.docName);
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
                                                    child: Image.file(bankPassbook!,fit: BoxFit.cover,),
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                top:-2, // Adjust these values to position the icon correctly
                                                right: 2,
                                                child: InkWell( // Consider using InkWell for better tap feedback
                                                  onTap: () async {
                                                    try {
                                                      if (bankPassbook != null) {
                                                        await bankPassbook!.delete();
                                                        setState(() {
                                                          bankPassbook = null;
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
                                          doc.docName=="Bank Passbook"?Flexible(
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
                                //END CODE CATEGORY=="ADD AND INCOME PROOF"

                                //START CODE CATEGORY=="ID AND ADD PROOF"
                                category == "ID AND ADD PROOF" ? Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    doc.docName=="Driving License ( card Type only)"?Container(
                                      height: MediaQuery.of(context).size.height/10,
                                      width: MediaQuery.of(context).size.width,
                                      color:Colors.white60,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          doc.docName=="Driving License ( card Type only)"?Stack(
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
                                                  child:isLoadingDrivingLicenseAddProof
                                                      ? const CircularProgressIndicator(  // 🔹 Loader
                                                  )
                                                      : drivingLicenseAddProof == null
                                                      ? InkWell(
                                                    onTap: ()async{
                                                      await pickImageDrivingLicenseAddProof(ImageSource.camera,doc.docName);
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
                                                    child: Image.file(drivingLicenseAddProof!,fit: BoxFit.cover,),
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                top:-2, // Adjust these values to position the icon correctly
                                                right: 2,
                                                child: InkWell( // Consider using InkWell for better tap feedback
                                                  onTap: () async {
                                                    try {
                                                      if (drivingLicenseAddProof != null) {
                                                        await drivingLicenseAddProof!.delete();
                                                        setState(() {
                                                          drivingLicenseAddProof = null;
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
                                          doc.docName=="Driving License ( card Type only)"?Flexible(
                                            child: Padding(
                                              padding: const EdgeInsets.all(5.0),
                                              child: Text(doc.docName,
                                                textAlign:TextAlign.left,softWrap:true,overflow:TextOverflow.ellipsis,maxLines:3,style: TextStyle(color: Colors.black,fontSize: 12),),
                                            ),
                                          ):SizedBox(),
                                        ],
                                      ),
                                    ):SizedBox.shrink(),
                                    doc.docName=="NREGA Card"?Container(
                                      height: MediaQuery.of(context).size.height/10,
                                      width: MediaQuery.of(context).size.width,
                                      color:Colors.white60,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          doc.docName=="NREGA Card"?Stack(
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
                                                  child:isLoadingNREGACard
                                                      ? const CircularProgressIndicator(  // 🔹 Loader
                                                  )
                                                      : nREGACard == null
                                                      ? InkWell(
                                                    onTap: () async{
                                                      await pickImageNREGACard(ImageSource.camera,doc.docName);
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
                                                    child: Image.file(nREGACard!,fit: BoxFit.cover,),
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                top:-2, // Adjust these values to position the icon correctly
                                                right: 2,
                                                child: InkWell( // Consider using InkWell for better tap feedback
                                                  onTap: () async {
                                                    try {
                                                      if (nREGACard != null) {
                                                        await nREGACard!.delete();
                                                        setState(() {
                                                          nREGACard = null;
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
                                          doc.docName=="NREGA Card"?Flexible(
                                            child: Padding(
                                              padding: const EdgeInsets.all(5.0),
                                              child: Text(doc.docName,
                                                textAlign:TextAlign.left,softWrap:true,overflow:TextOverflow.ellipsis,maxLines:3,style: TextStyle(color: Colors.black,fontSize: 12),),
                                            ),
                                          ):SizedBox(),
                                        ],
                                      ),
                                    ):SizedBox.shrink(),
                                    doc.docName=="Passport"?Container(
                                      height: MediaQuery.of(context).size.height/10,
                                      width: MediaQuery.of(context).size.width,
                                      color:Colors.white60,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          doc.docName=="Passport"?Stack(
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
                                                  child:isLoadingPassportAddProof
                                                      ? const CircularProgressIndicator(  // 🔹 Loader
                                                  )
                                                      : passportAddProof == null
                                                      ? InkWell(
                                                    onTap: () async{
                                                      await pickImagePassportAddProof(ImageSource.camera,doc.docName);
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
                                                    child: Image.file(passportAddProof!,fit: BoxFit.cover,),
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                top:-2, // Adjust these values to position the icon correctly
                                                right: 2,
                                                child: InkWell( // Consider using InkWell for better tap feedback
                                                  onTap: () async {
                                                    try {
                                                      if (passportAddProof != null) {
                                                        await passportAddProof!.delete();
                                                        setState(() {
                                                          passportAddProof = null;
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
                                          doc.docName=="Passport"?Flexible(
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
                                //END CODE CATEGORY=="ID AND ADD PROOF"
                              ],
                            ),
                          ),
                        ],
                      ),

                    );
                  }).toList(),
                ),
              );
            }).toList(),

          );

        },
      ),
      bottomNavigationBar: (collectedDocs == null || collectedDocs.isEmpty)
          ? const SizedBox.shrink()
          : SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SizedBox(
            width: double.infinity, // 👈 full width
            height: 50,             // 👈 fixed height
            child: ElevatedButton(
              onPressed: () async {
               Get.back(result: collectedDocs);

              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppConstant.appBatton1, // 👈 button color
                foregroundColor: AppConstant.appTextColor,  // 👈 text color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12), // 👈 rounded corners
                ),
                elevation: 4, // 👈 shadow
              ),
              child: const Text(
                "Upload Documents",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
          ),
        ),
      ),

    );
  }
}
