import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_planning_c13_sun3/model/event.dart';

class FirebaseUtils{
  static CollectionReference<Event> getEventCollection(){
    return FirebaseFirestore.instance.collection(Event.collectionName).
    withConverter<Event>(
        fromFirestore: (snapshot,options)=> Event.fromFireStore(snapshot.data()),
        toFirestore: (event,_) => event.toFireStore()
    );
  }

  static Future<void> addEventToFireStore(Event event){
    CollectionReference<Event> collectionRef =  getEventCollection();   // collection
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