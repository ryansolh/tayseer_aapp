import 'dart:io';
import 'dart:math';
import 'package:flutter/services.dart';
import 'package:flutter_file_dialog/flutter_file_dialog.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import '../../../feature/reminder/models/task.dart';

Future exportTasksToPDF(List<Task> tasks) async {
  // تحميل الخط العربي
  final arFont = pw.Font.ttf(await rootBundle.load("assets/fonts/Tajawal-Font/ArbFONTS-Tajawal-Regular.ttf"));
  final pdf = pw.Document(
    theme: pw.ThemeData.withFont(base: arFont),
  );

  pdf.addPage(
    pw.MultiPage(
      textDirection: pw.TextDirection.rtl, // تأكد من اتجاه النص في كل الصفحة
      theme: pw.ThemeData.withFont(base: arFont),
      header: (context) => pw.Center(
        child: pw.Header(
          level: 0,
          child: pw.Text(
            'تقرير خاص بالمواعيد التي تم تخصيصها مسبقاً وما تم تنفيذه من الإجراءات الخاصة بها',
            style: pw.TextStyle(font: arFont, fontSize: 16),
          ),
        ),
      ),
      build: (context) => tasks.map((task) => _buildTaskRow(context, task, arFont)).toList(),
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
    fileName: "تقرير المواعيد رقم $randomNumber لتطبيق تيسير.pdf",
  );

  await FlutterFileDialog.saveFile(params: params);
}

pw.Widget _buildTaskRow(pw.Context context, Task task, pw.Font arFont) {
  return pw.Padding(
    padding: const pw.EdgeInsets.all(5.0),
    child: pw.Column(
      children: [
        pw.Text(
          'يهدف هذا التقرير إلى تقديم نظرة شاملة حول مواعيد وتذكيرات المهام التي يتم إدخالها عبر التطبيق سواء كانت متعلقة بالعمل أو بتنظيم مواعيد تناول الأدوية.',
          textDirection: pw.TextDirection.rtl,
          style: pw.TextStyle(font: arFont, fontSize: 12),
        ),
        pw.SizedBox(height: 10),

        if (task.reminderType == 'عمل') _buildTable(task, 'جدول خاص بمواعيد الأعمال أو الأنشطة:', arFont),
        if (task.reminderType == 'مقابلة طبيب') _buildTable(task, 'جدول خاص بمواعيد مقابلة الطبيب:', arFont),
        if (task.reminderType == 'دواء') _buildTable(task, 'جدول خاص بمواعيد استخدام الأدوية:', arFont),
      ],
    ),
  );
}

pw.Widget _buildTable(Task task, String title, pw.Font arFont) {
  return pw.Column(
    crossAxisAlignment: pw.CrossAxisAlignment.start,
    children: [
      pw.Text(title, textDirection: pw.TextDirection.rtl, style: pw.TextStyle(font: arFont, fontSize: 14, fontWeight: pw.FontWeight.bold)),
      pw.SizedBox(height: 5),
      pw.Table(
        border: pw.TableBorder.all(),
        children: [
          _buildTableRow('المعرف:', task.id.toString(), arFont),
          _buildTableRow('عنوان المنبه:', task.title, arFont),
          _buildTableRow('ملاحظة:', task.note, arFont),
          _buildTableRow('نوع التنبيه:', task.reminderType!, arFont),
          if((task.reminderType!)=='دواء')
          _buildTableRow('نوع الدواء:', task.medicineType!, arFont),
          if((task.reminderType!)=='دواء'&&(task.medicineType!)=="حبوب")
            _buildTableRow('كم حبة تشرب في كل مرة', task.numberOfPills.toString(), arFont),
          if((task.reminderType!)=='دواء'&&(task.medicineType!)=="حبوب")
            _buildTableRow('عدد حبوب الشريط المتبقية', task.numberOfStripPills.toString(), arFont),
          _buildTableRow('التاريخ:', task.date.toString(), arFont),
          _buildTableRow('الأوقات:', '${task.startTime ?? ''} ${task.startTime2 ?? ''} ${task.startTime3 ?? ''}', arFont),
          _buildTableRow('مدة الغفوة:', task.remind.toString(), arFont),
          _buildTableRow('التكرار:', task.repeat.toString(), arFont),
          _buildTableRow('هل اكتمل:', task.isCompleted == 1 ? 'نعم' : 'لا', arFont),
          _buildTableRow('تاريخ الإنشاء:', task.createdAt.toString(), arFont),
        ],
      ),
      pw.SizedBox(height: 10),
    ],
  );
}

pw.TableRow _buildTableRow(String title, String value, pw.Font arFont) {
  return pw.TableRow(
    children: [
      pw.Padding(
        padding: const pw.EdgeInsets.all(5.0),
        child: pw.Text(title, textDirection: pw.TextDirection.rtl, style: pw.TextStyle(font: arFont, fontSize: 12, fontWeight: pw.FontWeight.bold)),
      ),
      pw.Padding(
        padding: const pw.EdgeInsets.all(5.0),
        child: pw.Text(value, textDirection: pw.TextDirection.rtl, style: pw.TextStyle(font: arFont, fontSize: 12)),
      ),
    ],
  );
}
















