import 'dart:ui';

import 'package:trybu_comform/controller/auth_controller.dart';
import 'package:trybu_comform/views/profile/add_profile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/app_color.dart';
import '../../widgets/my_widgets.dart';

class LoginView extends StatefulWidget {
  LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {


  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  int selectedRadio = 0;
  TextEditingController forgetEmailController = TextEditingController();

  void setSelectedRadio(int val) {
    setState(() {
      selectedRadio = val;
    });
  }

  bool isSignUp = false;

  late AuthController authController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    authController = Get.put(AuthController());

  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: Get.width * 0.05),
            child: Column(
              children: [
                SizedBox(
                  height: Get.height * 0.08,
                ),
                isSignUp
                    ? myText(
                  text: 'Sign Up',
                  style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.w600,
                  ),
                )
                    : myText(
                  text: 'Login',
                  style: GoogleFonts.poppins(
                    fontSize: 23,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.03,
                ),
                isSignUp
                    ? Container(
                  child: myText(
                    text:
                    'Bem-vindo, por favor, inscreva-se para ver eventos',
                    style: GoogleFonts.roboto(
                      letterSpacing: 0,
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.center,
                  ),
                )
                    : Container(
                  child: myText(
                    text:
                    'Bem-vindo de volta, fa??a login e continue sua jornada conosco.',
                    style: GoogleFonts.roboto(
                      letterSpacing: 0,
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.03,
                ),
                Container(
                  width: Get.width * 0.55,
                  child: TabBar(
                    labelPadding: EdgeInsets.all(Get.height * 0.01),
                    unselectedLabelColor: Colors.grey,
                    labelColor: Colors.black,
                    indicatorColor: Colors.black,
                    onTap: (v) {
                      setState(() {
                        isSignUp = !isSignUp;
                      });
                    },
                    tabs: [
                      myText(
                        text: 'Login',
                        style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w500,
                            color: AppColors.black),
                      ),
                      myText(
                        text: 'Sign Up',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w500,
                          color: AppColors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.04,
                ),
                Container(
                  width: Get.width,
                  height: Get.height * 0.6,
                  child: Form(
                    key: formKey,
                    child: TabBarView(
                      physics: NeverScrollableScrollPhysics(),
                      children: [
                        LoginWidget(),
                        SignUpWidget(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }


  Widget LoginWidget(){
    return SingleChildScrollView(
      child: Column(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              myTextField(
                  bool: false,
                  icon: 'assets/mail.png',
                  text: 'sarasmith12@gmail.com',
                  validator: (String input){
                    if(input.isEmpty){
                      Get.snackbar('Warning', 'Email is required.',colorText: Colors.white,backgroundColor: Colors.blue);
                      return '';
                    }

                    if(!input.contains('@')){
                      Get.snackbar('Aviso', 'E-mail obrigat??rio',colorText: Colors.white,backgroundColor: Colors.blue);
                      return '';
                    }
                  },
                  controller: emailController
              ),
              SizedBox(
                height: Get.height * 0.02,
              ),
              myTextField(
                  bool: true,
                  icon: 'assets/lock.png',
                  text: 'password',
                  validator: (String input){
                    if(input.isEmpty){
                      Get.snackbar('Aviso', 'Senha obrigat??rio',colorText: Colors.white,backgroundColor: Colors.blue);
                      return '';
                    }

                    if(input.length <6){
                      Get.snackbar('Aviso', 'A senha deve ter mais de 6 caracteres',colorText: Colors.white,backgroundColor: Colors.blue);
                      return '';
                    }
                  },
                  controller: passwordController
              ),
              InkWell(
                onTap: () {
                  Get.defaultDialog(
                    title: 'Esqueceu a senha?',
                    content: Container(
                      width: Get.width,
                      child: Column(
                        children: [
                          myTextField(
                              bool: false,
                              icon: 'assets/lock.png',
                              text: 'Digite seu e-mail...',
                              controller: forgetEmailController
                          ),

                          SizedBox(
                            height: 10,
                          ),

                          MaterialButton(
                            color: Colors.blue,
                            onPressed: (){
                              authController.forgetPassword(forgetEmailController.text.trim());
                            },child: Text("Sent"),minWidth: double.infinity,)

                        ],
                      ),
                    )
                  );
                },
                child: Container(
                  margin: EdgeInsets.only(
                    top: Get.height * 0.02,
                  ),
                  child: myText(
                      text: 'Esqueceu sua senha?',
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.w400,
                        color: AppColors.black,
                      )),
                ),
              ),
            ],
          ),
          Obx(()=> authController.isLoading.value? Center(child: CircularProgressIndicator(),) :Container(
            height: 50,
            margin: EdgeInsets.symmetric(
                vertical: Get.height * 0.04),
            width: Get.width,
            child: elevatedButton(
              text: 'Login',
              onpress: () {

                if(!formKey.currentState!.validate()){
                  return;
                }

                authController.login(email: emailController.text.trim(),password: passwordController.text.trim());


              },
            ),
          )),
          SizedBox(
            height: Get.height * 0.02,
          ),
          myText(
            text: 'Ou conecte-se com',
            style: TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.w400,
              color: AppColors.black,
            ),
          ),
          SizedBox(
            height: Get.height * 0.01,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              socialAppsIcons(
                  text: 'assets/fb.png',
                  onPressed: (){

                    Get.to(()=> ProfileScreen());

                  }
              ),

              socialAppsIcons(
                  text: 'assets/google.png',
                  onPressed: (){

                    authController.signInWithGoogle();

                  }

              ),
            ],
          )
        ],
      ),
    );
  }

  Widget SignUpWidget(){
    return SingleChildScrollView(
        child: Column(
          children: [


            myTextField(
                bool: false,
                icon: 'assets/mail.png',
                text: 'Email',
                validator: (String input){
                  if(input.isEmpty){
                    Get.snackbar('Aviso', 'E-mail obrigat??rio.',colorText: Colors.white,backgroundColor: Colors.blue);
                    return '';
                  }

                  if(!input.contains('@')){
                    Get.snackbar('Aviso', 'E-mail inv??lido.',colorText: Colors.white,backgroundColor: Colors.blue);
                    return '';
                  }
                },
                controller: emailController
            ),
            SizedBox(
              height: Get.height * 0.02,
            ),
            myTextField(
                bool: true,
                icon: 'assets/lock.png',
                text: 'password',
                validator: (String input){
                  if(input.isEmpty){
                    Get.snackbar('Aviso', 'Senha necess??ria',colorText: Colors.white,backgroundColor: Colors.blue);
                    return '';
                  }

                  if(input.length <6){
                    Get.snackbar('Aviso', 'A senha deve ter mais de 6 caracteres.',colorText: Colors.white,backgroundColor: Colors.blue);
                    return '';
                  }
                },
                controller: passwordController
            ),
            SizedBox(
              height: Get.height * 0.02,
            ),
            myTextField(
                bool: false,
                icon: 'assets/lock.png',
                text: 'Digite novamente a senha',
                validator: (input){
                  if(input != passwordController.text.trim()){
                    Get.snackbar('Aviso', 'Confirmar senha n??o ?? o mesmo que senha.',colorText: Colors.white,backgroundColor: Colors.blue);
                    return '';
                  }
                },
                controller: confirmPasswordController
            ),
           Obx(()=> authController.isLoading.value? Center(child: CircularProgressIndicator(),) : Container(
             height: 50,
             margin: EdgeInsets.symmetric(
               vertical: Get.height * 0.04,
             ),
             width: Get.width,
             child: elevatedButton(
               text: 'Sign Up',
               onpress: () {

                 if(!formKey.currentState!.validate()){
                   return;
                 }

                 authController.signUp(email: emailController.text.trim(),password: passwordController.text.trim());



               },
             ),
           )),
            myText(
              text: 'Ou conecte-se com',
              style: TextStyle(
                fontSize: Get.height * 0.025,
              ),
            ),
            SizedBox(
              height: Get.height * 0.01,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                socialAppsIcons(
                    text: 'assets/fb.png',
                    onPressed: (){
                    }
                ),

                socialAppsIcons(
                    text: 'assets/google.png',
                    onPressed: (){
                    }
                ),
              ],
            ),
            SizedBox(
              height: Get.height * 0.02,
            ),
            Container(
                width: Get.width * 0.8,
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(children: [
                    TextSpan(
                        text:
                        'Ao se inscrever, voc?? concorda com nossos ',
                        style: TextStyle(
                            color: Color(0xff262628),
                            fontSize: 12)),
                    TextSpan(
                        text:
                        'termos, pol??tica de dados e pol??tica de cookies',
                        style: TextStyle(
                            color: Color(0xff262628),
                            fontSize: 12,
                            fontWeight: FontWeight.bold)),
                  ]),
                )),
          ],
        )

    );
  }

}
