import 'dart:async';

import 'package:flutter/material.dart';
import 'package:quizai/utils/app_styles.dart';
import 'package:quizai/utils/sidebar_styles.dart';
import 'package:rxdart/rxdart.dart';

class SideBar extends StatefulWidget {
    const SideBar({super.key});

    @override
        State<SideBar> createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> with SingleTickerProviderStateMixin<SideBar>{

    late bool isOpen;

    late AnimationController _animationController;
    late StreamController<bool> isOpenStreamController;
    late Stream<bool> isOpenStream;
    late StreamSink<bool> isOpenSink;


    @override
        void initState() {
            super.initState();
            _animationController = AnimationController(vsync: this, duration: SideBarStyles.animationDuration);
            isOpenStreamController = PublishSubject<bool>();
            isOpenStream = isOpenStreamController.stream;
            isOpenSink = isOpenStreamController.sink;
            isOpen = false;
        }

    @override
        void dispose() {
            _animationController.dispose();
            isOpenStreamController.close();
            isOpenSink.close();
            super.dispose();
        }

    void onIconPressed() {
        final animationStatus = _animationController.status;
        final isAnimationCompleted = animationStatus == AnimationStatus.completed;

        if (isAnimationCompleted) {
            isOpenSink.add(false);
            _animationController.reverse();
            isOpen = false;
        } else {
            isOpenSink.add(true);
            _animationController.forward();
            isOpen = true;
        }
    }


    TextButton navButton(String text, Function()? pressed, AsyncSnapshot<bool> isOpenAsync, String iconDt) {
        return TextButton(
                onPressed: pressed,
                style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.navBg,
                    foregroundColor: AppTheme.white,
                    fixedSize: const Size(150, 50),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0)
                        )
                    ),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                    Text(text),
                    Text(""),
                    ]
                    )
                );
    }

    @override
        Widget build(BuildContext context) {
            final screenWidth = MediaQuery.of(context).size.width;
            return StreamBuilder<bool>(
                    initialData: false,
                    stream: isOpenStream,
                    builder: (context, isOpenAsync) {
                    return AnimatedPositioned( 
                            duration: SideBarStyles.animationDuration, 
                            top: 0,
                            bottom: 0,
                            left: isOpenAsync.data == true ? 0 : 0.0-(SideBarStyles.openedNavbarWidth - SideBarStyles.closedNavbarWidth), 
                            right: isOpenAsync.data == true ? screenWidth - SideBarStyles.openedNavbarWidth : screenWidth - SideBarStyles.closedNavbarWidth,
                            child: Row(
                                children: [
                                Expanded(
                                    child: Container(
                                        color: AppTheme.navBg,
                                        child: Column(
                                            children: [
                                            Row(
                                                mainAxisAlignment: MainAxisAlignment.end,
                                                children:[
                                                InkWell(
                                                    onTap: () => onIconPressed(),
                                                    child: AnimatedIcon(
                                                        progress: _animationController.view,
                                                        icon: AnimatedIcons.menu_close,
                                                        color: AppTheme.white,
                                                        size: 25
                                                        )
                                                    )
                                                ]
                                               ),
                                            Row(
                                                children: [
                                                isOpenAsync.data == true && isOpen == true?
                                                navButton("text", () {}, isOpenAsync, "") 
                                                : const Icon(Icons.home),
                                                
                                                ]
                                               )
                                            ]
                                            )
                                            ),
                                            ),
                                            ]
                                                )
                                                );
                    }
            );
        }


}
