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
1,1,"ধর্মক্ষেত্রে কুরুক্ষেত্রে সমবেতা যুযুত্সবঃ।","dharmakṣetre kurukṣetre samavetā yuyutsavaḥ","ধর্মক্ষেত্রে—ধর্মভূমি; কুরুক্ষেত্রে—কুরুক্ষেত্রে; সমবেতাঃ—সমবেত হয়ে; যুযুত্সবঃ—যুদ্ধাভিলাষী","ধৃতরাষ্ট্র বললেন: হে সঞ্জয়, ধর্মক্ষেত্র কুরুক্ষেত্রে যুদ্ধাভিলাষী আমার ও পাণ্ডুর ছেলেরা সমবেত হয়ে কি করলো?","ভগবদ্গীতা পরম প্রামাণিক আস্তিক বিজ্ঞান।"''';

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
        const SnackBar(content: Text('অনুগ্রহ করে শাস্ত্রের নাম ও অধ্যায় লিখুন')),
      );
      return;
    }
    if (_csvController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('অনুগ্রহ করে সিএসভি বা শ্লোক তথ্য লিখুন')),
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
        appBar: AppBar(title: const Text('কাঠামোগত শ্লোক আপলোডার')),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'শাস্ত্রের নাম ও স্কন্ধ/অধ্যায় *',
                  hintText: 'যেমন: শ্রীমদ্ভগবদ্গীতা - প্রথম অধ্যায়',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Text(
                    'সিএসভি শ্লোক তথ্য (হেডার আবশ্যক)',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextButton.icon(
                    icon: const Icon(Icons.refresh, size: 16),
                    label: const Text('নমুনা পুনঃস্থাপন'),
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
                label: const Text('যাচাই করে জমা দিন'),
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
