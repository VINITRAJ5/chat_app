import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:chat_app/widgets/chat/message_bubble.dart';


class Massages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var FirebaseAuth;
        return FutureBuilder(
              future: FirebaseAuth.instance.currentUser(),
          builder: (ctx,futureSnapshot)
          {
            if(futureSnapshot.connectionState == ConnectionState.waiting)
            {
              return Center(child: CircularProgressIndicator(),
              );
            }
          
         return StreamBuilder(
             stream: FirebaseFirestore.instance.
             collection('chat')
            .orderBy('createdAt',
           descending: true,
           )
           .snapshots(),
             builder: (ctx, chatSnapshot)
             {
             if (chatSnapshot.connectionState == ConnectionState.waiting)
           {
           return Center(
             child: CircularProgressIndicator(),
            );
            }

            final chatDocs = chatSnapshot.data.document;
            return ListView.builder(
            reverse: true,
            itemCount: chatDocs.length,
            itemBuilder: (ctx, index) => MessageBubble(
              chatDocs[index] ['text'],
              chatDocs[index] ['username'],
              chatDocs[index] ['userImage'],
              chatDocs[index] ['userId'] == futureSnapshot.data.uid,
            key: ValueKey(chatDocs[index].documentID),
            ),
              
            );
          } 
        );
        
      },
    );
  }
}