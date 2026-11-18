import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/app_colors.dart';
import '../bloc/contribute_bloc.dart';
import '../bloc/contribute_event.dart';
import '../bloc/contribute_state.dart';

class UploadCsvVersesPage extends StatefulWidget {
  const UploadCsvVersesPage({super.key});

  @override
  State<UploadCsvVersesPage> createState() => _UploadCsvVersesPageState();
}

class _UploadCsvVersesPageState extends State<UploadCsvVersesPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _csvController = TextEditingController();

  static const String _templateCsv = '''chapter,verse,sanskrit_text,transliteration,synonyms,translation,purport
1,1,"धर्मक्षेत्रे कुरुक्षेत्रे समवेता युयुत्सवः।","dharma-kṣetre kuru-kṣetre samavetā yuyutsavaḥ","dharma-kṣetre—in the place of pilgrimage; kuru-kṣetre—in the place named Kurukṣetra","Dhritarashtra said: O Sanjaya, after my sons and the sons of Pandu assembled in the place of pilgrimage at Kurukshetra...","Bhagavad-gita is the widely read theistic science summarized in the Gita-mahatmya."''';

  @override
  void initState() {
    super.initState();
    _csvController.text = _templateCsv;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _csvController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_titleController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter scripture title')),
      );
      return;
    }
    if (_csvController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter CSV or JSON verses')),
      );
      return;
    }

    context.read<ContributeBloc>().add(
          SubmitCsvContributionEvent(
            scriptureTitle: _titleController.text.trim(),
            csvContent: _csvController.text.trim(),
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ContributeBloc, ContributeState>(
      listener: (BuildContext context, ContributeState state) {
        if (state.status == ContributeStatus.success && state.message != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message!)),
          );
          Navigator.pop(context);
        }
      },
      child: Scaffold(
        appBar: AppBar(title: const Text('Structured Verse CSV Uploader')),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Scripture Name & Canto/Chapter *',
                  hintText: 'e.g. Srimad Bhagavatam - Canto 1 Chapter 1',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Text(
                    'CSV Data (Header required)',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextButton.icon(
                    icon: const Icon(Icons.refresh, size: 16),
                    label: const Text('Reset Template'),
                    onPressed: () => _csvController.text = _templateCsv,
                  ),
                ],
              ),
              const SizedBox(height: 8),

              TextField(
                controller: _csvController,
                maxLines: 12,
                style: const TextStyle(fontFamily: 'monospace', fontSize: 12),
                decoration: InputDecoration(
                  hintText: 'chapter,verse,sanskrit_text,transliteration,synonyms,translation,purport...',
                  border: const OutlineInputBorder(),
                  filled: true,
                  fillColor: Theme.of(context).cardColor,
                ),
              ),
              const SizedBox(height: 24),

              ElevatedButton.icon(
                icon: const Icon(Icons.cloud_upload_rounded),
                label: const Text('Validate & Submit CSV'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.saffronPrimary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                onPressed: _submit,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
