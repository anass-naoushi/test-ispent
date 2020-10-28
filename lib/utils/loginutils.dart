import 'package:firebase_auth/firebase_auth.dart';

///This class contains all the functions related to the login page without any UI
class LogInUtils{
  ///This function logs in the user into his firebase account with provided creditials and navigates him to 
///the home page of the app.
static Future login(var logindata)async{
  FirebaseAuth auth =FirebaseAuth.instance;
  var data= await auth.signInWithEmailAndPassword(email:logindata['email'], password: logindata['password'].toString().trim()); 
  return data;
}
//This function checks for any empty field
// ignore: missing_return
static String fieldvalidation(String field,String text){
 if(text==null||text.isEmpty){
   return 'your $field cannot be empty';
 }
}
///Thi sfunctions checks a string for valid email format
  // ignore: missing_return
  static String verifyemail(String email){
     if(email==null|| email.trim().isEmpty){
      return 'your email can\'t be empty';
    }else if(!email.trim().contains('@')){
     return 'check the format of your email';
    }
  }
}