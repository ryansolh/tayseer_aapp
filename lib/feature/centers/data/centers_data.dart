import 'package:flutter/material.dart';

import './model.dart';

class Centers with ChangeNotifier {
  static String dummyDesc =
      "تمتلك الجمعيه اقسام للتأهيل المهني لذوي الإحتياجات الخاصه ممن ينطبق عليهم معايير الإلتحاق بالأقسام المهنيه. تعمل الجمعيه على التنسيق الدائم مع المراكز المختصه في ذوي الإحتياجات الخاصه في المنطقه. تقوم الجمعيه بالتركيز على الجانب التعليمي لذوي الإحتياجات الخاصه والمزدوج.";

  List<CentersModel> _items = [
    CentersModel(
      id: 1,
      name: 'جمعية الثقافة لذوي الاحتياجات الخاصة',
      imageUrl:
      'https://th.bing.com/th/id/OIP.C8BYjHRj8nlbqt_VXXbSmQHaE8?w=2560&h=1707&rs=1&pid=ImgDetMain',
      location: '15.515457,43.967098',
      description: dummyDesc,
    ),

    CentersModel(
      id: 2,
      name: 'التأهيل لذوي الاحتياجات الخاصة',
      imageUrl:
      'https://th.bing.com/th/id/OIP.g62gQxeA9Z4LHd0h4k3dLgHaEd?rs=1&pid=ImgDetMain',
      location: '15.563265,43.964980',
      description: dummyDesc,
    ),
    CentersModel(
      id: 3,
      name: 'مركز تاهيل الاطفال(ذوي الاحتياجات الخاصة)',
      location: '15.568110,43.972510',
      imageUrl:
      'https://th.bing.com/th/id/R.d8ebb637bde9e2920c1a914c921c0710?rik=jztSavTaBuAXVQ&pid=ImgRaw&r=0',
      description: dummyDesc,
    ),

    CentersModel(
      id: 4,
      name: 'المركز التعليمي التربوي لذوي الهمم',
      imageUrl:
      'https://th.bing.com/th/id/OIP.DgsM-c72jR4mb-A05uA12AHaEO?rs=1&pid=ImgDetMain',
      location: '15.559608,43.951574',
      description: dummyDesc,
    ),
    CentersModel(
      id: 5,
      name: 'مركز امل لذوي الهمم',
      imageUrl:
      'https://th.bing.com/th/id/OIP.7CwHVIPRmDa_tnqAnEHsdgHaFL?rs=1&pid=ImgDetMain',
      location: '15.564037,43.945597',
      description: dummyDesc,
    ),
    CentersModel(
      id: 6,
      name: 'مركز ذوي الهمم للتدريب والتاهيل',
      imageUrl:
      'https://th.bing.com/th/id/R.fbc05690454605878d22ad62d4fc459d?rik=ojLyMgArpfBvmA&riu=http%3a%2f%2fwww2.0zz0.com%2f2017%2f11%2f20%2f14%2f106351133.jpg&ehk=4mMg7YTSJuHSvxBDMBodldCtE3H3KU2xfsjHOKcxXCg%3d&risl=&pid=ImgRaw&r=0',
      location: '15.564037,43.945597',
      description: dummyDesc,
    ),
    /// Vegetable Products
    CentersModel(
      id: 7,
      name: 'مركز التدريب والتاهيل المهني لذوي الاحتياجات الخاصة',
      location: '15.511090,43.983059',
      imageUrl:
      'https://th.bing.com/th/id/OIP.UcGWpHBnhtqtwT6YariS4gHaEK?rs=1&pid=ImgDetMain',
      description: dummyDesc,
    ),
    CentersModel(
      id: 8,
      name: 'مركز صنعاء المهني لذوي الاحتياجات الخاصة',
      imageUrl:
      'https://th.bing.com/th/id/OIP.bZ31D15fVMI1yLC8chNStgHaHa?w=720&h=720&rs=1&pid=ImgDetMain',
      location: '15.497596,43.960085',
      description: dummyDesc,
    ),
    CentersModel(
      id: 9,
      name: 'مركز ذوي الاحتياجات الخاصة للتدريب والتاهيل',
      imageUrl:
      'https://anfaspress.com/storage/cover/21-12/4RrqmL5Hs08r9gJWSfaiGJVtkSyG2k5I2RIi6YgO.jpeg',
      location: '15.497596,43.960085',
      description: dummyDesc,
    ),
    CentersModel(
      id: 10,
      name: 'مركز السعادة لذوي الهمم',
      imageUrl:
      'https://th.bing.com/th/id/OIP.DgsM-c72jR4mb-A05uA12AHaEO?rs=1&pid=ImgDetMain',
      location: '15.511528,43.960831',
      description: dummyDesc,
    ),
    CentersModel(
      id: 11,
      name: 'مركز الصحة لذوي الهمم',
      imageUrl:
      'https://th.bing.com/th/id/OIP.7CwHVIPRmDa_tnqAnEHsdgHaFL?rs=1&pid=ImgDetMain',
      location: '15.508124,43.949651',
      description: dummyDesc,
    ),
    CentersModel(
      id: 12,
      name: 'مركز ذوي الاعاقة',
      imageUrl:
      'https://th.bing.com/th/id/OIP.HxNrsX0kIyj5C3R9ETnBZAHaEC?rs=1&pid=ImgDetMain',
      location: '15.515457,43.967098',
      description: dummyDesc,
    ),
  ];


  List<CentersModel> get items {

    return [..._items];
  }

 /* CentersModel findById(String id) {
    return _items.firstWhere((prod) => prod.id == id);
  }*/



}
