import 'package:flutter/material.dart';
import 'package:chat_app/screens/chat_screen.dart';
import 'package:chat_app/screens/auth_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(ChatApp());
}
class ChatApp extends StatelessWidget {
  
  @override
  
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ChatApp',
      theme: ThemeData(
       
        primarySwatch: Colors.blue,
        backgroundColor: Colors.blue,
        accentColor: Colors.deepOrange,
        accentColorBrightness: Brightness.dark,
        buttonTheme: ButtonTheme.of(context).copyWith(
          buttonColor: Color.fromRGBO(45, 65, 45, 40),
          textTheme: ButtonTextTheme.primary,
          shape:RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
      home: StreamBuilder(stream: FirebaseAuth.instance
      .onAuthStateChanged,
       builder: (ctx,userSnapshot)
       {
      if (userSnapshot.hasData)
      {
        return ChatScreen();
      }
      return AuthScreen();
      }
      ),
      );
  }
  
}
      
      