import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:keykeep/model/PasswordModel.dart';
import 'package:keykeep/riverpod/state.dart';

import 'notifier.dart';


final passwordNotifierProvider =
StateNotifierProvider<PasswordNotifier, PasswordFormState<List<Password>>>(
      (ref) => PasswordNotifier(),
);
