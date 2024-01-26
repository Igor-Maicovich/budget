import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_budget/src/core/assets/icons.dart';
import 'package:my_budget/src/feature/app/model/app_theme.dart';
import 'package:my_budget/src/feature/initialization/widget/dependencies_scope.dart';
import 'package:my_budget/src/feature/settings/bloc/settings_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var settingsBloc = DependenciesScope.of(context).settingsBloc;
    return BlocProvider(
      create: (context) => settingsBloc,
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: AppBar(
          title: Text(
            'Settings',
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(fontSize: 20, fontWeight: FontWeight.w700),
          ),
          elevation: 0,
          backgroundColor: Theme.of(context).colorScheme.background,
          centerTitle: true,
        ),
        body: Column(
          children: [
            Container(
              margin: EdgeInsets.all(20),
              color: Theme.of(context).colorScheme.primaryContainer,
              child: Column(
                children: [
                  ListTile(
                    leading: SvgPicture.asset(AppIcons.money),
                    title: Text(
                      'Currency',
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .copyWith(fontSize: 16, fontWeight: FontWeight.w400),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'USD',
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(
                                  fontSize: 16, fontWeight: FontWeight.w400),
                        ),
                        const Icon(
                          Icons.chevron_right,
                          size: 24,
                        ),
                      ],
                    ),
                  ),
                  ListTile(
                    leading: SvgPicture.asset(AppIcons.shield),
                    title: Text(
                      'Safety',
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .copyWith(fontSize: 16, fontWeight: FontWeight.w400),
                    ),
                    trailing: const Icon(
                      Icons.chevron_right,
                      size: 24,
                    ),
                  ),
                  BlocBuilder<SettingsBloc, SettingsState>(
                    builder: (context, state) => ListTile(
                      leading: SvgPicture.asset(AppIcons.bell),
                      title: Text(
                        'Notification',
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            fontSize: 16, fontWeight: FontWeight.w400),
                      ),
                      trailing: CupertinoSwitch(
                        value: DependenciesScope.of(context)
                            .settingsBloc
                            .state
                            .enableNotification,
                        onChanged: (value) {
                          DependenciesScope.of(context).settingsBloc.add(
                                SettingsEvent.updateNotification(
                                  enableNotification: value,
                                ),
                              );
                        },
                      ),
                    ),
                  ),
                  ListTile(
                    leading: SvgPicture.asset(AppIcons.fill),
                    title: Text(
                      'Dark Theme',
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .copyWith(fontSize: 16, fontWeight: FontWeight.w400),
                    ),
                    trailing: CupertinoSwitch(
                      value: Theme.of(context).brightness == Brightness.dark,
                      onChanged: (value) {
                        DependenciesScope.of(context).settingsBloc.add(
                              SettingsEvent.updateTheme(
                                appTheme: AppTheme(
                                  mode:
                                      value ? ThemeMode.dark : ThemeMode.light,
                                  seed: Colors.black,
                                ),
                              ),
                            );
                      },
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              color: Theme.of(context).colorScheme.primaryContainer,
              child: Column(
                children: [
                  ListTile(
                    leading: SvgPicture.asset(AppIcons.star),
                    title: Text(
                      'Rate App',
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .copyWith(fontSize: 16, fontWeight: FontWeight.w400),
                    ),
                  ),
                  ListTile(
                    leading: SvgPicture.asset(AppIcons.mail),
                    title: Text(
                      'Write to developers',
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .copyWith(fontSize: 16, fontWeight: FontWeight.w400),
                    ),
                    onTap: () {
                      launchUrl(
                        Uri.parse('https://www.google.com/'),
                        mode: LaunchMode.externalApplication,
                      );
                    },
                  ),
                  ListTile(
                    leading: SvgPicture.asset(AppIcons.doc),
                    title: Text(
                      'Privacy policy',
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .copyWith(fontSize: 16, fontWeight: FontWeight.w400),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
