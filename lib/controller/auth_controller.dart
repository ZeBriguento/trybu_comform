import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../views/bottom_nav_bar/bottom_bar_view.dart';
import '../views/profile/add_profile.dart';
import 'package:path/path.dart' as Path;

class AuthController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;

  var isLoading = false.obs;

  void login({String? email, String? password}) {
    isLoading(true);

    auth
        .signInWithEmailAndPassword(email: email!, password: password!)
        .then((value) {
      /// Login Success

      isLoading(false);
      Get.to(() => BottomBarView());
    }).catchError((e) {
      isLoading(false);
      Get.snackbar('Error', "$e");

      ///Error occured
    });
  }

  void signUp({String? email, String? password}) {
    ///here we have to provide two things
    ///1- email
    ///2- password

    isLoading(true);

    auth
        .createUserWithEmailAndPassword(email: email!, password: password!)
        .then((value) {
      isLoading(false);

      /// Navigate user to profile screen
      Get.to(() => ProfileScreen());
    }).catchError((e) {
      /// print error information
      print("Erro de autenticação $e");
      isLoading(false);
    });
  }

  void forgetPassword(String email) {
    auth.sendPasswordResetEmail(email: email).then((value) {
      Get.back();
      Get.snackbar('E-mail enviado', 'Enviamos um e-mail de redefinição de senha');
    }).catchError((e) {
      print("Erro ao enviar e-mail de redefinição de senha é $e");
    });
  }

  signInWithGoogle() async {
    isLoading(true);
    // Acionar o fluxo de autenticação
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtenha os detalhes de autenticação da solicitação
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Criar uma nova credencial
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Uma vez conectado, retorne o UserCredential
    FirebaseAuth.instance.signInWithCredential(credential).then((value) {
      isLoading(false);

      ///Logado com sucesso
      Get.to(() => BottomBarView());
    }).catchError((e) {
      /// Erro ao obter Login
      isLoading(false);
      print("O erro é$e");
    });
  }


  var isProfileInformationLoading = false.obs;

  Future<String> uploadImageToFirebaseStorage(File image) async {
    String imageUrl = '';
    String fileName = Path.basename(image.path);

    var reference =
        FirebaseStorage.instance.ref().child('profileImages/$fileName');
    UploadTask uploadTask = reference.putFile(image);
    TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
    await taskSnapshot.ref.getDownloadURL().then((value) {
      imageUrl = value;
    }).catchError((e) {
      print("Ocorreu um erro $e");
    });

    return imageUrl;
  }




  uploadProfileData(String imageUrl, String firstName, String lastName,
      String mobileNumber, String dob, String gender) {

    String uid = FirebaseAuth.instance.currentUser!.uid;

    FirebaseFirestore.instance.collection('users').doc(uid).set({
      'image': imageUrl,
      'first': firstName,
      'last': lastName,
      'dob': dob,
      'gender': gender
    }).then((value) {
      isProfileInformationLoading(false);
      Get.offAll(()=> BottomBarView());
    });

  }
}
