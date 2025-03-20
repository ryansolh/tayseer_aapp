
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../cache/cache_helper.dart';
import '../../../../core/component/my_custom_linear_gradient.dart';
import '../../../basic_navigation_page/presention/page/navigation_page.dart';
import '../../../onboarding/presention/pages/onboarding_screen.dart';
import '../../../user_login/presention/pages/welcome_page.dart';
import '../management/splash_screen_bloc/splash_screen_cubit.dart';
import '../management/splash_screen_bloc/splash_screen_states.dart';




class PageOneOfSplashScreen extends StatefulWidget
{
  const PageOneOfSplashScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _PageOneOfSplashScreenState createState() => _PageOneOfSplashScreenState();

}

class _PageOneOfSplashScreenState extends State<PageOneOfSplashScreen> {
  @override
  void initState()
  {
    super.initState();

    BlocProvider.of<SplashScreenCubit>(context).StartingPageOneOfSplashScreen();

  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SplashScreenCubit,SplashScreenState>(
        builder: (context,state) {
          return  Scaffold(
              body:Container(
                decoration:  BoxDecoration(
                  gradient: MyLinearGradient,
                ),
              )
          );
        }, listener:
        (context,state)
    {
      if(state is NavigationToPageTwoOfSplashScreenState) {

/*
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => PageTwoOfSplashScreen()));
*/


        Navigator.of(context).pushReplacement(
          ThisIsFadeRoute(
            route:  const PageTwoOfSplashScreen(),
          ),
        );
      }
    }
    );
  }
}

class PageTwoOfSplashScreen extends StatefulWidget
{
  const PageTwoOfSplashScreen({super.key});


  @override
  // ignore: library_private_types_in_public_api
  _PageTwoOfSplashScreenState createState() => _PageTwoOfSplashScreenState();

}

class _PageTwoOfSplashScreenState extends State<PageTwoOfSplashScreen>
{

  @override
  void initState() {
    super.initState();
    BlocProvider.of<SplashScreenCubit>(context).StartingAnimationTimersOfSplashScreen();
  }


  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

 double heightOfScreen = MediaQuery.of(context).size.height;
 double widthOfScreen = MediaQuery.of(context).size.width;


    return BlocConsumer<SplashScreenCubit,SplashScreenState>
      (
        builder: (context, state)
        {
          return Scaffold
            (
           body: Container
              (
              decoration:  BoxDecoration(
                gradient: MyLinearGradient,
              ),
              child: Center
                (
                child: Column
                  (
                  children:
                  [

                    AnimatedContainer
                      (
                      duration: Duration
                        (
                          milliseconds: BlocProvider.of<SplashScreenCubit>(context).fourthAnimationTimer ? 900 : 2500
                      ),
                      curve: BlocProvider.of<SplashScreenCubit>(context).fourthAnimationTimer ? Curves.fastLinearToSlowEaseIn : Curves.elasticOut,
                      height: BlocProvider.of<SplashScreenCubit>(context).fourthAnimationTimer
                          ? 0
                          : BlocProvider.of<SplashScreenCubit>(context).firstAnimationTimer
                          ? heightOfScreen / 2
                          : 20,
                      width: 20,
                      // color: Colors.deepPurpleAccent,
                    ),
                    AnimatedContainer
                      (
                      duration: Duration
                        (
                          seconds: BlocProvider.of<SplashScreenCubit>(context).fourthAnimationTimer
                              ? 1
                              : BlocProvider.of<SplashScreenCubit>(context).thirdAnimationTimer
                              ? 2
                              : 0
                      ),
                      curve: Curves.fastLinearToSlowEaseIn,
                      height: BlocProvider.of<SplashScreenCubit>(context).fourthAnimationTimer
                          ? heightOfScreen
                          : BlocProvider.of<SplashScreenCubit>(context).thirdAnimationTimer
                          ? 200
                          : 20,
                      width: BlocProvider.of<SplashScreenCubit>(context).fourthAnimationTimer
                          ? widthOfScreen
                          : BlocProvider.of<SplashScreenCubit>(context).thirdAnimationTimer
                          ? 200
                          : 20,
                      decoration: BoxDecoration
                        (
                          color: Theme.of(context).colorScheme.background,
                          // shape: AnimationTimer_c? BoxShape.rectangle : BoxShape.circle,
                          borderRadius:
                          BlocProvider.of<SplashScreenCubit>(context).fourthAnimationTimer ? const BorderRadius.only() : BorderRadius.circular(30)
                      ),
                      child: Center
                        (
                        child: BlocProvider.of<SplashScreenCubit>(context).fifthAnimationTimer
                            ?Image.asset
                          (
                          "assets/images/logo_of_app/TAYSEER.png",
                        )
                            : const SizedBox(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
        listener:(context,state)
        {

          if(state is NavigationToOnBoardingPagesState)
          {
            Navigator.of(context).pushReplacement
              (
              ThisIsFadeRoute
                (
                route:(CacheHelper.getData(key: 'token')!=null)?NavigationScreen():CacheHelper.getData(key: "OnBoardingSkipped")!=null?WelcomePage():Onboarding(),
              ),
            );
          }
        }
    );
  }
}

class ThisIsFadeRoute extends PageRouteBuilder
{
  late Widget? page;
  late Widget? route;

  ThisIsFadeRoute({ this.route, this.page})
      : super
      (
      pageBuilder:
          (
          BuildContext context,
          Animation<double> animation,
          Animation<double> secondaryAnimation,
          ) =>
      page!,
      transitionsBuilder:
          (
          BuildContext context,
          Animation<double> animation,
          Animation<double> secondaryAnimation,
          Widget child,
          ) =>
          FadeTransition
            (
            opacity: animation,
            child: route,
          ),
    );
}
