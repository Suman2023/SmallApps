import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final usernameStateProvider =
    StateProvider<TextEditingController>((ref) => TextEditingController());
final emailStateProvider =
    StateProvider<TextEditingController>((ref) => TextEditingController());
final passwordStateProvider =
    StateProvider<TextEditingController>((ref) => TextEditingController());
final confirmPasswordStateProvider =
    StateProvider<TextEditingController>((ref) => TextEditingController());

final errorTextProvider = StateProvider<String?>((ref) => null);
