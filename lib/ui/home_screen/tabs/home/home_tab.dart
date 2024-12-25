import 'package:event_planning_c13_sun3/ui/home_screen/tabs/home/tab_event_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_styles.dart';
import '../../../../utils/assets_manager.dart';
import 'event_item_widget.dart';
class HomeTab extends StatefulWidget {
  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  int selectedIndex = 0 ;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height ;
    var width = MediaQuery.of(context).size.width ;
    List<String> eventsNameList = [
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryLight,
        actions: [
          const Icon(Icons.sunny,color: AppColors.whiteColor,),
          SizedBox(width: width*0.02,),
          Container(
            padding: EdgeInsets.symmetric(
                horizontal: width*0.02,
                vertical: height*0.01
            ),
            margin: EdgeInsets.only(right: width*0.02,),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: AppColors.whiteColor
            ),
            child: Text('EN',
              style: AppStyles.bold14Primary,),
          )
        ],
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(AppLocalizations.of(context)!.welcome_back,
            style: AppStyles.regular14White,),
            Text('Route Academy',
            style: AppStyles.bold24White,),
          ],
        ),
      ),
      body: Column(
        children: [
          Container(
            height: height * 0.12,
            padding: EdgeInsets.symmetric(
              horizontal: width*0.04,
              vertical: height*0.01
            ),
            decoration:  BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(35),
                bottomRight: Radius.circular(35)
              )
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Image.asset(AssetsManager.iconMap),
                    SizedBox(width: width*0.02,),
                    Text('Cairo, Egypt',
                    style: AppStyles.medium14White,)
                  ],
                ),
                DefaultTabController(
                    length: eventsNameList.length,
                    child: TabBar(
                      onTap: (index){
                        selectedIndex = index ;
                        setState(() {

                        });
                      },
                      isScrollable: true,
                        indicatorColor: AppColors.transparentColor,
                        dividerColor: AppColors.transparentColor,
                        tabAlignment: TabAlignment.start,
                        labelPadding: EdgeInsets.symmetric(
                          horizontal: width*0.02,
                          vertical: height*0.01
                        ),
                        tabs: eventsNameList.map((eventName){
                          return TabEventWidget(
                            backgroundColor: AppColors.whiteColor,
                              textSelectedStyle: AppStyles.medium16Primary,
                              textUnSelectedStyle: AppStyles.medium16White,
                              isSelected: selectedIndex == eventsNameList.indexOf(eventName),
                              eventName: eventName);
                        }).toList()
                    )
                )
              ],
            ),
          ),
          Expanded(child: Padding(
            padding:  EdgeInsets.symmetric(
              vertical: height*0.02,
              horizontal: width * 0.04
            ),
            child: ListView.separated(
              separatorBuilder: (context,index){
                return SizedBox(
                  height: height*0.02,
                );
              },
              itemBuilder: (context,index){
              return EventItemWidget();
            },
            itemCount: 20,),
          ))
        ],
      ),
    );
  }
}
