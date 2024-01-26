import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_budget/src/feature/onboading/widget/page_1.dart';
import 'package:my_budget/src/feature/onboading/widget/page_2.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController controller = PageController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: AppBar(
          title: Text(
            'My Budget',
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(fontSize: 20, fontWeight: FontWeight.w700),
          ),
          elevation: 0,
          backgroundColor: Theme.of(context).colorScheme.background,
          centerTitle: true,
        ),
        body: PageView(
          controller: controller,
          children: [
            OnboardingPage1(
              controller: controller,
            ),
            OnboaringPage2()
          ],
        ),
      );
}
