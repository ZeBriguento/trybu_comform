import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'auth/login_signup.dart';

class OnBoardingScreen extends StatelessWidget {
 
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      body: Container(
        width: double.infinity,
        child: Column(

          mainAxisAlignment: MainAxisAlignment.start,
           crossAxisAlignment: CrossAxisAlignment.center,

          children: [

            SizedBox(
              height: 50,
            ),

            Text("Bem Vindo a Trybo!",style: TextStyle(
              color: Colors.black,
              fontSize: 27,
              fontWeight: FontWeight.w700,
            ),),

            SizedBox(
              height: 5,
            ),

            Text("Aplicação de empreendedores",style: TextStyle(fontSize: 16),),

            SizedBox(
              height: 50,
            ),

            Padding(
              padding: EdgeInsets.only(left: 15,right: 15),
              child: Image.asset('assets/onboardIcon.png'),
            ),

            SizedBox(
              height: 50,
            ),


            Expanded(
              child: Container(
                width: double.infinity,

                decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 5,
                        spreadRadius: 2
                      )
                    ],
                    borderRadius: BorderRadius.only(topRight: Radius.circular(16),topLeft: Radius.circular(16))
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [



                    Padding(
                      padding: EdgeInsets.only(left: 15,right: 15),
                      child: Text("A plataforma de mídia social projetada para colocá-lo offline",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600
                        ),),
                    ),



                    Padding(
                      padding: EdgeInsets.only(left: 15,right: 15),
                      child: Text("EMS é um aplicativo onde os usuários podem aproveitar para criar, descobrir, compartilhar e monetizar eventos ou serviços.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.normal,

                        ),),
                    ),





                    Padding(
                      padding: EdgeInsets.only(
                        left: 15,
                        right: 15
                      ),
                      child: MaterialButton(
                        minWidth: double.infinity,
                        color: Colors.white,
                        elevation: 2,
                        onPressed: (){
                          Get.to(()=> LoginView());
                          },

                        child: Text("Iniciar",
                          style: TextStyle(
                              fontSize: 18,
                              color: Color(0xff274560),
                              fontWeight: FontWeight.w500
                          ),),),
                    )

                  ],
                ),
              ),
            ),

          ],

        ),
      ),
    ));
  }
}
