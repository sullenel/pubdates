import 'package:scroll_to_index/scroll_to_index.dart';

typedef KeyExtractor<T> = String Function(T);

// Finally, a manager class.
// It is 2030 and Flutter still sucks when it comes to scrolling to a particular
// item.
class ScrollManager<E> {
  ScrollManager({
    required KeyExtractor<E> keyExtractor,
  }) : _keyExtractor = keyExtractor;

  final KeyExtractor<E> _keyExtractor;
  final controller = AutoScrollController();
  var _indexes = <String, int>{};

  void addAll(Iterable<E> elements) {
    var index = 0;
    _indexes = {for (final it in elements) _keyExtractor(it): index++};
  }

  Future<void> scrollTo(
    E element, {
    Duration duration = const Duration(milliseconds: 400),
  }) async {
    final index = _indexes[_keyExtractor(element)];

    if (index != null) {
      controller.scrollToIndex(
        index,
        duration: duration,
        preferPosition: AutoScrollPosition.begin,
      );
    }
  }

  void dispose() {
    controller.dispose();
  }
}
