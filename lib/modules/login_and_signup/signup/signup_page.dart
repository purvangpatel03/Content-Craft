import 'package:article_web/custom_widgets/responsive_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'widgets/signup_form.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ResponsiveWidget(
        builder: (type) {
          if (type != DeviceType.WEB) {
            return SingleChildScrollView(
              child: SignupForm(),
            );
          }
          return Row(
            children: [
              Flexible(
                child: _buildLogo(context),
              ),
              Flexible(
                child: SignupForm(),
              ),
            ],
          );
        },
      ),
    );
  }

  _buildLogo(BuildContext context) {
    return Container(
      color: Colors.amberAccent,
      child: Center(
        child: SvgPicture.asset(
          height: MediaQuery.sizeOf(context).height / 3,
          'assets/logo/black_logo.svg',
        ),
      ),
    );
  }
}
