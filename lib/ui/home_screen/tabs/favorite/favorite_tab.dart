import 'package:event_planning_c13_sun3/providers/event_list_provider.dart';
import 'package:event_planning_c13_sun3/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_styles.dart';
import '../../../../utils/assets_manager.dart';
import '../home/event_item_widget.dart';
import '../widgets/custom_text_field.dart';

class FavoriteTab extends StatelessWidget {
  const FavoriteTab({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height ;
    var width = MediaQuery.of(context).size.width ;
    var eventListProvider = Provider.of<EventListProvider>(context);
    var userProvider = Provider.of<UserProvider>(context);
    if(eventListProvider.favoriteEventList.isEmpty){
      eventListProvider.getFavoriteEvents(userProvider.currentUser!.id);
    }
    return SafeArea(
      child: Padding(
        padding:  EdgeInsets.symmetric(
          horizontal: width*0.04,
        ),
        child: Column(
          children: [
            CustomTextField(
              hintStyle: AppStyles.bold14Primary,
              borderColor: AppColors.primaryLight,
              prefixIcon: Image.asset(AssetsManager.iconSearch),
              hintText: AppLocalizations.of(context)!.search_event,
            ),
            SizedBox(height: height*0.02,),
            Expanded(child:
                eventListProvider.favoriteEventList.isEmpty?
                    Center(child: Text(AppLocalizations.of(context)!.no_favorite_events_found,
                    style: AppStyles.medium16Black,),)
                    :
            ListView.separated(
                separatorBuilder: (context,index){
                  return SizedBox(
                    height: height*0.02,
                  );
                },
              padding: EdgeInsets.zero,
              itemBuilder: (context,index){
              return  EventItemWidget(event: eventListProvider.favoriteEventList[index],);
            },
              itemCount: eventListProvider.favoriteEventList.length,))
          ],
        ),
      ),
    );
  }
}
