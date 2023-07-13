import 'package:flutter/material.dart';
import 'package:upgrader/upgrader.dart';

import '../presentation.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({Key? key}) : super(key: key);

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  late NavigationViewModel _viewModel;

  @override
  Widget build(BuildContext context) {
    return BaseWidget<NavigationViewModel>(
        viewModel: NavigationViewModel(),
        onViewModelReady: (viewModel) {
          _viewModel = viewModel..init();
        },
        // child: WidgetBackground(),
        builder: (context, viewModel, child) {
          return Scaffold(
            body: UpgradeAlert(
                upgrader: Upgrader(
                    durationUntilAlertAgain: const Duration(days: 1),
                    shouldPopScope: () => true,
                    canDismissDialog: true),
                child: _buildBody()),
          );
        });
  }

  Widget _buildBody() {
    return SizedBox();
  }
}
