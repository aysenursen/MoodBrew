import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class MomentsTimelinePage extends StatelessWidget {
  const MomentsTimelinePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Your Moments'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Center(child: Text('Moments timeline - Coming soon')),
    );
  }
}
