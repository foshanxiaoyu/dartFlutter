import 'package:flutter/material.dart';

class FilterAnimationGoogleIOTutorial extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: GoogleIOFilter(),
        ),
      ),
    );
  }
}

class GoogleIOFilter extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return GoogleIOFilterState();
  }
}

class GoogleIOFilterState extends State<GoogleIOFilter>
    with TickerProviderStateMixin {
  final GlobalKey _commonContainerKey =
      GlobalKey(debugLabel: 'CommonContainer');
  // init 用late 处理以下八个值 21.09.18
  late AnimationController _controller;
  late Animation<double> _rightPaddingAnimation;
  late Animation<double> _leftPaddingAnimation;
  late Animation<double> _dotHeightAnimation;
  late Animation<double> _closeImageAnimation;
  late Animation<double> _dotLeftPositionAnimation;
  late Animation<double> _dotTopPositionAnimation;
  late Animation<Color?> _textColorAnimation;
  bool isChecked = false;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 400));
    _rightPaddingAnimation = Tween(begin: 20.0, end: 40.0).animate(_controller);
    _leftPaddingAnimation = Tween(begin: 40.0, end: 20.0).animate(_controller);
    _dotHeightAnimation = Tween(begin: 20.0, end: 40.0).animate(_controller);
    _closeImageAnimation = Tween(begin: 0.0, end: 1.0).animate(_controller);
    _dotLeftPositionAnimation =
        Tween(begin: 10.0, end: 0.0).animate(_controller);
    _dotTopPositionAnimation = Tween(begin: 8.0, end: 0.0).animate(_controller);
    _textColorAnimation = ColorTween(begin: Colors.black, end: Colors.white)
        .animate(_controller); //此处要在35行声明处类型'Color'后加？,类型检测空值不能通过
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  bool get filterAnimationStatus {
    var status = _controller.status;
    print("status$status");
    return status == AnimationStatus.completed;
  }

  Animation<double> getDotWidthAnimation() {
    var width = 20.0;
    if (_commonContainerKey.currentContext != null) {
      final RenderBox renderBox =
          _commonContainerKey.currentContext!.findRenderObject() as RenderBox;
      //此处加入'as RenderBox'强制转换还在.find前加判断非空'!'
      width = renderBox.size.width;
    }
    print("width$width");

    return Tween(begin: 20.0, end: width).animate(_controller);
  }

  Widget getWidgetBuilder(BuildContext context, Widget? widget) {
    return InkWell(
      onTap: () {
        isChecked = !isChecked;
        if (filterAnimationStatus) {
          _controller.reverse();
        } else {
          _controller.forward();
        }
      },
      child: Container(
        height: 40.0,
        decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            border: Border.all(color: Colors.black26, width: 1.0),
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
        child: Stack(
          key: _commonContainerKey,
          children: <Widget>[
            Positioned(
              left: _dotLeftPositionAnimation.value,
              top: _dotTopPositionAnimation.value,
              child: Align(
                alignment: Alignment.center,
                child: Container(
                  height: _dotHeightAnimation.value,
                  width: getDotWidthAnimation().value,
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      shape: BoxShape.rectangle),
                ),
              ),
            ),
            Align(
              widthFactor: 1,
              alignment: Alignment.centerLeft,
              child: Container(
                padding: EdgeInsets.only(
                    left: _leftPaddingAnimation.value,
                    right: _rightPaddingAnimation.value),
                child: Text(
                  "Some thing to filter",
                  style: TextStyle(
                      fontSize: 20.0, color: _textColorAnimation.value),
                ),
              ),
            ),
            Positioned(
              right: 5.0,
              top: 7.0,
              child: ScaleTransition(
                scale: _closeImageAnimation,
                child: Container(
                  padding: EdgeInsets.all(2.0),
                  child: Icon(
                    Icons.close,
                    size: 20.0,
                  ),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: Colors.grey.shade400),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      builder: getWidgetBuilder, //在getWidgetBuilder 87行声明处‘Widget’后加?
      animation: _controller,
    );
  }
}
