import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_budget/src/core/assets/colors.dart';
import 'package:my_budget/src/feature/add_entry/widget/add_entry_screen.dart';
import 'package:my_budget/src/feature/history/widget/history_screen.dart';
import 'package:my_budget/src/feature/settings/widget/settings_scope.dart';
import 'package:my_budget/src/feature/settings/widget/settings_screen.dart';

/// {@template sample_page}
/// SamplePage widget
/// {@endtemplate}
class HomeScreen extends StatefulWidget {
  /// {@macro sample_page}
  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  int index = 0;
  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: IndexedStack(
          index: index,
          children: [HistoryScreen(), Container(), SettingsScreen()],
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Theme.of(context).colorScheme.background,
          onTap: (value) {
            if (value == 1) {
              Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) => AddEntryScreen(),
                ),
              ).then((value) {
                setState(() {});
              });
            } else {
              index = value;
              setState(() {});
            }
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.history,
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Container(
                height: 52,
                width: 52,
                decoration: BoxDecoration(
                  color: AppColors.accent,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Icon(
                  Icons.add,
                  color: Theme.of(context).colorScheme.background,
                ),
              ),
              label: '',
            ),
            const BottomNavigationBarItem(
              icon: Icon(
                Icons.settings_outlined,
              ),
              label: '',
            ),
          ],
        ),
      );
}

class _LanguagesSelector extends StatelessWidget {
  const _LanguagesSelector(this._languages);

  final List<Locale> _languages;

  @override
  Widget build(BuildContext context) => SizedBox(
        height: 100,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: _languages.length,
          itemBuilder: (context, index) {
            final language = _languages.elementAt(index);

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: _LanguageCard(language),
            );
          },
        ),
      );
}

class _LanguageCard extends StatelessWidget {
  const _LanguageCard(this._language);

  final Locale _language;

  @override
  Widget build(BuildContext context) => Card(
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            borderRadius: BorderRadius.circular(4),
          ),
          child: InkWell(
            onTap: () => SettingsScope.localeOf(context).setLocale(_language),
            borderRadius: BorderRadius.circular(4),
            child: SizedBox(
              width: 64,
              child: Center(
                child: Text(
                  _language.languageCode,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                ),
              ),
            ),
          ),
        ),
      );
}

class _ThemeSelector extends StatelessWidget {
  const _ThemeSelector(this._colors);

  final List<Color> _colors;

  @override
  Widget build(BuildContext context) => SizedBox(
        height: 100,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: _colors.length,
          itemBuilder: (context, index) {
            final color = _colors.elementAt(index);

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: _ThemeCard(color),
            );
          },
        ),
      );
}

class _ThemeCard extends StatelessWidget {
  const _ThemeCard(this._color);

  final Color _color;

  @override
  Widget build(BuildContext context) => Card(
        child: Material(
          color: _color,
          borderRadius: BorderRadius.circular(4),
          child: InkWell(
            onTap: () {
              SettingsScope.themeOf(context).setThemeSeedColor(_color);
            },
            borderRadius: BorderRadius.circular(4),
            child: const SizedBox.square(dimension: 64),
          ),
        ),
      );
}
