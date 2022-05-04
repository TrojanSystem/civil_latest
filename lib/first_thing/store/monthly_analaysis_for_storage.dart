import 'package:example/constants.dart';
import 'package:example/first_thing/store/add_to_store/shop_model_data_for_store.dart';
import 'package:example/first_thing/store/add_to_store/storage_list_item_for_stored_item.dart';
import 'package:example/first_thing/store/substract_from_store/storage_list_item_for_used_item.dart';
import 'package:example/first_thing/store/substract_from_store/storage_pdf_report_for_used_item.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'add_to_store/storage_pdf_report.dart';

class MonthlyAnalaysisForStorage extends StatefulWidget {
  const MonthlyAnalaysisForStorage(
      {this.monthlyDataForStore, this.monthlyDataForUsed});

  final List monthlyDataForUsed;
  final List monthlyDataForStore;

  @override
  State<MonthlyAnalaysisForStorage> createState() =>
      _MonthlyAnalaysisForStorageState();
}

int tabIndex = 0;

class _MonthlyAnalaysisForStorageState
    extends State<MonthlyAnalaysisForStorage> {
  int selectedMonth = DateTime.now().month;
  List<StoragePDFReportForUsedItems> newPdfStoreOut = [];
  List<StoragePDFReport> newPdfStoreIn = [];
  @override
  Widget build(BuildContext context) {
    final monthSelected =
        Provider.of<ShopModelDataForStore>(context).monthOfAYear;
    final dailyUsedStorageFilteredForMonth = widget.monthlyDataForUsed
        .where((element) =>
            DateTime.parse(element.itemDate).month == selectedMonth)
        .toList();
    final dailyStorageFilteredForMonth = widget.monthlyDataForStore
        .where((element) =>
            DateTime.parse(element.itemDate).month == selectedMonth)
        .toList();

    newPdfStoreIn = dailyStorageFilteredForMonth
        .map(
          (e) => StoragePDFReport(
            id: e.id.toString(),
            storekeeper: e.storeKeeperName,
            name: e.itemName,
            quantity: e.itemQuantity.toString(),
            date: DateFormat.yMMMEd().format(
              DateTime.parse(e.itemDate),
            ),
          ),
        )
        .toList();
    newPdfStoreOut = dailyUsedStorageFilteredForMonth
        .map(
          (e) => StoragePDFReportForUsedItems(
            id: e.id.toString(),
            storekeeper: e.storeKeeperName,
            name: e.itemNames,
            usedQuantity: e.takeQuantity.toString(),
            date: DateFormat.yMMMEd().format(
              DateTime.parse(e.itemDate),
            ),
          ),
        )
        .toList();

    Provider.of<FileHandlerForStorageForUsedItems>(context)
        .fileListForUsedItems = newPdfStoreOut;
    Provider.of<FileHandlerForStorage>(context).fileListForStoredItems =
        newPdfStoreIn;
    return Consumer<ShopModelDataForStore>(
      builder: (context, data, child) => DefaultTabController(
        length: 2,
        initialIndex: tabIndex,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              onTap: (index) {
                setState(() {
                  tabIndex = index;
                });
              },
              tabs: const [
                Tab(
                  child: Text(
                    'Store-In',
                    style: TextStyle(
                      color: Colors.green,
                      fontFamily: 'FjallaOne',
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                Tab(
                  child: Text(
                    'Store-Out',
                    style: TextStyle(
                      color: Colors.red,
                      fontFamily: 'FjallaOne',
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ],
            ),
            backgroundColor: const Color.fromRGBO(3, 83, 151, 1),
            title: const Text(
              'Monthly Storage',
              style: storageTitle,
            ),
            elevation: 0,
            actions: [
              DropdownButton(
                dropdownColor: Colors.grey[850],
                iconEnabledColor: Colors.white,
                menuMaxHeight: 300,
                value: selectedMonth,
                items: monthSelected
                    .map(
                      (e) => DropdownMenuItem(
                        child: Text(
                          e['mon'],
                          style: kkDropDown,
                        ),
                        value: e['day'],
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    selectedMonth = value;
                  });
                },
              ),
            ],
          ),
          body: TabBarView(
            children: [
              dailyStorageFilteredForMonth.isEmpty
                  ? const Center(
                      child: Text(
                        'Storage Empty!',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 25,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    )
                  : data.isLoading
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: Colors.red,
                          ),
                        )
                      : StorageListItemForStoredItem(
                          storageList: dailyStorageFilteredForMonth,
                          usedList: dailyUsedStorageFilteredForMonth,
                        ),
              data.shopList.isEmpty
                  ? const Center(
                      child: Text(
                        'Storage Empty!',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 25,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    )
                  : data.isLoading
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: Colors.red,
                          ),
                        )
                      : StorageListItemForUsedItem(
                          usedList: dailyUsedStorageFilteredForMonth,
                        ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              setState(() {
                if (tabIndex == 0) {
                  Provider.of<FileHandlerForStorage>(context, listen: false)
                      .createTableForStoredItem();
                } else {
                  Provider.of<FileHandlerForStorageForUsedItems>(context,
                          listen: false)
                      .createTableForUsed();
                }
              });
            },
            child: const Icon(Icons.save),
          ),
        ),
      ),
    );
  }
}

void _showSnackBar(BuildContext context, String message) {
  Scaffold.of(context).showSnackBar(SnackBar(
    backgroundColor: Colors.black.withOpacity(0.5),
    content: Padding(
      padding: const EdgeInsets.only(bottom: 18.0),
      child: Text(
        message,
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 20),
      ),
    ),
    duration: const Duration(milliseconds: 1000),
  ));
}
