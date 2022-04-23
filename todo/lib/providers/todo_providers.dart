import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo/locator.dart';
import 'package:todo/services/api_service.dart';

final getAllTasksProvider =
    FutureProvider<List<Map<String, String>>>((ref) async {
  var allHabits = await locator<ApiService>().getAllHabits();
  return allHabits;
});
