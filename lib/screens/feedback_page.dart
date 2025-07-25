import 'package:flutter/material.dart';
import '../services/firebase_service.dart';
import '../widgets/modern_button.dart';
import '../widgets/modern_text_field.dart';
import '../widgets/modern_error.dart';
import '../widgets/modern_scaffold.dart';
import '../constants/app_constants.dart';

class FeedbackPage extends StatefulWidget {
  const FeedbackPage({super.key});

  @override
  State<FeedbackPage> createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  int _rating = 5;
  final _commentController = TextEditingController();
  bool _loading = false;
  String? _error;
  bool _submitted = false;

  Future<void> _submit() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final user = FirebaseService().getCurrentUser();
      if (user == null) throw Exception('Not authenticated.');
      // TODO: Pass correct packId after pickup
      await FirebaseService().addFeedback(
        userId: user.uid,
        packId: 'demo-pack-id',
        rating: _rating,
        comment: _commentController.text.trim(),
      );
      setState(() => _submitted = true);
    } catch (e) {
      setState(() => _error = e.toString());
    } finally {
      setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;
    return ModernScaffold(
      centerContent: true,
      child: Center(
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 400),
            child: Container(
              padding: EdgeInsets.symmetric(
                vertical: isMobile ? 32 : 48,
                horizontal: isMobile ? 16 : 32,
              ),
              decoration: BoxDecoration(
                gradient: AppGradients.glass,
                borderRadius: BorderRadius.circular(32),
                boxShadow: AppShadows.glass,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 8),
                  Text('Feedback', style: AppTextStyles.headline.copyWith(fontSize: 32, color: AppColors.primary), textAlign: TextAlign.center),
                  const SizedBox(height: 32),
                  Text('Share your experience and help us improve.', style: AppTextStyles.body.copyWith(fontSize: 18, color: AppColors.textLight), textAlign: TextAlign.center),
                  const SizedBox(height: 32),
                  ModernTextField(
                    label: 'Your Feedback',
                    controller: _commentController,
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(5, (i) => IconButton(
                      icon: Icon(
                        i < _rating ? Icons.star : Icons.star_border,
                        color: AppColors.accent,
                        size: 32,
                      ),
                      onPressed: () => setState(() => _rating = i + 1),
                    )),
                  ),
                  if (_error != null) ...[
                    const SizedBox(height: 12),
                    ModernError(message: _error!),
                  ],
                  const SizedBox(height: 24),
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 350),
                    child: ModernButton(
                      key: ValueKey(_loading),
                      text: _loading ? 'Submitting...' : 'Submit Feedback',
                      onPressed: _loading ? null : _submit,
                      isPrimary: true,
                    ),
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
} 