class Ticker {
  const Ticker();
  Stream<int> tick({required int ticks}) {
    return Stream.periodic(Duration(seconds: 1), (x) => ticks - x - 1)
        .take(ticks);
  }

  Stream<int> tickLoop({required int ticks}) {
    return Stream.periodic(
        Duration(seconds: 1), (x) => (ticks - x) % (ticks + 1));
  }
}
