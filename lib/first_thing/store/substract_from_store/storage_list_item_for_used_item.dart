import 'package:example/first_thing/store/substract_from_store/shop_model_data_for_used_items.dart';
import 'package:example/first_thing/store/substract_from_store/storage_pdf_report_for_used_item.dart';
import 'package:example/first_thing/store/substract_from_store/update_take_from_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';

class StorageListItemForUsedItem extends StatelessWidget {
  final List usedList;

  const StorageListItemForUsedItem({this.usedList});

  @override
  Widget build(BuildContext context) {
    double _w = MediaQuery.of(context).size.width;

    final List<StoragePDFReportForUsedItems> newPdfReportForUsedItems = [];

    return AnimationLimiter(
      child: ListView.builder(
        padding: EdgeInsets.all(_w / 30),
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        itemCount: usedList.length,
        itemBuilder: (BuildContext context, int index) {
          newPdfReportForUsedItems.add(
            StoragePDFReportForUsedItems(
              id: usedList[index].id.toString(),
              storekeeper: usedList[index].storeKeeperName,
              name: usedList[index].itemNames,
              usedQuantity: usedList[index].takeQuantity.toString(),
              date: DateFormat.yMMMEd().format(
                DateTime.parse(usedList[index].itemDate),
              ),
            ),
          );

          Provider.of<FileHandlerForStorageForUsedItems>(context)
              .fileListForUsedItems = newPdfReportForUsedItems;
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
                          Provider.of<UsedShopModelData>(context, listen: false)
                              .deleteShopList(usedList[index].itemNames);
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
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => UpdateTakeFromStorage(
                                index: usedList[index].id,
                                existedItemName: usedList[index].itemNames,
                                existedItemDate: usedList[index].itemDate,
                                existedTakeQuantity:
                                    usedList[index].takeQuantity.toString(),
                                existedStorekeeper:
                                    usedList[index].storeKeeperName,
                              ),
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
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  'Total',
                                  style: storageItemMoney,
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  '${usedList[index].takeQuantity}',
                                  style: storageItemMoney,
                                ),
                              ],
                            ),
                            margin: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.redAccent,
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
                                  usedList[index].itemNames,
                                  style: storageItemName,
                                ),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    usedList[index].storeKeeperName,
                                    style: storageItemDate,
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    DateFormat.yMMMEd().format(
                                      DateTime.parse(usedList[index].itemDate),
                                    ),
                                    style: storageItemDate,
                                  ),
                                ],
                              ),
                              trailing: Text(
                                ' x ${usedList[index].takeQuantity}',
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
