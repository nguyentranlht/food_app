import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:itc_food/features/authentication/auth_bloc/auth_bloc.dart';
import 'package:itc_food/features/authentication/auth_bloc/auth_event.dart';
import 'package:itc_food/share/widgets/widgets.dart';

class GoogleButtonView extends StatelessWidget {
  const GoogleButtonView({super.key});

  @override
  Widget build(BuildContext context) {
    return _googleButtonUI(context);
  }

  Widget _googleButtonUI(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: CommonButton(
            padding: EdgeInsets.zero,
            backgroundColor: Colors.blueGrey,
            buttonTextWidget: _buttonTextUI(),
            onTap: () {
              context.read<AuthBloc>().add(SignInWithGoogleRequested());
            },
          ),
        ),
      ],
    );
  }

  Widget _buttonTextUI() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        const Icon(FontAwesomeIcons.google, size: 20, color: Colors.white),
        const SizedBox(
          width: 4,
        ),
        const Text(
          "Google",
          style: TextStyle(
              fontWeight: FontWeight.w500, fontSize: 16, color: Colors.white),
        ),
      ],
    );
  }
}
