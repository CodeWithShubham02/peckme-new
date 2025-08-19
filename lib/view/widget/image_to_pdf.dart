import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';

Future<File> jpgToPdf(File imageFile, {String? pdfFileName}) async {
  final pdf = pw.Document();
  final bytes = await imageFile.readAsBytes();
  final image = pw.MemoryImage(bytes);

  pdf.addPage(
    pw.Page(
      pageFormat: PdfPageFormat.a4,
      margin: const pw.EdgeInsets.all(24),
      build: (_) => pw.Center(
        child: pw.Image(image, fit: pw.BoxFit.contain),
      ),
    ),
  );

  // 👇 instead of app-private dir, use public Downloads folder
  Directory? dir;

  if (Platform.isAndroid) {
    dir = Directory('/storage/emulated/0/Download'); // public Downloads
  } else {
    dir = await getApplicationDocumentsDirectory(); // iOS stays sandboxed
  }

  final name = pdfFileName ?? 'image_${DateTime.now().millisecondsSinceEpoch}.pdf';
  final outFile = File('${dir.path}/$name');

  await outFile.writeAsBytes(await pdf.save());
  return outFile;
}
