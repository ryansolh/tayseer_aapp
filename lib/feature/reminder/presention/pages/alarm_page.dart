import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todo_apps/core/my_extention/my_extentions.dart';
import '../../../../core/component/my_custom_buttons.dart';
import '../../../../core/component/my_custom_shadermask.dart';
import '../../../../core/component/my_custom_title.dart';
import '../../../../core/services/notifications_service/notification_services.dart';
import '../../../../core/services/reports_services/pdf_services.dart';
import '../../../../core/task_db_controllers/device_info.dart';
import '../../../../core/task_db_controllers/task.controller.dart';
import '../../../../core/utils/theme_data/theme_mode.dart';
import '../../models/task.dart';
import '../widgets/task_tile.dart';
import 'add_task_bar.dart';



bool randomOrderView=false;
class AlarmPage extends StatefulWidget {
  const AlarmPage({super.key});

  @override
  State<AlarmPage> createState() => _AlarmPageState();
}

class _AlarmPageState extends State<AlarmPage> {
  List<Task> filterTaskList = [];

  double? width;
  double? height;
  // ignore: prefer_typing_uninitialized_variables
  var notifyHelper;
  String? deviceName;
  bool shorted = false;
  //DateTime _selectedDate = DateTime.now();
  DateTime _selectedDateOfview = DateTime.now();
  final _taskController = Get.put(TaskController());
  bool _procedureDone=false;

  @override
  void initState() {
    super.initState();


    filterTaskList = _taskController.taskList;
    DeviceInfo deviceInfo = DeviceInfo();
    deviceInfo.getDeviceName().then((value) {
      setState(() {
        deviceName = value;
      });
    });

    notifyHelper = NotifyHelper();
    notifyHelper.initializeNotification();
 /*   notifyHelper.requestIOSPermissions();
    notifyHelper.requestAndroidPermissions();*/
  }

  // Sorting function
  List<Task> _shortNotesByModifiedDate(List<Task> taskList) {
    taskList.sort((a, b) => a.updatedAt!.compareTo(b.updatedAt!));

    if (shorted) {
      taskList = List.from(taskList.reversed);

    } else {
      taskList = List.from(taskList.reversed);
    }

    shorted = !shorted;

    return taskList;
  }

  @override
  Widget build(BuildContext context) {



    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    // print(filterTaskList[0].updatedAt);
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onBackground,
      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Container(
          height: height,
          width: width,
          color: Theme.of(context).colorScheme.background ,

          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _addTaskBar(),
                5.SH,

                if(randomOrderView==false)

                  _dateBar(),


                Stack(
                  children: [

                    Column(
                      children: [
                        SizedBox(
                          height: randomOrderView==false?height!*0.530:height!*0.663,
                          child:  randomOrderView==false?
                          _showTasksInOrder():_showTasksInRandom(),
                        ),


                      ],
                    ),
                    /* Positioned(
                       top: 20,
                       right: 10,
                       child: Card(
                         shape: RoundedRectangleBorder(
                           borderRadius: BorderRadius.all(Radius.circular(50))
                         ),
                         elevation: 4,
                         color: Theme.of(context).colorScheme.background,
                         child: MyShaderMask(
                           radius: 1,
                           toolWidget: PopupMenuButton<String>(
                             shape: RoundedRectangleBorder(
                               borderRadius: BorderRadius.all(Radius.circular(20))
                             ),
                             color: Theme.of(context).colorScheme.background,
                             // color: Get.isDarkMode ? darkGreyColor : Colors.white,
                             icon: const Icon(Icons.sort_rounded,size: 27,),
                             padding: const EdgeInsets.symmetric(horizontal: 0,vertical: 0),
                             tooltip: "More",
                             onSelected: (value)  {
                               if (value == "عرض كل المنبهات عشوائيا") {
                                 setState(() {
                                   randomOrderView=true;
                                 });

                               } else if (value == "عرض المنبهات بشكل منظم") {
                                 setState(() {
                                   randomOrderView=false;
                                 });


                               }
                             },
                             itemBuilder: (BuildContext context) {

                               return [
                                 const PopupMenuItem(
                                   value: "عرض كل المنبهات عشوائيا",
                                   child: Text("عرض كل المنبهات عشوائيا"),
                                 ),
                                 const PopupMenuItem(
                                   value: "عرض المنبهات بشكل منظم",
                                   child: Text("عرض المنبهات بشكل منظم"),
                                 ),

                               ];
                             },
                           ),
                         ),
                       ),
                     ),*/
                  ],
                ),





              ],
            ),
          ),
        ),
      ),
    );
  }

  _addTaskBar() {
    return Container(
      margin: const EdgeInsets.only(left: 10, right: 10, top: 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [



         Column(
           children: [
             MyButtonWithBackground(
               context: context,
               textButton: "اضافة موعد",
               height: width!/9,
               width: width!/3,
               fontSize: height!*0.02,
               onPressed: () async {
                 await Get.to(() => const AddTaskPage());
                 _taskController.getTasks();
               }
             ),
             10.SH,
             MyButtonWithBackground(
                 context: context,
                 textButton: "طباعة التقرير",
                 height: width!/9,
                 width: width!/3,
                 fontSize: height!*0.02,
                 onPressed: () async {
                   await exportTasksToPDF(filterTaskList);

                 }
             ),


           ],
         ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              MyShaderMask(
                radius: 1,
                toolWidget: PopupMenuButton<String>(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20))
                  ),
                  color: Theme.of(context).colorScheme.background,
                  // color: Get.isDarkMode ? darkGreyColor : Colors.white,
                  icon: const Icon(Icons.sort_rounded,size: 27,),
                  padding: const EdgeInsets.symmetric(horizontal: 0,vertical: 0),
                  tooltip: "More",
                  onSelected: (value)  {
                    if (value == "عرض كل المنبهات عشوائيا") {
                      setState(() {
                        randomOrderView=true;
                      });

                    } else if (value == "عرض المنبهات بشكل منظم") {
                      setState(() {
                        randomOrderView=false;
                      });


                    }
                  },
                  itemBuilder: (BuildContext context) {

                    return [
                      const PopupMenuItem(
                        value: "عرض كل المنبهات عشوائيا",
                        child: Text("عرض كل المنبهات عشوائيا"),
                      ),
                      const PopupMenuItem(
                        value: "عرض المنبهات بشكل منظم",
                        child: Text("عرض المنبهات بشكل منظم"),
                      ),

                    ];
                  },
                ),
              ),
              5.SH,
              MyTitle(
                startDelay: 0,
                textOfTitle: DateFormat("EEE, d MMM yyyy",'ar').format(DateTime.now()).toString(),
              ),
              MyTitle(
                startDelay: 0,
                textOfTitle: "Today",
              )
            ],
          ),


        ],
      ),
    );
  }



  _dateBar() {
    return Container(

      margin: const EdgeInsets.only(top: 0, left: 16,right: 0),
      child:DatePicker(



        locale: 'ar',
        DateTime.now(),
        height: height!*0.139,
        width: height!*0.100,
        initialSelectedDate: DateTime.now(),
        selectionColor: Color(0x2C2929),
        selectedTextColor: Colors.white,
        onDateChange: (date) {
          // New date selected
          setState(() {
            _selectedDateOfview = date;
            //print("---------------------------${_selectedDate}-------------------------------");
          });
        },
        monthTextStyle:  Theme.of(context).textTheme.labelSmall!.copyWith(fontSize: width!*0.039,),
        dateTextStyle:  Theme.of(context).textTheme.labelSmall!.copyWith(fontSize: width!*0.037,),
        //0.020
        dayTextStyle:  Theme.of(context).textTheme.labelSmall!.copyWith(fontSize: width!*0.030,),
      ),
    );
  }
  _showTasksInOrder() {
    return Obx(() {
      return ListView.builder(

       // shrinkWrap: true,
       // physics: NeverScrollableScrollPhysics(),
        itemCount: filterTaskList.length,
        itemBuilder: (_, index) {
          Task task = filterTaskList[filterTaskList.length - 1 - index];

          DateTime date = _parseDateTime(task.startTime.toString());
          var myTime = DateFormat.Hm().format(date);
          var remind = DateFormat.Hm()
              .format(date.subtract(Duration(minutes: task.remind!)));
          print("/////////////////////////////////+{}"+task.startTime.toString()+"//////////////////////");
          print("/////////////////////////////////+{}"+task.startTime2.toString()+"//////////////////////");
          print("/////////////////////////////////+{}"+task.startTime3.toString()+"//////////////////////");
          print("------------------------------------------------------------------------------");


          DateTime? date2 ;
          var myTime2 ;
          var remind2 ;
          DateTime? date3 ;
          var myTime3 ;
          var remind3 ;


          if(task.startTime2.toString()!='null'){
            date2 = _parseDateTime(task.startTime2.toString());
            myTime2 = DateFormat.Hm().format(date2);
            remind2 = DateFormat.Hm()
                .format(date2.subtract(Duration(minutes: task.remind!)));
          }
          if(task.startTime3.toString()!='null'){
            date3 = _parseDateTime(task.startTime3.toString());
            myTime3 = DateFormat.Hm().format(date3);
            remind3 = DateFormat.Hm()
                .format(date3.subtract(Duration(minutes: task.remind!)));
          }



          int mainTaskNotificationId = task.id!.toInt();
          int reminderNotificationId = mainTaskNotificationId + 300;
          int reminderNotificationId2 = mainTaskNotificationId + 400;
          int reminderNotificationId3 = mainTaskNotificationId + 500;


          if (task.repeat == "يومياً") {
            if (task.remind! > 4) {

              notifyHelper.remindNotification(
                int.parse(remind.toString().split(":")[0]), //hour
                int.parse(remind.toString().split(":")[1]), //minute
                task,
              );
              notifyHelper.cancelNotification(reminderNotificationId);



              if(task.startTime2.toString()!='null'){
                notifyHelper.remindNotification2(
                  int.parse(remind2.toString().split(":")[0]), //hour
                  int.parse(remind2.toString().split(":")[1]), //minute
                  task,
                );
                notifyHelper.cancelNotification(reminderNotificationId2);

              }









              if(task.startTime3.toString()!='null'){
                notifyHelper.remindNotification3(
                  int.parse(remind3.toString().split(":")[0]), //hour
                  int.parse(remind3.toString().split(":")[1]), //minute
                  task,

                );
                notifyHelper.cancelNotification(reminderNotificationId3);

              }


            }
            notifyHelper.scheduledNotification(
              int.parse(myTime.toString().split(":")[0]), //hour
              int.parse(myTime.toString().split(":")[1]), //minute
              task,
            );
            notifyHelper.cancelNotification(reminderNotificationId);

            if(task.startTime2.toString()!='null'){

              notifyHelper.scheduledNotification2(
                int.parse(myTime2.toString().split(":")[0]), //hour
                int.parse(myTime2.toString().split(":")[1]), //minute
                task,

              );
              notifyHelper.cancelNotification(reminderNotificationId2);
            }

            if(task.startTime3.toString()!='null'){

              notifyHelper.scheduledNotification3(
                int.parse(myTime3.toString().split(":")[0]), //hour
                int.parse(myTime3.toString().split(":")[1]), //minute
                task,
              );
              notifyHelper.cancelNotification(reminderNotificationId3);
            }




            // update if daily task is completed to reset it every 11:59 pm is not completed
            if (DateTime.now().hour == 23 && DateTime.now().minute == 59) {
              _taskController.markTaskAsCompleted(task.id!, false);
            }

            return AnimationConfiguration.staggeredList(
              position: index,
              child: SlideAnimation(
                child: FadeInAnimation(
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          _showBottomSheet(context, task);
                        },
                        onLongPress: () {
                          HapticFeedback.mediumImpact();
                          Get.to(
                            () => AddTaskPage(task: task),
                          );
                        },
                        child: TaskTile(
                          task,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          } else if (task.date == DateFormat.yMd().format(_selectedDateOfview)) {
            if(DateFormat.yMd().format(_selectedDateOfview)==DateFormat.yMd().format(DateTime.now())){
              if (task.remind! > 0) {
                notifyHelper.remindNotification(
                  int.parse(remind.toString().split(":")[0]), //hour
                  int.parse(remind.toString().split(":")[1]), //minute
                  task,

                );
                notifyHelper.cancelNotification(reminderNotificationId);


                if(task.startTime2.toString()!='null'){
                  notifyHelper.remindNotification2(
                    int.parse(remind2.toString().split(":")[0]), //hour
                    int.parse(remind2.toString().split(":")[1]), //minute
                    task,

                  );
                  notifyHelper.cancelNotification(reminderNotificationId2);
                }


                if(task.startTime3.toString()!='null'){
                  notifyHelper.remindNotification3(
                    int.parse(remind3.toString().split(":")[0]), //hour
                    int.parse(remind3.toString().split(":")[1]), //minute
                    task,
                  );
                  notifyHelper.cancelNotification(reminderNotificationId3);
                }



              }
              notifyHelper.scheduledNotification(
                int.parse(myTime.toString().split(":")[0]), //hour
                int.parse(myTime.toString().split(":")[1]), //minute
                task,
              );
              notifyHelper.cancelNotification(reminderNotificationId);



              if(task.startTime2.toString()!='null'){
                notifyHelper.scheduledNotification2(
                  int.parse(myTime2.toString().split(":")[0]), //hour
                  int.parse(myTime2.toString().split(":")[1]), //minute
                  task,

                );
                notifyHelper.cancelNotification(reminderNotificationId2);
              }




              if(task.startTime3.toString()!='null'){
                notifyHelper.scheduledNotification3(
                  int.parse(myTime3.toString().split(":")[0]), //hour
                  int.parse(myTime3.toString().split(":")[1]), //minute
                  task,
                );
                notifyHelper.cancelNotification(reminderNotificationId3);
              }
            }
            return AnimationConfiguration.staggeredList(
              position: index,
              child: SlideAnimation(
                child: FadeInAnimation(
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          _showBottomSheet(context, task);
                        },
                        child: TaskTile(
                          task,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          } else if (task.repeat == "إسبوعياً" &&
              DateFormat('EEEE').format(_selectedDateOfview) ==
                  DateFormat('EEEE').format(DateTime.now())) {
            return AnimationConfiguration.staggeredList(
              position: index,
              child: SlideAnimation(
                child: FadeInAnimation(
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          _showBottomSheet(context, task);
                        },
                        child: TaskTile(
                          task,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          } else if (task.repeat == "شهرياً" &&
              DateFormat('dd').format(_selectedDateOfview) ==
                  DateFormat('dd').format(DateTime.now())) {
            return AnimationConfiguration.staggeredList(
              position: index,
              child: SlideAnimation(
                child: FadeInAnimation(
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          _showBottomSheet(context, task);
                        },
                        child: TaskTile(
                          task,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          } else {
            return Container();
          }

        },
      );
    });
  }


  /////////////////////////////////////////////////////////////////////
  //////////////////////////////////////////////////////////////////////////
  /////////////////////////////////////////////////////////////////////////
  _showTasksInRandom() {
    return Obx(() {
      return ListView.builder(
        shrinkWrap: true,
       // physics: NeverScrollableScrollPhysics(),
        itemCount: filterTaskList.length,
        itemBuilder: (_, index) {
          Task task = filterTaskList[filterTaskList.length - 1 - index];

          DateTime date = _parseDateTime(task.startTime.toString());
          var myTime = DateFormat.Hm().format(date);
          var remind = DateFormat.Hm()
              .format(date.subtract(Duration(minutes: task.remind!)));
          print("/////////////////////////////////+{}"+task.startTime.toString()+"//////////////////////");
          print("/////////////////////////////////+{}"+task.startTime2.toString()+"//////////////////////");
          print("/////////////////////////////////+{}"+task.startTime3.toString()+"//////////////////////");
          print("------------------------------------------------------------------------------");


          DateTime? date2 ;
          var myTime2 ;
          var remind2 ;
          DateTime? date3 ;
          var myTime3 ;
          var remind3 ;


          if(task.startTime2.toString()!='null'){
            date2 = _parseDateTime(task.startTime2.toString());
            myTime2 = DateFormat.Hm().format(date2);
            remind2 = DateFormat.Hm()
                .format(date2.subtract(Duration(minutes: task.remind!)));
          }
          if(task.startTime3.toString()!='null'){
            date3 = _parseDateTime(task.startTime3.toString());
            myTime3 = DateFormat.Hm().format(date3);
            remind3 = DateFormat.Hm()
                .format(date3.subtract(Duration(minutes: task.remind!)));
          }



          int mainTaskNotificationId = task.id!.toInt();
          int reminderNotificationId = mainTaskNotificationId + 300;
          int reminderNotificationId2 = mainTaskNotificationId + 400;
          int reminderNotificationId3 = mainTaskNotificationId + 500;

          if (task.repeat == "يومياً") {
            if (task.remind! > 4) {

              notifyHelper.remindNotification(
                int.parse(remind.toString().split(":")[0]), //hour
                int.parse(remind.toString().split(":")[1]), //minute
                task,
              );
              notifyHelper.cancelNotification(reminderNotificationId);
              notifyHelper.scheduledNotification(
                int.parse(myTime.toString().split(":")[0]), //hour
                int.parse(myTime.toString().split(":")[1]), //minute
                task,
              );
              notifyHelper.cancelNotification(reminderNotificationId);





              if(task.startTime2.toString()!='null'){
                notifyHelper.remindNotification2(
                  int.parse(remind2.toString().split(":")[0]), //hour
                  int.parse(remind2.toString().split(":")[1]), //minute
                  task,
                );
                notifyHelper.cancelNotification(reminderNotificationId2);
                notifyHelper.scheduledNotification2(
                  int.parse(myTime2.toString().split(":")[0]), //hour
                  int.parse(myTime2.toString().split(":")[1]), //minute
                  task,

                );
                notifyHelper.cancelNotification(reminderNotificationId2);
              }









              if(task.startTime3.toString()!='null'){
                notifyHelper.remindNotification3(
                  int.parse(remind3.toString().split(":")[0]), //hour
                  int.parse(remind3.toString().split(":")[1]), //minute
                  task,

                );
                notifyHelper.cancelNotification(reminderNotificationId3);
                notifyHelper.scheduledNotification3(
                  int.parse(myTime3.toString().split(":")[0]), //hour
                  int.parse(myTime3.toString().split(":")[1]), //minute
                  task,
                );
                notifyHelper.cancelNotification(reminderNotificationId3);
              }


            }




            // update if daily task is completed to reset it every 11:59 pm is not completed
            if (DateTime.now().hour == 23 && DateTime.now().minute == 59) {
              _taskController.markTaskAsCompleted(task.id!, false);
            }

            return AnimationConfiguration.staggeredList(
              position: index,
              child: SlideAnimation(
                child: FadeInAnimation(
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          _showBottomSheet(context, task);
                        },
                        onLongPress: () {
                          HapticFeedback.mediumImpact();
                          Get.to(
                                () => AddTaskPage(task: task),
                          );
                        },
                        child: TaskTile(
                          task,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          } else if (task.repeat == "مرة واحدة") {
            if(task.date==DateFormat.yMd().format(DateTime.now())){

              ///هنا يوجد خطاء يجب اصلاحة وهو عند ما يعرض المنبهات بشكل عشوائي فانه يقوم بعرض المنبهات التي
              ///تكرارها مرة واحدة حتى وان قد نفذت

              if (task.remind! > 0) {
                notifyHelper.remindNotification(
                  int.parse(remind.toString().split(":")[0]), //hour
                  int.parse(remind.toString().split(":")[1]), //minute
                  task,

                );
                notifyHelper.cancelNotification(reminderNotificationId);


                if(task.startTime2.toString()!='null'){
                  notifyHelper.remindNotification2(
                    int.parse(remind2.toString().split(":")[0]), //hour
                    int.parse(remind2.toString().split(":")[1]), //minute
                    task,

                  );
                  notifyHelper.cancelNotification(reminderNotificationId2);
                }


                if(task.startTime3.toString()!='null'){
                  notifyHelper.remindNotification3(
                    int.parse(remind3.toString().split(":")[0]), //hour
                    int.parse(remind3.toString().split(":")[1]), //minute
                    task,
                  );
                  notifyHelper.cancelNotification(reminderNotificationId3);
                }



              }
              notifyHelper.scheduledNotification(
                int.parse(myTime.toString().split(":")[0]), //hour
                int.parse(myTime.toString().split(":")[1]), //minute
                task,
              );
              notifyHelper.cancelNotification(reminderNotificationId);



              if(task.startTime2.toString()!='null'){
                notifyHelper.scheduledNotification2(
                  int.parse(myTime2.toString().split(":")[0]), //hour
                  int.parse(myTime2.toString().split(":")[1]), //minute
                  task,

                );
                notifyHelper.cancelNotification(reminderNotificationId2);
              }




              if(task.startTime3.toString()!='null'){
                notifyHelper.scheduledNotification3(
                  int.parse(myTime3.toString().split(":")[0]), //hour
                  int.parse(myTime3.toString().split(":")[1]), //minute
                  task,
                );
                notifyHelper.cancelNotification(reminderNotificationId3);
              }
            }
            return AnimationConfiguration.staggeredList(
              position: index,
              child: SlideAnimation(
                child: FadeInAnimation(
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          _showBottomSheet(context, task);
                        },
                        child: TaskTile(
                          task,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          } else if (task.repeat == "إسبوعياً") {
            return AnimationConfiguration.staggeredList(
              position: index,
              child: SlideAnimation(
                child: FadeInAnimation(
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          _showBottomSheet(context, task);
                        },
                        child: TaskTile(
                          task,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          } else if (task.repeat == "شهرياً") {
            return AnimationConfiguration.staggeredList(
              position: index,
              child: SlideAnimation(
                child: FadeInAnimation(
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          _showBottomSheet(context, task);
                        },
                        child: TaskTile(
                          task,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          } else {
            return Container();
          }
        },
      );
    });
  }


  DateTime _parseDateTime(String timeString) {
    // Split the timeString into components (hour, minute, period)
    List<String> components = timeString.split(' ');

    // Extract and parse the hour and minute
    List<String> timeComponents = components[0].split(':');
    int hour = int.parse(timeComponents[0]);
    int minute = int.parse(timeComponents[1]);

    // If the time string contains a period (AM or PM),
    //adjust the hour for 12-hour format
    if (components.length > 1) {
      String period = components[1];
      if (period.toLowerCase() == 'pm' && hour < 12) {
        hour += 12;
      } else if (period.toLowerCase() == 'am' && hour == 12) {
        hour = 0;
      }
    }

    return DateTime(DateTime.now().year, DateTime.now().month,
        DateTime.now().day, hour, minute);
  }

  void _showBottomSheet(BuildContext context, Task task) {
    Size size=MediaQuery.of(context).size;
    Get.bottomSheet(
      isDismissible: true,

     // shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(10)),
      Container(
        padding: const EdgeInsets.only(top: 0),
        width: size.width,
        height: task.isCompleted == 1
            ? MediaQuery.of(context).size.height * 0.20
            : MediaQuery.of(context).size.height * 0.25,

        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20)),
          color: Get.isDarkMode ? Color(0xff121212) : Colors.white,
        ),
        
        child: Column(children: [

         20.SH,

          task.isCompleted == 1
              ? Container()
              :MyButtonWithBackground(
            context: context,
            width: MediaQuery.of(context).size.width-50,
            textButton: "إكتملت المهمة" ,
            onPressed: () {
              Get.back();
              _taskController.markTaskAsCompleted(task.id!, true);
              _taskController.getTasks();
            },
          ),
           12.SH,
          MyButtonWithBackground(
            context: context,
            width: MediaQuery.of(context).size.width-50,
            textButton: "حذف المهمة" ,
            onPressed: () {
              Get.back();
              _taskController.deleteTask(task.id!);
              // Cancel delete notification
              if (task.remind! > 4) {
                notifyHelper.cancelNotification(task.id! + 1);
              }
              if(randomOrderView==false){
                _showTasksInOrder();
              }
              else{
                _showTasksInRandom();
              }
            },
          ),


          const SizedBox(height: 15),
          SizedBox(
            width: MediaQuery.of(context).size.width-50,
            child: MyButtonNoBackground(

              context,
              textButton: "إغلاق",
              onPressed: () => Get.back(),
              Width: size.width-50,
              Height: 45

            ),
          )
        ]),
      ),
    );
  }



  _bottomSheetButton(
      {required String label,
      required BuildContext context,
      required Color color,
      required Function()? onTap,
      IconData? icon,
      bool isClose = false}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        // alignment: Alignment.center,
        margin: const EdgeInsets.symmetric(vertical: 7),
        height: 55,
        width: MediaQuery.of(context).size.width * 0.9,

        decoration: BoxDecoration(
          border: Border.all(
            width: 2,
            color: isClose
                ? Get.isDarkMode
                    ? Colors.grey[700]!
                    : Colors.grey[300]!
                : color,
          ),
          borderRadius: BorderRadius.circular(20),
          color: isClose ? Colors.transparent : color,
        ),

        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon != null
                ? Icon(
                    icon,
                    color: isClose
                        ? Get.isDarkMode
                            ? Colors.white
                            : Colors.black
                        : Colors.white,
                    size: 30,
                  )
                : const SizedBox(),
            Text(
              label,
             /* style: titleStyle.copyWith(
                fontSize: 18,
                color: isClose
                    ? Get.isDarkMode
                        ? Colors.white
                        : Colors.black
                    : Colors.white,
              ),*/
            ),
          ],
        ),
      ),
    );
  }

  List<Task> getTasksCompletedToday(List<Task> taskList) {
    DateTime now = DateTime.now();
    DateTime today = DateTime(now.year, now.month, now.day);

    return taskList.where((task) {
      if (task.completedAt == null) {
        return false;
      }

      DateTime completedDate = DateTime.parse(task.completedAt!);
      completedDate = DateTime(
        completedDate.year,
        completedDate.month,
        completedDate.day,
      );

      return completedDate == today;
    }).toList();
  }
}
