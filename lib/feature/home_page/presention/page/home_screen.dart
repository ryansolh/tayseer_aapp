import 'package:flutter/material.dart';

import 'package:todo_apps/core/my_extention/my_extentions.dart';

import '../../../../core/component/my_custom_subtitle.dart';
import '../widgets/inner_indicator_carousel_slider.dart';
import '../widgets/outter_indicator_carousel_slider.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.background,
      height: double.infinity,
      width: double.infinity,
      child:SingleChildScrollView(
        child: Column(
          children:  [
            InnerIndicatorCarouselSlider(),
            20.SH,
            const MySubTitle(textOfSubTitle:
            "نقدم لكم مجموعة من الفعاليات والأنشطة التي تنظمها"
            "المراكز والمؤسسات المتخصصة في دعم وتدريب وتعليم ذوي "
                "الإعاقة. تهدف هذه الفعاليات إلى تعزيز المهارات، وتوفير فرص التعلم، "
                "ودعم الاندماج المجتمعي للأفراد ذوي الإعاقة. نأمل أن تجدوا في هذه "
                "الاقتراحات ما يلبي احتياجاتكم ويساهم في تحقيق أهدافكم."
              ,startDelay: 700,),

            OuterIndicatorCarouselSlider(),
            100.SH
          ],
        ),
      ),
    );
  }
}
