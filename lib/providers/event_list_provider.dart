import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_planning_c13_sun3/utils/flutter_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../firebase_utils.dart';
import '../model/event.dart';

class EventListProvider extends ChangeNotifier{
  // data
  List<Event> eventsList = [];
  int selectedIndex = 0 ;
  List<String> eventsNameList = [];
  List<Event> filterEventsList = [];  // filter
  List<Event> favoriteEventList = [];  // favorite
  Map<String,String> localizationEnMap = {};
  Map<String,String> localizationArMap = {};

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

    localizationEnMap = {
      AppLocalizations.of(context)!.all : 'All',
      AppLocalizations.of(context)!.sport : 'Sport',
      AppLocalizations.of(context)!.birthday :'Birthday',
      AppLocalizations.of(context)!.meeting  :'Meeting',
      AppLocalizations.of(context)!.gaming :'Gaming',
      AppLocalizations.of(context)!.workshop : 'WorkShop',
      AppLocalizations.of(context)!.book_club : 'Book Club',
      AppLocalizations.of(context)!.exhibition :'Exhibition',
      AppLocalizations.of(context)!.holiday :  'Holiday',
      AppLocalizations.of(context)!.eating :  'Eating'
    };
    localizationArMap = {
      AppLocalizations.of(context)!.all : "الكل",
      AppLocalizations.of(context)!.sport : 'رياضة',
      AppLocalizations.of(context)!.birthday :'عيد الميلاد',
      AppLocalizations.of(context)!.meeting  :'اجتماع',
      AppLocalizations.of(context)!.gaming :'ألعاب',
      AppLocalizations.of(context)!.workshop : 'ورشة عمل',
      AppLocalizations.of(context)!.book_club : 'نادي الكتاب',
      AppLocalizations.of(context)!.exhibition :'معرض',
      AppLocalizations.of(context)!.holiday :  'إجازة',
      AppLocalizations.of(context)!.eating :  'تناول الطعام'
    };
  }



  void getAllEvents(String uId)async{
    QuerySnapshot<Event> querySnapshot = await FirebaseUtils.getEventCollection(uId).get();
    //  List<Event>  List<QueryDocumentSnapshot<Event>>
    eventsList = querySnapshot.docs.map((doc){
      return doc.data();
    }).toList() ;
    //todo: sorting
    filterEventsList.sort((Event event1 , Event event2){
      return event1.dateTime.compareTo(event2.dateTime);
    });
    filterEventsList = eventsList ;

    notifyListeners();

  }
  void getFilterEvents(String uId)async{
    QuerySnapshot<Event> querySnapshot = await FirebaseUtils.getEventCollection(uId).get();
    //  List<Event>  List<QueryDocumentSnapshot<Event>>
    eventsList = querySnapshot.docs.map((doc){
      return doc.data();
    }).toList() ;

    //todo: filter all events
    filterEventsList = eventsList.where((event){
      return (event.eventName == localizationEnMap[eventsNameList[selectedIndex]]) ||
          (event.eventName == localizationArMap[eventsNameList[selectedIndex]]);
    }).toList();

    //todo: sorting
    filterEventsList.sort((Event event1 , Event event2){
      return event1.dateTime.compareTo(event2.dateTime);
    });
    notifyListeners();

  }


  void getFilterEvents1(String uId)async{
    QuerySnapshot<Event> querySnapshot = await FirebaseUtils.getEventCollection(uId).
    orderBy('dateTime',descending: false)
    .where('eventName',isEqualTo: eventsNameList[selectedIndex])
        .get();
    //  List<Event>  List<QueryDocumentSnapshot<Event>>
    filterEventsList = querySnapshot.docs.map((doc){
      return doc.data();
    }).toList() ;

    notifyListeners();

  }

  void updateFavoriteEvent(Event event,String uId){
    FirebaseUtils.getEventCollection(uId).doc(event.id)
        .update({'isFavorite': !event.isFavorite}).then((value){
      print('updated successfully.');
      ToastMessage.toastMsg('Event Updated Successfully.');
      selectedIndex == 0 ?getAllEvents(uId) : getFilterEvents(uId);
      getFavoriteEvents(uId);
    })
        .timeout(
      Duration(milliseconds: 500),onTimeout: (){
        print('updated successfully.');
        selectedIndex == 0 ?getAllEvents(uId) : getFilterEvents(uId);
        getFavoriteEvents(uId);
    }
    );
  }

  void getFavoriteEvents(String uId)async{
    var querySnapshot = await FirebaseUtils.getEventCollection(uId)
    .orderBy('dateTime').where('isFavorite',isEqualTo: true)
        .get();
    favoriteEventList = querySnapshot.docs.map((doc){
      return doc.data();
    }).toList();
    notifyListeners();
  }

  void changeSelectedIndex(int newSelectedIndex, String uId){
    selectedIndex = newSelectedIndex ;
    if(selectedIndex == 0){
      getAllEvents(uId);
    }else{
      getFilterEvents(uId);
    }
  }


}