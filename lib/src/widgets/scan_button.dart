import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:provider/provider.dart';
import 'package:qr_scanner/src/providers/scan_list_provider.dart';
import 'package:qr_scanner/src/utils/utils.dart';

class ScanButton extends StatelessWidget {
	const ScanButton({Key? key}) : super(key: key);

	@override
	Widget build(BuildContext context) {
		return FloatingActionButton(
			elevation: 0,
			child: const Icon(Icons.filter_center_focus),
			onPressed: () async {
				String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode( '#3D8BEF', 'Cancel', false, ScanMode.QR);
				//final barcodeScanRes = 'geo:32.62963456308017,-115.42930868839892';

				if ( barcodeScanRes == '-1') return;
				
				final scanListProvider = Provider.of<ScanListProvider>(context, listen: false);
				final newScan = await scanListProvider.newScan(barcodeScanRes);
        		launchURL(context, newScan);
      		},
		);
	}
}