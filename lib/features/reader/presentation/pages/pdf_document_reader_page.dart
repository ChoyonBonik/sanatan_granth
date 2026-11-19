import 'package:flutter/material.dart';
import 'package:pdfrx/pdfrx.dart';
import '../../../../core/theme/app_colors.dart';

class PdfDocumentReaderPage extends StatefulWidget {
  final String documentId;
  final String? fileUrl;

  const PdfDocumentReaderPage({
    super.key,
    required this.documentId,
    this.fileUrl,
  });

  @override
  State<PdfDocumentReaderPage> createState() => _PdfDocumentReaderPageState();
}

class _PdfDocumentReaderPageState extends State<PdfDocumentReaderPage> {
  final PdfViewerController _controller = PdfViewerController();
  int _currentPage = 1;
  int _totalPages = 1;

  @override
  Widget build(BuildContext context) {
    final String url = widget.fileUrl ??
        'https://raw.githubusercontent.com/mozilla/pdf.js/ba2edeae/web/compressed.tracemonkey-pldi-09.pdf';

    return Scaffold(
      appBar: AppBar(
        title: const Text('শাস্ত্রীয় নথি পাঠক'),
        actions: <Widget>[
          Center(
            child: Padding(
              padding: const EdgeInsets.only(right: 16),
              child: Text(
                '$_currentPage / $_totalPages',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.zoom_in),
            onPressed: () => _controller.zoomUp(),
          ),
          IconButton(
            icon: const Icon(Icons.zoom_out),
            onPressed: () => _controller.zoomDown(),
          ),
        ],
      ),
      body: PdfViewer.uri(
        Uri.parse(url),
        controller: _controller,
        params: PdfViewerParams(
          onPageChanged: (int? page) {
            if (page != null) {
              setState(() => _currentPage = page);
            }
          },
          onViewerReady: (PdfDocument doc, PdfViewerController ctrl) {
            setState(() {
              _totalPages = doc.pages.length;
            });
          },
          loadingBannerBuilder: (BuildContext context, int bytes, int? total) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.saffronPrimary),
            );
          },
        ),
      ),
    );
  }
}
