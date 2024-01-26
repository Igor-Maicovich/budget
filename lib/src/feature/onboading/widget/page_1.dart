import 'package:flutter/material.dart';

class OnboardingPage1 extends StatelessWidget {
  final PageController controller;
  const OnboardingPage1({super.key, required this.controller});

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Image.asset('assets/images/Onboarding_1.png'),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 8,
                width: 16,
                decoration: BoxDecoration(
                  color: const Color(0xFFDE6969),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(''),
              ),
              const SizedBox(width: 8),
              Container(
                height: 8,
                width: 8,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(''),
              ),
            ],
          ),
          const SizedBox(height: 32),
          Text(
            'Save money',
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(height: 32),
          Text(
            'Control you money ib one\nplace',
            style: Theme.of(context).textTheme.caption!.copyWith(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 50),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 40)),
            onPressed: () {
              controller.nextPage(
                duration: const Duration(milliseconds: 500),
                curve: Curves.linear,
              );
            },
            child: const Text(
              "Continue",
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
          const SizedBox(height: 100),
        ],
      );
}
