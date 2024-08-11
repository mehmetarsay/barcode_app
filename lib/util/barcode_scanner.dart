import 'package:barcode_app/network/api.dart';
import 'package:barcode_scan2/barcode_scan2.dart';

class BarcodeScannerWrapper {
  static const options = ScanOptions(
    strings: {
      'cancel': 'Cancel',
      'flash_on': 'Flass on',
      'flash_off': 'Flash off',
    },
    restrictFormat: [],
  );

  static Future<ScanResult> _scan() async {
    try {
      return await BarcodeScanner.scan(options: options);
    } catch (e) {
      rethrow;
    }
  }

  static Future<int> get _numberOfCameras async {
    try {
      return await BarcodeScanner.numberOfCameras;
    } catch (e) {
      rethrow;
    }
  }

  static Future<String?> customScanFunction() async {
    try {
      if ((await _numberOfCameras) == 0) throw ErrorException('No camera found');
      final result = await _scan();
      if (result.type == ResultType.Cancelled) return null;
      if (result.type == ResultType.Error) throw ErrorException(result.rawContent);
      return result.rawContent;
    } catch (e) {
      rethrow;
    }
  }
}
