import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_apps/core/component/my_custom_image_viewer.dart';
import 'package:todo_apps/core/utils/app_constants/blog_app_constants.dart';

import '../../../../../core/component/my_custom_buttons.dart';
import '../../../providers_management/card.dart';


class CartWidget extends StatelessWidget {
  final String id;
  final String productId;
  final double price;
  final int quantity;
  final String title;
  final String imageUrl;

  CartWidget(
    this.id,
    this.productId,
    this.price,
    this.quantity,
    this.title,
    this.imageUrl,
  );

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(id),
      background: Container(
        color: Colors.red,
        child: Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20),
        margin: EdgeInsets.symmetric(
          vertical: 4,
        ),
      ),
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction) {
        return showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text(
              'هل انت متأكد?',
              style:Theme.of(context).textTheme.labelSmall!.copyWith(fontSize:30 ),
            ),
            content: Text('هل تريد حذف هذا المنتج من السلة?',
                style: Theme.of(context).textTheme.labelSmall),
            actions: <Widget>[
             MyButtonWithBackground(
                 context: context,
               textButton: "لا",
               width: MediaQuery.of(context).size.height*0.08,
               height:MediaQuery.of(context).size.height*0.04,
               onPressed: (){
                 Navigator.of(ctx).pop(false);
               }

             ),
              MyButtonWithBackground(
                  context: context,
                  textButton: "نعم",
                  fontSize: Theme.of(context).textTheme.labelSmall!.fontSize!,
                  width: MediaQuery.of(context).size.height*0.08,
                  height:MediaQuery.of(context).size.height*0.04,
                  onPressed: (){
                    Navigator.of(ctx).pop(true);
                  }

              ),
            ],
          ),
        );
      },
      onDismissed: (direction) {
        Provider.of<Cart>(context, listen: false).removeItem(productId);
      },
      child: Card(
        color: Theme.of(context).colorScheme.background,
        margin: EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 4,
        ),
        child: ListTile(
          leading: Text('$quantity x',style:  Theme.of(context).textTheme.labelSmall!.copyWith(fontSize: MediaQuery.of(context).size.height*0.018),textDirection: TextDirection.rtl,),
          title: Text(
            title,
            style: Theme.of(context).textTheme.labelSmall!.copyWith(fontSize: MediaQuery.of(context).size.height*0.025,),
            textDirection: TextDirection.rtl,
          ),
          subtitle: Text('المجموع: ${(price * quantity)}'+" ر.ي",style:  Theme.of(context).textTheme.labelSmall!.copyWith(fontSize: MediaQuery.of(context).size.height*0.018),textDirection: TextDirection.rtl,),
          trailing: CircleAvatar(
            radius: 30.0,

            backgroundColor: Colors.transparent,
            child: CustomImageViewer.show(context: context, url: baseUrl+imageUrl),
          ),
        ),
      ),
    );
  }
}
