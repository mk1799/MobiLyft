import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:mobilyft/Car_Sell/car_sell_buy/sell_car_search_add.dart';
import 'package:mobilyft/Car_Sell/car_sell_dashboard/sell_dashboard_home.dart';
import 'package:mobilyft/Car_Sell/car_sell_message/sell_message.dart';

class sell_home extends StatefulWidget {
  sell_home({Key key, this.email}) : super(key: key);
  final String email;
  @override
  _sell_homeState createState() => _sell_homeState();
}

class _sell_homeState extends State<sell_home> {
   int _currentIndex = 1;
  GlobalKey _bottomNavigationKey = GlobalKey();

  Widget callPage(int currentIndex) {
    switch (_currentIndex) {
      case 0:
        return sell_dashboard(email: widget.email);
      case 1:
        return car_add_search(email: widget.email);
      case 2:
        return sell_msg(email: widget.email);
      
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        body: callPage(_currentIndex),
        // appBar: AppBar(
        //   backgroundColor: Colors.white,
        // ),

      //   appBar:  PreferredSize(
      //     preferredSize: Size.fromHeight(50.0), // here the desired height
      //     child:AppBar(backgroundColor: Colors.white,
      //       iconTheme: IconThemeData(color: Colors.black,size: 30.0),
      //     ),
      // ),  
          bottomNavigationBar: ConvexAppBar(
          backgroundColor: Colors.white,
          activeColor: Colors.blue,
          color: Colors.lightBlue,
    items: [
      TabItem(icon: Icons.dashboard, title: 'Dashboard'),
      // TabItem(icon: Icons.person_add, title: 'Request'),
      TabItem(icon: Icons.add, title: 'Add'),
      // TabItem(icon: Icons.notifications, title: 'Notification'),
      TabItem(icon: Icons.message, title: 'Message'),
    ],
    
    initialActiveIndex: 1,
     onTap: (value) {
            _currentIndex = value;
            setState(() {});
          },
  ),
        );
  }
}