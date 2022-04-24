import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_scanner/src/providers/scan_list_provider.dart';
import 'package:qr_scanner/src/providers/ui_provider.dart';
import 'package:qr_scanner/src/screens/screens.dart';
import 'package:qr_scanner/src/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
	const HomeScreen({Key? key}) : super(key: key);

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(
				title: const Text('History'),
				elevation: 0,
				actions: [
					IconButton(
						onPressed: () { 
							Provider.of<ScanListProvider>( context, listen: false ).deleteAllScans();
						}, 
						icon: const Icon( Icons.delete_forever )
					)
				],
			),
			body: const _HomeScreenBody(),
			bottomNavigationBar: const CustomNavigationBar(),
			floatingActionButton: const ScanButton(),
			floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
		);
	}
}

class _HomeScreenBody extends StatelessWidget {
	const _HomeScreenBody({Key? key}) : super(key: key);

	@override
	Widget build(BuildContext context) {
		final uiProvider = Provider.of<UiProvider>(context);
		//Change to show the indicated screen
		final currentIndex = uiProvider.selectedMenuOption;

		//Use the scan list provider
		final scanListProvider = Provider.of<ScanListProvider>( context, listen: false );

		switch( currentIndex ) {
			case 0:
				scanListProvider.loadScansByType('geo');
				return const HistoryScreen();
			case 1:
				scanListProvider.loadScansByType('https');
				return const DirectionsScreen();
			default:
				scanListProvider.loadScansByType('geo');
				return const HistoryScreen();
		}
	}
}