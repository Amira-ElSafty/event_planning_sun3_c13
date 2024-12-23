import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_styles.dart';
import '../../../utils/assets_manager.dart';
import '../../home_screen/home_screen.dart';
import '../../home_screen/tabs/widgets/custom_elevated_button.dart';
import '../../home_screen/tabs/widgets/custom_text_field.dart';
import '../login/login_screen.dart';

class RegisterScreen extends StatefulWidget {
  static const String routeName = 'register_screen';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(AppLocalizations.of(context)!.register,
        style: AppStyles.medium16Black,),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: width * 0.02,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.asset(
                AssetsManager.logo,
                height: height * 0.25,
              ),
              SizedBox(
                height: height * 0.02,
              ),
              CustomTextField(
                hintText: AppLocalizations.of(context)!.name,
                prefixIcon: Image.asset(AssetsManager.iconName),
              ),SizedBox(
                height: height * 0.02,
              ),
              CustomTextField(
                hintText: AppLocalizations.of(context)!.email,
                prefixIcon: Image.asset(AssetsManager.iconEmail),
              ),
              SizedBox(
                height: height * 0.02,
              ),
              CustomTextField(
                obscureText: true,
                hintText: AppLocalizations.of(context)!.password,
                prefixIcon: Image.asset(AssetsManager.iconPassword),
                suffixIcon: Image.asset(AssetsManager.iconShowPassword),
              ),
              SizedBox(
                height: height * 0.02,
              ),
              CustomTextField(
                obscureText: true,
                hintText: AppLocalizations.of(context)!.re_password,
                prefixIcon: Image.asset(AssetsManager.iconPassword),
                suffixIcon: Image.asset(AssetsManager.iconShowPassword),
              ),
              SizedBox(
                height: height * 0.02,
              ),
              CustomElevatedButton(
                  onButtonClicked: register,
                  text: AppLocalizations.of(context)!.create_account,
              ),
              SizedBox(
                height: height * 0.02,
              ),
              Text.rich(
                textAlign: TextAlign.center,
                  TextSpan(
                children:[
                  TextSpan(text: AppLocalizations.of(context)!
                  .already_have_account,
                      style: AppStyles.medium16Black),
                  TextSpan(
                    recognizer: TapGestureRecognizer()..onTap = (){
                      Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
                    },
                      text: AppLocalizations.of(context)!
                  .login,
                  style: AppStyles.bold16Primary.copyWith(
                    decoration: TextDecoration.underline,
                    decorationColor: AppColors.primaryLight,
                  )),
                ]
              )),


            ],
          ),
        ),
      ),
    );
  }

  void register(){
    Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);

  }
}
