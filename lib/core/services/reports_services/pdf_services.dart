import 'dart:io';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_file_dialog/flutter_file_dialog.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';

import '../../../feature/reminder/models/task.dart';

Future<void> exportTasksToPDF(List<Task> tasks) async {

  late Font arFont;
  arFont =Font.ttf((await rootBundle.load("assets/fonts/cairo/Cairo-VariableFont_slnt,wght.ttf")));
  final pdf = pw.Document(

    theme: pw.ThemeData.withFont(

      base:arFont,


    ),



  );

  pdf.addPage(

    pw.MultiPage(

      header: (context) => pw.Center(
        child: pw.Header(
          level: 0,
          child: pw.Text('تقرير خاص المواعيد التي تم تخصيصها مسبقاً وما تم تنفيذه من الاجراءات الخاصة بها ',
              textDirection: pw.TextDirection.rtl
          ),
        ),
      ),
      build: (context) =>
          tasks.map((task) => _buildTaskRow(context, task)).toList(),
    ),
  );

  final directory = await getTemporaryDirectory();
  final file = File('${directory.path}/tasks.pdf');
  await file.writeAsBytes(await pdf.save());

  var rand = Random();
  int randomNumber = rand.nextInt(50);

  final params = SaveFileDialogParams(
    sourceFilePath: file.path,
    localOnly: true,
    fileName: "تقرير المواعيد رقم$randomNumber لتطبيق تيسير.pdf",
  );

  await FlutterFileDialog.saveFile(params: params);
}

pw.Widget _buildTaskRow(pw.Context context, Task task) {

  return pw.Padding(
    padding: const pw.EdgeInsets.all(5.0),
    child:pw.Column(

      children: [
        pw.Text('يهدف هذا التقرير إلى تقديم نظرة شاملة حول مواعيد وتذكيرات المهام التي يتم إدخالها عبر التطبيق سواء كانت متعلقة بالعمل أو بتنظيم مواعيد تناول الأدوية. يُتيح التطبيق للمستخدمين جدولة مهامهم اليومية وتلقي التذكيرات لضمان الالتزام بالمهام والمواعيد المحددة مسبقًا.',
         textDirection: pw.TextDirection.rtl
          ),
        pw.Text('حيث يتم تضمين هذه المواعيد في الجداول التالية: ',
            textDirection: pw.TextDirection.rtl
         ),

        pw.SizedBox(height: 10),
        if(task.reminderType=='عمل')
          pw.Text('جدول خاص بمواعيد الاعمال او الانشطة:',
              textDirection: pw.TextDirection.rtl
         ),

        if(task.reminderType=='عمل')
        pw.Table(
          border: pw.TableBorder.all(),
          children: [
            pw.TableRow(

              children: [
                pw.Text('المعرف:',
                    textDirection: pw.TextDirection.rtl
                ),
                pw.Text(task.id.toString(),textDirection: pw.TextDirection.rtl),
              ],
            ),
            pw.TableRow(
              children: [
                pw.Text('عنوان المنبه:',textDirection: pw.TextDirection.rtl),
                pw.Text(task.title,textDirection: pw.TextDirection.rtl),
              ],
            ),
            pw.TableRow(
              children: [
                pw.Text('ملاحضه:',textDirection: pw.TextDirection.rtl),
                pw.Text(task.note,textDirection: pw.TextDirection.rtl),
              ],
            ),

            pw.TableRow(
              children: [
                pw.Text('التاريخ:' ,textDirection: pw.TextDirection.rtl),
                pw.Text(task.date.toString(),textDirection: pw.TextDirection.rtl),
              ],
            ),
            pw.TableRow(
              children: [
                pw.Text('الاوقات',textDirection: pw.TextDirection.rtl),
                pw.Text(task.startTime.toString(),textDirection: pw.TextDirection.rtl),
                if(task.startTime2!=null)
                  pw.Text(task.startTime2.toString(),textDirection: pw.TextDirection.rtl),
                if(task.startTime3!=null)
                  pw.Text(task.startTime3.toString(),textDirection: pw.TextDirection.rtl),
              ],
            ),
            /*pw.TableRow(
              children: [
                pw.Text('End Time:'),
                pw.Text(task.endTime.toString()),
              ],
            ),*/
            pw.TableRow(
              children: [
                pw.Text('مدة الغفوة:',textDirection: pw.TextDirection.rtl),
                pw.Text(task.remind.toString(),textDirection: pw.TextDirection.rtl),
              ],
            ),
            pw.TableRow(
              children: [
                pw.Text('التكرار:',textDirection: pw.TextDirection.rtl),
                pw.Text(task.repeat.toString(),textDirection: pw.TextDirection.rtl),
              ],
            ),

            pw.TableRow(
              children: [
                pw.Text('هل اكتمل:',textDirection: pw.TextDirection.rtl),
                task.isCompleted==1?
                    pw.Text('نعم',textDirection: pw.TextDirection.rtl)
                    :pw.Text('لا',textDirection: pw.TextDirection.rtl)
              ],
            ),
            pw.TableRow(
              children: [
                pw.Text('تاريخ انشاءه:',textDirection: pw.TextDirection.rtl),
                pw.Text(task.createdAt.toString(),textDirection: pw.TextDirection.rtl),
              ],
            ),
            /*pw.TableRow(
              children: [
                pw.Text('updatedAt:'),
                pw.Text(task.updatedAt.toString()),
              ],
            ),*/
          ],
        ),
pw.SizedBox(height: 10),




/////////////////////////////////////////////////////////////////////////////

        if( task.reminderType=='مقابلة طبيب')
          pw.Text('جدول خاص بمواعيد مقابلة الطبيب:',
              textDirection: pw.TextDirection.rtl),

       if( task.reminderType=='مقابلة طبيب')
        pw.Table(
          border: pw.TableBorder.all(),
          children: [
            pw.TableRow(
              children: [
                pw.Text('المعرف:',textDirection: pw.TextDirection.rtl),
                pw.Text(task.id.toString(),textDirection: pw.TextDirection.rtl),
              ],
            ),
            pw.TableRow(
              children: [
                pw.Text('عنوان المنبه:',textDirection: pw.TextDirection.rtl),
                pw.Text(task.title,textDirection: pw.TextDirection.rtl),
              ],
            ),
            pw.TableRow(
              children: [
                pw.Text('ملاحضه:',textDirection: pw.TextDirection.rtl),
                pw.Text(task.note,textDirection: pw.TextDirection.rtl),
              ],
            ),
            pw.TableRow(
              children: [
                pw.Text('التاريخ:',textDirection: pw.TextDirection.rtl),
                pw.Text(task.date.toString(),textDirection: pw.TextDirection.rtl),
              ],
            ),
            pw.TableRow(
              children: [
                pw.Text('الاوقات',textDirection: pw.TextDirection.rtl),
                pw.Text(task.startTime.toString(),textDirection: pw.TextDirection.rtl),
                if(task.startTime2!=null)
                  pw.Text(task.startTime2.toString(),textDirection: pw.TextDirection.rtl),
                if(task.startTime3!=null)
                  pw.Text(task.startTime3.toString(),textDirection: pw.TextDirection.rtl),
              ],
            ),
            /*pw.TableRow(
              children: [
                pw.Text('End Time:'),
                pw.Text(task.endTime.toString()),
              ],
            ),*/
            pw.TableRow(
              children: [
                pw.Text('مدة الغفوة:',textDirection: pw.TextDirection.rtl),
                pw.Text(task.remind.toString(),textDirection: pw.TextDirection.rtl),
              ],
            ),
            pw.TableRow(
              children: [
                pw.Text('التكرار:',textDirection: pw.TextDirection.rtl),
                pw.Text(task.repeat.toString(),textDirection: pw.TextDirection.rtl),
              ],
            ),

            pw.TableRow(
              children: [
                pw.Text('هل اكتمل:',textDirection: pw.TextDirection.rtl),
                task.isCompleted==1?
                pw.Text('نعم',textDirection: pw.TextDirection.rtl)
                    :pw.Text('لا',textDirection: pw.TextDirection.rtl)
              ],
            ),
            pw.TableRow(
              children: [
                pw.Text('تاريخ انشاءه:',textDirection: pw.TextDirection.rtl),
                pw.Text(task.createdAt.toString(),textDirection: pw.TextDirection.rtl),
              ],
            ),
            /*pw.TableRow(
              children: [
                pw.Text('updatedAt:'),
                pw.Text(task.updatedAt.toString()),
              ],
            ),*/
          ],
        ),

/////////////////////////////////////////////////////////////////////////////////////////////////////

        pw.SizedBox(height: 10),

        if( task.reminderType=='دواء')

          pw.Text('جدول خاص بمواعيد استخدام الادوية:',
              textDirection: pw.TextDirection.rtl
          ),

       if( task.reminderType=='دواء')
        pw.Table(
          border: pw.TableBorder.all(),
          children: [
            pw.TableRow(
              children: [
                pw.Text('المعرف:',textDirection: pw.TextDirection.rtl),
                pw.Text(task.id.toString(),textDirection: pw.TextDirection.rtl),
              ],
            ),
            pw.TableRow(
              children: [
                pw.Text('عنوان المنبه:',textDirection: pw.TextDirection.rtl),
                pw.Text(task.title,textDirection: pw.TextDirection.rtl),
              ],
            ),
            pw.TableRow(
              children: [
                pw.Text('ملاحضه:',textDirection: pw.TextDirection.rtl),
                pw.Text(task.note,textDirection: pw.TextDirection.rtl),
              ],
            ),
            pw.TableRow(
              children: [
                pw.Text('نوع الدواء:',textDirection: pw.TextDirection.rtl),
                pw.Text(task.medicineType.toString(),textDirection: pw.TextDirection.rtl),
              ],
            ),
            pw.TableRow(
              children: [
                pw.Text('كم حبة في المرة',textDirection: pw.TextDirection.rtl),
                task.medicineType=='حبوب'?
                pw.Text(task.numberOfPills.toString(),textDirection: pw.TextDirection.rtl):
                pw.Text('/////////',textDirection: pw.TextDirection.rtl),

              ],
            ),
            pw.TableRow(
              children: [
                pw.Text('عدد حبوب الشريط المتبقية:',textDirection: pw.TextDirection.rtl),
                task.medicineType=='حبوب'?
                pw.Text(task.numberOfStripPills.toString(),textDirection: pw.TextDirection.rtl):
                pw.Text('/////////',textDirection: pw.TextDirection.rtl),

              ],
            ),

            pw.TableRow(
              children: [
                pw.Text('التاريخ:',textDirection: pw.TextDirection.rtl),
                pw.Text(task.date.toString(),textDirection: pw.TextDirection.rtl),
              ],
            ),
            pw.TableRow(
              children: [
                pw.Text('الاوقات',textDirection: pw.TextDirection.rtl),
                pw.Text(task.startTime.toString(),textDirection: pw.TextDirection.rtl),
                if(task.startTime2!=null)
                  pw.Text(task.startTime2.toString(),textDirection: pw.TextDirection.rtl),
                if(task.startTime3!=null)
                  pw.Text(task.startTime3.toString(),textDirection: pw.TextDirection.rtl),
              ],
            ),
            /*pw.TableRow(
              children: [
                pw.Text('End Time:'),
                pw.Text(task.endTime.toString()),
              ],
            ),*/
            pw.TableRow(
              children: [
                pw.Text('مدة الغفوة:',textDirection: pw.TextDirection.rtl),
                pw.Text(task.remind.toString(),textDirection: pw.TextDirection.rtl),
              ],
            ),
            pw.TableRow(
              children: [
                pw.Text('التكرار:',textDirection: pw.TextDirection.rtl),
                pw.Text(task.repeat.toString(),textDirection: pw.TextDirection.rtl),
              ],
            ),

            pw.TableRow(
              children: [
                pw.Text('هل اكتمل:',textDirection: pw.TextDirection.rtl),
                task.isCompleted==1?
                pw.Text('نعم',textDirection: pw.TextDirection.rtl)
                    :pw.Text('لا',textDirection: pw.TextDirection.rtl)
              ],
            ),
            pw.TableRow(
              children: [
                pw.Text('تاريخ انشاءه:',textDirection: pw.TextDirection.rtl),
                pw.Text(task.createdAt.toString(),textDirection: pw.TextDirection.rtl),
              ],
            ),
            /*pw.TableRow(
              children: [
                pw.Text('updatedAt:'),
                pw.Text(task.updatedAt.toString()),
              ],
            ),*/
          ],
        ),

      ]
    )
  );
}
