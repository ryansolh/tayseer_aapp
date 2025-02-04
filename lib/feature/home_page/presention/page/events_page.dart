import 'package:appinio_video_player/appinio_video_player.dart';
import 'package:flutter/material.dart';
import 'package:todo_apps/core/component/my_custom_image_viewer.dart';
import 'package:todo_apps/core/component/my_custom_loading.dart';
import 'package:todo_apps/core/component/my_custom_subtitle.dart';
import 'package:todo_apps/core/component/my_custom_title.dart';
import 'package:todo_apps/core/my_extention/my_extentions.dart';
import 'package:todo_apps/feature/home_page/data/model/models.dart';

import '../../../../core/component/my_custom_linear_gradient.dart';


const kDefaultPadding = 20.0;
const kTextColor = Color(0xFF535353);
const kTextLightColor = Color(0xFFACACAC);

class EventDetailsScreen extends StatefulWidget {
  final EventsModel? event;

  const EventDetailsScreen({Key? key, this.event}) : super(key: key);

  @override
  State<EventDetailsScreen> createState() => _EventDetailsScreenState();
}

class _EventDetailsScreenState extends State<EventDetailsScreen> {

  void initializeVideoPlayer(String src) {
    setState(() {
      isLoadingVideo = true;
    });

    CachedVideoPlayerController cachedVideoPlayerController;

    // استخدام CachedVideoPlayerController
    cachedVideoPlayerController =
    CachedVideoPlayerController.network(src)
      ..initialize().then((_) {
        setState(() {
          isLoadingVideo = false;

        });
      });


    _customVideoPlayerController = CustomVideoPlayerController(
      context: context,
      videoPlayerController: cachedVideoPlayerController,
    );
  }
  late CustomVideoPlayerController _customVideoPlayerController;



 /* Uri videoUri = Uri.parse(
      "https://l.top4top.io/m_3315pn3370.mp4");*/

  late bool isLoadingVideo = false;

  @override
  void initState() {
    super.initState();
    (widget.event!.videoUrl)!=null&&(widget.event!.videoUrl)!="null"&&(widget.event!.videoUrl)!=''?
    initializeVideoPlayer(widget.event!.videoUrl!):print('');
  }

  @override
  void dispose() {
    (widget.event!.videoUrl)!=null&&(widget.event!.videoUrl)!="null"&&(widget.event!.videoUrl)!=''?
    _customVideoPlayerController.dispose():print('');
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title:   Text(widget.event!.name,
          style: TextStyle(color: Colors.white, fontFamily: 'Tajawal', fontWeight: FontWeight.bold,),),
        leading: Container(),
        actions: [IconButton(onPressed: (){context.pop();}, icon: Icon(Icons.chevron_right_sharp,size: 40,color: Colors.white,))],
        flexibleSpace:
        Container(
          decoration:  BoxDecoration(
            gradient:MyLinearGradient,
          ),
        ),

      ),
      body: Container(

        color: Theme.of(context).colorScheme.background,
        height: double.infinity,
        child: Padding(
          padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.1),
          child: SingleChildScrollView(

            child: Column(
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    Hero(
                      tag: "${widget.event!.id}",
                      child: Container(
                          height: MediaQuery.of(context).size.height/2.7,
                          width:MediaQuery.of(context).size.width ,
                          // height: size.height * 0.3,
                          child: CustomImageViewer.show(
                              radius: 0,
                              context: context,
                              url: widget.event!.imageUrl
                          )
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: size.height/2.8),

                      // height: 500,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(24),
                          topRight: Radius.circular(24),
                        ),
                      ),
                      child: Padding(
                        padding:const EdgeInsets.symmetric(horizontal: 15),
                        child: Column(

                          children: <Widget>[
                            20.SH,
                            Align(
                              alignment: Alignment.topRight,
                              child: MyTitle(
                                  textOfTitle: "نبذة عن الحدث او الفعالية",
                                  startDelay: 0
                              ),
                            ),
                            Align(
                              alignment: Alignment.topRight,
                              child: MySubTitle(
                                startDelay: 300,
                                textOfSubTitle:  widget.event!.description,
                              ),
                            ),


                            20.SH,
                            Align(
                              alignment: Alignment.topRight,
                              child: MyTitle(
                                  textOfTitle: "اين سيقام الحدث او الفعالية",
                                  startDelay: 0
                              ),
                            ),
                            Align(
                              alignment: Alignment.topRight,
                              child: MySubTitle(
                                startDelay: 300,
                                textOfSubTitle:  widget.event!.address,
                              ),
                            ),
                            (widget.event!.videoUrl)!=null&&(widget.event!.videoUrl)!="null"&&(widget.event!.videoUrl)!=''?
                            isLoadingVideo==true?
                                Container(
                                  color:Colors.black,
                                  width: double.infinity,
                                    height: 210,
                                    child: Center(
                                      child:MyCustomLoading()
                                    )
                                ):
                            CustomVideoPlayer(
                              customVideoPlayerController: _customVideoPlayerController,
                            ):
                                SizedBox(),

                            30.SH


                          ],
                        ),
                      ),
                    ),
                    // ProductTitleWithImage(product: widget.product)
                  ],
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
    );
  }
}
