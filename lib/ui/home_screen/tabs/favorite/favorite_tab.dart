import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
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
            Expanded(child: ListView.separated(
                separatorBuilder: (context,index){
                  return SizedBox(
                    height: height*0.02,
                  );
                },
              padding: EdgeInsets.zero,
              itemBuilder: (context,index){
              return Container();
                // EventItemWidget();
            },
              itemCount: 20,))
          ],
        ),
      ),
    );
  }
}
