import 'dart:math';

import 'package:binder/binder.dart';
import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile/client.dart';
import 'package:mobile/state.dart';
import 'package:swipable_stack/swipable_stack.dart';

const _kDebugBadges = false;
const _kDebugNoneLeft = false;

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

  SwipeDirection? previousDirection;
  OptionDto? previousOption;

  @override
  Widget build(BuildContext context) {
    late final duelStack = context.watch(duelStackRef);

    return Shortcuts(
      shortcuts: {
        LogicalKeySet(LogicalKeyboardKey.arrowLeft):
            const _DuelIntentSwipeLeft(),
        LogicalKeySet(LogicalKeyboardKey.arrowRight):
            const _DuelIntentSwipeRight(),
      },
      child: Actions(
        actions: <Type, Action<Intent>>{
          _DuelIntentSwipeLeft: CallbackAction<_DuelIntentSwipeLeft>(
            onInvoke: (_) =>
                controller.next(swipeDirection: SwipeDirection.left),
          ),
          _DuelIntentSwipeRight: CallbackAction<_DuelIntentSwipeRight>(
            onInvoke: (_) =>
                controller.next(swipeDirection: SwipeDirection.right),
          ),
        },
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Duel!'),
          ),
          body: Stack(
            children: [
              const Center(
                child: Padding(
                  padding: EdgeInsets.all(40),
                  child: Text(
                    'fam actually spent time of their life to rank 30 solutions to a single problem 💀💀',
                    style: TextStyle(fontSize: 24),
                  ),
                ),
              ),
              Positioned.fill(
                child: SwipableStack(
                  itemCount: _kDebugNoneLeft ? 0 : duelStack.length,
                  controller: controller,
                  detectableSwipeDirections: const {
                    SwipeDirection.left,
                    SwipeDirection.right,
                  },
                  onSwipeCompleted: (index, swipedDirection) {
                    final swipedOption = duelStack[index];
                    final isFirst = index == 0;

                    if (!isFirst) {
                      /// if swiped draw, do nothing
                      if (swipedDirection == previousDirection) return;
                      if (previousOption == null) return;

                      /// swipedOption won
                      if (swipedDirection == SwipeDirection.right) {
                        postDuel(DuelVoteDto(
                          optionAId: swipedOption.id,
                          optionBId: previousOption!.id,
                          winnerId: swipedOption.id,
                        ));
                      }

                      /// swipedOption lost
                      else {
                        postDuel(DuelVoteDto(
                          optionAId: swipedOption.id,
                          optionBId: previousOption!.id,
                          winnerId: previousOption!.id,
                        ));
                      }
                    }

                    previousDirection = swipedDirection;
                    previousOption = swipedOption;
                  },
                  builder: (context, properties) {
                    final option = duelStack[properties.index];

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
                                            ? properties.swipeProgress
                                                .clamp(0, 1)
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
                                            ? properties.swipeProgress
                                                .clamp(0, 1)
                                            : 0,
                                    child: const _SwipeDirectionBadge(
                                      direction: SwipeDirection.right,
                                    ),
                                  ),
                                ),
                                Center(
                                  child: Text(
                                    option.name,
                                    style: const TextStyle(
                                      fontSize: 24,
                                    ),
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
              ),
            ],
          ),
        ),
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

class _DuelIntentSwipeLeft extends Intent {
  const _DuelIntentSwipeLeft();
}

class _DuelIntentSwipeRight extends Intent {
  const _DuelIntentSwipeRight();
}
