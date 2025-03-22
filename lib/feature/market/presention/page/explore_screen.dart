
import 'package:add_to_cart_animation/add_to_cart_animation.dart';
import 'package:add_to_cart_animation/add_to_cart_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:http/http.dart' as http;

import 'package:provider/provider.dart';
import 'package:todo_apps/core/component/my_custom_loading.dart';
import 'package:todo_apps/core/my_extention/my_extentions.dart';
import 'package:todo_apps/core/network/remote/remote_dio.dart';
import 'package:todo_apps/feature/market/presention/page/product_details_screen.dart';

import '../../../../core/component/my_custom_buttons.dart';
import '../../../../core/component/my_custom_linear_gradient.dart';
import '../../../../core/component/my_custom_shadermask.dart';
import '../../../../core/utils/app_constants/blog_app_constants.dart';
import '../../data/data_sources/products.dart';
import '../../data/model/cart.dart';
import '../../data/model/product.dart';
import '../../data/model/product_response.dart';
import '../explore/product_widget.dart';
import 'cart_screen.dart';



class ExploreScreen extends StatefulWidget {
  final List<ProductDataManage>? categoryProducts;

   ExploreScreen({Key? key, this.categoryProducts}) : super(key: key);

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}


class _ExploreScreenState extends State<ExploreScreen> {
  List<ProductDataManage>? _products;
  List<ProductDataManage>? _originalProducts;
  bool SafeProductInOnTime=false;
  String nextPageUrlWithPaginate="Start";


  GlobalKey<CartIconKey> cartKey = GlobalKey<CartIconKey>();
  late Function(GlobalKey) runAddToCartAnimation;

  int _indexOfCatogry=0;

  late ProductResponse productResponse;

  TextEditingController _productSearchController = TextEditingController();



  bool _isContainerVisible = false;

  void _toggleContainer() {
    setState(() {
      _isContainerVisible = !_isContainerVisible;
    });
  }





  void getProductsDataOfNextPageWithPaginate(String nextPageUrl)async{
   // print(nextPageUrl);
   try{
     print(("///////////////"));
   /*  print(productResponse.data.currentPage);
     print(productsUrl+"?page="+(productResponse.data.currentPage+2).toString());
     print(("///////////////"));*/
    var response= await DioHelper.get(url: productsUrl+"?page="+(productResponse.data.currentPage+1).toString());


    if(response.statusCode==200||response.statusCode==201){
      try{

setState(() {
  productResponse = ProductResponse.fromJson(response.data);

});
    }catch(e){
        print("kkkkkkkkkkkkkkkkkk");
        print(e);
      }

     setState(() {
       nextPageUrlWithPaginate=productResponse.data.nextPageUrl!;
     });

      print(productResponse);
      Provider.of<Products>(context, listen: false).addAllProducts(productResponse.data.data);

    }

   }catch(e){

   }
  }



  void getProductsDataOfFirstPageWithPaginate()async{
   // final ProductResponse
    try{
      var response= await DioHelper.get(
          url: productsUrl,
      );
      if(response.statusCode==200||response.statusCode==201){
        print("===================(json response)=================");
        print(response);
        print("===================(fromjson response)=================");
        try {
          productResponse = ProductResponse.fromJson(response.data);
          setState(() {
            nextPageUrlWithPaginate=productResponse.data.nextPageUrl!;
          });
          Provider.of<Products>(context, listen: false).addAllProducts(productResponse.data.data);

        }catch(e){
          print(e);
        }
      }
    }
    catch(e){

    }
  }





  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getProductsDataOfFirstPageWithPaginate();
  }

   dispose() {

    if(_isContainerVisible!=true){
      super.dispose();

    }
    else{
      _isContainerVisible!=false;
    }
  }



  Future<bool> _onWillPop()async{
    if(_isContainerVisible){
      setState(() {
        _isContainerVisible=false;
      });
      return false;
    }return true;
  }

  @override
  Widget build(BuildContext context) {

    Size size=MediaQuery.of(context).size;

    List<String>nameOfCatogry=[
      'أجهزة سمعية',
      'أجهزة بصرية',
      'معدات تنقل'
    ];

    List<Widget>iconsOfCatogry=[

      Icon(Icons.hearing, color:_indexOfCatogry==0?Colors.white: Colors.grey,),
      Icon(Icons.visibility_outlined,color:_indexOfCatogry==1?Colors.white: Colors.grey,),
      Icon(Icons.accessible_forward,color:_indexOfCatogry==2?Colors.white: Colors.grey,)
    ];



    final cart = Provider.of<Cart>(context);
    if (widget.categoryProducts == null || widget.categoryProducts!.isEmpty) {
      _products = Provider.of<Products>(context).items;
      if(SafeProductInOnTime==false){
        _originalProducts= _products;
        setState(() {
          SafeProductInOnTime=true;
        });
      }
      _originalProducts = Provider.of<Products>(context).items;
    } else {
      _products = widget.categoryProducts;
      if(SafeProductInOnTime==false){
        setState(() {
          _originalProducts = _products;
          SafeProductInOnTime=true;
        });
      }
    }



    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        body:  GestureDetector(
          onTap: (){
            if (_isContainerVisible) {
              setState(() {
                _isContainerVisible = false;
              });
            }
          },
          child: AddToCartAnimation(

            cartKey: cartKey,
            height: 0,
            width: 0,
            opacity: 0.85,
            dragAnimation: const DragToCartAnimationOptions(
              duration: Durations.medium4,
              rotation: true,
              curve: Curves.fastOutSlowIn
            ),

            jumpAnimation: const JumpAnimationOptions(
              duration: Durations.medium4
            ),
            createAddToCartAnimation: (runAddToCartAnimation) {
              // You can run the animation by addToCartAnimationMethod, just pass trough the the global key of  the image as parameter
              this.runAddToCartAnimation = runAddToCartAnimation;
            },
            child: Stack(
              children: [
                Container(
                  color: Theme.of(context).colorScheme.background,
                  child: SingleChildScrollView(
                    physics: const NeverScrollableScrollPhysics(),

                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(0),
                          child: Row(
                            children: [
                              10.SW,
                              Expanded(
                                flex: 5,
                                child: MyButtonNoBackground(
                                    context,
                                  Height: 40,
                                  Width: 200,
                                  textButton: "طلباتي",
                                  onPressed: (){
                    
                                  }
                    
                                ),
                              ),
                    
                              Expanded(
                                flex: 1,
                                child: MyShaderMask(
                                    toolWidget: IconButton(
                                        onPressed: (){
                                          _toggleContainer();
                                        },
                                        icon: Icon(Icons.search, size:size.height*0.036)
                                    ),
                                    radius: 1
                                ),
                              ),
                    
                    
                              Expanded(
                                flex: 1,
                                child: Stack(
                                  children: [
                                   MyShaderMask(
                                       toolWidget: AddToCartIcon(
                                         key:cartKey,
                                         badgeOptions: const BadgeOptions(
                                           active: true,
                                           backgroundColor: Color(0x00000000)
                    
                                         ),
                                         icon: IconButton(
                                             onPressed: (){
                                               Navigator.push(context, MaterialPageRoute(builder: (context)=>CartScreen()));
                    
                                             },
                                             icon: Icon(Icons.shopping_cart_checkout,size:size.height*0.032 ,)
                                         ),
                                       ),
                                       radius: 1.3
                                   ),
                                    Positioned(
                                        top: 2,
                                        right: 7,
                                        child: Container(
                                            height: 15,
                                            width: 15,
                                            // padding: EdgeInsets.all(20),
                                            decoration: const BoxDecoration(
                                                color: Colors.red,
                                                borderRadius: BorderRadius.all(Radius.circular(100))
                                            ),
                                            child: Center(
                                                child: Text('${cart.itemCount}',
                                                  style: const TextStyle(
                                                      fontSize: 10,color: Colors.white),
                                                )
                                            )
                    
                                        )
                                    ),
                    
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        //20.SH,
                        SizedBox(
                            height: 70,
                            width: double.infinity,
                            child:ListView.builder(
                              padding: const EdgeInsets.all(5),
                              itemCount: nameOfCatogry.length,
                              itemBuilder: (context, index) {
                                final category = nameOfCatogry;
                                return Column(
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.symmetric(horizontal: 5),
                                      child: InkWell(
                                        borderRadius:BorderRadius.circular(20) ,
                                        child: Container(
                                          //margin: EdgeInsets.symmetric(vertical: 10),
                    
                    
                    
                                          padding: const EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                              borderRadius: const BorderRadius.all(Radius.circular(20)),
                                              gradient: index==_indexOfCatogry?
                                              MyLinearGradient:
                                              LinearGradient(
                    
                                                colors: [
                                                  Theme.of(context).colorScheme.background,
                                                  Theme.of(context).colorScheme.background,
                                                  Theme.of(context).colorScheme.background,
                                                  Theme.of(context).colorScheme.background,
                                                ],
                                              ),
                                              boxShadow: [
                                                BoxShadow(
                    
                                                    color: Theme.of(context).colorScheme.secondary.withOpacity(0.1),
                                                    // spreadRadius: 3,
                                                    blurRadius: 7,
                                                    offset: const Offset(0,0)
                                                )
                                              ]
                                          ),
                                          child: Row(
                                            children: [
                                              Text(
                                                category[index],
                                                style: Theme.of(context).textTheme.labelSmall!.copyWith(
                                                    color:index==_indexOfCatogry?Colors.white
                                                        : Theme.of(context).textTheme.labelSmall!.color
                                                ),
                                              ),
                                              5.SW,
                    
                    
                                              iconsOfCatogry[index]
                    
                                            ],
                                          ),
                                        ),
                    
                                        onTap: (){
                                          setState(() {
                                            _indexOfCatogry=index;
                                          });
                                        },
                                      ),
                                    ),
                                    //SizedBox(width: 20,)
                                  ],
                                );
                              },
                              scrollDirection: Axis.horizontal,
                    
                            )
                        ),
                    
                    
                    
                        Container(
                          height: size.height-270,
                          child: _products!.length==0?const MyCustomLoading()
                              :AnimationLimiter(
                            child: GridView.builder(
                              shrinkWrap: true,
                              padding: const EdgeInsets.symmetric(horizontal: 16.0),

                              itemBuilder: (_, index) {
                                if(index==_products!.length){
                                  getProductsDataOfNextPageWithPaginate(nextPageUrlWithPaginate);

                                  return SizedBox(
                                    width: double.infinity,
                                    child: MyCustomLoading(),
                                  );
                                }else{
                                  return  AnimationConfiguration.staggeredList(
                                    position: index,
                                    delay: const Duration(milliseconds: 100),
                                    child: SlideAnimation(
                                      duration: const Duration(milliseconds: 1000),
                                      curve: Curves.decelerate,
                                      verticalOffset: -250,
                                      child: ScaleAnimation(
                                        duration: const Duration(milliseconds: 1000),
                                        curve: Curves.fastLinearToSlowEaseIn,
                                        child: ChangeNotifierProvider.value(
                                          value: _products![index],
                                          child: InkWell(
                                            borderRadius: BorderRadius.circular(10),
                                            onTap: () {
                                              Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
                                                return ProductDetailsScreen(product: _products![index]);
                                              }));
                                            },
                                            child: ProductWidget(onClick: listClick),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                }
                              },
                              itemCount: nextPageUrlWithPaginate != null?_products!.length+1:_products!.length,
                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount:2,
                                // childAspectRatio: 200 / 220,
                                crossAxisSpacing: 16.0,
                                mainAxisSpacing: 16.0,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  top: _isContainerVisible ? 0 : -300,
                  left: 0,
                  right: 0,
                  child: GestureDetector(
                    onTap: () {
                      // لمنع إغلاق الحاوية عند الضغط داخلها
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 3,vertical: 2),
                      child: Container(
                        decoration: BoxDecoration(
                      
                            color: Theme.of(context).colorScheme.background,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                  color: Theme.of(context).colorScheme.secondary.withOpacity(0.1),
                                  // spreadRadius: 3,
                                  blurRadius: 7,
                                  offset: const Offset(0,0)
                              )
                            ]
                        ),
                      
                      
                        child: Center(
                          child:Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(

                                    color: Theme.of(context).colorScheme.background.withOpacity(0.8),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Theme.of(context).colorScheme.secondary.withOpacity(0.1),
                                          spreadRadius: 3,
                                          blurRadius: 7,
                                          offset: const Offset(0,0)
                                      )
                                    ]
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: SizedBox(
                                    height: 50,
                                    child: TextFormField(
                                      textDirection: TextDirection.rtl,
                                      controller:_productSearchController,

                                      cursorColor: Colors.grey.withOpacity(0.4),
                                      autofocus: false,
                                      canRequestFocus: _isContainerVisible,

                                      style: TextStyle(color: Theme.of(context).textTheme.labelSmall!.color),
                                      onChanged: (value) {


                                          Provider.of<Products>(context, listen: false).searchByName(value);

                                      },
                                      // controller: serchController,
                                      decoration: InputDecoration(
                                          hintTextDirection: TextDirection.rtl,
                                          hintText: "ابحث عن منتج معين",
                                          // filled: true,

                                          fillColor: Theme.of(context).colorScheme.background,
                                          hoverColor: Theme.of(context).colorScheme.background.withOpacity(0.1),
                                          focusColor: Theme.of(context).colorScheme.background.withOpacity(0.1),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(color: Colors.grey),
                                            borderRadius: BorderRadius.circular(24),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(color: Colors.grey),
                                            borderRadius: BorderRadius.circular(24),
                                          ),
                                          prefixIcon:  MyShaderMask(
                                            toolWidget: IconButton(
                                              icon: const Icon(Icons.clear),
                                              onPressed: () {
                                                Provider.of<Products>(context, listen: false).searchByName('');

                                                setState(() {

                                                  _isContainerVisible = false;
                                                });
                                              },
                                            ),
                                            radius: 1.3,
                                          ),
                                          suffixIcon: const MyShaderMask(
                                            toolWidget: Icon(
                                              Icons.search,
                                              color: Colors.black,
                                            ),
                                            radius: 1.3,
                                          ),
                                          border: const OutlineInputBorder(
                                              borderRadius: BorderRadius.all(Radius.circular(25.0)
                                              )
                                          )
                                      ),

                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void listClick(GlobalKey widgetKey) async {
    await runAddToCartAnimation(widgetKey);
    await cartKey.currentState!
        .runCartAnimation();
  }
}
