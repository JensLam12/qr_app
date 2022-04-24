import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_scanner/src/utils/utils.dart';
import '../providers/providers.dart';

class ScanTiles extends StatelessWidget {
	final String type;
	const ScanTiles({Key? key, required this.type}) : super(key: key);

	@override
	Widget build(BuildContext context) {
		final scanListProvider = Provider.of<ScanListProvider>(context, listen: true);
		final scans = scanListProvider.scans;

		return ListView.builder(
			itemCount: scans.length,
			itemBuilder: ( _, index) => Dismissible(
				key: UniqueKey(),
				background: Container(
					color: Colors.red,
				),
				onDismissed: ( DismissDirection direction) {
					Provider.of<ScanListProvider>(context, listen: false).deleteScanById( scans[index].id! );
				},
				child: ListTile(
					leading: Icon( 
						type == 'https' 
						? Icons.home
						: Icons.map, 
						color: Theme.of(context).primaryColor
					),
					title: Text( scans[index].valor ),
					subtitle: Text( scans[index].id.toString() ),
					trailing: const Icon( Icons.keyboard_arrow_right, color: Colors.grey),
					onTap: () => launchURL(context, scans[index]),
				),
			)
		);
	}
}