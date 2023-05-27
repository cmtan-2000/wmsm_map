// ignore_for_file: file_names

class StreamViewModel {
  Stream<String> fetchData1() {
    return Stream.periodic(const Duration(seconds: 1), (count) {
      return '$count';
    });
  }

  Stream<int> fetchNumber() {
    return Stream.periodic(const Duration(seconds: 2), (count) {
      return count;
    });
  }
}
