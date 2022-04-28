import 'package:example/constants.dart';
import 'package:example/first_thing/store/add_to_store/shop_model_data_for_store.dart';
import 'package:example/first_thing/store/add_to_store/storage_list_item_for_stored_item.dart';
import 'package:example/first_thing/store/substract_from_store/storage_list_item_for_used_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MonthlyAnalaysisForStorage extends StatefulWidget {
  const MonthlyAnalaysisForStorage(
      {this.monthlyDataForStore, this.monthlyDataForUsed});
  final List monthlyDataForUsed;
  final List monthlyDataForStore;

  @override
  State<MonthlyAnalaysisForStorage> createState() =>
      _MonthlyAnalaysisForStorageState();
}

class _MonthlyAnalaysisForStorageState
    extends State<MonthlyAnalaysisForStorage> {
  int selectedMonth = DateTime.now().month;
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
    return Consumer<ShopModelDataForStore>(
      builder: (context, data, child) => DefaultTabController(
        length: 2,
        initialIndex: 0,
        child: Scaffold(
          appBar: AppBar(
            bottom: const TabBar(
              tabs: [
                Tab(
                  child: Icon(Icons.home),
                ),
                Tab(
                  child: Icon(Icons.add),
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
        ),
      ),
    );
  }
}
