import 'package:bloc/bloc.dart';

import '../app_states/app_states.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(InitialState());
}