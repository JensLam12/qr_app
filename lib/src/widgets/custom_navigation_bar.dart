import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/ui_provider.dart';

class CustomNavigationBar extends StatelessWidget {
	const CustomNavigationBar({Key? key}) : super(key: key);

	@override
	Widget build(BuildContext context) {

		final uiProvider = Provider.of<UiProvider>(context);
		final currentIndex = uiProvider.selectedMenuOption;

		return BottomNavigationBar(
			onTap: ( int index ) {
				uiProvider.setSelectedMenuOption = index;
			},
			currentIndex: currentIndex,
			elevation: 0,
			items: const [
				BottomNavigationBarItem(
					icon: Icon( Icons.map),
					label: 'Map'
				),
				BottomNavigationBarItem(
					icon: Icon( Icons.compass_calibration),
					label: 'Directions'
				),
			],
		);
	}
}