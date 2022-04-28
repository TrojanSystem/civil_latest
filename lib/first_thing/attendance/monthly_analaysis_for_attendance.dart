import 'package:example/first_thing/attendance/attendance_update_input_form.dart';
import 'package:example/first_thing/attendance/daily_attendance_data.dart';
import 'package:example/first_thing/attendance/file.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';
import '../store/add_to_store/shop_model_data_for_store.dart';

class MonthlyAnalaysisForAttendance extends StatefulWidget {
  MonthlyAnalaysisForAttendance({this.dailyShopFilteredForYear});

  final List dailyShopFilteredForYear;

  @override
  State<MonthlyAnalaysisForAttendance> createState() =>
      _MonthlyAnalaysisForAttendanceState();
}

class _MonthlyAnalaysisForAttendanceState
    extends State<MonthlyAnalaysisForAttendance> {
  int selectedMonth = DateTime.now().month;

  @override
  Widget build(BuildContext context) {
    double _w = MediaQuery.of(context).size.width;
    final monthSelected =
        Provider.of<ShopModelDataForStore>(context).monthOfAYear;
    final dailyAttendanceFilteredForMonth = widget.dailyShopFilteredForYear
        .where((element) => DateTime.parse(element.date).month == selectedMonth)
        .toList();

    final newLabour = dailyAttendanceFilteredForMonth
        .map(
          (e) => FileModelForAttendance(
              id: e.id.toString(),
              price: e.price,
              name: e.name,
              title: e.title,
              date: DateFormat.yMMMEd().format(
                DateTime.parse(e.date),
              ),
              phone: e.phoneNumber),
        )
        .toList();
    Provider.of<FileHandlerForAttendance>(context, listen: false).fileList =
        newLabour;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            color: Color.fromRGBO(3, 83, 151, 1),
          ),
        ),
        title: const Text('Attendance Monthly'),
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
      body: AnimationLimiter(
        child: ListView.builder(
          padding: EdgeInsets.all(_w / 30),
          physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
          itemCount: dailyAttendanceFilteredForMonth.length,
          itemBuilder: (BuildContext context, int index) {
            return AnimationConfiguration.staggeredList(
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
                        width: 15,
                      ),
                      IconButton(
                        color: Colors.red,
                        onPressed: () => showDialog(
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
                                  Provider.of<DailyAttendanceData>(context,
                                          listen: false)
                                      .deleteDailyAttendanceList(
                                          dailyAttendanceFilteredForMonth[index]
                                              .id);
                                  Navigator.of(ctx).pop(true);
                                },
                                child: const Text('Yes'),
                              ),
                            ],
                            content: const Text(
                                'Do you want to remove the Labour from the List?'),
                          ),
                        ),
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
                        width: 50,
                      ),
                      IconButton(
                        color: Colors.green,
                        onPressed: () => showModalBottomSheet(
                          context: context,
                          builder: (_) => AttendanceUpdateForm(
                            existedDate: DateTime.parse(
                                dailyAttendanceFilteredForMonth[index].date),
                            existedTitle:
                                dailyAttendanceFilteredForMonth[index].title,
                            existedName:
                                dailyAttendanceFilteredForMonth[index].name,
                            existedPhoneNumber:
                                dailyAttendanceFilteredForMonth[index]
                                    .phoneNumber,
                            existedPrice:
                                dailyAttendanceFilteredForMonth[index].price,
                            id: dailyAttendanceFilteredForMonth[index].id,
                          ),
                        ),
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
                                  dailyAttendanceFilteredForMonth[index].price,
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
                                  dailyAttendanceFilteredForMonth[index].name,
                                  style: storageItemName,
                                ),
                              ),
                              subtitle: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    dailyAttendanceFilteredForMonth[index]
                                        .title,
                                    style: storageItemName,
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    DateFormat.yMMMEd().format(
                                      DateTime.parse(
                                          dailyAttendanceFilteredForMonth[index]
                                              .date),
                                    ),
                                    style: storageItemDate,
                                  ),
                                ],
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
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            Provider.of<FileHandlerForAttendance>(context, listen: false)
                .createTable();
          });
        },
        child: const Icon(Icons.save),
      ),
    );
  }
}
