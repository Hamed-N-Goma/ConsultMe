import 'dart:async';

import 'package:flutter/material.dart';
import 'package:consultme/shard/widgets/my_icon_button.dart';

class MySlider extends StatefulWidget {
  const MySlider({
    Key? key,
    required this.children,
    this.duration,
  }) : super(key: key);
  final List<Widget> children;
  final Duration? duration;

  @override
  State<MySlider> createState() => _MySliderState();
}

class _MySliderState extends State<MySlider> with TickerProviderStateMixin {
  final PageController _controller = PageController(initialPage: 0);
  var currentPage = 0;
  Timer? _timer;

  @override
  void initState() {
    slide();
    super.initState();
  }

  slide() async {
    if (_timer != null) {
      _timer!.cancel();
    }
    _timer =
        Timer.periodic(widget.duration ?? const Duration(seconds: 5), (timer) {
      nextPage();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Column(
          children: [
            Expanded(
              child: PageView.builder(
                scrollDirection: Axis.horizontal,
                allowImplicitScrolling: true,
                pageSnapping: true,
                controller: _controller,
                onPageChanged: (index) {
                  setState(() {
                    currentPage = index;
                  });
                },
                itemCount: widget.children.length,
                itemBuilder: (BuildContext context, int index) {
                  return widget.children[index];
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List<Widget>.generate(
                    widget.children.length,
                    (i) {
                      return InkWell(
                        onTap: () {
                          _controller.animateToPage(i,
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut);
                          slide();
                        },
                        child: Container(
                          height: 10,
                          width: 15,
                          margin: const EdgeInsets.all(4.0),
                          decoration: BoxDecoration(
                            color: i == currentPage
                                ? Theme.of(context).primaryColor
                                : Theme.of(context)
                                    .primaryColor
                                    .withOpacity(0.2),
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      );
                    },
                  ).toList(),
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MyIconButton(
                onPressed: previousPage,
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              MyIconButton(
                onPressed: nextPage,
                icon: Icon(
                  Icons.arrow_forward_ios,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  nextPage() {
    if (_controller.page == widget.children.length - 1) {
      _controller.animateToPage(0,
          duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
      slide();
      return;
    }
    _controller.nextPage(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
    slide();
  }

  previousPage() {
    if (_controller.page == 0) {
      _controller.animateToPage(widget.children.length,
          duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
      slide();
      return;
    }
    _controller.previousPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
    slide();
  }

  @override
  void dispose() {
    _controller.dispose();
    _timer!.cancel();
    super.dispose();
  }
}
