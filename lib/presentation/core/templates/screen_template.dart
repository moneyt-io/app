import 'package:flutter/material.dart';
import '../atoms/app_button.dart';

class ScreenTemplate extends StatelessWidget {
  final String title;
  final List<Widget> children;
  final Widget? floatingActionButton;
  final List<Widget>? actions;
  final bool showBackButton;
  final Widget? bottomNavigationBar;
  final bool centerTitle;

  const ScreenTemplate({
    Key? key,
    required this.title,
    required this.children,
    this.floatingActionButton,
    this.actions,
    this.showBackButton = true,
    this.bottomNavigationBar,
    this.centerTitle = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        centerTitle: centerTitle,
        actions: actions,
        automaticallyImplyLeading: showBackButton,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: children,
          ),
        ),
      ),
      floatingActionButton: floatingActionButton,
      bottomNavigationBar: bottomNavigationBar,
    );
  }

  factory ScreenTemplate.withForm({
    required String title,
    required List<Widget> formFields,
    required String submitLabel,
    required VoidCallback onSubmit,
    bool isLoading = false,
    VoidCallback? onCancel,
  }) {
    return ScreenTemplate(
      title: title,
      children: [
        ...formFields,
        const SizedBox(height: 24),
        AppButton(
          text: submitLabel,
          onPressed: isLoading ? null : onSubmit,
          isFullWidth: true,
          type: AppButtonType.primary,
        ),
        if (onCancel != null) ...[
          const SizedBox(height: 16),
          AppButton(
            text: 'Cancelar',
            onPressed: isLoading ? null : onCancel,
            isFullWidth: true,
            type: AppButtonType.text,
          ),
        ],
      ],
    );
  }
}
