import 'package:flutter/material.dart';
import 'package:flutter_app/core/core.dart';
import 'package:flutter_app/data/datasources/auth_local_datasource.dart';
// import 'package:flutter/widgets.dart';

import '../home/main_page.dart';
import 'login_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: Future.delayed(const Duration(seconds: 2),
              () => AuthLocalDatasource().isLogin()),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.data == true) {
                return const MainPage();
              } else {
                return const LoginPage();
              }
            }
            return Stack(children: [
              Column(
                children: [
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.all(96.0),
                    child: Center(
                      child: Assets.images.logoBlue.image(),
                    ),
                  ),
                  const Spacer(),
                  const Center(
                    child: CircularProgressIndicator(
                      color: AppColors.primary,
                    ),
                  ),
                  const SpaceHeight(40.0),
                  SizedBox(
                    height: 100.0,
                    child: Align(
                      alignment: Alignment.center,
                      child: Assets.images.logoWhite.image(width: 96.0),
                    ),
                  )
                ],
              )
            ]);
          }),
    );
  }
}
