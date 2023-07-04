// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import '../presentation.dart';
//
// class Screen extends StatefulWidget {
//   const Screen({Key? key}) : super(key: key);
//
//   @override
//   _ScreenState createState() => _ScreenState();
// }
//
// class _ScreenState extends State<Screen> {
//   late ViewModel _viewModel;
//
//   @override
//   Widget build(BuildContext context) {
//     return BaseWidget<ViewModel>(
//         viewModel: ViewModel(),
//         onViewModelReady: (viewModel) {
//           _viewModel = viewModel..init();
//         },
//         // child: WidgetBackground(),
//         builder: (context, viewModel, child) {
//           return Scaffold(
//             body: SafeArea(child: _buildBody()),
//           );
//         });
//   }
//
//   Widget _buildBody() {
//     return SizedBox();
//   }
// }
