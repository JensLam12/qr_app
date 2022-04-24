import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:qr_scanner/src/models/scan_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBProvider {
	static Database? _database;
	static final DBProvider db = DBProvider._();

	DBProvider._();

	Future<Database> get database async {
		if( _database != null) return _database!;
		
		_database = await initDB();
		return _database!;
	}

	Future<Database> initDB() async {
		// Path de donde almacenaremos la base de datos
		Directory documentsDirectory = await getApplicationDocumentsDirectory();
		final path = join(documentsDirectory.path, 'ScansDB.db');
		print(path);

		//Crear base de datos
		return await openDatabase(
			path,
			version: 1,
			onOpen: ( db ) {},
			onCreate: ( Database db, int version ) async {
				await db.execute('''
					CREATE TABLE Scans(
						id INTEGER PRIMARY KEY,
						tipo TEXT,
						valor TEXT
					)
				''');
			}
		);
	}

	Future<int> newScan( ScanModel newScan ) async {
		final db = await database;
		final res = await db.insert( 'Scans', newScan.toMap() );

		return res;
	}

	Future<ScanModel?> getScanById(int id ) async {
		final db = await database;
		final res = await db.query('Scans', where: 'id=?', whereArgs: [id]);

		return res.isNotEmpty ? ScanModel.fromMap(res.first) : null;
	}

	Future<List<ScanModel>?> getAllScans() async {
		final db = await database;
		final res = await db.query('Scans');

		return res.isNotEmpty ? res.map(( scan ) => ScanModel.fromMap(scan)).toList() : [];
	}

	Future<List<ScanModel>?> getScansByType( String tipo ) async {
		final db = await database;
		final res = await db.rawQuery('''
			SELECT 
				* 
			FROM Scans
			WHERE Tipo = '$tipo'
		''');

		return res.isNotEmpty ? res.map(( scan ) => ScanModel.fromMap(scan)).toList() : [];
	}

	Future<int> updateScan( ScanModel scan ) async {
		final db = await database;
		final res = await db.update('Scans', scan.toMap(), where: 'id = ?', whereArgs: [scan.id]);
		return res;
	}

	Future<int> deleteScan( int id ) async {
		final db = await database;
		final res = await db.delete('Scans', where: 'id = ?', whereArgs: [id]);
		return res;
	}

	Future<int> deleteAllScans() async {
		final db = await database;
		final res = await db.delete('Scans');
		return res;
	}
}