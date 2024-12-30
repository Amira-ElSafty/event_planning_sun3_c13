import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../firebase_utils.dart';
import '../model/event.dart';

class EventListProvider extends ChangeNotifier{
  // data
  List<Event> eventsList = [];
  int selectedIndex = 0 ;
  List<String> eventsNameList = [];
  List<Event> filterEventsList = [];

  void getEventsNameList(BuildContext context){
    eventsNameList = [
      AppLocalizations.of(context)!.all,
      AppLocalizations.of(context)!.sport,
      AppLocalizations.of(context)!.birthday,
      AppLocalizations.of(context)!.meeting,
      AppLocalizations.of(context)!.gaming,
      AppLocalizations.of(context)!.workshop,
      AppLocalizations.of(context)!.book_club,
      AppLocalizations.of(context)!.exhibition,
      AppLocalizations.of(context)!.holiday,
      AppLocalizations.of(context)!.eating,
    ];
  }



  void getAllEvents()async{
    QuerySnapshot<Event> querySnapshot = await FirebaseUtils.getEventCollection().get();
    //  List<Event>  List<QueryDocumentSnapshot<Event>>
    eventsList = querySnapshot.docs.map((doc){
      return doc.data();
    }).toList() ;
    filterEventsList = eventsList ;
    //todo: sorting
    filterEventsList.sort((Event event1 , Event event2){
      return event1.dateTime.compareTo(event2.dateTime);
    });
    notifyListeners();

  }
  void getFilterEvents()async{
    QuerySnapshot<Event> querySnapshot = await FirebaseUtils.getEventCollection().get();
    //  List<Event>  List<QueryDocumentSnapshot<Event>>
    eventsList = querySnapshot.docs.map((doc){
      return doc.data();
    }).toList() ;

    //todo: filter all events
    filterEventsList = eventsList.where((event){
      return event.eventName == eventsNameList[selectedIndex];
    }).toList();

    //todo: sorting
    filterEventsList.sort((Event event1 , Event event2){
      return event1.dateTime.compareTo(event2.dateTime);
    });
    notifyListeners();

  }

  void getFilterEvents1()async{
    QuerySnapshot<Event> querySnapshot = await FirebaseUtils.getEventCollection().
    orderBy('dateTime',descending: false)
    .where('eventName',isEqualTo: eventsNameList[selectedIndex])
        .get();
    //  List<Event>  List<QueryDocumentSnapshot<Event>>
    filterEventsList = querySnapshot.docs.map((doc){
      return doc.data();
    }).toList() ;

    notifyListeners();

  }

  void changeSelectedIndex(int newSelectedIndex){
    selectedIndex = newSelectedIndex ;
    if(selectedIndex == 0){
      getAllEvents();
    }else{
      getFilterEvents();
    }
  }


}