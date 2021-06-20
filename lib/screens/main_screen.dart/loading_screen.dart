import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internship0006/model/user.dart';
import 'package:internship0006/screens/authentication/auth_screen.dart';
import 'package:internship0006/screens/main_screen.dart/loading_bloc.dart';
import 'package:internship0006/screens/main_screen.dart/loading_event.dart';
import 'package:internship0006/screens/main_screen.dart/loading_state.dart';
import 'package:internship0006/screens/profile_page_user_screen.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  late LoadingBloc _loadingBloc;

  @override
  void initState() {
    super.initState();
    _loadingBloc = LoadingBloc();
    _checkIsLogined();
  }

  @override
  void dispose() {
    super.dispose();
    _loadingBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoadingBloc>(
        create: (context) {
          return _loadingBloc;
        },
        child: BlocListener<LoadingBloc, LoadingState>(
            listener: (context, state) {
              if (state is UserLoded) {
                _openInformationScreen(state.user);
              }

              if (state is UserNotLoaded) {
                _openAuthencicationScreen();
              }
            },
            child: _render()));
  }

  Widget _render() {
    return BlocBuilder<LoadingBloc, LoadingState>(builder: (context, state) {
      return const Scaffold(
          backgroundColor: Colors.yellow,
          resizeToAvoidBottomInset: false,
          body: Center(
            child: CircularProgressIndicator(),
          ));
    });
  }

  Future<void> _openAuthencicationScreen() {
    return Navigator.push(context, MaterialPageRoute(builder: (_) {
      return AuthenticationScreen();
    }));
  }

  Future<void> _checkIsLogined() async {
    _loadingBloc.add(UserLoadedEvent());
  }

  Future<void> _openInformationScreen(User user) {
    return Navigator.push(context, MaterialPageRoute(builder: (_) {
      return ProfilePageUserScreen(user: user);
    }));
  }
}
