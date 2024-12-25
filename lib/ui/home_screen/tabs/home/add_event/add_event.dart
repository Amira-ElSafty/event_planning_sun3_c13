import 'package:event_planning_c13_sun3/ui/home_screen/tabs/home/tab_event_widget.dart';
import 'package:event_planning_c13_sun3/ui/home_screen/tabs/widgets/choose_date_or_time.dart';
import 'package:event_planning_c13_sun3/ui/home_screen/tabs/widgets/custom_elevated_button.dart';
import 'package:event_planning_c13_sun3/ui/home_screen/tabs/widgets/custom_text_field.dart';
import 'package:event_planning_c13_sun3/utils/app_colors.dart';
import 'package:event_planning_c13_sun3/utils/app_styles.dart';
import 'package:event_planning_c13_sun3/utils/assets_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
class AddEvent extends StatefulWidget {
  static const String routeName = 'add_event';

  @override
  State<AddEvent> createState() => _AddEventState();
}

class _AddEventState extends State<AddEvent> {
  //todo: save image , save event name
  int selectedIndex = 0 ;
  var formKey = GlobalKey<FormState>();
  var titleController = TextEditingController();   // title
  var descriptionController = TextEditingController();  // desc
  DateTime? selectedDate ;
  String formatedDate = '';
  TimeOfDay? selectedTime ;
  String? formatedTime ;     /// =>
  String selectedImage = '';   /// image
  String selectedEventName = '';   /// event name

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    List<String> eventsNameList = [
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
    List<String> imageSelectedNameList = [
      AssetsManager.sportImage,
      AssetsManager.birthdayImage,
      AssetsManager.meetingImage,
      AssetsManager.gamingImage,
      AssetsManager.workshopImage,
      AssetsManager.bookClubImage,
      AssetsManager.exhibitionImage,
      AssetsManager.holidayImage,
      AssetsManager.eatingImage,
    ];
    Map<String,String> mapList = {
      AppLocalizations.of(context)!.sport:AssetsManager.sportImage,
      AppLocalizations.of(context)!.birthday:AssetsManager.birthdayImage,
      AppLocalizations.of(context)!.meeting:AssetsManager.meetingImage,
      AppLocalizations.of(context)!.gaming:AssetsManager.gamingImage,
      AppLocalizations.of(context)!.workshop:AssetsManager.workshopImage,
      AppLocalizations.of(context)!.book_club:AssetsManager.bookClubImage,
      AppLocalizations.of(context)!.exhibition:AssetsManager.exhibitionImage,
      AppLocalizations.of(context)!.holiday:AssetsManager.holidayImage,
      AppLocalizations.of(context)!.eating:AssetsManager.eatingImage,
    };
    selectedImage = imageSelectedNameList[selectedIndex];
    selectedEventName = eventsNameList[selectedIndex] ;
    print('selectedImage : $selectedImage');
    print('selectedEventName : $selectedEventName');
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: AppColors.primaryLight
        ),
        title: Text(AppLocalizations.of(context)!.create_event,
        style: AppStyles.medium20Primary,),
      ),
      body: Padding(
        padding:  EdgeInsets.symmetric(
          horizontal: width*0.04
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                    // mapList[eventsNameList[selectedIndex]]!
                    imageSelectedNameList[selectedIndex]
                ),
              ),
              SizedBox(height: height*0.02,),
              SizedBox(
                height: height * 0.05,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                    itemBuilder: (context,index){
                      return InkWell(
                        onTap: (){
                          selectedIndex = index ;
                          setState(() {
          
                          });
                        },
                        child: TabEventWidget(
                          borderColor: AppColors.primaryLight,
                            backgroundColor: AppColors.primaryLight,
                            textSelectedStyle: AppStyles.medium16White,
                            textUnSelectedStyle: AppStyles.medium16Primary,
                            isSelected: selectedIndex == index  ,
                            eventName: eventsNameList[index]
                        ),
                      );
                    },
                    separatorBuilder: (context,index){
                      return SizedBox(width: width*0.02,);
                    },
                    itemCount: eventsNameList.length
                ),
              ),
              SizedBox(height: height*0.02,),
              Form(
                  key: formKey,
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(AppLocalizations.of(context)!.title,
                    style: AppStyles.medium16Black,),
                  SizedBox(height: height*0.02,),
                  CustomTextField(
                    controller: titleController,
                    validator: (text){
                      if(text == null || text.isEmpty){
                        return 'Please enter event title';   // invalid
                      }
                      return null ;   // valid
                    },
                    hintText: AppLocalizations.of(context)!.event_title,
                    prefixIcon: Image.asset(AssetsManager.iconEdit),
                  ),
                  SizedBox(height: height*0.02,),
                  Text(AppLocalizations.of(context)!.description,
                    style: AppStyles.medium16Black,),
                  SizedBox(height: height*0.02,),
                  CustomTextField(
                    controller: descriptionController,
                    validator: (text){
                      if(text == null || text.isEmpty){
                        return 'Please enter event description';   // invalid
                      }
                      return null ;   // valid
                    },
                    maxLines: 4,
                    hintText: AppLocalizations.of(context)!.event_description,
                  ),
                  SizedBox(height: height*0.02,),
                  ChooseDateOrTime(
                      iconName: AssetsManager.iconDate,
                      eventDateOrTime: AppLocalizations.of(context)!.event_date,
                      chooseDateOrTime: selectedDate == null ?
                      AppLocalizations.of(context)!.choose_date:formatedDate
                          // '${selectedDate!.day}/${selectedDate!.month}/'
                          //     '${selectedDate!.year}'
                      , onChooseDateOrTime: chooseDate
                  ),
                  ChooseDateOrTime(
                      iconName: AssetsManager.iconTime,
                      eventDateOrTime: AppLocalizations.of(context)!.event_time,
                      chooseDateOrTime: selectedTime == null ?
                      AppLocalizations.of(context)!.choose_time:
                          formatedTime!
                      , onChooseDateOrTime: chooseTime
                  ),
                  SizedBox(height: height*0.02,),
                  Text(AppLocalizations.of(context)!.location,
                    style: AppStyles.medium16Black,),
                  SizedBox(height: height*0.02,),
                  Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: width * 0.02,
                        vertical: height * 0.01
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                            color: AppColors.primaryLight,
                            width: 2
                        )
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: width * 0.02,
                              vertical: height * 0.01
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.primaryLight,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Image.asset(AssetsManager.iconLocation),
                        ),
                        SizedBox(width: width*0.02,),
                        Expanded(
                          child: Text(AppLocalizations.of(context)!.choose_event_location,
                            style: AppStyles.medium16Primary,),
                        ),
                        Icon(Icons.arrow_forward_ios_outlined,color: AppColors.primaryLight,)
                      ],
                    ),
                  ),
                  SizedBox(height: height*0.02,),
                  CustomElevatedButton(onButtonClicked: addEvent,
                      text: AppLocalizations.of(context)!.add_event
                  )
                ],
              ))

            ],
          ),
        ),
      ),
    );
  }
  void addEvent(){

    if(formKey.currentState?.validate() == true){
      if(selectedDate == null || selectedTime == null ){

      }
      //todo: add event
    }

  }
  void chooseDate()async{
   var chooseDate = await  showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 365))
    );
   selectedDate = chooseDate ;
   // selectedDate = DateFormat('dd/MM/yyyy').format(chooseDate!);
   formatedDate = DateFormat('dd/MM/yyyy').format(selectedDate!);
   setState(() {

   });
  }
  void chooseTime()async{
    var chooseTime = await showTimePicker(context: context, initialTime: TimeOfDay.now());
    selectedTime = chooseTime ;
    formatedTime = selectedTime!.format(context);
    setState(() {

    });
  }
}
