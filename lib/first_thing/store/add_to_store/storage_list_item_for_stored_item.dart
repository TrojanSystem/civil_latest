import 'package:example/constants.dart';
import 'package:example/first_thing/store/add_to_store/shop_model_data_for_store.dart';
import 'package:example/first_thing/store/add_to_store/storage_pdf_report.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class StorageListItemForStoredItem extends StatelessWidget {
  final List storageList;
  final List usedList;

  const StorageListItemForStoredItem({this.storageList, this.usedList});

  @override
  Widget build(BuildContext context) {
    double _w = MediaQuery.of(context).size.width;
    var filterName = storageList.map((e) => e.itemName).toSet().toList();
    var filterNameForUsedItems =
        usedList.map((e) => e.itemNames).toSet().toList();

    final List<StoragePDFReport> newLabour = [];

    return AnimationLimiter(
      child: ListView.builder(
        padding: EdgeInsets.all(_w / 30),
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        itemCount: filterName.length,
        itemBuilder: (BuildContext context, int index) {
          var filteredNameForUsedItems = usedList
              .where((element) => element.itemNames == filterName[index])
              .toSet()
              .toList();

          var filterQuantityForUsedItems =
              filteredNameForUsedItems.map((e) => e.takeQuantity).toList();

          var sumQuantityForUsedItems = 0.0;
          for (int x = 0; x < filteredNameForUsedItems.length; x++) {
            sumQuantityForUsedItems +=
                double.parse(filterQuantityForUsedItems[x]);
          }

          var filteredName = storageList
              .where((element) => element.itemName == filterName[index])
              .toSet()
              .toList();

          var filterQuantity = filteredName.map((e) => e.itemQuantity).toList();
          var sumQuantity = 0.0;
          for (int x = 0; x < filteredName.length; x++) {
            sumQuantity += double.parse(filterQuantity[x]);
          }
          double remainingQuantity = sumQuantity - sumQuantityForUsedItems;

          newLabour.add(
            StoragePDFReport(
              id: storageList[index].id.toString(),
              storekeeper: storageList[index].storeKeeperName,
              name: filterName[index],
              quantity: remainingQuantity.toString(),
              date: DateFormat.yMMMEd().format(
                DateTime.parse(storageList[index].itemDate),
              ),
            ),
          );

          Provider.of<FileHandlerForStorage>(context, listen: false).fileList =
              newLabour;
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
                          Provider.of<ShopModelDataForStore>(context,
                                  listen: false)
                              .deleteShopList(storageList[index].itemName);
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
                          // Navigator.of(context).push(
                          //   MaterialPageRoute(
                          //     builder: (_) => UpdateStorage(
                          //       index: storageList[index].id,
                          //       existedItemName: storageList[index].itemName,
                          //       existedItemDate: storageList[index].itemDate,
                          //       existedItemQuantity: sumQuantity.toString(),
                          //     ),
                          //   ),
                          // );
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
                                  '$sumQuantity',
                                  style: storageItemMoney,
                                ),
                              ],
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
                                  filterName[index],
                                  style: storageItemName,
                                ),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    storageList[index].storeKeeperName,
                                    style: storageItemDate,
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    DateFormat.yMMMEd().format(
                                      DateTime.parse(
                                          storageList[index].itemDate),
                                    ),
                                    style: storageItemDate,
                                  ),
                                ],
                              ),
                              trailing: Text(
                                remainingQuantity < 0
                                    ? 'Empty'
                                    : 'x $remainingQuantity',
                                style: TextStyle(
                                  color: remainingQuantity == 0
                                      ? Colors.red
                                      : remainingQuantity < 20
                                          ? Colors.redAccent
                                          : remainingQuantity >= 20 ||
                                                  remainingQuantity < 50
                                              ? Colors.green
                                              : Colors.green[800],
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
