import 'package:flutter/material.dart';

List<Map<String, dynamic>> centersData = [
  {
    "id": 1,
    "name": "مركز جنة لرعاية ذوي الاحتياجات الخاصة",
    "imageUrl": "https://scontent.fsah2-1.fna.fbcdn.net/v/t39.30808-6/366830135_158407630620503_1589564997598494899_n.jpg?stp=dst-jpg_s960x960_tt6&_nc_cat=103&ccb=1-7&_nc_sid=cc71e4&_nc_ohc=LCTWsMD8xvgQ7kNvgEWPQZf&_nc_zt=23&_nc_ht=scontent.fsah2-1.fna&_nc_gid=AhsqGM3dtMVELCNAWLdztJG&oh=00_AYCmQubOevgtWHvAw_hY2frPjPzZ4J9GgV95OKMh_XjcNw&oe=67983652",
    "description": "يقدم المركز خدمات رعاية وتأهيل شاملة للأطفال ذوي الاحتياجات الخاصة، مع برامج تعليمية وتدريبية متخصصة.",
    "services": [
      {
        "name": "الخدمات التعليمية والتأهيلية",
        "subServices": [
          "برامج التعليم الخاص",
          "برامج التدخل المبكر للأطفال",
        ],
      },
      {
        "name": "الخدمات الاجتماعية",
        "subServices": [
          "دعم الأسر والإرشاد الأسري",
          "برامج الدمج المجتمعي",
        ],
      },
    ],
    "location": {
      "latitude": 15.369445,
      "longitude": 44.191006,
    },
    "address": "صنعاء ـ الحصبة ـ أمام اللجنة الدائمة",
    "contactNumber": "770402500",
    "whatsappNumber": "770402500",
  },
  {
    "id": 2,
    "name": "مركز التأهيل التعليمي والمهني لذوي الاحتياجات الخاصة",
    "imageUrl": "https://evrcsn.com/storage/images/%D9%85%D8%B1%D9%83%D8%B2%20%D8%A7%D9%84%D8%AA%D8%A7%D9%87%D9%8A%D9%84%20%20%D8%B5%D9%88%D8%B1%D8%A9_2.jpg",
    "description": "يقدم المركز برامج تعليمية ومهنية لذوي الاحتياجات الخاصة، بهدف دمجهم في المجتمع وتعزيز مهاراتهم الحياتية.",
    "services": [
      {
        "name": "الخدمات التعليمية والتأهيلية",
        "subServices": [
          "التدريب المهني والتأهيل للعمل",
          "تعليم مهارات الحياة اليومية",
        ],
      },
      {
        "name": "خدمات التدريب والتطوير",
        "subServices": [
          "تدريب العاملين في المجال",
          "ورش عمل وندوات للأسر والأفراد",
        ],
      },
    ],
    "location": {
      "latitude": 15.360445,
      "longitude": 44.191006,
    },
    "address": "صنعاء - بني الحارث - صرف - الأحضان",
    "contactNumber": "01340724",
    "whatsappNumber": "770044350",
  },
  {
    "id": 3,
    "name": "مؤسسة البسمة لذوي الاحتياجات الخاصة",
    "imageUrl": "https://scontent.fsah2-1.fna.fbcdn.net/v/t39.30808-6/306139199_584037966850666_7247686132847296763_n.jpg?stp=dst-jpg_s960x960_tt6&_nc_cat=108&ccb=1-7&_nc_sid=cc71e4&_nc_ohc=BEAgcj9w20kQ7kNvgFiGlUD&_nc_zt=23&_nc_ht=scontent.fsah2-1.fna&_nc_gid=AJobu9VgTUFyvgtT8d865Oa&oh=00_AYDkUDHb9gRDn7C53TYVSVn7HW4OvcQ9v9QRUNaICiLR5A&oe=67983B19",
    "description": "تسعى المؤسسة إلى تقديم الدعم والرعاية لذوي الاحتياجات الخاصة من خلال برامج تعليمية وتأهيلية متنوعة.",
    "services": [
      {
        "name": "الخدمات الاجتماعية",
        "subServices": [
          "دعم الأسر والإرشاد الأسري",
          "إنشاء مجموعات دعم اجتماعي",
        ],
      },
      {
        "name": "الخدمات الترفيهية",
        "subServices": [
          "تنظيم أنشطة ترفيهية ورياضية",
          "رحلات جماعية وبرامج ترفيهية خارجية",
        ],
      },
    ],
    "location": {
      "latitude": 15.3489,
      "longitude": 44.2061,
    },
    "address": "صنعاء - شارع الزبيري - جوار مستشفى الثورة",
    "contactNumber": "01234567",
    "whatsappNumber": "771234567",
  },
  {
    "id": 4,
    "name": "مؤسسة التعاون الإنساني لرعاية ذوي الاحتياجات الخاصة",
    "imageUrl": "https://scontent.fsah2-1.fna.fbcdn.net/v/t39.30808-6/458492616_814052330925156_5609528870476476778_n.jpg?stp=dst-jpg_s960x960_tt6&_nc_cat=106&ccb=1-7&_nc_sid=cc71e4&_nc_ohc=WW8ELMVS7rUQ7kNvgECaUrB&_nc_zt=23&_nc_ht=scontent.fsah2-1.fna&_nc_gid=AREeUEjr0Wekqvo2q0CK8IO&oh=00_AYDwoMumPNSMtoF8Tx6sqJsc_q_cW8rGYfFe0tCznpwLKA&oe=67984181",
    "description": "تقدم المؤسسة خدمات رعاية وتأهيل لذوي الاحتياجات الخاصة، بالإضافة إلى مبادرات إنسانية لدعم الأسر المحتاجة.",
    "services": [
      {
        "name": "الخدمات الصحية الوقائية",
        "subServices": [
          "فحوصات طبية دورية",
          "برامج توعية صحية",
        ],
      },
      {
        "name": "الخدمات الاجتماعية",
        "subServices": [
          "دعم الأسر والإرشاد الأسري",
          "برامج الدمج المجتمعي",
        ],
      },
    ],
    "location": {
      "latitude": 15.3694,
      "longitude": 44.1910,
    },
    "address": "صنعاء - حي الحصبة - شارع عمران",
    "contactNumber": "01234568",
    "whatsappNumber": "772345678",
  },
  {
    "id": 5,
    "name": "مركز الإرادة لإعادة التأهيل",
    "imageUrl": "https://scontent.fsah2-1.fna.fbcdn.net/v/t39.30808-6/300825110_437522768395070_1299955230407846296_n.jpg?_nc_cat=104&ccb=1-7&_nc_sid=6ee11a&_nc_ohc=aVjCG7pj390Q7kNvgGkxyiu&_nc_zt=23&_nc_ht=scontent.fsah2-1.fna&_nc_gid=AmHdm--k4NCC2EF1BXjrS8q&oh=00_AYBIRuHCKI7CJdjW0sTJwV8wO1_KCdC2baDClh5tj-E-Tg&oe=67985BF0",
    "description": "يقدم المركز خدمات التشخيص والعلاج الوظيفي والنطقي، بالإضافة إلى برامج التربية الخاصة والعلاج الطبيعي.",
    "services": [
      {
        "name": "الخدمات الطبية والعلاجية",
        "subServices": [
          "العلاج الطبيعي",
          "العلاج الوظيفي",
          "العلاج بالنطق والتخاطب",
        ],
      },
    ],
    "location": {
      "latitude": 15.3765,
      "longitude": 44.2145,
    },
    "address": "صنعاء - شارع 45 - جولة الصافية",
    "contactNumber": "01543210",
    "whatsappNumber": "773210987",
  },
  {
    "id": 6,
    "name": "مركز الحكيم التخصصي للتشخيص وتأهيل ذوي الإحتياجات الخاصة",
    "imageUrl": "https://scontent.fsah1-1.fna.fbcdn.net/v/t39.30808-6/471821274_447202915121536_3945344421543025345_n.jpg?_nc_cat=103&ccb=1-7&_nc_sid=cc71e4&_nc_ohc=_IWK3YQbd6MQ7kNvgH46bMT&_nc_zt=23&_nc_ht=scontent.fsah1-1.fna&_nc_gid=ApfbrDN7bYdLkq43o1arK5G&oh=00_AYBxKgX_BetiHTUpLXTBWANQJ-S_EffiLdJ7q1_StSYXRQ&oe=67983489",
    "description": "يقدم المركز خدمات تشخيصية وتأهيلية متخصصة لذوي الاحتياجات الخاصة، بما في ذلك اضطرابات النطق والتوحد وتشتت الانتباه.",
    "services": [
      {
        "name": "الخدمات الطبية والعلاجية",
        "subServices": [
          "العلاج الطبيعي",
          "العلاج الوظيفي",
          "العلاج بالنطق والتخاطب",
          "الدعم النفسي والعلاج السلوكي",
        ],
      },
      {
        "name": "الخدمات التعليمية والتأهيلية",
        "subServices": [
          "برامج التعليم الخاص",
          "التدريب المهني والتأهيل للعمل",
          "تعليم مهارات الحياة اليومية",
        ],
      },
    ],
    "location": {
      "latitude": 15.369445,
      "longitude": 44.191006,
    },
    "address": "صنعاء - شارع الدائري - جولة كنتاكي - برج القديمي الطبي - الدور الثاني",
    "contactNumber": "01209725",
    "whatsappNumber": "777216770",
  },




];









/*
import 'package:flutter/material.dart';

List<Map<String, dynamic>> centersData = [
  {
    "id": 1,
    "name": "مركز الحكيم التخصصي للتشخيص وتأهيل ذوي الإحتياجات الخاصة",
    "imageUrl": "https://www.alhakeem-ye.com/wp-content/uploads/2020/01/logo.png",
    "description": "يقدم المركز خدمات تشخيصية وتأهيلية متخصصة لذوي الاحتياجات الخاصة، بما في ذلك اضطرابات النطق والتوحد وتشتت الانتباه.",
    "services": [
      {
        "name": "الخدمات الطبية والعلاجية",
        "icon": Icons.local_hospital,
        "subServices": [
          "العلاج الطبيعي",
          "العلاج الوظيفي",
          "العلاج بالنطق والتخاطب",
          "الدعم النفسي والعلاج السلوكي",
        ],
      },
      {
        "name": "الخدمات التعليمية والتأهيلية",
        "icon": Icons.school,
        "subServices": [
          "برامج التعليم الخاص",
          "التدريب المهني والتأهيل للعمل",
          "تعليم مهارات الحياة اليومية",
        ],
      },
    ],
    "location": {
      "latitude": 15.369445,
      "longitude": 44.191006,
    },
    "address": "صنعاء - شارع الدائري - جولة كنتاكي - برج القديمي الطبي - الدور الثاني",
    "contactNumber": "01209725",
    "whatsappNumber": "777216770",
  },
  {
    "id": 2,
    "name": "مركز جنة لرعاية ذوي الاحتياجات الخاصة",
    "imageUrl": "https://sanaamedical.net/wp-content/uploads/2020/01/jannah_center_logo.png",
    "description": "يقدم المركز خدمات رعاية وتأهيل شاملة للأطفال ذوي الاحتياجات الخاصة، مع برامج تعليمية وتدريبية متخصصة.",
    "services": [
      {
        "name": "الخدمات التعليمية والتأهيلية",
        "icon": Icons.school,
        "subServices": [
          "برامج التعليم الخاص",
          "برامج التدخل المبكر للأطفال",
        ],
      },
      {
        "name": "الخدمات الاجتماعية",
        "icon": Icons.group,
        "subServices": [
          "دعم الأسر والإرشاد الأسري",
          "برامج الدمج المجتمعي",
        ],
      },
    ],
    "location": {
      "latitude": 15.369445,
      "longitude": 44.191006,
    },
    "address": "صنعاء ـ الحصبة ـ أمام اللجنة الدائمة",
    "contactNumber": "770402500",
    "whatsappNumber": "770402500",
  },
  {
    "id": 3,
    "name": "مركز التأهيل التعليمي والمهني لذوي الاحتياجات الخاصة",
    "imageUrl": "https://evrcsn.com/wp-content/uploads/2020/01/evrcsn_logo.png",
    "description": "يقدم المركز برامج تعليمية ومهنية لذوي الاحتياجات الخاصة، بهدف دمجهم في المجتمع وتعزيز مهاراتهم الحياتية.",
    "services": [
      {
        "name": "الخدمات التعليمية والتأهيلية",
        "icon": Icons.school,
        "subServices": [
          "التدريب المهني والتأهيل للعمل",
          "تعليم مهارات الحياة اليومية",
        ],
      },
      {
        "name": "خدمات التدريب والتطوير",
        "icon": Icons.lightbulb,
        "subServices": [
          "تدريب العاملين في المجال",
          "ورش عمل وندوات للأسر والأفراد",
        ],
      },
    ],
    "location": {
      "latitude": 15.369445,
      "longitude": 44.191006,
    },
    "address": "صنعاء - بني الحارث - صرف - الأحضان",
    "contactNumber": "01340724",
    "whatsappNumber": "770044350",
  },
  {
    "id": 4,
    "name": "مؤسسة البسمة لذوي الاحتياجات الخاصة",
    "imageUrl": "https://example.com/albasmah_logo.png",
    "description": "تسعى المؤسسة إلى تقديم الدعم والرعاية لذوي الاحتياجات الخاصة من خلال برامج تعليمية وتأهيلية متنوعة.",
    "services": [
      {
        "name": "الخدمات الاجتماعية",
        "icon": Icons.group,
        "subServices": [
          "دعم الأسر والإرشاد الأسري",
          "إنشاء مجموعات دعم اجتماعي",
        ],
      },
      {
        "name": "الخدمات الترفيهية",
        "icon": Icons.sports_soccer,
        "subServices": [
          "تنظيم أنشطة ترفيهية ورياضية",
          "رحلات جماعية وبرامج ترفيهية خارجية",
        ],
      },
    ],
    "location": {
      "latitude": 15.3489,
      "longitude": 44.2061,
    },
    "address": "صنعاء - شارع الزبيري - جوار مستشفى الثورة",
    "contactNumber": "01234567",
    "whatsappNumber": "771234567",
  },
  {
    "id": 5,
    "name": "مؤسسة التعاون الإنساني لرعاية ذوي الاحتياجات الخاصة",
    "imageUrl": "https://example.com/altawaon_logo.png",
    "description": "تقدم المؤسسة خدمات رعاية وتأهيل لذوي الاحتياجات الخاصة، بالإضافة إلى مبادرات إنسانية لدعم الأسر المحتاجة.",
    "services": [
      {
        "name": "الخدمات الصحية الوقائية",
        "icon": Icons.health_and_safety,
        "subServices": [
          "فحوصات طبية دورية",
          "برامج توعية صحية",
        ],
      },
      {
        "name": "الخدمات الاجتماعية",
        "icon": Icons.group,
        "subServices": [
          "دعم الأسر والإرشاد الأسري",
          "برامج الدمج المجتمعي",
        ],
      },
    ],
    "location": {
      "latitude": 15.3694,
      "longitude": 44.1910,
    },
    "address": "صنعاء - حي الحصبة - شارع عمران",
    "contactNumber": "01234568",
    "whatsappNumber": "772345678",
  },
  {
    "id": 6,
    "name": "مركز الإرادة لإعادة التأهيل",
    "imageUrl": "https://example.com/aleradah_logo.png",
    "description": "يقدم المركز خدمات التشخيص والعلاج الوظيفي والنطقي، بالإضافة إلى برامج التربية الخاصة والعلاج الطبيعي.",
    "services": [
      {
        "name": "الخدمات الطبية والعلاجية",
        "icon": Icons.local_hospital,
        "subServices": [
          "العلاج الطبيعي",
          "العلاج الوظيفي",
          "العلاج بالنطق والتخاطب",
        ],
      },
    ],
    "location": {
      "latitude": 15.3765,
      "longitude": 44.2145,
    },
    "address": "صنعاء - شارع 45 - جولة الصافية",
    "contactNumber": "01543210",
    "whatsappNumber": "773210987",
  },
  // أضيف المزيد من المراكز حتى تصل إلى 10...
];
*/