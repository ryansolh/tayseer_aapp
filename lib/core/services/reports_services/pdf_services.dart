import 'dart:io';
import 'dart:math';
import 'package:flutter_file_dialog/flutter_file_dialog.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart' as llll;

import '../../../feature/reminder/models/task.dart';
import 'package:pdf/widgets.dart' as ggg;

Future<void> exportTasksToPDF(List<Task> tasks) async {
  final pdf = pw.Document();
  //final font = await  pw.Document.load(pw.Font().fontName())
  pdf.addPage(

    pw.MultiPage(
      header: (context) => pw.Center(
        child: pw.Header(
          level: 0,
          child: pw.Text('تقرير خاص المواعيد التي تم تخصيصها مسبقاً وما تم تنفيذه من الاجراءات الخاصة بها ',
              style:
                  pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold,)
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
            style:
            pw.TextStyle(fontSize: 12, )),
        pw.Text('حيث يتم تضمين هذه المواعيد في الجداول التالية: ',
            style:
            pw.TextStyle(fontSize: 12,)),

        pw.SizedBox(height: 10),
        if(task.reminderType=='عمل')
          pw.Text('جدول خاص بمواعيد الاعمال او الانشطة:',
              style:
              pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold,)),

        if(task.reminderType=='عمل')
        pw.Table(
          border: pw.TableBorder.all(),
          children: [
            pw.TableRow(

              children: [
                pw.Text('المعرف:'),
                pw.Text(task.id.toString()),
              ],
            ),
            pw.TableRow(
              children: [
                pw.Text('عنوان المنبه:'),
                pw.Text(task.title),
              ],
            ),
            pw.TableRow(
              children: [
                pw.Text('ملاحضه:'),
                pw.Text(task.note),
              ],
            ),

            pw.TableRow(
              children: [
                pw.Text('التاريخ:' ,),
                pw.Text(task.date.toString()),
              ],
            ),
            pw.TableRow(
              children: [
                pw.Text('الاوقات'),
                pw.Text(task.startTime.toString()),
                if(task.startTime2!=null)
                  pw.Text(task.startTime2.toString()),
                if(task.startTime3!=null)
                  pw.Text(task.startTime3.toString()),
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
                pw.Text('مدة الغفوة:'),
                pw.Text(task.remind.toString()),
              ],
            ),
            pw.TableRow(
              children: [
                pw.Text('التكرار:'),
                pw.Text(task.repeat.toString()),
              ],
            ),

            pw.TableRow(
              children: [
                pw.Text('هل اكتمل:'),
                task.isCompleted==1?
                    pw.Text('نعم')
                    :pw.Text('لا')
              ],
            ),
            pw.TableRow(
              children: [
                pw.Text('تاريخ انشاءه:'),
                pw.Text(task.createdAt.toString()),
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
              style:
              pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold,)),

       if( task.reminderType=='مقابلة طبيب')
        pw.Table(
          border: pw.TableBorder.all(),
          children: [
            pw.TableRow(
              children: [
                pw.Text('المعرف:'),
                pw.Text(task.id.toString()),
              ],
            ),
            pw.TableRow(
              children: [
                pw.Text('عنوان المنبه:'),
                pw.Text(task.title),
              ],
            ),
            pw.TableRow(
              children: [
                pw.Text('ملاحضه:'),
                pw.Text(task.note),
              ],
            ),
            pw.TableRow(
              children: [
                pw.Text('التاريخ:'),
                pw.Text(task.date.toString()),
              ],
            ),
            pw.TableRow(
              children: [
                pw.Text('الاوقات'),
                pw.Text(task.startTime.toString()),
                if(task.startTime2!=null)
                  pw.Text(task.startTime2.toString()),
                if(task.startTime3!=null)
                  pw.Text(task.startTime3.toString()),
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
                pw.Text('مدة الغفوة:'),
                pw.Text(task.remind.toString()),
              ],
            ),
            pw.TableRow(
              children: [
                pw.Text('التكرار:'),
                pw.Text(task.repeat.toString()),
              ],
            ),

            pw.TableRow(
              children: [
                pw.Text('هل اكتمل:'),
                task.isCompleted==1?
                pw.Text('نعم')
                    :pw.Text('لا')
              ],
            ),
            pw.TableRow(
              children: [
                pw.Text('تاريخ انشاءه:'),
                pw.Text(task.createdAt.toString()),
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
              style:
              pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold,)),

       if( task.reminderType=='دواء')
        pw.Table(
          border: pw.TableBorder.all(),
          children: [
            pw.TableRow(
              children: [
                pw.Text('المعرف:'),
                pw.Text(task.id.toString()),
              ],
            ),
            pw.TableRow(
              children: [
                pw.Text('عنوان المنبه:'),
                pw.Text(task.title),
              ],
            ),
            pw.TableRow(
              children: [
                pw.Text('ملاحضه:'),
                pw.Text(task.note),
              ],
            ),
            pw.TableRow(
              children: [
                pw.Text('نوع الدواء:'),
                pw.Text(task.medicineType.toString()),
              ],
            ),
            pw.TableRow(
              children: [
                pw.Text('كم حبة في المرة'),
                task.medicineType=='حبوب'?
                pw.Text(task.numberOfPills.toString()):
                pw.Text('/////////'),

              ],
            ),
            pw.TableRow(
              children: [
                pw.Text('عدد حبوب الشريط المتبقية:'),
                task.medicineType=='حبوب'?
                pw.Text(task.numberOfStripPills.toString()):
                pw.Text('/////////'),

              ],
            ),

            pw.TableRow(
              children: [
                pw.Text('التاريخ:'),
                pw.Text(task.date.toString()),
              ],
            ),
            pw.TableRow(
              children: [
                pw.Text('الاوقات'),
                pw.Text(task.startTime.toString()),
                if(task.startTime2!=null)
                  pw.Text(task.startTime2.toString()),
                if(task.startTime3!=null)
                  pw.Text(task.startTime3.toString()),
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
                pw.Text('مدة الغفوة:'),
                pw.Text(task.remind.toString()),
              ],
            ),
            pw.TableRow(
              children: [
                pw.Text('التكرار:'),
                pw.Text(task.repeat.toString()),
              ],
            ),

            pw.TableRow(
              children: [
                pw.Text('هل اكتمل:'),
                task.isCompleted==1?
                pw.Text('نعم')
                    :pw.Text('لا')
              ],
            ),
            pw.TableRow(
              children: [
                pw.Text('تاريخ انشاءه:'),
                pw.Text(task.createdAt.toString()),
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
