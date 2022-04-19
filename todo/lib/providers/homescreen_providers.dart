import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final currentChipStateProvider = StateProvider<int>((ref) => 0);

final pageControllerState =
    StateProvider<PageController>((ref) => PageController());
