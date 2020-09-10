import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:chat_app/widgets/auth/auth_form.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _auth = FirebaseAuth.instance;
  var _isLoading = false;
   

  void _submitAuthForm(
    String email,
    String password,
    String username,
    File image,
    bool isLogin,
    BuildContext ctx, 
  )
    async {
       var authResult;
    
    try{
      setState(() {
        _isLoading = true;
      }
      );
      if (isLogin)
    {
      authResult = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    }
      else 
      {
        authResult = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
        );

       final ref = FirebaseStorage.instance
       .ref()
       .child('user_image')
       .child(authResult.user.uid+ '.jpg');

       await ref.putFile(image).onComplete;

       final url = await ref.getDownloadURL();

      await FirebaseFirestore.instance
       .collection('user')
       .doc(authResult.user.uid)
       .set({
         'username': username,
         'email': email,
         'image_url':url,
       });
      }
  }

    on PlatformException catch (err) {
      var massage = 'An error Occurred,check Crendetials!';

      if (err.message != null)
      {
        massage = err.message;
      }

        Scaffold.of(ctx).showSnackBar(
          SnackBar(
              content: Text(massage),
              backgroundColor: Theme.of(ctx).errorColor,
            ),
          );
          setState(() {
            _isLoading = false;  
          });
    }
      catch (err)
      {
        print(err);
        setState(() {
          _isLoading = false;
        });
      }
    }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: AuthForm(
        _submitAuthForm,
        _isLoading,
        ),
      );
  }
}