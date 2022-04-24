import 'dart:async';
import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:qr_scanner/src/models/models.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
	const MapScreen({Key? key}) : super(key: key);

	@override
	State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {

	Completer<GoogleMapController> _controller = Completer();
	MapType mapType = MapType.normal;
	
	@override
	Widget build(BuildContext context) {

		final ScanModel scan = ModalRoute.of(context)!.settings.arguments as ScanModel;

		final CameraPosition initialPoint = CameraPosition(
			target: scan.getLatLng(),
			zoom: 18,
			tilt: 50
		);

		//Markers
		Set<Marker> markers = new Set<Marker>() ;
		markers.add( Marker(
			markerId: const MarkerId('geo-location'),
			position: scan.getLatLng()
		));

		return Scaffold(
			appBar: AppBar(
				title: const Text('Map'),
				actions: [
					IconButton(
						onPressed: () async {
							final GoogleMapController controller = await _controller.future;
    						controller.animateCamera(
								CameraUpdate.newCameraPosition(
									CameraPosition(
										target: scan.getLatLng(),
										zoom: 18,
										tilt: 50
									)
								)
							);
						}, 
						icon: const Icon( Icons.location_disabled)
					)
				],
			),
			body: GoogleMap(
				mapType: mapType,
				markers: markers,
				initialCameraPosition: initialPoint,
				onMapCreated: (GoogleMapController controller) {
					_controller.complete(controller);
				},
			),
			floatingActionButton: FloatingActionButton(
				
				child: const Icon( Icons.layers),
				onPressed: () {
					if( mapType == MapType.normal) {
						mapType = MapType.hybrid;
					} else {
						mapType = MapType.normal;
					}
					setState(() {});
				},
			),
			floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
		);
	}
}