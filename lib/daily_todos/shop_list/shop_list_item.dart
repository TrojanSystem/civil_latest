import 'package:example/daily_todos/shop_list/update_shop_input_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';
import 'database_helper/shop_database_helper.dart';
import 'files.dart';

class ShopListItem extends StatelessWidget {
  final List shopList;
  final int selectedDay;

  const ShopListItem({this.shopList, this.selectedDay});

  @override
  Widget build(BuildContext context) {
    double _w = MediaQuery.of(context).size.width;
    return AnimationLimiter(
      child: ListView.builder(
        padding: EdgeInsets.all(_w / 30),
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        itemCount: shopList.length,
        itemBuilder: (BuildContext context, int index) {
          final shopListFilter = Provider.of<ShopHandler>(context).fileList;

          final totalPrice = shopList.map((e) => e.total).toList();
          var sumTotalPrice = 0.0;
          for (int items = 0; items < shopList.length; items++) {
            sumTotalPrice += totalPrice[items];
          }
          Provider.of<ShopHandler>(context).totals = sumTotalPrice;
          return GestureDetector(
            onTap: () {},
            child: AnimationConfiguration.staggeredList(
              position: index,
              delay: const Duration(milliseconds: 100),
              child: SlideAnimation(
                duration: const Duration(milliseconds: 2500),
                curve: Curves.fastLinearToSlowEaseIn,
                horizontalOffset: -300,
                verticalOffset: -850,
                child: Slidable(
                  endActionPane: ActionPane(
                    motion: const ScrollMotion(),
                    children: [
                      const SizedBox(
                        width: 50,
                      ),
                      IconButton(
                        color: Colors.red,
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (ctx) => AlertDialog(
                              title: const Text('Are you sure'),
                              actions: [
                                FlatButton(
                                  onPressed: () {
                                    Navigator.of(ctx).pop(false);
                                  },
                                  child: const Text('No'),
                                ),
                                FlatButton(
                                  onPressed: () {
                                    DatabaseHelperForShop.getInstance().delete(
                                      shopList[index].id,
                                    );
                                    Navigator.of(ctx).pop(true);
                                  },
                                  child: const Text('Yes'),
                                ),
                              ],
                              content: const Text(
                                  'Do you want to remove this item from the cart?'),
                            ),
                          );
                        },
                        icon: const Icon(
                          Icons.delete_forever,
                          size: 40,
                        ),
                      ),
                    ],
                  ),
                  startActionPane: ActionPane(
                    motion: const ScrollMotion(),
                    children: [
                      const SizedBox(
                        width: 20,
                      ),
                      IconButton(
                        color: Colors.green,
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (ctx) => ShopUpdateForm(
                              index: shopList[index].id,
                              existedName: shopList[index].name,
                              existedDate: shopList[index].date,
                              existedPrice: shopList[index].price,
                              existedQuantity: shopList[index].quantity,
                              existedTotal: shopList[index].total,
                            ),
                          );
                        },
                        icon: const Icon(
                          Icons.edit,
                          size: 40,
                        ),
                      ),
                    ],
                  ),
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: Container(
                            child: Column(
                              children: [
                                Text(
                                  shopList[index].price,
                                  style: storageItemMoney,
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                const Text(
                                  'ETB',
                                  style: storageItemCurrency,
                                ),
                              ],
                              mainAxisAlignment: MainAxisAlignment.center,
                            ),
                            margin: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.blueAccent,
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Container(
                            child: ListTile(
                              title: Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: Text(
                                  shopList[index].name,
                                  style: storageItemName,
                                ),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'Total Price: ${shopList[index].total}',
                                    style: storageItemDate,
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    DateFormat.yMMMEd().format(
                                      DateTime.parse(shopList[index].date),
                                    ),
                                    style: storageItemDate,
                                  ),
                                ],
                              ),
                              trailing: Text(
                                'x ${shopList[index].quantity}',
                                style: TextStyle(
                                  color: Colors.green[800],
                                  fontFamily: 'FjallaOne',
                                  fontSize: 25,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ),
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(
                                Radius.circular(20),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    margin: EdgeInsets.only(bottom: _w / 20),
                    height: _w / 4,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 40,
                          spreadRadius: 10,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
