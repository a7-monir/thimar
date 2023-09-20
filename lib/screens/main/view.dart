import 'package:flutter/material.dart';
import 'package:thimar/core/logic/app_theme.dart';
import 'package:thimar/screens/favorites.dart';
import 'package:thimar/screens/my_account.dart';
import 'package:thimar/screens/my_order.dart';
import 'package:thimar/screens/notifications.dart';

import '../home/view.dart';





class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  List pages=[
    const HomeView(),
    const MyOrderView(),
    const NotificationsView(),
    const FavoritesView(),
    const MyAccountView(),
  ];
  int selectedIndex=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: selectedIndex,
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
          selectedIndex=index;

          setState(() {});
        },
        items: [
          BottomNavigationBarItem(
              icon:Image.asset('assets/icons/home.png',
                color: selectedIndex==0 ? Colors.white :Colors.grey,),
              label:'الرئيسية',


          ),
           BottomNavigationBarItem(
              icon: Image.asset('assets/icons/note.png',
                color: selectedIndex==1 ? Colors.white :Colors.grey,),
              label:'طلباتي'
          ),
           BottomNavigationBarItem(
              icon:  Image.asset('assets/icons/notification.png',
                color: selectedIndex==2 ? Colors.white :Colors.grey,),
              label:'الاشعارات',
          ),
           BottomNavigationBarItem(
              icon: Image.asset('assets/icons/heart.png',
                color: selectedIndex==3 ? Colors.white :Colors.grey,),
              label:'المفضلة'
          ),
           BottomNavigationBarItem(
              icon:  Image.asset('assets/icons/user2.png',
                color: selectedIndex==4 ? Colors.white :Colors.grey,),
              label:'حسابي'
          ),
        ],
      ),
      body: pages[selectedIndex],
    );
  }
}

