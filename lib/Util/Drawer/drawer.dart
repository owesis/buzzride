// ignore_for_file: file_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// ignore: file_names
class Drawerer extends StatefulWidget {
  const Drawerer({
    Key? key,
    required this.child,
    required this.drawer,
    this.controller,
    this.backdropColor,
    this.openRatio = 0.75,
    this.animationDuration = const Duration(milliseconds: 250),
    this.animationCurve,
    this.childDecoration,
    this.animateChildDecoration = true,
    this.rtlOpening = false,
    this.disabledGestures = false,
    this.animationController,
  }) : super(key: key);

  /// Child widget. (Usually widget that represent a screen)
  final Widget child;

  /// Drawer widget. (Widget behind the [child]).
  final Widget drawer;

  /// Controller that controls widget state.
  final ZiDrawerController? controller;

  /// Backdrop color.
  final Color? backdropColor;

  /// Opening ratio.
  final double openRatio;

  /// Animation duration.
  final Duration animationDuration;

  /// Animation curve.
  final Curve? animationCurve;

  /// Child container decoration in open widget state.
  final BoxDecoration? childDecoration;

  /// Indicates that [childDecoration] might be animated or not.
  /// NOTICE: It may cause animation jerks.
  final bool animateChildDecoration;

  /// Opening from Right-to-left.
  final bool rtlOpening;

  /// Disable gestures.
  final bool disabledGestures;

  /// Controller that controls widget animation.
  final AnimationController? animationController;

  @override
  _DrawerState createState() => _DrawerState();
}

class _DrawerState extends State<Drawerer> with SingleTickerProviderStateMixin {
  late final ZiDrawerController _controller;
  late final AnimationController _animationController;
  late final Animation<double> _drawerScaleAnimation;
  late final Animation<Offset> _childSlideAnimation;
  late final Animation<double> _childScaleAnimation;
  late final Animation<Decoration> _childDecorationAnimation;
  late double _offsetValue;
  late Offset _freshPosition;
  Offset? _startPosition;
  bool _captured = false;

  @override
  void initState() {
    super.initState();

    _controller = widget.controller ?? ZiDrawerController();
    _controller.addListener(handleControllerChanged);

    _animationController = widget.animationController ??
        AnimationController(
          vsync: this,
          value: _controller.value.visible ? 1 : 0,
        );

    _animationController.duration = widget.animationDuration;

    final parentAnimation = widget.animationCurve != null
        ? CurvedAnimation(
            curve: widget.animationCurve!,
            parent: _animationController,
          )
        : _animationController;

    _drawerScaleAnimation = Tween<double>(
      begin: 0.75,
      end: 1.0,
    ).animate(parentAnimation);

    _childSlideAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: Offset(widget.openRatio, 0),
    ).animate(parentAnimation);

    _childScaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.85,
    ).animate(parentAnimation);

    _childDecorationAnimation = DecorationTween(
      begin: const BoxDecoration(),
      end: widget.childDecoration,
    ).animate(parentAnimation);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: widget.backdropColor,
      child: GestureDetector(
        onHorizontalDragStart:
            widget.disabledGestures ? null : _handleDragStart,
        onHorizontalDragUpdate:
            widget.disabledGestures ? null : _handleDragUpdate,
        onHorizontalDragEnd: widget.disabledGestures ? null : _handleDragEnd,
        onHorizontalDragCancel:
            widget.disabledGestures ? null : _handleDragCancel,
        child: Container(
          color: Colors.transparent,
          child: Stack(
            children: <Widget>[
              // -------- DRAWER
              Align(
                alignment: widget.rtlOpening
                    ? Alignment.centerRight
                    : Alignment.centerLeft,
                child: FractionallySizedBox(
                  widthFactor: widget.openRatio,
                  child: ScaleTransition(
                    scale: _drawerScaleAnimation,
                    alignment: widget.rtlOpening
                        ? Alignment.centerLeft
                        : Alignment.centerRight,
                    child: widget.drawer,
                  ),
                ),
              ),
              // -------- CHILD
              SlideTransition(
                position: _childSlideAnimation,
                textDirection:
                    widget.rtlOpening ? TextDirection.rtl : TextDirection.ltr,
                child: ScaleTransition(
                  scale: _childScaleAnimation,
                  child: Builder(
                    builder: (_) {
                      final childStack = Stack(
                        children: [
                          widget.child,
                          ValueListenableBuilder<ZiDrawerValue>(
                            valueListenable: _controller,
                            builder: (_, value, __) {
                              if (!value.visible) {
                                return const SizedBox();
                              }

                              return Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  onTap: _controller.hideDrawer,
                                  highlightColor: Colors.transparent,
                                  child: Container(),
                                ),
                              );
                            },
                          ),
                        ],
                      );

                      if (widget.animateChildDecoration &&
                          widget.childDecoration != null) {
                        return AnimatedBuilder(
                          animation: _childDecorationAnimation,
                          builder: (_, child) {
                            return Container(
                              clipBehavior: Clip.antiAlias,
                              decoration: _childDecorationAnimation.value,
                              child: child,
                            );
                          },
                          child: childStack,
                        );
                      }

                      return Container(
                        clipBehavior: widget.childDecoration != null
                            ? Clip.antiAlias
                            : Clip.none,
                        decoration: widget.childDecoration,
                        child: childStack,
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void handleControllerChanged() {
    _controller.value.visible
        ? _animationController.forward()
        : _animationController.reverse();
  }

  void _handleDragStart(DragStartDetails details) {
    _captured = true;
    _startPosition = details.globalPosition;
    _offsetValue = _animationController.value;
  }

  void _handleDragUpdate(DragUpdateDetails details) {
    if (!_captured) return;

    final screenSize = MediaQuery.of(context).size;

    _freshPosition = details.globalPosition;

    final diff = (_freshPosition - _startPosition!).dx;

    _animationController.value = _offsetValue +
        (diff / (screenSize.width * widget.openRatio)) *
            (widget.rtlOpening ? -1 : 1);
  }

  void _handleDragEnd(DragEndDetails details) {
    if (!_captured) return;

    _captured = false;

    if (_animationController.value >= 0.5) {
      if (_controller.value.visible) {
        _animationController.forward();
      } else {
        _controller.showDrawer();
      }
    } else {
      if (!_controller.value.visible) {
        _animationController.reverse();
      } else {
        _controller.hideDrawer();
      }
    }
  }

  void _handleDragCancel() {
    _captured = false;
  }

  @override
  void dispose() {
    _controller.removeListener(handleControllerChanged);

    if (widget.controller == null) {
      _controller.dispose();
    }

    if (widget.animationController == null) {
      _animationController.dispose();
    }

    super.dispose();
  }
}

/// Advanced Drawer Controller that manage drawer state.
class ZiDrawerController extends ValueNotifier<ZiDrawerValue> {
  /// Creates controller with initial drawer state. (Hidden by default)
  ZiDrawerController([ZiDrawerValue? value])
      : super(value ?? ZiDrawerValue.hidden());

  /// Shows drawer.
  void showDrawer() {
    value = ZiDrawerValue.visible();
  }

  /// Hides drawer.
  void hideDrawer() {
    value = ZiDrawerValue.hidden();
  }

  /// Toggles drawer.
  void toggleDrawer() {
    if (value.visible) {
      return hideDrawer();
    }

    return showDrawer();
  }
}

/// AdvancedDrawer state value.
class ZiDrawerValue {
  const ZiDrawerValue({
    this.visible = false,
  });

  /// Indicates whether drawer visible or not.
  final bool visible;

  /// Create a value with hidden state.
  factory ZiDrawerValue.hidden() {
    return const ZiDrawerValue();
  }

  /// Create a value with visible state.
  factory ZiDrawerValue.visible() {
    return const ZiDrawerValue(
      visible: true,
    );
  }
}
