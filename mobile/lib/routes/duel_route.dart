import 'dart:math';

import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:swipable_stack/swipable_stack.dart';

const _kDebugBadges = false;

class DuelRoute extends StatefulWidget {
  const DuelRoute._();

  static Future<void> show(BuildContext context) {
    return Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return const DuelRoute._();
        },
      ),
    );
  }

  @override
  State<DuelRoute> createState() => _DuelRouteState();
}

class _DuelRouteState extends State<DuelRoute> {
  final controller = SwipableStackController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Duel!'),
      ),
      body: SwipableStack(
        itemCount: 99,
        controller: controller,
        detectableSwipeDirections: const {
          SwipeDirection.left,
          SwipeDirection.right,
        },
        builder: (context, properties) {
          return Padding(
            padding: const EdgeInsets.all(25.0),
            child: AnimatedBuilder(
              animation: controller,
              builder: (BuildContext context, Widget? child) {
                final shouldPaint = (properties.stackIndex == 0 &&
                    properties.direction != null);

                return Card(
                  elevation: 30,
                  shape: SmoothRectangleBorder(
                    borderRadius: SmoothBorderRadius(
                      cornerRadius: 20,
                      cornerSmoothing: 1.0,
                    ),
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        top: 35,
                        right: 25,
                        child: Opacity(
                          opacity: _kDebugBadges
                              ? 1
                              : shouldPaint &&
                                      properties.direction ==
                                          SwipeDirection.left
                                  ? properties.swipeProgress.clamp(0, 1)
                                  : 0,
                          child: const _SwipeDirectionBadge(
                            direction: SwipeDirection.left,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 35,
                        left: 25,
                        child: Opacity(
                          opacity: _kDebugBadges
                              ? 1
                              : shouldPaint &&
                                      properties.direction ==
                                          SwipeDirection.right
                                  ? properties.swipeProgress.clamp(0, 1)
                                  : 0,
                          child: const _SwipeDirectionBadge(
                            direction: SwipeDirection.right,
                          ),
                        ),
                      ),
                      Center(
                        child: ElevatedButton(
                          onPressed: () {},
                          child: Text('${properties.index}'),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class _SwipeDirectionBadge extends StatelessWidget {
  const _SwipeDirectionBadge({
    required this.direction,
  });

  final SwipeDirection direction;
  @override
  Widget build(BuildContext context) {
    final color = direction == SwipeDirection.left ? Colors.red : Colors.green;
    return Transform.rotate(
      angle: direction == SwipeDirection.left ? pi / 6 : -pi / 6,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const SmoothBorderRadius.all(
            SmoothRadius(cornerRadius: 20, cornerSmoothing: 1.0),
          ),
          border: Border.all(
            color: color,
            width: 4.0,
          ),
        ),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: Text(
          direction == SwipeDirection.left ? 'SUS' : 'BET',
          style: TextStyle(
            color: color,
            fontSize: 28,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
    );
  }
}
