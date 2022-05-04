import 'package:example/first_thing/attendance/daily_attendance_data.dart';
import 'package:example/first_thing/store/add_to_store/shop_model_data_for_store.dart';
import 'package:example/first_thing/store/add_to_store/storage_pdf_report.dart';
import 'package:example/first_thing/store/monthly_analaysis_for_storage.dart';
import 'package:example/first_thing/store/substract_from_store/shop_model_data_for_used_items.dart';
import 'package:example/first_thing/store/substract_from_store/storage_list_item_for_used_item.dart';
import 'package:example/first_thing/store/substract_from_store/storage_pdf_report_for_used_item.dart';
import 'package:example/first_thing/store/substract_from_store/take_from_store.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';
import 'add_to_store/add_storage.dart';
import 'add_to_store/storage_list_item_for_stored_item.dart';
import 'drop_down_menu_button.dart';

class StorageScreen extends StatefulWidget {
  StorageScreen({Key key}) : super(key: key);

  @override
  State<StorageScreen> createState() => _StorageScreenState();
}

int currentTab = 0;

class _StorageScreenState extends State<StorageScreen> {
  int selectedDayOfMonth = DateTime.now().day;

  @override
  Widget build(BuildContext context) {
    final dailyStoreAttendance =
        Provider.of<DailyAttendanceData>(context).daysOfMonth;
    final yearFilterForStore =
        Provider.of<ShopModelDataForStore>(context).shopList;
    final resultForStore = yearFilterForStore
        .where((element) =>
            DateTime.parse(element.itemDate).year == DateTime.now().year)
        .toList();
    final resultForStoreMonthly = resultForStore
        .where((element) =>
            DateTime.parse(element.itemDate).month == DateTime.now().month)
        .toList();
    final resultForStoreDaily = resultForStoreMonthly
        .where((element) =>
            DateTime.parse(element.itemDate).day == selectedDayOfMonth)
        .toList();
    final yearFilterForUsed =
        Provider.of<UsedShopModelData>(context).usedShopList;
    final resultForUsed = yearFilterForUsed
        .where((element) =>
            DateTime.parse(element.itemDate).year == DateTime.now().year)
        .toList();
    final resultForUsedMonthly = resultForUsed
        .where((element) =>
            DateTime.parse(element.itemDate).month == DateTime.now().month)
        .toList();
    final resultForUsedDaily = resultForUsedMonthly
        .where((element) =>
            DateTime.parse(element.itemDate).day == selectedDayOfMonth)
        .toList();
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Consumer<ShopModelDataForStore>(
        builder: (context, data, child) => Scaffold(
          //   backgroundColor: const Color.fromRGBO(3, 83, 151, 1),
          appBar: AppBar(
            bottom: TabBar(
              onTap: (currentIndex) {
                setState(() {
                  currentTab = currentIndex;
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
              'Storage',
              style: storageTitle,
            ),
            elevation: 0,
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownButton(
                  borderRadius: BorderRadius.zero,
                  dropdownColor: Colors.grey[850],
                  iconEnabledColor: Colors.white,
                  menuMaxHeight: 300,
                  value: selectedDayOfMonth,
                  items: dailyStoreAttendance
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
                      selectedDayOfMonth = value;
                    });
                  },
                ),
              ),
            ],
          ),
          body: TabBarView(
            children: [
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
                      : StorageListItemForStoredItem(
                          storageList: resultForStoreDaily,
                          usedList: resultForUsedDaily,
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
                          usedList: resultForUsedDaily,
                        ),
            ],
          ),
          floatingActionButton: Builder(
            builder: (context) => DropDownMenuButton(
              primaryColor: const Color.fromRGBO(3, 83, 151, 1),
              iconsOne: const Icon(
                Icons.add,
                color: Colors.white,
                size: 35,
              ),
              iconsTwo: const Image(
                image: AssetImage('images/pdf.png'),
                width: 40,
              ),
              iconsThree: const Image(
                image: AssetImage('images/check-list.png'),
                width: 50,
              ),
              iconsFour: const Image(
                image: AssetImage('images/minus.png'),
                width: 50,
              ),
              button_1: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => const AddStorageList(),
                  ),
                );
              },
              button_2: () {
                setState(() {
                  if (currentTab == 0) {
                    Provider.of<FileHandlerForStorage>(context, listen: false)
                        .createTableForStoredItem();
                  } else {
                    Provider.of<FileHandlerForStorageForUsedItems>(context,
                            listen: false)
                        .createTableForUsed();
                  }
                });
              },
              button_3: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => MonthlyAnalaysisForStorage(
                        monthlyDataForUsed: resultForUsed,
                        monthlyDataForStore: resultForStore),
                  ),
                );
              },
              button_4: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => const TakeFromStorage(),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
