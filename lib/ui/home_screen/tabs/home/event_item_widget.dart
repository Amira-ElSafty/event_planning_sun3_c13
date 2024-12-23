import 'package:flutter/material.dart';

import '../../../../utils/app_colors.dart';
import '../../../../utils/app_styles.dart';
import '../../../../utils/assets_manager.dart';

class EventItemWidget extends StatelessWidget {
  const EventItemWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height ;
    var width = MediaQuery.of(context).size.width ;
    return Container(
      height: height * 0.31,
      // margin: EdgeInsets.symmetric(
      //   horizontal: width*0.04,
      //   vertical: height * 0.01
      // ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Theme.of(context).primaryColor,
          width: 2
        ),
        image: const DecorationImage(
          fit: BoxFit.fill,
            image: AssetImage(
          AssetsManager.birthdayImage
        ))
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: EdgeInsets.symmetric(
                horizontal: width*0.02,
                vertical: height * 0.002
            ),
            margin: EdgeInsets.symmetric(
                horizontal: width*0.04,
                vertical: height * 0.008
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: AppColors.whiteColor
            ),
            child: Column(
              children: [
                Text('22',
                style: AppStyles.bold20Primary,),
                Text('Dec',
                  style: AppStyles.bold20Primary,)
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(
                horizontal: width*0.02,
                vertical: height * 0.01
            ),
            margin: EdgeInsets.symmetric(
                horizontal: width*0.04,
                vertical: height * 0.008
            ),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: AppColors.whiteColor
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text('This is a Birthday Party',
                  style: AppStyles.bold14Black,),
                ),
                Image.asset(AssetsManager.iconFavorite,
                color: AppColors.primaryLight,)
              ],
            ),
          )
        ],
      ),
    );
  }
}
