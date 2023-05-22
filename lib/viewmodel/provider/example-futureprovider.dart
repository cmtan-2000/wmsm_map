// ignore_for_file: file_names

class FutureViewModel {
  Future<String> getFutureString() async {
    await Future.delayed(const Duration(seconds: 5));
    return "Future String";
  }

  Future<int> getFutureInt() async {
    await Future.delayed(const Duration(seconds: 5));
    return 1;
  }

  Future<bool> getFutureBool() async {
    await Future.delayed(const Duration(seconds: 5));
    return true;
  }

  Future<List<dynamic>> getFutureList() async {
    return Future.wait([getFutureString(), getFutureInt(), getFutureBool()]);
  }
}
