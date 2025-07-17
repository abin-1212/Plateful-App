import 'package:flutter/material.dart';

class CarouselWidget extends StatefulWidget {
  final List<Widget> items;
  final double height;
  final bool autoPlay;
  final Duration autoPlayInterval;

  const CarouselWidget({
    super.key,
    required this.items,
    this.height = 260,
    this.autoPlay = true,
    this.autoPlayInterval = const Duration(seconds: 4),
  });

  @override
  State<CarouselWidget> createState() => _CarouselWidgetState();
}

class _CarouselWidgetState extends State<CarouselWidget> {
  late final PageController _controller;
  int _currentPage = 0;
  late final bool _autoPlay;

  @override
  void initState() {
    super.initState();
    _controller = PageController(viewportFraction: 0.88);
    _autoPlay = widget.autoPlay;
    if (_autoPlay && widget.items.length > 1) {
      WidgetsBinding.instance.addPostFrameCallback((_) => _startAutoPlay());
    }
  }

  void _startAutoPlay() async {
    while (mounted && _autoPlay && widget.items.length > 1) {
      await Future.delayed(widget.autoPlayInterval);
      if (!mounted) break;
      int nextPage = (_currentPage + 1) % widget.items.length;
      _controller.animateToPage(
        nextPage,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: widget.height,
          child: PageView.builder(
            controller: _controller,
            itemCount: widget.items.length,
            onPageChanged: (i) => setState(() => _currentPage = i),
            itemBuilder: (context, i) => AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOut,
              margin: EdgeInsets.symmetric(horizontal: _currentPage == i ? 0 : 8, vertical: _currentPage == i ? 0 : 16),
              child: widget.items[i],
            ),
          ),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(widget.items.length, (i) => AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: const EdgeInsets.symmetric(horizontal: 4),
                width: _currentPage == i ? 18 : 8,
                height: 8,
                decoration: BoxDecoration(
                  color: _currentPage == i ? Colors.tealAccent : Colors.deepPurple.withOpacity(0.18),
                  borderRadius: BorderRadius.circular(8),
                ),
              )),
        ),
      ],
    );
  }
} 