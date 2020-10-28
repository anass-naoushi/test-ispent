import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:recruit_test/home/homepage.dart';
import 'package:recruit_test/utils/loginutils.dart';

class LogIn extends StatefulWidget {
  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  Map userlogindetals={};
  bool loading=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButton: FloatingActionButton(
      //   onPressed: ()async{
      //     print('getting data');
      //     var data= await FirebaseFirestore.instance.collection('testdata').get();
      //     print('testdata:${data.docs[0].data()}'); 
      //   },
      // ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
             key: formKey,
             child: Column(
               mainAxisAlignment: MainAxisAlignment.center,
               children: [
                 
                 
             Padding(
              padding: const EdgeInsets.only(left:60.0,right: 60,bottom:20),
              child: TextFormField(
                obscureText: false,
    textAlign: TextAlign.center,
   // controller: searchCtrl,
    keyboardType: TextInputType.text,
    decoration: InputDecoration(
        hintText: 'Email',
        hintStyle: TextStyle(fontSize: 16),
        border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(24),
                borderSide: BorderSide(
                    width: 0, 
                    style: BorderStyle.none,
                ),
        ),
        filled: true,
        contentPadding: EdgeInsets.all(16),
       // fillColor: Colors.white
    ),
    onChanged: (email){
      userlogindetals.addAll({
        'email':email.trim()
      });
    },
    validator: (email){
      return LogInUtils.verifyemail(email);
    },
),
            ),
             Padding(
              padding: const EdgeInsets.only(left:60.0,right: 60),
              child: TextFormField(
                obscureText: true,
    textAlign: TextAlign.center,
   // controller: searchCtrl,
    keyboardType: TextInputType.text,
    decoration: InputDecoration(
        hintText: 'Password',
        hintStyle: TextStyle(fontSize: 16),
        border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(24),
                borderSide: BorderSide(
                    width: 0, 
                    style: BorderStyle.none,
                ),
        ),
        filled: true,
        contentPadding: EdgeInsets.all(16),
       // fillColor: Colors.white
    ),
    onChanged: (password){
      userlogindetals.addAll({
        'password':password
      });
    },
    validator: (password){
      return LogInUtils.fieldvalidation('password', password);
    },
),
            ),
               ],
             ),
         ),
          ),
         Padding(
           padding: const EdgeInsets.all(8.0),
           child: Row(
             crossAxisAlignment: CrossAxisAlignment.center,
             mainAxisAlignment: MainAxisAlignment.center,
             children: [
               RaisedButton(
                 shape: RoundedRectangleBorder(
                   borderRadius: BorderRadius.circular(24)
                 ),
                 color: Theme.of(context).accentColor,
                 child: !loading?Text('Login',style: TextStyle(color: Colors.white),):Padding(
                   padding: const EdgeInsets.all(8.0),
                   child: CircularProgressIndicator(
                     backgroundColor: Colors.white,
                   ),
                 ),
                 onPressed: () async {
                   if(formKey.currentState.validate()){
                     

                  loading=true;
                  setState(() {
                    
                  });
                  try{
                    await  LogInUtils.login(userlogindetals);
                    loading=false;
                    setState(() {
                      
                    });
                    Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MainHome()),
                        );
                  }catch(e){
                     print(e);
                           loading=false;
                           setState(() {
                             
                           });
                           if(e.toString().contains('There is no user record corresponding to this identifier')){
                             FlushbarHelper.createError(message: 'wrong username or password').show(context);
                           }else if(e.toString().contains('The email address is badly formatted.')){
                             FlushbarHelper.createError(message: 'Check the format of your email').show(context);
                           }
                           else{
                             FlushbarHelper.createError(message: 'Unable to sign in').show(context);
                           }
                  }
                   }else{
                     FlushbarHelper.createError(message: 'Please fill in the fields properly').show(context);
                   }
                 },
               ),
             ],
           ),
         )
        ],
      ),
    );
  }
}