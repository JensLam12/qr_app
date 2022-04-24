import 'package:flutter/material.dart';
import 'package:qr_scanner/src/providers/db_provider.dart';
import '../models/models.dart';

class ScanListProvider extends ChangeNotifier {
	List<ScanModel> scans = [];
	String selectedType = 'https';

	Future<ScanModel> newScan( String value) async {
		final newScan = new ScanModel( valor: value );
		final id = await DBProvider.db.newScan( newScan );
		//Asignar el ID de la base de datos al modelo
		newScan.id = id;

		if( selectedType == newScan.tipo ) {
			scans.add( newScan );
			notifyListeners();
		}

		return newScan;
	}

	loadScans() async {
		final scans = await DBProvider.db.getAllScans();
		this.scans = [...scans!];
		notifyListeners();
	}

	loadScansByType( String type ) async {
		final scans = await DBProvider.db.getScansByType(type);
		this.scans = [...scans!];
		selectedType = type;
		notifyListeners();
	}

	deleteAllScans() async {
		await DBProvider.db.deleteAllScans();
		scans = [];
		notifyListeners();
	}

	deleteScanById( int id ) async {
		await DBProvider.db.deleteScan(id);
		loadScansByType( selectedType );
	}
}