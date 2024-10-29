import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_list/splash_cubit/cubit/splashscreen_cubit.dart';

class SpashScreen extends StatelessWidget {
  const SpashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SplashscreenCubit(context),
      child: BlocBuilder<SplashscreenCubit, SplashscreenState>(
        builder: (context, state) {
          return Scaffold(
              backgroundColor: Colors.white,
              body: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Image(
                      image: NetworkImage(
                          "https://miro.medium.com/v2/resize:fit:1400/1*UDNyY_8XZWb5AFAar_gAZA.png"),
                      width: 300,
                      height: 300,
                    ),
                  ),
                ],
              ));
        },
      ),
    );
  }
}
