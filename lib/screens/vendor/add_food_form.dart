import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../../services/firebase_service.dart';
import '../../widgets/modern_text_field.dart';
import '../../widgets/modern_button.dart';
import '../../widgets/modern_dropdown.dart';
import '../../widgets/modern_error.dart';
import '../../widgets/modern_scaffold.dart';
import '../../constants/app_constants.dart';

class AddFoodForm extends StatefulWidget {
  const AddFoodForm({super.key});

  @override
  State<AddFoodForm> createState() => _AddFoodFormState();
}

class _AddFoodFormState extends State<AddFoodForm> {
  final _titleController = TextEditingController();
  final _priceController = TextEditingController();
  final _expiryController = TextEditingController();
  int _hygieneRating = 5;
  File? _imageFile;
  bool _loading = false;
  String? _error;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery, imageQuality: 80);
    if (picked != null) {
      setState(() => _imageFile = File(picked.path));
    }
  }

  Future<String?> _uploadImage(File file) async {
    // TODO: Implement Firebase Storage upload and return URL
    return null;
  }

  Future<void> _submit() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final user = FirebaseService().getCurrentUser();
      if (user == null) throw Exception('Not authenticated.');
      String? imageUrl;
      if (_imageFile != null) {
        imageUrl = await _uploadImage(_imageFile!);
      }
      await FirebaseService().addFoodPack({
        'title': _titleController.text.trim(),
        'price': _priceController.text.trim(),
        'expiryTime': _expiryController.text.trim(),
        'hygieneRating': _hygieneRating,
        'imageUrl': imageUrl ?? '',
        'vendorId': user.uid,
        'reserved': false,
      });
      if (mounted) context.go('/dashboard/vendor');
    } catch (e) {
      setState(() => _error = e.toString());
    } finally {
      setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ModernScaffold(
      centerContent: true,
      child: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 400),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 48),
              Text('Add Food Pack', style: Theme.of(context).textTheme.headlineLarge, textAlign: TextAlign.center),
              const SizedBox(height: 32),
              GestureDetector(
                onTap: _loading ? null : _pickImage,
                child: Container(
                  height: 160,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(28),
                    color: Colors.white.withOpacity(0.5),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: _imageFile != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(28),
                          child: Image.file(_imageFile!, fit: BoxFit.cover, width: double.infinity, height: 160),
                        )
                      : Center(
                          child: Text('Tap to pick image', style: Theme.of(context).textTheme.bodyLarge),
                        ),
                ),
              ),
              const SizedBox(height: 24),
              ModernTextField(
                label: 'Title',
                controller: _titleController,
              ),
              ModernTextField(
                label: 'Price',
                controller: _priceController,
                keyboardType: TextInputType.number,
              ),
              ModernTextField(
                label: 'Expiry Time (e.g. 2 days)',
                controller: _expiryController,
              ),
              ModernDropdown<int>(
                label: 'Hygiene Rating',
                value: _hygieneRating,
                items: List.generate(5, (i) => DropdownMenuItem(value: 5 - i, child: Text('${5 - i} ★'))),
                onChanged: (val) {
                  if (!_loading) setState(() => _hygieneRating = val ?? 5);
                },
              ),
              if (_error != null) ModernError(message: _error!),
              const SizedBox(height: 24),
              ModernButton(
                text: _loading ? 'Adding...' : 'Add Food Pack',
                onPressed: _loading ? null : _submit,
              ),
              const SizedBox(height: 48),
            ],
          ),
        ),
      ),
    );
  }
} 