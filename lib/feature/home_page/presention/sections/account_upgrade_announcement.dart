import 'package:flutter/material.dart';
import 'package:todo_apps/cache/cache_helper.dart';
import 'package:todo_apps/core/component/my_custom_subtitle.dart';
import 'package:todo_apps/core/component/my_custom_title.dart';
import 'package:todo_apps/core/my_extention/my_extentions.dart';
class AccountUpgradeAnnouncement extends StatefulWidget {
  const AccountUpgradeAnnouncement({super.key});

  @override
  State<AccountUpgradeAnnouncement> createState() => _AccountUpgradeAnnouncementState();
}

class _AccountUpgradeAnnouncementState extends State<AccountUpgradeAnnouncement> {



  @override
  Widget build(BuildContext context) {
    return CacheHelper.getData(key: "role")!="vendor"
        ?Column(
      children: [
        Align(
          alignment: Alignment.topRight,
          child: MyTitle(
              textOfTitle: "    ابدأ رحلتك في عالم البيع!",
              startDelay: 0
          ),
        ),
        MySubTitle(
          textOfSubTitle: "حوّل حسابك الآن إلى 'حساب تاجر مميز' وابدأ رحلتك في البيع والربح معنا!\n\nهل لديك منتجات ترغب في بيعها؟ هل تريد الوصول إلى جمهور واسع بطريقة احترافية وسهلة؟\nقم بترقية حسابك إلى 'حساب بائع معتمد' وابدأ في بناء متجرك الخاص داخل التطبيق خلال دقائق!",
          startDelay: 0,
        ),
        Align(
          alignment: Alignment.topRight,
          child: MyTitle(
               startDelay: 0,
            textOfTitle: "    مميزات وصلاحيات حساب البائع المعتمد",
          ),
        ),
        MySubTitle(
          textOfSubTitle: "🔹 لوحة تحكم احترافية لإدارة منتجاتك بسهولة\n"
              "🔹 رفع منتجاتك الخاصة وعرضها للبيع مباشرة\n"
              "🔹 تعديل أو حذف المنتجات في أي وقت\n"
              "🔹 متابعة الطلبات الخاصة بك\n"
              "  ▫️ عدد الطلبات الكلي\n"
              "  ▫️ عدد الطلبات المعلقة\n"
              "  ▫️ عدد الطلبات التي تم توصيلها\n"
              "🔹 قبول أو رفض الطلبات الخاصة بمنتجاتك\n"
              "🔹 إحصائيات الأرباح:\n"
              "  ▫️ اليومية\n"
              "  ▫️ الأسبوعية\n"
              "  ▫️ الشهرية\n"
              "  ▫️ السنوية\n"
              "🔹 واجهة منظمة وسهلة الاستخدام تساعدك على تتبع كل شيء من مكان واحد",
          startDelay: 0,
        ),
        Align(
          alignment: Alignment.topRight,
          child: MyTitle(
            startDelay: 0,
            textOfTitle: "    ماذا تنتظر؟",
          ),
        ),
        MySubTitle(
          textOfSubTitle: "قم بترقية حسابك الآن وابدأ بيع منتجاتك، واكسب من هوايتك أو مشروعك الصغير عبر تطبيقنا.\nكل ما تحتاجه هو خطوة واحدة لتحول شغفك إلى دخل حقيقي!",
          startDelay: 0,
        ),

        100.SH

      ],
    )
    :100.SH;
  }
}
