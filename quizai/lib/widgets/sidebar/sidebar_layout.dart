import 'package:flutter/material.dart';
import 'package:quizai/screens/home_screen.dart';

import 'sidebar.dart';

class SideBarLayout extends StatelessWidget {
    @override
        Widget build(BuildContext context) {
            return const Scaffold( 
                    body: Stack(
                        children: <Widget> [
                        
                        SideBar(),
                        ]
                        ),
                    );
        }
}
