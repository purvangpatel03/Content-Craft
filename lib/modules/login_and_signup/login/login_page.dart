import 'package:article_web/modules/login_and_signup/login/widgets/login_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../custom_widgets/responsive_widget.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ResponsiveWidget(
        builder: (type) {
          if (type != DeviceType.WEB) {
            return SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    height: MediaQuery.sizeOf(context).height / 3,
                    color: Colors.amberAccent,
                    child: Center(
                      child: Align(
                        alignment: const Alignment(0, 0.3),
                        child: SvgPicture.asset(
                          height: 150,
                          'assets/logo/black_logo.svg',
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                      height: MediaQuery.sizeOf(context).height * (2 / 3),
                      child: Form(
                          key: _formKey,
                          child: LoginForm(formKey: _formKey,),
                      ),
                  ),
                ],
              ),
            );
          }
          return Row(
            children: [
              Flexible(
                child: _buildLogo(context),
              ),
              Flexible(
                child: Form(
                    key: _formKey,
                    child: LoginForm(formKey: _formKey,),
                ),
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
