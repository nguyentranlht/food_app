import 'package:itc_food/features/authentication/auth_bloc/auth_bloc.dart';
import 'package:itc_food/features/authentication/auth_bloc/auth_event.dart';
import 'package:itc_food/features/authentication/auth_bloc/auth_state.dart';
import 'package:itc_food/router/routers.dart';
import 'package:itc_food/share/utils/validator.dart';
import 'package:itc_food/share/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _fnameController = TextEditingController();
  final TextEditingController _pnumController = TextEditingController();

  String? emailError;
  String? passwordError;
  String? nameError;
  String? phoneError;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _fnameController.dispose();
    _pnumController.dispose();
    super.dispose();
  }

  void _onSignUpButtonPressed() {
    setState(() {
      emailError = Validator.validateEmail(_emailController.text.trim());
      passwordError = Validator.validatePassword(
        _passwordController.text.trim(),
      );
      nameError = Validator.validateName(_fnameController.text.trim());
      phoneError = Validator.validatePhoneNumber(_pnumController.text.trim());
    });

    if (emailError == null &&
        passwordError == null &&
        nameError == null &&
        phoneError == null) {
      context.read<AuthBloc>().add(
        SignupEvent(
          _emailController.text.trim(),
          _passwordController.text.trim(),
        ),
      );
    } else {
      _showSnackBar("Vui lòng nhập đầy đủ và chính xác thông tin!");
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  void _goToLogin() {
    context.go(RoutesPages.login);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            _showSnackBar("Đăng ký thành công!");
            context.go(RoutesPages.login);
          } else if (state is AuthFailure) {
            _showSnackBar("Đăng ký thất bại: ${state.error}");
          }
        },
        child: RemoveFocuse(
          onClick: () => FocusScope.of(context).unfocus(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _appBar(title: "Đăng ký"),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    children: <Widget>[
                      const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text(
                          "Đăng ký tài khoản",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      CommonTextFieldView(
                        errorText: nameError,
                        controller: _fnameController,
                        titleText: "Họ và tên",
                        hintText: "Nhập họ và tên",
                        keyboardType: TextInputType.name,
                      ),
                      CommonTextFieldView(
                        errorText: phoneError,
                        controller: _pnumController,
                        titleText: "Số điện thoại",
                        hintText: "Nhập số điện thoại",
                        keyboardType: TextInputType.phone,
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
                      CommonButton(
                        buttonText: "Đăng ký",
                        onTap: _onSignUpButtonPressed,
                        textColor: Colors.black,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          "Đăng nhập bằng email",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Theme.of(context).disabledColor,
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "Đã có tài khoản?",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Theme.of(context).disabledColor,
                            ),
                          ),
                          InkWell(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(8),
                            ),
                            onTap: _goToLogin,
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Text(
                                "Đăng nhập",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.amber,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).padding.bottom + 24,
                      ),
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
