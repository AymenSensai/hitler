import 'package:barcode_scan2/barcode_scan2.dart';

Future<String?> scanSKU() async {
  try {
    var result = await BarcodeScanner.scan();
    return result.rawContent.isNotEmpty ? result.rawContent : null;
  } catch (e) {
    return null;
  }
}
