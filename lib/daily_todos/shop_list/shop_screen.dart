import 'package:example/daily_todos/shop_list/shop_input_form.dart';
import 'package:example/daily_todos/shop_list/shop_list_item.dart';
import 'package:example/first_thing/store/add_to_store/shop_model_data_for_store.dart';
import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';
import '../drop_down_menu_button_for_daily_todos.dart';
import 'daily_shop_data.dart';
import 'files.dart';
import 'monthly_analaysis.dart';

class ShopList extends StatefulWidget {
  static const routeName = '/ShopList';

  const ShopList({Key key}) : super(key: key);

  @override
  State<ShopList> createState() => _ShopListState();
}

class _ShopListState extends State<ShopList> {
  int selectedDayOfMonth = DateTime.now().day;
  final GlobalKey<FabCircularMenuState> fabKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final items = Provider.of<DailyShopData>(context).dailyShopList;

    final dailySell = Provider.of<ShopModelDataForStore>(context).daysOfMonth;
    final dailyShopFilteredForYear = items
        .where((element) =>
            DateTime.parse(element.date).year == DateTime.now().year)
        .toList();
    final dailyShopFilteredForMonth = dailyShopFilteredForYear
        .where((element) =>
            DateTime.parse(element.date).month == DateTime.now().month)
        .toList();
    final dailyShop = dailyShopFilteredForMonth
        .where(
            (element) => DateTime.parse(element.date).day == selectedDayOfMonth)
        .toList();
    final totalPrice = dailyShopFilteredForMonth.map((e) => e.total).toList();
    var sumTotalPrice = 0.0;
    for (int x = 0; x < dailyShopFilteredForMonth.length; x++) {
      sumTotalPrice += totalPrice[x];
    }

    final dailyTotalPrice = dailyShop.map((e) => e.total).toList();
    double dailySumUp = 0.00;

    for (int items = 0; items < dailyShop.length; items++) {
      dailySumUp += dailyTotalPrice[items];
    }

    final newLabours = dailyShop
        .map((e) => ShopModel(
              dailySum: dailySumUp.toStringAsFixed(2),
              price: e.price,
              name: e.name,
              quantity: e.quantity,
              date: DateFormat.yMMMEd().format(
                DateTime.parse(e.date),
              ),
            ))
        .toList();
    Provider.of<ShopHandler>(context).fileList = newLabours;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(3, 83, 151, 1),
        title: const Text(
          'Daily Shop',
          style: storageTitle,
        ),
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: DropdownButton(
                        borderRadius: BorderRadius.zero,
                        dropdownColor: Colors.grey[850],
                        iconEnabledColor: Colors.white,
                        menuMaxHeight: 300,
                        value: selectedDayOfMonth,
                        items: dailySell
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
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8.0, 0, 8, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Daily Expense: $dailySumUp',
                            style: dailyIncomeStyle,
                          ),
                          Text(
                            'Total: $sumTotalPrice',
                            style: dailyIncomeStyle,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              color: const Color.fromRGBO(3, 83, 151, 1),
            ),
          ),
          Expanded(
            flex: 7,
            child: ShopListItem(shopList: dailyShop),
          ),
        ],
      ),
      floatingActionButton: Builder(
        builder: (context) => DropDownMenuButtonForDailyTodos(
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
          iconsFour: const Icon(Icons.arrow_back),
          button_11: () {
            showModalBottomSheet(
              context: context,
              builder: (ctx) => const ShopForm(),
            );
          },
          button_22: () {
            setState(() {
              Provider.of<ShopHandler>(context, listen: false)
                  .createTableMonthly();
            });
          },
          button_33: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => MonthlyAnalaysis(
                    dailyShopFilteredForYear: dailyShopFilteredForYear),
              ),
            );
          },
          button_44: () {
            Navigator.of(context).pop();
          },
        ),
      ),
    );
  }

  Widget slideRightBackground() {
    return Container(
      alignment: Alignment.centerLeft,
      child: const Icon(
        Icons.edit,
        size: 40,
      ),
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.fromLTRB(20, 8, 8, 8),
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
            Radius.circular(8),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
          color: Colors.green),
    );
  }

  Widget slideLeftBackground() {
    return Container(
      alignment: Alignment.centerRight,
      child: const Icon(
        Icons.delete_forever,
        size: 40,
      ),
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.fromLTRB(8, 8, 20, 8),
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
            Radius.circular(8),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
          color: Colors.red),
    );
  }
}
