import 'package:event_planning_c13_sun3/ui/home_screen/tabs/favorite/favorite_tab.dart';
import 'package:event_planning_c13_sun3/ui/home_screen/tabs/home/add_event/add_event.dart';
import 'package:event_planning_c13_sun3/ui/home_screen/tabs/home/home_tab.dart';
import 'package:event_planning_c13_sun3/ui/home_screen/tabs/map/map_tab.dart';
import 'package:event_planning_c13_sun3/ui/home_screen/tabs/profile/profile_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../utils/app_colors.dart';
import '../../utils/assets_manager.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = 'home_screen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;

  List<Widget> tabs = [HomeTab(), MapTab(), FavoriteTab(), ProfileTab()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Theme(
        data:
            Theme.of(context).copyWith(canvasColor: AppColors.transparentColor),
        child: BottomAppBar(
          color: Theme.of(context).primaryColor,
          // padding: EdgeInsets.zero,
          shape: CircularNotchedRectangle(),
          notchMargin: 4,
          child: BottomNavigationBar(
              currentIndex: selectedIndex,
              onTap: (index) {
                selectedIndex = index;
                setState(() {});
              },
              items: [
                buildBottomNavItems(
                    index: 0,
                    iconSelectedName: AssetsManager.iconHomeSelected,
                    iconName: AssetsManager.iconHome,
                    label: AppLocalizations.of(context)!.home),
                buildBottomNavItems(
                    index: 1,
                    iconSelectedName: AssetsManager.iconMapSelected,
                    iconName: AssetsManager.iconMap,
                    label: AppLocalizations.of(context)!.map),
                buildBottomNavItems(
                    index: 2,
                    iconSelectedName: AssetsManager.iconFavoriteSelected,
                    iconName: AssetsManager.iconFavorite,
                    label: AppLocalizations.of(context)!.favorite),
                buildBottomNavItems(
                    index: 3,
                    iconSelectedName: AssetsManager.iconProfileSelected,
                    iconName: AssetsManager.iconProfile,
                    label: AppLocalizations.of(context)!.profile),
              ]),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // navigate to add event screen
          Navigator.of(context).pushNamed(AddEvent.routeName);
        },
        child: Icon(
          Icons.add,
          size: 25,
          color: AppColors.whiteColor,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: tabs[selectedIndex],
    );
  }

  BottomNavigationBarItem buildBottomNavItems(
      {required int index,
      required String iconSelectedName,
      required String iconName,
      required String label}) {
    return BottomNavigationBarItem(
        icon: ImageIcon(
            AssetImage(selectedIndex == index ? iconSelectedName : iconName)),
        label: label);
  }
}
