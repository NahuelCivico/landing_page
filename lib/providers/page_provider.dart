import 'package:flutter/material.dart';
import 'package:universal_html/html.dart' as html;

class PageProvider extends ChangeNotifier {
  PageController scrollController = PageController();

  final List<String> _pages = [
    '/home',
    '/about',
    '/pricing',
    '/contact',
    '/location',
  ];

  int _currentIndex = 0;

  createScrollController(String routeName) {
    scrollController = PageController(initialPage: getPageIndex(routeName));

    html.document.title = _pages[getPageIndex(routeName)].substring(1);

    scrollController.addListener(() {
      final index = (scrollController.page ?? 0).round();
      if (index != _currentIndex) {
        html.window.history.pushState(null, '', '#${_pages[index]}');
        _currentIndex = index;
        html.document.title = _pages[index].substring(1);
      }
    });
  }

  int getPageIndex(String routeName) {
    return !_pages.contains(routeName) ? 0 : _pages.indexOf(routeName);
  }

  goTo(int index) {
    scrollController.animateToPage(
      index,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }
}
