extension ListExtension<E> on List<E> {
  List<E> takeFromStart(int count) {
    return length <= count ? this : take(count).toList();
  }

  List<E> takeFromEnd(int count) {
    return length <= count ? this : skip(length - count).toList();
  }
}
