import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_planning_c13_sun3/model/event.dart';
import 'package:event_planning_c13_sun3/model/myUser.dart';

class FirebaseUtils{
  static CollectionReference<Event> getEventCollection(String uId){
    return getUsersCollection().doc(uId)
        .collection(Event.collectionName).
    withConverter<Event>(
        fromFirestore: (snapshot,options)=> Event.fromFireStore(snapshot.data()),
        toFirestore: (event,_) => event.toFireStore()
    );
  }

  static CollectionReference<MyUser> getUsersCollection(){
    return FirebaseFirestore.instance.collection(MyUser.collectionName)
        .withConverter<MyUser>(
        fromFirestore: (snapShot,option) => MyUser.fromFireStore(snapShot.data()),
        toFirestore: (user,options) => user.toFireStore()
    );
  }

  static Future<void> addUserToFireStore(MyUser myUser){
    return getUsersCollection().doc(myUser.id).set(myUser);
  }
  static Future<MyUser?> readUserFromFireStore(String id)async{
   var querySnapshot = await  getUsersCollection().doc(id).get();
   return querySnapshot.data();
  }

  static Future<void> addEventToFireStore(Event event,String uId){
    CollectionReference<Event> collectionRef =  getEventCollection(uId);   // collection
    DocumentReference<Event> documentRef = collectionRef.doc();   // document
    event.id = documentRef.id ;    // auto id
    return documentRef.set(event);
  }
}
/*
json =>
{} , []
firebase  => json
developers => object

json => object
object => json
 */