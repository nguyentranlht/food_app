import 'package:itc_food/features/authentication/auth_bloc/auth_bloc.dart';
import 'package:itc_food/features/authentication/auth_bloc/auth_event.dart';
import 'package:itc_food/features/authentication/auth_bloc/auth_state.dart';
import 'package:itc_food/features/authentication/screen/google_button_view.dart';
import 'package:itc_food/router/routers.dart';
import 'package:itc_food/share/utils/validator.dart';
import 'package:itc_food/share/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String? emailError;
  String? passwordError;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onLoginButtonPressed() async {
    setState(() {
      emailError = Validator.validateEmail(_emailController.text.trim());
      passwordError = Validator.validatePassword(_passwordController.text.trim());
    });

    if (emailError == null && passwordError == null) {
      context.read<AuthBloc>().add(
        LoginEvent(
          _emailController.text.trim(),
          _passwordController.text.trim(),
        ),
      );
    } else {
      _showSnackBar("Vui lòng nhập đầy đủ và chính xác thông tin!");
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) async {
          if (state is AuthSuccess) {
            final prefs = await SharedPreferences.getInstance();
            await prefs.setBool('isLoggedIn', true);
            _showSnackBar("Đăng nhập thành công!");
            context.go(RoutesPages.main);
          } else if (state is AuthFailure) {
            _showSnackBar(state.error);
          }
        },
        child: RemoveFocuse(
          onClick: () => FocusScope.of(context).unfocus(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _appBar(title: "Đăng nhập"),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    children: <Widget>[
                      const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text(
                          "Đăng nhập tài khoản",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                        ),
                      ),
                      CommonTextFieldView(
                        errorText: emailError,
                        controller: _emailController,
                        titleText: "Email",
                        hintText: "Nhập email của bạn",
                        keyboardType: TextInputType.emailAddress,
                      ),
                      CommonTextFieldView(
                        errorText: passwordError,
                        titleText: "Mật khẩu",
                        hintText: "Nhập mật khẩu của bạn",
                        isObscureText: true,
                        controller: _passwordController,
                      ),
                      const SizedBox(height: 16),
                      CommonButton(
                        buttonText: "Đăng nhập",
                        onTap: _onLoginButtonPressed,
                        textColor: Colors.black,
                      ),
                      const SizedBox(height: 16),
                      GoogleButtonView(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _appBar({required String title}) {
    return CommonAppbarView(
      iconData: Icons.arrow_back,
      titleText: title,
      onBackClick: () {
        context.go(RoutesPages.start);
      },
    );
  }
}