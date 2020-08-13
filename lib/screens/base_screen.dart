import 'package:custom_navigator/custom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:gym/blocs/base_bloc.dart';
import 'package:gym/providers/base_bloc_provider.dart';
import 'package:gym/screens/members_screen.dart';
import 'package:gym/screens/slot_screen.dart';
import 'package:gym/utils/constants.dart';

class BaseScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseBlocProvider(
      child: BaseScreenBase(),
    );
  }
}

class BaseScreenBase extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final BaseBloc _baseBloc = BaseBlocProvider.getHomeBloc(context);
    _baseBloc.updateContext(context);
    // SnackbarUtil _snackbarUtil = SnackbarUtil();
    // _snackbarUtil.buildContextBaseScreen = context;
    return StreamBuilder(
        stream: _baseBloc.currentIndex,
        builder: (BuildContext context, AsyncSnapshot<int> currentIndex) {
          return WillPopScope(
            onWillPop: _baseBloc.onWillPop,
            child: Scaffold(
              bottomNavigationBar: Theme(
                data: Theme.of(context).copyWith(
                    // sets the background color of the `BottomNavigationBar`
                    canvasColor: Color(Constants.BASE_COLOR),
                    // sets the active color of the `BottomNavigationBar` if `Brightness` is light
                    primaryColor: Color(Constants.BASE_LIGHT_COLOR),
                    textTheme: Theme.of(context).textTheme.copyWith(
                            caption: new TextStyle(
                          color: Colors.white,
                        ))), // sets the inactive color of the `BottomNavigationBar`
                child: BottomNavigationBar(
                  selectedFontSize: 14,
                  unselectedFontSize: 14,
                  onTap: (index) {
                    _baseBloc.updateNavigation(index);
                  },
                  type: BottomNavigationBarType.fixed,
                  currentIndex: currentIndex.hasData ? currentIndex.data : 0,
                  items: [
                    BottomNavigationBarItem(
                      icon: Icon(Icons.home),
                      title: Text(
                        'Home',
                        style: TextStyle(
                          fontFamily: "SegoeRegular",
                          fontSize: 12.0,
                        ),
                      ),
                    ),
                    BottomNavigationBarItem(
                      icon: Padding(
                        padding: const EdgeInsets.only(right: 20.0),
                        child: Icon(Icons.people),
                      ),
                      title: Padding(
                        padding: const EdgeInsets.only(right: 20.0),
                        child: Text(
                          'Members',
                          style: TextStyle(
                            fontFamily: "SegoeRegular",
                            fontSize: 12.0,
                          ),
                        ),
                      ),
                    ),
                    BottomNavigationBarItem(
                      icon: Padding(
                        padding: const EdgeInsets.only(right: 20.0),
                        child: Icon(Icons.schedule),
                      ),
                      title: Padding(
                        padding: const EdgeInsets.only(right: 20.0),
                        child: Text(
                          'Slots',
                          style: TextStyle(
                            fontFamily: "SegoeRegular",
                            fontSize: 12.0,
                          ),
                        ),
                      ),
                    ),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.account_circle),
                        title: Text(
                          'Profile',
                          style: TextStyle(
                            fontFamily: "SegoeRegular",
                            fontSize: 12.0,
                          ),
                        )),
                  ],
                ),
              ),
              body: BaseScreenDetails(),
            ),
          );
        });
  }
}

class BaseScreenDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
    final BaseBloc _baseBloc = BaseBlocProvider.getHomeBloc(context);
    _baseBloc.updateContext(context);
    // SnackbarUtil _snackbarUtil = SnackbarUtil();
    // _snackbarUtil.buildContextBaseScreen = context;
    final List<Widget> _children = [
      StreamBuilder(
          stream: _baseBloc.isProfile,
          builder: (BuildContext context, AsyncSnapshot<bool> isProfile) {
            // if (isProfile.hasData && isProfile.data) {
            //   return Text('Home');
            // } else {
            //   return ThanksScreen();
            // }
            return Center(
                child: Text(
              'Home',
              style: TextStyle(color: Colors.black),
            ));
          }),
      StreamBuilder(
          stream: _baseBloc.isProfile,
          builder: (BuildContext context, AsyncSnapshot<bool> isProfile) {
            // if (isProfile.hasData && isProfile.data) {
            //   return ConnectionScreen();
            // } else {
            //   return ThanksScreen();
            // }
            return MembersScreen();
          }),
      StreamBuilder(
          stream: _baseBloc.isProfile,
          builder: (BuildContext context, AsyncSnapshot<bool> isProfile) {
            // if (isProfile.hasData && isProfile.data) {
            //   return NotificationScreen();
            // } else {
            //   return ThanksScreen();
            // }
            return SlotScreen(); // Slot screen
          }),
      StreamBuilder(
          stream: _baseBloc.isProfile,
          builder: (BuildContext context, AsyncSnapshot<bool> isProfile) {
            return Center(child: Text('Profile'));
            // if (isProfile.hasData) {
            //   if (isProfile.data) {
            //     return ProfileScreen();
            //   } else {
            //     return ThanksScreen();
            //   }
            // } else {
            //   return Container(
            //     decoration: BoxDecoration(
            //       gradient: LinearGradient(
            //         begin: const FractionalOffset(1.0, 0.0),
            //         end: const FractionalOffset(0.6, 0.8),
            //         stops: [0.0, 1.0],
            //         colors: [
            //           Color(Constants.GRADIENT_LIGHT_COLOR),
            //           Color(Constants.GRADIENT_DARK_COLOR),
            //         ],
            //       ),
            //     ),
            //   );
            // }
          }),
    ];
    return StreamBuilder(
        stream: _baseBloc.currentIndex,
        builder: (BuildContext context, AsyncSnapshot<int> currentIndex) {
          if (currentIndex.hasData) {
            print(currentIndex.data);
            return CustomNavigator(
              navigatorKey: _baseBloc.navigatorKey,
              home: _children[currentIndex.data],
              //Specify your page route [PageRoutes.materialPageRoute] or [PageRoutes.cupertinoPageRoute]
              pageRoute: PageRoutes.materialPageRoute,
            );
          } else {
            return Container();
          }
        });
  }
}
