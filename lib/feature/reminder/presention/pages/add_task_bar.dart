import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todo_apps/core/component/my_custom_buttons.dart';
import 'package:todo_apps/core/component/my_custom_shadermask.dart';
import 'package:todo_apps/core/component/my_custom_title.dart';
import 'package:todo_apps/core/my_extention/my_extentions.dart';
import '../../../../core/services/confirmed_app_message_sevice/snakbar_message_sevice.dart';
import '../../../../core/task_db_controllers/device_info.dart';
import '../../../../core/task_db_controllers/task.controller.dart';
import '../../models/task.dart';
import '../widgets/confirmation_dialog_of_adding_task.dart';
import '../widgets/input_field.dart';

class AddTaskPage extends StatefulWidget {
  final Task? task;

  const AddTaskPage({Key? key, this.task}) : super(key: key);

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  String? deviceName;

  final TaskController _taskController = Get.put(TaskController());
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();


  int _numOfStartTime=1;

  DateTime _selectedDate = DateTime.now();
  String _startTime = DateFormat("hh:mm a")
      .format(DateTime.now().add(const Duration(minutes: 2)))
      .toString();
  String? _startTime2;
  String? _startTime3;
  String _endTime = DateFormat("hh:mm a")
      .format(DateTime.now().add(const Duration(minutes: 10)))
      .toString();

  int _selectedRemind = 0;
  List<int> remindList = [0, 5, 10, 15, 20, 25, 30];


  String _selectedRepeat = "مرة واحدة";
  List<String> repeatList = ["مرة واحدة", "يومياً", "إسبوعياً", "شهرياً"];


  String _numOfTimes="1";
  List<String> countOfTimes = ["1", "2", "3"];

  String _reminderType="عمل";
  List<String> typeofReminder = ["عمل","مقابلة طبيب","دواء"];
  String? _medicineType;
  List<String> medicineType = ["حقن","شراب","حبوب"];
  String? _medicineName;
  int? _numberOfStripPills;
  List<String> numberOfStripPills = ["1", "2", "3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20"];
  int? _numberOfPills;
  List<String> numberOfPills = ["1", "2", "3",];


  int _selectedColor = 0;

  @override
  void initState() {
    super.initState();

    if (widget.task != null) {
      _titleController.text = widget.task!.title;
      _noteController.text = widget.task!.note;
      // _reminderType=widget.task!.reminderType!;
      // _medicineType=widget.task!.medicineType!;
      // _medicineName=widget.task!.medicineName!;
      //  _numberOfStripPills=widget.task!.numberOfStripPills!;
      //  _numberOfPills=widget.task!.numberOfPills!;
      _selectedDate = DateFormat.yMd().parse(widget.task!.date!);
      _startTime = widget.task!.startTime!;
      _startTime2 = widget.task!.startTime2!;
      _startTime3 = widget.task!.startTime3!;
      _endTime = widget.task!.endTime!;
      _selectedRemind = widget.task!.remind!;
      _selectedRepeat = widget.task!.repeat!;
      _selectedColor = widget.task!.color!;
    }

    DeviceInfo deviceInfo = DeviceInfo();
    deviceInfo.getDeviceName().then((value) {
      setState(() {
        deviceName = value;
      });
    });
  }
  @override
  void setState(VoidCallback fn) {
    // TODO: implement setState
    super.setState(fn);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: context.theme.colorScheme.background,

      body: Container(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              30.SH,
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [

                  MyTitle(startDelay: 0,textOfTitle: widget.task == null ? "إضافة موعد" : "تعديل موعد",),

                  MyShaderMask(
                    toolWidget: IconButton(
                      onPressed: (){
                        Get.back();
                      }, icon: Icon(Icons.chevron_right_sharp,size: 40,color: Colors.white,),


                    ),
                    radius: 1.5,
                  ),
                ],
              ),
             // _titleBar(),
              _inputField(),
              50.SH
            ],
          ),
        ),
      ),
    );
  }




  _getDateFromUser() async {
    DateTime? pickerDate = await showDatePicker(

      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(const Duration(days: 365 * 4)),
      lastDate: DateTime.now().add(const Duration(days: 365 * 8)),

    );

    if (pickerDate != null) {
      setState(() {
        _selectedDate = pickerDate;
      });
    }
  }

  _getTimeFromUser({required bool isStartTime ,required bool isStartTime2 ,required bool isStartTime3 ,}) async {
    var pickTime = await _showTimePicker(_numOfStartTime);

    if (pickTime != null) {
      // ignore: use_build_context_synchronously
      String formatedTime = pickTime.format(context);

      setState(() {
        if (isStartTime) {
          _numOfStartTime=1;
          _startTime = formatedTime;
        }
        else if (isStartTime2) {
          _numOfStartTime=2;
          _startTime2 = formatedTime;
        }
        else if (isStartTime3) {
          _numOfStartTime=3;
          _startTime3 = formatedTime;
        }else {
          _endTime = formatedTime;
        }
      });
    }
  }

  _showTimePicker(int numOfStartTime) {

    return showTimePicker(


      initialEntryMode: TimePickerEntryMode.dial,
      context: context,
      initialTime: TimeOfDay(
        hour: int.parse(numOfStartTime==1?_startTime.split(":")[0]:numOfStartTime==2?_startTime2!.split(":")[0]:_startTime3!.split(":")[0]),
        minute: int.parse(numOfStartTime==1?_startTime.split(":")[1].split(" ")[0]:numOfStartTime==2?_startTime2!.split(":")[1].split(" ")[0]:_startTime3!.split(":")[1].split(" ")[0]),
      ),
    );
  }

  _inputField() {
    return Container(
      margin: const EdgeInsets.only(
          top: 16,
        bottom: 16
      ),
      child: SingleChildScrollView(
        child: Column(

          children: [
            MyInputField(
              title: "العنوان",
              hint: "ادخل عنوان الموعد",
              controller: _titleController,
            ),
            MyInputField(
              title: "ملاحظة",
              hint: "ادخل ملاحظتك",
              controller: _noteController,
            ),
            Row(
              children: [
                Expanded(
                  child: MyInputField(
                    title: "نوع التنبيه",
                    hint: _reminderType,
                    widget: DropdownButton(
                      icon: const Icon(
                        Icons.keyboard_arrow_down,
                        color: Colors.grey,
                      ),
                      iconSize: 32,
                      elevation: 4,
                      padding: const EdgeInsets.only(right: 5),
                     // style: subTitleStyle,
                      underline: Container(
                        height: 0,
                        color: Colors.transparent,
                      ),
                      onChanged: (String? newValue) {
                        setState(() {
                          _reminderType = newValue!;
                        });
                        if(_reminderType=="دواء"){
                          setState((){
                            _medicineType="حبوب";
                            if(_medicineType=="حبوب"){
                              setState((){
                                _numberOfStripPills=8;
                                _numberOfPills=1;
                              });
                            }
                            else{
                              setState((){
                                _numberOfStripPills=null;
                                _numberOfPills=null;
                                print(_numberOfPills);
                              });
                            }
                          });
                        }
                        else{
                          setState((){
                            _medicineType='null';
                          });
                        }
                      },
                      items: typeofReminder.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                          //  style: subTitleStyle,
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                if(_reminderType=="دواء"&&(_medicineType!='null'||_medicineType!=''))
                  SizedBox(width: 12,),
                if(_reminderType=="دواء"&&(_medicineType!='null'||_medicineType!=''))
                  Expanded(
                    child: MyInputField(
                      title: "نوع الدواء",
                      hint: _medicineType!.toString(),
                      widget: Align(
                        child: DropdownButton(


                          icon: const Icon(
                            Icons.keyboard_arrow_down,
                            color: Colors.grey,
                          ),
                          iconSize: 32,
                          elevation: 4,

                         // style: subTitleStyle,
                          underline: Container(
                            height: 0,
                            color: Colors.transparent,
                          ),
                          onChanged: (String? newValue) {
                            setState(() {
                              _medicineType = newValue!;
                            });
                            if(_medicineType=="حبوب"){
                              setState((){
                                _numberOfStripPills=8;
                                _numberOfPills=1;
                              });
                            }
                            else{
                              setState((){
                                _numberOfStripPills=null;
                                _numberOfPills=null;
                                print(_numberOfPills);
                              });
                            }

                          },
                          items: medicineType.map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                               // style: subTitleStyle,
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
        
            if(_medicineType=="حبوب"&&(_numberOfStripPills!=null||_numberOfPills!=null))
              Row(
                children: [
                  Expanded(
                    child: MyInputField(
                      title: "عدد حبوب الشريط",
                      hint: _numberOfStripPills!.toString(),
                      widget: DropdownButton(
                        icon: const Icon(
                          Icons.keyboard_arrow_down,
                          color: Colors.grey,
                        ),
                        iconSize: 32,
                        elevation: 4,
                        padding: const EdgeInsets.only(right: 5),
                       // style: subTitleStyle,
                        underline: Container(
                          height: 0,
                          color: Colors.transparent,
                        ),
                        onChanged: (String? newValue) {
                          setState(() {
                            _numberOfStripPills = int.parse(newValue!);
                          });

                        },
                        items: numberOfStripPills.map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                             // style: subTitleStyle,
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  SizedBox(width: 12,),
                  Expanded(
                    child: MyInputField(
                      title: " كم حبة تشرب في كل مرة",
                      hint: _numberOfPills!.toString(),
                      widget: DropdownButton(
                        icon: const Icon(
                          Icons.keyboard_arrow_down,
                          color: Colors.grey,
                        ),
                        iconSize: 32,
                        elevation: 4,
                        padding: const EdgeInsets.only(right: 5),
                       // style: subTitleStyle,
                        underline: Container(
                          height: 0,
                          color: Colors.transparent,
                        ),
                        onChanged: (String? newValue) {
                          setState(() {
                            _numberOfPills =int.parse(newValue!);
                          });
        
        
                        },
                        items: numberOfPills.map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                             // style: subTitleStyle,
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ],
              ),
            Row(
              children: [
                Expanded(
                  child: MyInputField(
                    title: "التاريخ",
                    hint: DateFormat.yMd().format(_selectedDate),
                    widget: IconButton(
                      onPressed: () => {
                        _getDateFromUser(),
                      },
                      icon: const Icon(
                        Icons.calendar_month_outlined,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 20,),
                Expanded(
                  child: MyInputField(
                    title: "عدد المرات",
                    hint: _numOfTimes,
                    widget: DropdownButton(
                      icon: const Icon(
                        Icons.keyboard_arrow_down,
                        color: Colors.grey,
                      ),
                      iconSize: 32,
                      elevation: 4,
                      padding: const EdgeInsets.only(right: 5),
                     // style: subTitleStyle,
                      underline: Container(
                        height: 0,
                        color: Colors.transparent,
                      ),
                      onChanged: (String? newValue) {
                        setState(() {
                          _numOfTimes = newValue!;
        
                          if(_numOfTimes=="2"||_numOfTimes=="3"){
                            _startTime2 = DateFormat("hh:mm a")
                                .format(DateTime.now().add(const Duration(minutes: 2)))
                                .toString();
                          }
                          if(_numOfTimes=="3"){
                            _startTime3 = DateFormat("hh:mm a")
                                .format(DateTime.now().add(const Duration(minutes: 2)))
                                .toString();
                          }
                        });
                      },
                      items: countOfTimes.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                           // style: subTitleStyle,
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ],
            ),
        
            if(_numOfTimes=="1"||_numOfTimes=="2"||_numOfTimes=="3")
              MyInputField(
                title: _numOfTimes=="1"?"الوقت":"الوقت الاول",
                hint: _startTime,
                widget: IconButton(
                  onPressed: () => {
                    setState(_getTimeFromUser(isStartTime: true,isStartTime2: false,isStartTime3: false),)
                  },
                  icon: const Icon(
                    Icons.access_time_rounded,
                    color: Colors.grey,
                  ),
                ),
              ),
            if(_numOfTimes=="2"||_numOfTimes=="3")
              MyInputField(
                title: "الوقت الثاني",
                hint: _startTime2!,
                widget: IconButton(
                  onPressed: () => {
                    setState(_getTimeFromUser(isStartTime: false,isStartTime2: true,isStartTime3: false),)
                  },
                  icon: const Icon(
                    Icons.access_time_rounded,
                    color: Colors.grey,
                  ),
                ),
              ),
            if(_numOfTimes=="3")
              MyInputField(
                title: "الوقت الثالث",
                hint: _startTime3!,
                widget: IconButton(
                  onPressed: () => {
                    _getTimeFromUser(isStartTime: false,isStartTime2: false,isStartTime3: true),
                  },
                  icon: const Icon(
                    Icons.access_time_rounded,
                    color: Colors.grey,
                  ),
                ),
              ),
        
        
            Row(
              children: [
                Expanded(
                  child: MyInputField(
                    title: "عفوة",
                    hint: "${_selectedRemind} دقيقة.",
                    widget: DropdownButton(
                      icon: const Icon(
                        Icons.keyboard_arrow_down,
                        color: Colors.grey,
                      ),
                      iconSize: 32,
                      elevation: 4,
                      padding: const EdgeInsets.only(right: 5),
                      // style: subTitleStyle,
                      underline: Container(
                        height: 0,
                        color: Colors.transparent,
                      ),
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedRemind = int.parse(newValue!);
                        });
                      },
                      items: remindList.map<DropdownMenuItem<String>>((int value) {
                        return DropdownMenuItem<String>(
                          value: value.toString(),
                          child: Text(
                            "$value دقيقة.",
                            //style: subTitleStyle,
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                20.SW,
                Expanded(
                  child: MyInputField(
                    title: "التكرار",
                    hint: _selectedRepeat,
                    widget: DropdownButton(
                      icon: const Icon(
                        Icons.keyboard_arrow_down,
                        color: Colors.grey,
                      ),
                      iconSize: 32,
                      elevation: 4,
                      padding: const EdgeInsets.only(right: 5),
                      // style: subTitleStyle,
                      underline: Container(
                        height: 0,
                        color: Colors.transparent,
                      ),
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedRepeat = newValue!;
                        });
                      },
                      items: repeatList.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            // style: subTitleStyle,
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ],
            ),
        
        
        
            12.SH,
            MyButtonWithBackground(
              context: context,
              textButton: widget.task == null ? "إضافة الموعد" : "تعديل موعد",
              onPressed: ()=>_validateData(),
            ),
            20.SH
        
        
          ],
        ),
      ),
    );
  }

  _validateData() {

    if (_titleController.text.isNotEmpty && _noteController.text.isNotEmpty) {
      // Add to database
      final _taskController = Get.put(TaskController());
      if(_taskController.taskList.isEmpty){
        _addTaskToDb();
        Get.back();
      }
      else{
        if(_reminderType!="مقابلة طبيب"){
          _addTaskToDb();
          Get.back();
        }
       else{
      bool StopSerch=false;
      for(var taskCheck in _taskController.taskList){
        if(StopSerch==false){
          if(taskCheck.reminderType=="مقابلة طبيب"){

            if(_selectedRepeat=="يومياً"){


             if(StopSerch==false){
               if(_startTime==(taskCheck.startTime)||
                   _startTime==(taskCheck.startTime2)||
                   _startTime==(taskCheck.startTime3)){
                 StopSerch=true;


               }
             }
              //---------------------------------------
             if(StopSerch==false){
               if(_numOfTimes=="2"||_numOfTimes=="3"){
                 if(_startTime2==(taskCheck.startTime)||
                     _startTime2==(taskCheck.startTime2)||
                     _startTime2==(taskCheck.startTime3)){
                   StopSerch=true;
                 }
               }
             }

             //---------------------------------------
             if(StopSerch==false){
               if(_numOfTimes=="3"){
                 if(_startTime3==(taskCheck.startTime)||
                     _startTime3==(taskCheck.startTime2)||
                     _startTime3==(taskCheck.startTime3)){
                   StopSerch=true;
                 }
               }
             }



            }

            ///////////////////////////////////////////
            ///////////////////////////////////////////
            ///////////////////////////////////////////
            ///////////////////////////////////////////
            else if(_selectedRepeat=="إسبوعياً"){
              DateTime parsedDate=DateFormat('M/d/yyyy').parse("${taskCheck.date}");
              if( DateFormat('EEEE').format(_selectedDate) ==DateFormat('EEEE').format(parsedDate)){


                if(StopSerch==false){
                  if(_startTime==(taskCheck.startTime)||
                      _startTime==(taskCheck.startTime2)||
                      _startTime==(taskCheck.startTime3)){
                    StopSerch=true;


                  }
                }
                //---------------------------------------
                if(StopSerch==false){
                  if(_numOfTimes=="2"||_numOfTimes=="3"){
                    if(_startTime2==(taskCheck.startTime)||
                        _startTime2==(taskCheck.startTime2)||
                        _startTime2==(taskCheck.startTime3)){
                      StopSerch=true;
                    }
                  }
                }

                //---------------------------------------
                if(StopSerch==false){
                  if(_numOfTimes=="3"){
                    if(_startTime3==(taskCheck.startTime)||
                        _startTime3==(taskCheck.startTime2)||
                        _startTime3==(taskCheck.startTime3)){
                      StopSerch=true;
                    }
                  }
                }



              }
              //______________________________________________

            }
            ///////////////////////////////////////////
            ///////////////////////////////////////////
            ///////////////////////////////////////////
            ///////////////////////////////////////////
            else if(_selectedRepeat=="شهرياً"){
              DateTime parsedDate=DateFormat('M/d/yyyy').parse("${taskCheck.date}");
              if( DateFormat('dd').format(_selectedDate) ==
                  DateFormat('dd').format(parsedDate)){
                if(StopSerch==false){
                  if(_startTime==(taskCheck.startTime)||
                      _startTime==(taskCheck.startTime2)||
                      _startTime==(taskCheck.startTime3)){
                    StopSerch=true;


                  }
                }
                //---------------------------------------
                if(StopSerch==false){
                  if(_numOfTimes=="2"||_numOfTimes=="3"){
                    if(_startTime2==(taskCheck.startTime)||
                        _startTime2==(taskCheck.startTime2)||
                        _startTime2==(taskCheck.startTime3)){
                      StopSerch=true;
                    }
                  }
                }
                //---------------------------------------
                if(StopSerch==false){
                  if(_numOfTimes=="3"){
                    if(_startTime3==(taskCheck.startTime)||
                        _startTime3==(taskCheck.startTime2)||
                        _startTime3==(taskCheck.startTime3)){
                      StopSerch=true;
                    }
                  }
                }
              }
              //______________________________________________
            }
            else if(_selectedRepeat=="مرة واحدة"){
              DateTime parsedDate=DateFormat('M/d/yyyy').parse("${taskCheck.date}");
              if( DateFormat.yMd().format(parsedDate) ==
                  DateFormat.yMd().format(_selectedDate)){
                if(StopSerch==false){
                  if(_startTime==(taskCheck.startTime)||
                      _startTime==(taskCheck.startTime2)||
                      _startTime==(taskCheck.startTime3)){
                    StopSerch=true;


                  }
                }
                //---------------------------------------
                if(StopSerch==false){
                  if(_numOfTimes=="2"||_numOfTimes=="3"){
                    if(_startTime2==(taskCheck.startTime)||
                        _startTime2==(taskCheck.startTime2)||
                        _startTime2==(taskCheck.startTime3)){
                      StopSerch=true;
                    }
                  }
                }
                //---------------------------------------
                if(StopSerch==false){
                  if(_numOfTimes=="3"){
                    if(_startTime3==(taskCheck.startTime)||
                        _startTime3==(taskCheck.startTime2)||
                        _startTime3==(taskCheck.startTime3)){
                      StopSerch=true;
                    }
                  }
                }
              }
              //______________________________________________
            }
          }
        }
      }
      if(StopSerch==true){
        alertDialog(context: context,onPressed: (){
          _addTaskToDb();
          Get.back();
          Navigator.pop(context, 'متابعة');
        });
      }else{
        _addTaskToDb();
        Get.back();
      }

    }
      }


    } else if (_titleController.text.isEmpty || _noteController.text.isEmpty) {
     if(_titleController.text.isEmpty&&_noteController.text.isEmpty){
       showCustomSnackbar(
         backgroundColor: Colors.red,
           title:"لايمكن إضافة المنبه!!",
           subTitle: "يجب عليك إدخال عنوان المنبه والملاحضة."

       );
     }
     else if(_titleController.text.isEmpty&&_noteController.text.isNotEmpty){
       showCustomSnackbar(
         backgroundColor: Colors.red,
           title:"لايمكن إضافة المنبه!!",
           subTitle: "يجب عليك إدخال عنوان المنبه."

       );
     }
     else if(_titleController.text.isNotEmpty&&_noteController.text.isEmpty){
       showCustomSnackbar(
         backgroundColor: Colors.red,
           title:"لايمكن إضافة المنبه!!",
           subTitle: "يجب عليك إدخال الملاحضة."

       );
     }

    }
  }



  void _addTaskToDb() async {
    Task task = Task(
      id: widget.task?.id,
      title: _titleController.text,
      note: _noteController.text,
      date: DateFormat.yMd().format(_selectedDate),
      reminderType: _reminderType,
      medicineType:_medicineType,
      numberOfStripPills: _numberOfStripPills,
      numberOfPills: _numberOfPills,
      startTime: _startTime,
      startTime2: _startTime2,
      startTime3: _startTime3,
      endTime: _endTime,
      remind: _selectedRemind,
      repeat: _selectedRepeat,
      color: _selectedColor,
      isCompleted: widget.task?.isCompleted ?? 0,
      createdAt:
      widget.task?.createdAt ?? DateFormat.yMd().format(DateTime.now()),
      updatedAt: DateFormat.yMd().format(DateTime.now()),
    );

    if (widget.task == null) {
      // Add a new task to the database
      await _taskController.addTask(task: task);
    } else {
      // Update the existing task in the database
      await _taskController.updateTaskInfo(task);
    }
    // Navigate back to the task list
    //Get.back();
  }
}
