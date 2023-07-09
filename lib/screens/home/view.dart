import 'package:flutter/material.dart';
import 'package:thimar/helper/app_theme.dart';
import 'package:thimar/screens/home/favorites/view.dart';
import 'package:thimar/screens/home/my_account/view.dart';
import 'package:thimar/screens/home/my_order/view.dart';
import 'package:thimar/screens/home/notifications/view.dart';

import 'main/view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List pages=[
    const MainView(),
    const MyOrderView(),
    const NotificationsView(),
    const FavoritesView(),
    const MyAccountView(),
  ];
  int selectedindex=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: selectedindex,
        selectedItemColor: Colors.white,
        unselectedItemColor: const Color(0xFFAED489),
        selectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 13,
          color: Color(0xFFAED489),
        ),
        showSelectedLabels: true,
        showUnselectedLabels: true,
        elevation: 0.0,
        backgroundColor: AppTheme.mainColor,
        onTap: (index){
          setState(() {
            selectedindex=index;

          });
        },
        items: [
          BottomNavigationBarItem(
              icon:Image.asset('assets/icons/home.png',
                color: selectedindex==0 ? Colors.white :Colors.grey,),
              label:'الرئيسية',


          ),
           BottomNavigationBarItem(
              icon: Image.asset('assets/icons/note.png',
                color: selectedindex==1 ? Colors.white :Colors.grey,),
              label:'طلباتي'
          ),
           BottomNavigationBarItem(
              icon:  Image.asset('assets/icons/notification.png',
                color: selectedindex==2 ? Colors.white :Colors.grey,),
              label:'الاشعارات',
          ),
           BottomNavigationBarItem(
              icon: Image.asset('assets/icons/heart.png',
                color: selectedindex==3 ? Colors.white :Colors.grey,),
              label:'المفضلة'
          ),
           BottomNavigationBarItem(
              icon:  Image.asset('assets/icons/user2.png',
                color: selectedindex==4 ? Colors.white :Colors.grey,),
              label:'حسابي'
          ),
        ],
      ),
      body: pages[selectedindex],
    );
  }
}

