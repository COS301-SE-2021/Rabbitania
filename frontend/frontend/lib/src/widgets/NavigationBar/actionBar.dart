import 'package:flutter/material.dart';

// ignore: must_be_immutable
class FancyFab extends StatefulWidget {
  final String? heroTag;
  final int? numberOfItems;
  final Function() onPressed1;
  final IconData? icon1;
  final Function() onPressed2;
  final IconData? icon2;
  final Function() onPressed3;
  final IconData? icon3;

  FancyFab({
    required this.heroTag,
    required this.numberOfItems,
    required this.onPressed1,
    required this.icon1,
    required this.onPressed2,
    required this.icon2,
    required this.onPressed3,
    required this.icon3,
  });

  @override
  _FancyFabState createState() => _FancyFabState(
      this.heroTag!,
      this.numberOfItems!,
      this.icon1!,
      this.onPressed1,
      this.icon2!,
      this.onPressed2,
      this.icon3!,
      this.onPressed3);

  get getTag => this.heroTag;
  get getNumberofItems => this.numberOfItems;

  get getIcon1 => this.icon1;
  get getIcon2 => this.icon2;
  get getIcon3 => this.icon3;

  get getOnPressed1 => this.onPressed1;
  get getOnPressed2 => this.onPressed2;
  get getOnPressed3 => this.onPressed3;
}

class _FancyFabState extends State<FancyFab>
    with SingleTickerProviderStateMixin {
  bool isOpened = false;
  late AnimationController _animationController;
  late Animation<Color?> _buttonColor;
  late Animation<double> _animateIcon;
  late Animation<double> _translateButton;
  Curve _curve = Curves.easeOut;
  double _fabHeight = 56.0;

  _FancyFabState(
      String? heroTag,
      int num,
      IconData? icon1,
      Function() onPressed1,
      IconData? icon2,
      Function() onPressed2,
      IconData? icon3,
      Function() onPressed3);

  @override
  initState() {
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500))
          ..addListener(() {
            setState(() {});
          });
    _animateIcon =
        Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);
    _buttonColor = ColorTween(
      begin: Color.fromRGBO(171, 255, 79, 1),
      end: Colors.red,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Interval(
        0.00,
        1.00,
        curve: Curves.linear,
      ),
    ));
    _translateButton = Tween<double>(
      begin: _fabHeight,
      end: -14.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Interval(
        0.0,
        0.75,
        curve: _curve,
      ),
    ));
    super.initState();
  }

  @override
  dispose() {
    _animationController.dispose();
    super.dispose();
  }

  animate() {
    if (!isOpened) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
    isOpened = !isOpened;
  }

  Widget fab1(String heroTag, int num, IconData icon, Function() onPressed) {
    if (num > 0) {
      return Container(
        child: FloatingActionButton(
          heroTag: 'fab1',
          backgroundColor: Color.fromRGBO(171, 255, 79, 1),
          onPressed: onPressed,
          child: Icon(icon, color: Color.fromRGBO(33, 33, 33, 1)),
        ),
      );
    } else {
      return SizedBox.shrink();
    }
  }

  Widget fab2(String heroTag, int num, IconData icon, Function() onPressed) {
    if (num > 1) {
      return Container(
        child: FloatingActionButton(
          heroTag: 'fab2',
          backgroundColor: Color.fromRGBO(171, 255, 79, 1),
          onPressed: onPressed,
          child: Icon(icon, color: Color.fromRGBO(33, 33, 33, 1)),
        ),
      );
    } else {
      return SizedBox.shrink();
    }
  }

  Widget fab3(String heroTag, int num, IconData icon, Function() onPressed) {
    if (num > 2) {
      return Container(
        child: FloatingActionButton(
          heroTag: 'fab3',
          backgroundColor: Color.fromRGBO(171, 255, 79, 1),
          onPressed: onPressed,
          child: Icon(icon, color: Color.fromRGBO(33, 33, 33, 1)),
        ),
      );
    } else {
      return SizedBox.shrink();
    }
  }

  Widget toggle() {
    return Container(
      child: FloatingActionButton(
        heroTag: 'hhhtag',
        backgroundColor: _buttonColor.value,
        onPressed: animate,
        tooltip: 'Toggle',
        child: AnimatedIcon(
            icon: AnimatedIcons.menu_close,
            progress: _animateIcon,
            color: Color.fromRGBO(33, 33, 33, 1)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Transform(
          transform: Matrix4.translationValues(
            0.0,
            _translateButton.value * 3.0,
            0.0,
          ),
          child: fab3(widget.heroTag!, widget.numberOfItems!, widget.getIcon3,
              widget.getOnPressed3),
        ),
        Transform(
          transform: Matrix4.translationValues(
            0.0,
            _translateButton.value * 2.0,
            0.0,
          ),
          child: fab2(widget.heroTag!, widget.numberOfItems!, widget.getIcon2,
              widget.getOnPressed2),
        ),
        Transform(
          transform: Matrix4.translationValues(
            0.0,
            _translateButton.value,
            0.0,
          ),
          child: fab1(widget.heroTag!, widget.numberOfItems!, widget.getIcon1,
              widget.getOnPressed1),
        ),
        toggle(),
      ],
    );
  }
}
