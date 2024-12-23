import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_styles.dart';
import '../../../utils/assets_manager.dart';
import '../../home_screen/home_screen.dart';
import '../../home_screen/tabs/widgets/custom_elevated_button.dart';
import '../../home_screen/tabs/widgets/custom_text_field.dart';
import '../register/register_screen.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = 'login_screen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: width * 0.02,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: height * 0.04,
              ),
              Image.asset(
                AssetsManager.logo,
                height: height * 0.25,
              ),
              SizedBox(
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
              TextButton(
                  onPressed: () {
                    //todo: navigate to forget password screen
                  },
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      AppLocalizations.of(context)!.forget_password,
                      style: AppStyles.bold16Primary.copyWith(
                          decoration: TextDecoration.underline,
                          decorationColor: AppColors.primaryLight),
                    ),
                  )),
              SizedBox(
                height: height * 0.02,
              ),
              CustomElevatedButton(
                  onButtonClicked: login,
                  text: AppLocalizations.of(context)!.login,
              ),
              SizedBox(
                height: height * 0.02,
              ),
              Text.rich(
                textAlign: TextAlign.center,
                  TextSpan(
                children:[
                  TextSpan(text: AppLocalizations.of(context)!
                  .do_not_have_an_account,
                      style: AppStyles.medium16Black),
                  TextSpan(
                    recognizer: TapGestureRecognizer()..onTap = (){
                      Navigator.of(context).pushNamed(RegisterScreen.routeName);
                    },
                      text: AppLocalizations.of(context)!
                  .create_account,
                  style: AppStyles.bold16Primary.copyWith(
                    decoration: TextDecoration.underline,
                    decorationColor: AppColors.primaryLight,
                  )),
                ]
              )),
              SizedBox(
                height: height * 0.02,
              ),
              Row(
                children: [
                  const Expanded(
                    child: Divider(
                      thickness: 2,
                      color: AppColors.primaryLight,
                      endIndent: 20,
                      indent: 20,
                    ),
                  ),
                  Text(AppLocalizations.of(context)!.or,
                  style: AppStyles.medium16Primary,),
                  const Expanded(
                    child: Divider(
                      endIndent: 20,
                      indent: 20,
                      thickness: 2,
                      color: AppColors.primaryLight,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: height * 0.02,
              ),
              CustomElevatedButton(onButtonClicked: (){
                //todo: login with google
              },
                  backgroundColor: AppColors.transparentColor,
                  textStyle: AppStyles.medium16Primary,
                  icon: Image.asset(AssetsManager.iconGoogle),
                  text: AppLocalizations.of(context)!.login_with_google)

            ],
          ),
        ),
      ),
    );
  }

  void login(){
    Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
  }
}
