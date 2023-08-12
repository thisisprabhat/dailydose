import 'package:dailydose/ui/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

import '../landing_page/landing_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late ZoomDrawerController _controller;
  @override
  void initState() {
    super.initState();
    _controller = ZoomDrawerController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ZoomDrawer(
        controller: _controller,
        androidCloseOnBackTap: true,
        mainScreenTapClose: true,
        menuScreen: const CustomDrawer(),
        mainScreen: LandingPage(
          onMenuPressed: () {
            _controller.toggle?.call();
          },
        ),
        boxShadow: const [
          BoxShadow(
            offset: Offset(-5, 0),
            color: Colors.black26,
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
        borderRadius: 24.0,
        // showShadow: true,
        menuBackgroundColor: Theme.of(context).colorScheme.background,
        angle: 0.0,
        // drawerShadowsBackgroundColor: Theme.of(context).colorScheme.background,
        slideWidth: MediaQuery.of(context).size.width * 0.75,
        dragOffset: 200,
      ),
    );
  }
}
