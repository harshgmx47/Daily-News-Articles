import 'package:daily_news_articles/News-Module/controller/tabs_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';

class SlideMenu extends StatefulWidget {
  final Widget child;
  final List<Widget> menuItems;
  const SlideMenu({super.key, required this.child, required this.menuItems});

  @override
  State<SlideMenu> createState() => _SlideMenuState();
}

class _SlideMenuState extends State<SlideMenu>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final tabsController = Get.put(TabsController());

  @override
  initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final animation =
        Tween(begin: const Offset(0.0, 0.0), end: const Offset(-0.3, 0.0))
            .animate(CurveTween(curve: Curves.decelerate).animate(_controller));

    return GestureDetector(
      onHorizontalDragUpdate: (data) {
        setState(() {
          _controller.value -=
              (data.primaryDelta! / (context.size!.width * 0.2));
        });
      },
      onHorizontalDragEnd: (details) {
        if (details.primaryVelocity! > 1500) {
          _controller.animateTo(.0);
        } else if (_controller.value >= 0.5 ||
            details.primaryVelocity! < -1500) {
          // tabsController.slidable(true);

          _controller.animateTo(1.0);
        } else {
          _controller.animateTo(.0);
          // tabsController.slidable(false);
        }
      },
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Stack(
            children: [
              SlideTransition(
                position: animation,
                child: widget.child,
              ),
              AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  return Positioned(
                    right: .0,
                    top: .0,
                    bottom: .0,
                    width: constraints.minWidth * animation.value.dx * -1.110,
                    child: SingleChildScrollView(
                      padding:
                          EdgeInsets.symmetric(vertical: 20, horizontal: 0),
                      scrollDirection: Axis.horizontal,
                      child: SizedBox(
                        child: Column(
                          children: widget.menuItems.map((e) {
                            return Expanded(child: e);
                          }).toList(),
                        ),
                      ),
                    ),
                  );
                },
              )
            ],
          );
        },
      ),
    );
  }
}
