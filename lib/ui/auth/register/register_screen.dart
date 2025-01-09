import 'package:event_planning_c13_sun3/firebase_utils.dart';
import 'package:event_planning_c13_sun3/model/myUser.dart';
import 'package:event_planning_c13_sun3/providers/event_list_provider.dart';
import 'package:event_planning_c13_sun3/utils/dialog_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import '../../../providers/user_provider.dart';
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
  var nameController = TextEditingController(text: 'Amira');
  var emailController = TextEditingController(text: 'amira@route.com');
  var passwordController = TextEditingController(text: '123456');
  var rePasswordController = TextEditingController(text: '123456');
  var formKey = GlobalKey<FormState>();
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
          child: Form(
            key: formKey,
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
                  controller: nameController,
                  validator: (text){
                    if(text == null || text.trim().isEmpty){
                      return 'Please enter name';
                    }
                    return null ;
                  },
                  hintText: AppLocalizations.of(context)!.name,
                  prefixIcon: Image.asset(AssetsManager.iconName),
                ),SizedBox(
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
                CustomTextField(
                  obscureText: true,
                  controller: rePasswordController,
                  keyboardType: TextInputType.number,
                  validator: (text){
                    if(text == null || text.trim().isEmpty){
                      return 'Please enter Re-password';
                    }
                    if(text.length < 6){
                      return 'Password should be at least 6 chars.';
                    }
                    if(text != passwordController.text){
                      return "Re-Password doesn't match password";
                    }
                    return null ;
                  },
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
      ),
    );
  }

  void register() async{
    if(formKey.currentState?.validate() == true){
      //todo: show loading
      DialogUtils.showLoading(context: context, message: 'Loading ...');
      try {
        final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        MyUser myUser = MyUser(
            id: credential.user?.uid??'',
            name: nameController.text,
            email: emailController.text
        );
        await FirebaseUtils.addUserToFireStore(myUser);

        var userProvider = Provider.of<UserProvider>(context,listen: false);
        var eventListProvider = Provider.of<EventListProvider>(context,listen: false);
        userProvider.updateUser(myUser);


        //todo: hide loading
        DialogUtils.hideLoading(context);
        // todo: show message
        DialogUtils.showMessage(context: context, message: 'Register Successfully',
            title: 'Success',posActionName: 'Ok',
            posAction: (){
          eventListProvider.changeSelectedIndex(0, userProvider.currentUser!.id);
          // eventListProvider.getAllEvents(userProvider.currentUser!.id);
              Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
            });
        print('register successfully.');
        print(credential.user?.uid??"");
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          //todo: hide loading
          DialogUtils.hideLoading(context);
          // todo: show message
          DialogUtils.showMessage(context: context, message: 'The password provided is too weak.',
              title: 'Error',posActionName: 'Ok');
          print('The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          //todo: hide loading
          DialogUtils.hideLoading(context);
          // todo: show message
          DialogUtils.showMessage(context: context, message: 'The account already exists for that email.',
              title: 'Error',posActionName: 'Ok');
          print('The account already exists for that email.');
        }else if (e.code == 'network-request-failed') {
          //todo: hide loading
          DialogUtils.hideLoading(context);
          // todo: show message
          DialogUtils.showMessage(context: context, message: 'A network error (such as timeout, '
              'interrupted connection or unreachable host) has occurred.',title: 'Error',posActionName: 'Ok');
          print('The supplied auth credential is incorrect, malformed or has expired.',
          );
        }
      } catch (e) {
        //todo: hide loading
        DialogUtils.hideLoading(context);
        // todo: show message
        DialogUtils.showMessage(context: context, message: e.toString(),
            title: 'Error',posActionName: 'Ok');
        print(e);
      }
    }
  }
}
