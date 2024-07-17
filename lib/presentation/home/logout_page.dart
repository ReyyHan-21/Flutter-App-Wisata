import 'package:flutter/material.dart';
import 'package:flutter_app/core/core.dart';
import 'package:flutter_app/data/datasources/auth_local_datasource.dart';
import 'package:flutter_app/presentation/auth/splash_page.dart';
// import 'package:flutter_app/data/datasources/auth_remote_datasource.dart';

class LogoutPage extends StatefulWidget {
  const LogoutPage({super.key});

  @override
  State<LogoutPage> createState() => _LogoutPageState();
}

class _LogoutPageState extends State<LogoutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Logout'),
      ),
      body: Center(
        child: ElevatedButton(onPressed: () async {
          await AuthLocalDatasource().removeAuthData();
          context.pushReplacement(const SplashPage());//Back To Splash Page
        }, 
        child: Text('Logout', selectionColor: Color.fromARGB(255, 236, 80, 236),)
        )
      ),
    );
  }
}
