import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_budget/src/feature/home/widget/home_screen.dart';

class OnboaringPage2 extends StatelessWidget {
  const OnboaringPage2({super.key});

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Image.asset('assets/images/Onboarding_2.png'),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 8,
                width: 8,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(''),
              ),
              const SizedBox(width: 8),
              Container(
                height: 8,
                width: 16,
                decoration: BoxDecoration(
                  color: const Color(0xFFDE6969),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(''),
              ),
            ],
          ),
          const SizedBox(height: 32),
          Text(
            'Check your wallet',
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(height: 32),
          Text(
            'In our app you can track your\nspendings and incomes',
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
              Navigator.pushAndRemoveUntil(
                  context,
                  // ignore: inference_failure_on_instance_creation
                  CupertinoPageRoute(
                    builder: (context) => HomeScreen(),
                  ),
                  (route) => false);
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
