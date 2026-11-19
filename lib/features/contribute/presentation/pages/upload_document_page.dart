import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../domain/entities/contribution_entity.dart';
import '../bloc/contribute_bloc.dart';
import '../bloc/contribute_event.dart';
import '../bloc/contribute_state.dart';

class UploadDocumentPage extends StatefulWidget {
  const UploadDocumentPage({super.key});

  @override
  State<UploadDocumentPage> createState() => _UploadDocumentPageState();
}

class _UploadDocumentPageState extends State<UploadDocumentPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _authorController = TextEditingController();
  String _selectedCategory = AppConstants.canonicalCategories[1];
  String? _selectedFilePath;
  String? _selectedFileName;
  ContributionType _docType = ContributionType.bookPdf;

  @override
  void dispose() {
    _titleController.dispose();
    _authorController.dispose();
    super.dispose();
  }

  Future<void> _pickFile() async {
    final FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: <String>['pdf', 'epub'],
    );

    if (result != null && result.files.single.path != null) {
      setState(() {
        _selectedFilePath = result.files.single.path;
        _selectedFileName = result.files.single.name;
        _docType = _selectedFileName!.toLowerCase().endsWith('.epub')
            ? ContributionType.bookEpub
            : ContributionType.bookPdf;
      });
    }
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    if (_selectedFilePath == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('অনুগ্রহ করে একটি পিডিএফ বা ইপাব ফাইল নির্বাচন করুন')),
      );
      return;
    }

    context.read<ContributeBloc>().add(
          SubmitDocumentContributionEvent(
            title: _titleController.text.trim(),
            author: _authorController.text.trim(),
            category: _selectedCategory,
            filePath: _selectedFilePath!,
            type: _docType,
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
        appBar: AppBar(title: const Text('শাস্ত্রীয় নথি আপলোড')),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                // Document Picker Container
                InkWell(
                  onTap: _pickFile,
                  borderRadius: BorderRadius.circular(16),
                  child: Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: _selectedFilePath != null
                            ? AppColors.saffronPrimary
                            : Theme.of(context).dividerColor,
                        width: 1.5,
                      ),
                    ),
                    child: Column(
                      children: <Widget>[
                        Icon(
                          _selectedFilePath != null
                              ? Icons.check_circle_rounded
                              : Icons.cloud_upload_outlined,
                          size: 48,
                          color: AppColors.saffronPrimary,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          _selectedFileName ?? 'পিডিএফ বা ইপাব ফাইল নির্বাচন করতে ট্যাপ করুন',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          'সমর্থিত ফরম্যাট: .pdf, .epub (সর্বোচ্চ ৫০ মেগাবাইট)',
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                TextFormField(
                  controller: _titleController,
                  decoration: const InputDecoration(
                    labelText: 'শাস্ত্রের নাম *',
                    hintText: 'যেমন: শ্রীমদ্ভগবদ্গীতা শঙ্করভাষ্য',
                    border: OutlineInputBorder(),
                  ),
                  validator: (String? val) =>
                      val == null || val.isEmpty ? 'শাস্ত্রের নাম আবশ্যক' : null,
                ),
                const SizedBox(height: 16),

                TextFormField(
                  controller: _authorController,
                  decoration: const InputDecoration(
                    labelText: 'রচয়িতা / ভাষ্যকার / অনুবাদক *',
                    hintText: 'যেমন: আদি শঙ্করাচার্য',
                    border: OutlineInputBorder(),
                  ),
                  validator: (String? val) =>
                      val == null || val.isEmpty ? 'রচয়িতা বা ভাষ্যকারের নাম আবশ্যক' : null,
                ),
                const SizedBox(height: 16),

                DropdownButtonFormField<String>(
                  value: _selectedCategory,
                  decoration: const InputDecoration(
                    labelText: 'শাস্ত্রীয় বিভাগ',
                    border: OutlineInputBorder(),
                  ),
                  items: AppConstants.canonicalCategories
                      .where((String c) => c != AppConstants.canonicalCategories[0])
                      .map((String cat) => DropdownMenuItem<String>(
                            value: cat,
                            child: Text(cat),
                          ))
                      .toList(),
                  onChanged: (String? val) {
                    if (val != null) setState(() => _selectedCategory = val);
                  },
                ),
                const SizedBox(height: 32),

                ElevatedButton(
                  onPressed: _submit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.saffronPrimary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: const Text(
                    'পর্যালোচনার জন্য জমা দিন',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
