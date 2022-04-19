import 'package:flutter_riverpod/flutter_riverpod.dart';

final buttomNavbarCurrentIndexProvider = StateProvider<int>((ref) => 0);

final addButtonProvider = StateProvider<bool>((ref) => true);
