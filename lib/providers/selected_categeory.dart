import 'package:flutter_riverpod/flutter_riverpod.dart';

class SelectedCategeoryProvider extends StateNotifier<String> {
  SelectedCategeoryProvider() : super('');

  void setSelectedCategeory(String cat) {
    state = cat;
  }
}

final selectedCategeoryProvider =
    StateNotifierProvider<SelectedCategeoryProvider, String>((ref) {
  return SelectedCategeoryProvider();
});
