import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_apps/core/my_extention/my_extentions.dart';


import '../../models/task.dart';

class TaskTile extends StatelessWidget {
  final Task? task;
  const TaskTile(this.task, {super.key});

  @override
  Widget build(BuildContext context) {
    // if (task?.completedAt == DateTime.now()) {
    //   task!.isCompleted = 0;
    // }
    Size size=MediaQuery.of(context).size;
    return Container(

      padding: const EdgeInsets.symmetric(horizontal: 10),
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(bottom: 7,top: 10),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 7,horizontal: 12),
        //  width: SizeConfig.screenWidth * 0.78,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Theme.of(context).colorScheme.background.withOpacity(0.8),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).colorScheme.secondary.withOpacity(0.1),
              spreadRadius: 3,
              blurRadius: 7,
              offset: Offset(0,0)
            )
          ]
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [




              Expanded(
                child: Column(
                  textDirection: TextDirection.rtl,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      task?.title ?? "",
                      style:Theme.of(context).textTheme.labelSmall!.copyWith(fontSize: size.height*0.020,wordSpacing: 0),
                    ),
                    7.SH,
                    Row(
                      textDirection: TextDirection.rtl,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [

                        Text(
                          "${task!.startTime}",
                            style:Theme.of(context).textTheme.labelSmall!.copyWith(fontSize: size.height*0.0150,wordSpacing: 0),
                        ),
                        Text("  -  ",
                            style:Theme.of(context).textTheme.labelSmall!.copyWith(fontSize: size.height*0.0150,wordSpacing: 0)
                        ),
                        Text(
                          "${task!.endTime}",
                          style:Theme.of(context).textTheme.labelSmall!.copyWith(fontSize: size.height*0.0150,wordSpacing: 0),
                        ),
                        const SizedBox(width: 12),
                        Icon(
                          Icons.access_time_rounded,
                          color: Theme.of(context).textTheme.labelSmall!.color,
                          size: size.height*0.02,
                        ),
                        const SizedBox(width: 16),

                      ],
                    ),
                    ///////////////////////
                    /////////////////////////
                    if(task!.startTime2.toString()!='null')
                    const SizedBox(height: 6),
                    if(task!.startTime2.toString()!='null')
                      Row(
                        textDirection: TextDirection.rtl,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [

                          Text(
                            "${task!.startTime2}",
                            style:Theme.of(context).textTheme.labelSmall!.copyWith(fontSize: size.height*0.0150,wordSpacing: 0),
                          ),
                          Text("  -  ",
                              style:Theme.of(context).textTheme.labelSmall!.copyWith(fontSize: size.height*0.0150,wordSpacing: 0)
                          ),
                          Text(
                            "${task!.endTime}",
                            style:Theme.of(context).textTheme.labelSmall!.copyWith(fontSize: size.height*0.0150,wordSpacing: 0),
                          ),
                          const SizedBox(width: 12),
                          Icon(
                            Icons.access_time_rounded,
                            color: Theme.of(context).textTheme.labelSmall!.color,
                            size: size.height*0.02,
                          ),
                          const SizedBox(width: 16),

                        ],
                      ),
                    /////////////////////////
                    ////////////////////////
                    if(task!.startTime3.toString()!='null')
                    const SizedBox(height: 6),
                   // if(task!.startTime3!=null||task!.startTime3.toString()!='')
                    if(task!.startTime3.toString()!='null')
                      Row(
                        textDirection: TextDirection.rtl,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [

                          Text(
                            "${task!.startTime3}",
                            style:Theme.of(context).textTheme.labelSmall!.copyWith(fontSize: size.height*0.0150,wordSpacing: 0),
                          ),
                          Text("  -  ",
                              style:Theme.of(context).textTheme.labelSmall!.copyWith(fontSize: size.height*0.0150,wordSpacing: 0)
                          ),
                          Text(
                            "${task!.endTime}",
                            style:Theme.of(context).textTheme.labelSmall!.copyWith(fontSize: size.height*0.0150,wordSpacing: 0),
                          ),
                          const SizedBox(width: 12),
                          Icon(
                            Icons.access_time_rounded,
                            color:Theme.of(context).textTheme.labelSmall!.color,
                            size:size.height*0.02,
                          ),
                          const SizedBox(width: 16),

                        ],
                      ),
                    7.SH,
                    Text(
                      task?.note ?? "",
                      style:Theme.of(context).textTheme.labelSmall!.copyWith(fontSize: size.height*0.0170,wordSpacing: 0)
                    ),
                  ],
                ),
              ),
              RotatedBox(
                quarterTurns: 3,
                child: Chip(
                  shape: RoundedRectangleBorder(
                    borderRadius:BorderRadius.all(Radius.circular(10)),
                      side: BorderSide(

                      color: Theme.of(context).textTheme.labelSmall!.color!,
                  )),
                  label: Text(
                    "${task!.repeat}",
                    style: Theme.of(context).textTheme.labelSmall!.copyWith(fontSize: size.height*0.0150,wordSpacing: 0,)
                  ),

                  clipBehavior: Clip.antiAlias,
                  shadowColor: Colors.grey,
                  padding: const EdgeInsets.only(
                    top: 0,
                    bottom: 0,
                    left: 4,
                    right: 4,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                height: task!.isCompleted == 1 ? 105 : 90,
                width: 0.9,
                color: Theme.of(context).textTheme.labelSmall!.color,
              ),
              RotatedBox(
                quarterTurns: 3,
                child: Row(

                  children: [
                    task!.isCompleted == 1
                        ? const Icon(Icons.done_rounded)
                        : Container(),
                    Text(
                      task!.isCompleted == 1 ? "اكتمل" : "${task!.reminderType}${task!.reminderType=="دواء"?" - ${task!.medicineType}":"" }",
                      style: Theme.of(context).textTheme.labelSmall!.copyWith(fontSize: size.height*0.018,wordSpacing: 0)
                      ,
                    ),
                  ],
                ),
              ),

            ]),
            if(task!.medicineType=='حبوب')
              Container(
                margin: const EdgeInsets.fromLTRB(50, 3, 2, 7),
                height: 0.9,
                width: double.infinity,
                color: Theme.of(context).textTheme.labelSmall!.color,
              ),
            if(task!.medicineType=='حبوب')
              Text(
                "عدد الحبوب الملزم تناولها في المره: ${task!.numberOfPills}",
                style: Theme.of(context).textTheme.labelSmall!.copyWith(fontSize: size.height*0.0150,wordSpacing: 0)
              ),
            if(task!.medicineType=='حبوب')
            SizedBox(height: 4,),
            if(task!.medicineType=='حبوب')
            Text(
              "عدد الحبوب المتبقية في الشريط: ${task!.numberOfStripPills}",
              style:Theme.of(context).textTheme.labelSmall!.copyWith(fontSize: size.height*0.0150,wordSpacing: 0)
            ),
          ],
        ),
      ),
    );
  }


}
