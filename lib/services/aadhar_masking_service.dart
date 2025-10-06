import 'dart:io';
import 'dart:ui' as ui;
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';

class AadhaarMaskService {
  final ImagePicker _picker = ImagePicker();
  final TextRecognizer _textRecognizer =
  TextRecognizer(script: TextRecognitionScript.latin);

  final RegExp aadhaarRegex = RegExp(
      r'(?:(?:\d{4}\s?\d{4}\s?\d{4})|(?:\d{4}-?\d{4}-?\d{4})|\d{12})');

  Future<File?> pickImage(ImageSource source) async {
    final XFile? xfile = await _picker.pickImage(
        source: source, imageQuality: 80);
    if (xfile == null) return null;
    return File(xfile.path);
  }

  Future<AadhaarMaskResult> processImage(File imageFile) async {
    final inputImage = InputImage.fromFile(imageFile);
    final recognizedText = await _textRecognizer.processImage(inputImage);
    final fullText = recognizedText.text;
    final match = aadhaarRegex.firstMatch(fullText);

    if (match == null) {
      return AadhaarMaskResult(
        maskedAadhaar: "Aadhaar number not found",
        redactRects: [],
        image: await _loadUiImage(imageFile),
      );
    }

    String raw = match.group(0)!.replaceAll(RegExp(r'[\s-]'), '');
    if (raw.length != 12) {
      return AadhaarMaskResult(
        maskedAadhaar: "Invalid Aadhaar detected",
        redactRects: [],
        image: await _loadUiImage(imageFile),
      );
    }

    String last4 = raw.substring(8);
    String masked = '**** **** $last4';

    List<ui.Rect> rects = [];
    for (final block in recognizedText.blocks) {
      for (final line in block.lines) {
        for (final element in line.elements) {
          final elText = element.text.replaceAll(RegExp(r'[\s-]'), '');
          if (RegExp(r'^\d+$').hasMatch(elText)) {
            if (raw.contains(elText) || elText.length >= 3) {
              rects.add(element.boundingBox);
            }
          }
        }
      }
    }

    rects.sort((a, b) => a.left.compareTo(b.left));
    int digitsCovered = 0;
    List<int> keep = [];
    for (int i = rects.length - 1; i >= 0; i--) {
      digitsCovered += 3;
      keep.add(i);
      if (digitsCovered >= 4) break;
    }

    List<ui.Rect> redact = [];
    for (int i = 0; i < rects.length; i++) {
      if (!keep.contains(i)) redact.add(rects[i]);
    }

    final img = await _loadUiImage(imageFile);
    return AadhaarMaskResult(
        maskedAadhaar: masked, redactRects: redact, image: img);
  }

  Future<ui.Image> _loadUiImage(File file) async {
    final bytes = await file.readAsBytes();
    final codec = await ui.instantiateImageCodec(bytes);
    final frame = await codec.getNextFrame();
    return frame.image;
  }

  void dispose() {
    _textRecognizer.close();
  }
}

class AadhaarMaskResult {
  final String maskedAadhaar;
  final List<ui.Rect> redactRects;
  final ui.Image image;

  AadhaarMaskResult({
    required this.maskedAadhaar,
    required this.redactRects,
    required this.image,
  });
}
