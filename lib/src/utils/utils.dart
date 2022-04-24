
import 'package:flutter/cupertino.dart';
import 'package:qr_scanner/src/models/models.dart';
import 'package:url_launcher/url_launcher.dart';

launchURL( BuildContext context, ScanModel scan ) async {

	if( scan.tipo == 'https') {
		final url = Uri.parse(scan.valor);
		if ( !await launchUrl( url ) ) throw 'Could not launch $url';
	} else {
		Navigator.pushNamed(context, 'map', arguments: scan);
	}
	
}