import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../view_model/scan_view_model.dart';
import 'barcode_scanner_page.dart';

class ScanPage extends StatelessWidget {
  const ScanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ScanViewModel(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('סריקת מזון'),
        ),
        body: Consumer<ScanViewModel>(
          builder: (context, viewModel, child) {
            if (viewModel.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (viewModel.scannedProduct != null) {
              final product = viewModel.scannedProduct!;
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('שם: ${product.name}'),
                    Text('ברקוד: ${product.barcode}'),
                    Text('קלוריות: ${product.calories}'),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: viewModel.clearScan,
                      child: const Text('סריקה חדשה'),
                    )
                  ],
                ),
              );
            }

            return Center(
              child: ElevatedButton(
                onPressed: () async {
                  final barcode = await Navigator.push<String>(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const BarcodeScannerPage(),
                    ),
                  );

                  if (barcode != null) {
                    viewModel.scanBarcode(barcode);
                  }
                },
                child: const Text('סרוק ברקוד'),
              )
            );
          },
        ),
      ),
    );
  }
}