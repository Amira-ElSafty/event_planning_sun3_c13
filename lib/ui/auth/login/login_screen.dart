import 'package:event_planning_c13_sun3/firebase_utils.dart';
import 'package:event_planning_c13_sun3/providers/user_provider.dart';
import 'package:event_planning_c13_sun3/utils/dialog_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import '../../../providers/event_list_provider.dart';
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
  var emailController = TextEditingController(text: 'amira@route.com');
  var passwordController = TextEditingController(text: '123456');
  var formKey = GlobalKey<FormState>();
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
          child: Form(
            key: formKey,
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
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  validator: (text){
                    if(text == null || text.trim().isEmpty){
                      return 'Please enter email';
                    }
                    final bool emailValid =
                    RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                        .hasMatch(text);
                    if(!emailValid){
                      return 'Please enter valid email.';
                    }
                    return null ;
                  },
                  hintText: AppLocalizations.of(context)!.email,
                  prefixIcon: Image.asset(AssetsManager.iconEmail),
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                CustomTextField(
                  obscureText: true,
                  controller: passwordController,
                  keyboardType: TextInputType.phone,
                  validator: (text){
                    if(text == null || text.trim().isEmpty){
                      return 'Please enter password';
                    }
                    if(text.length < 6){
                      return 'Password should be at least 6 chars.';
                    }
                    return null ;
                  },
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
      ),
    );
  }

  void login()async{
    if(formKey.currentState?.validate() == true){
      //todo: show Loading
      DialogUtils.showLoading(context: context, message: 'Waiting ...');
      try {
        final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: emailController.text,
            password: passwordController.text
        );
        var user = await FirebaseUtils.readUserFromFireStore(credential.user?.uid??'');
        if(user == null){
          return ;
        }
        var userProvider = Provider.of<UserProvider>(context,listen: false);
        userProvider.updateUser(user);
        //todo: hide loading
        DialogUtils.hideLoading(context);
        // todo: show message
        DialogUtils.showMessage(context: context, message: 'Login Successfully.',
            title: 'Success',posActionName: 'Ok',
        posAction: (){
          var eventListProvider = Provider.of<EventListProvider>(context,listen: false);
          eventListProvider.changeSelectedIndex(0, userProvider.currentUser!.id);
          // eventListProvider.getAllEvents(userProvider.currentUser!.id);
          Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
        });
        print('login successfully.');
        print(credential.user?.uid??"");
      }
      on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          //todo: hide loading
          // todo: show message
          print('No user found for that email.');
        } else if (e.code == 'wrong-password') {
          //todo: hide loading
          // todo: show message
          print('Wrong password provided for that user.');
        }else if (e.code == 'invalid-credential') {
          //todo: hide loading
          DialogUtils.hideLoading(context);
          // todo: show message
          DialogUtils.showMessage(context: context, message: 'The supplied auth credential is incorrect,'
              ' malformed or has expired.',title: 'Error',posActionName: 'Ok');
          print('The supplied auth credential is incorrect, malformed or has expired.',
              );
        }else if (e.code == 'network-request-failed') {
          //todo: hide loading
          DialogUtils.hideLoading(context);
          // todo: show message
          DialogUtils.showMessage(context: context, message: 'A network error (such as timeout, '
              'interrupted connection or unreachable host) has occurred.',title: 'Error',posActionName: 'Ok');
          print('The supplied auth credential is incorrect, malformed or has expired.',
              );
        }
      }
      catch(e){
        //todo: hide loading
        DialogUtils.hideLoading(context);
        // todo: show message
        DialogUtils.showMessage(context: context, message: e.toString(),title: 'Error',posActionName: 'Ok');
        print(e.toString());
      }
    }
  }
}
