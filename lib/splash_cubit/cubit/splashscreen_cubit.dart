import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:login_list/SCREENS/list_screen.dart';
import 'package:login_list/SCREENS/login_screen.dart';
import 'package:login_list/cubit/cubit/login_cubit.dart';
import 'package:meta/meta.dart';
part 'splashscreen_state.dart';

class SplashscreenCubit extends Cubit<SplashscreenState> {
  SplashscreenCubit(this.context) : super(SplashscreenInitial()) {
    loadData();
  }
  BuildContext context;
  Future<void> loadData() async {
    emit(Loading());
    // final prefs = await SharedPreferences.getInstance();
    // final token = prefs.getString('token');
    final token = await getToken();
    await Future.delayed(Duration(seconds: 3));

    if (token != null && token.isNotEmpty) {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => ListScreen()));
    } else {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => LoginScreen()));
    }
  }
}
