import 'package:example/daily_todos/drop_down_menu_button_for_daily_todos.dart';
import 'package:example/first_thing/attendance/attendance_input_form.dart';
import 'package:example/first_thing/attendance/attendance_update_input_form.dart';
import 'package:example/first_thing/attendance/daily_attendance_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../constants.dart';
import 'file.dart';
import 'monthly_analaysis_for_attendance.dart';

class AttendanceList extends StatefulWidget {
  static const routeName = '/AttendanceList';

  const AttendanceList({Key key}) : super(key: key);

  @override
  State<AttendanceList> createState() => _AttendanceListState();
}

class _AttendanceListState extends State<AttendanceList> {
  int selectedDayOfMonth = DateTime.now().day;

  Future _callContact(BuildContext context, String number) async {
    final url = 'tel:$number';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      const snackbar = SnackBar(content: Text('Can\'t make a call'));
      Scaffold.of(context).showSnackBar(snackbar);
    }
  }

  Future _smsContact(BuildContext context, String number) async {
    final url = 'sms:$number';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      const snackbar = SnackBar(content: Text('Can\'t make a call'));
      Scaffold.of(context).showSnackBar(snackbar);
    }
  }

  List<FileModelForAttendance> newLabour = [];

  @override
  Widget build(BuildContext context) {
    double _w = MediaQuery.of(context).size.width;
    final dailyAttendanceListData =
        Provider.of<DailyAttendanceData>(context).dailyAttendanceList;

    final dailyAttendance =
        Provider.of<DailyAttendanceData>(context).daysOfMonth;
    final dailyAttendanceFilteredForYear = dailyAttendanceListData
        .where((element) =>
            DateTime.parse(element.date).year == DateTime.now().year)
        .toList();
    final dailyAttendanceFilteredForMonth = dailyAttendanceFilteredForYear
        .where((element) =>
            DateTime.parse(element.date).month == DateTime.now().month)
        .toList();
    final dailyAttendanceList = dailyAttendanceFilteredForMonth
        .where(
            (element) => DateTime.parse(element.date).day == selectedDayOfMonth)
        .toList();

    final newLabour = dailyAttendanceList
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
      // backgroundColor: const Color.fromRGBO(3, 83, 151, 1),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(3, 83, 151, 1),
        title: const Text(
          'Attendance List',
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
              items: dailyAttendance
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
      body: dailyAttendanceList.isNotEmpty
          ? AnimationLimiter(
              child: ListView.builder(
                padding: EdgeInsets.all(_w / 30),
                physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                itemCount: dailyAttendanceList.length,
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
                              width: 50,
                            ),
                            IconButton(
                              color: Colors.green,
                              onPressed: () => showModalBottomSheet(
                                context: context,
                                builder: (_) => AttendanceUpdateForm(
                                  existedDate: DateTime.parse(
                                      dailyAttendanceList[index].date),
                                  existedTitle:
                                      dailyAttendanceList[index].title,
                                  existedName: dailyAttendanceList[index].name,
                                  existedPhoneNumber:
                                      dailyAttendanceList[index].phoneNumber,
                                  existedPrice:
                                      dailyAttendanceList[index].price,
                                  id: dailyAttendanceList[index].id,
                                ),
                              ),
                              icon: const Icon(
                                Icons.edit,
                                size: 40,
                              ),
                            ),
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
                                        Provider.of<DailyAttendanceData>(
                                                context)
                                            .deleteDailyAttendanceList(
                                                dailyAttendanceList[index].id);
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
                              width: 20,
                            ),
                            IconButton(
                              color: Colors.green,
                              onPressed: () => _callContact(context,
                                  dailyAttendanceList[index].phoneNumber),
                              icon: const Icon(
                                Icons.call,
                                size: 40,
                              ),
                            ),
                            const SizedBox(
                              width: 30,
                            ),
                            IconButton(
                              color: Colors.blue,
                              onPressed: () => _smsContact(context,
                                  dailyAttendanceList[index].phoneNumber),
                              icon: const Icon(
                                Icons.message_rounded,
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
                                        dailyAttendanceList[index].price,
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
                                      padding:
                                          const EdgeInsets.only(bottom: 8.0),
                                      child: Text(
                                        dailyAttendanceList[index].name,
                                        style: storageItemName,
                                      ),
                                    ),
                                    subtitle: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          dailyAttendanceList[index].title,
                                          style: storageItemName,
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          DateFormat.yMMMEd().format(
                                            DateTime.parse(
                                                dailyAttendanceList[index]
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
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20)),
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
            )
          : const Center(
              child: Text(
                'The List is Empty!',
                style: storageTitle,
              ),
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
          iconsFour: const Icon(
            Icons.arrow_back,
            color: Colors.white,
            size: 35,
          ),
          button_11: () {
            showModalBottomSheet(
              context: context,
              builder: (ctx) => const AttendanceForm(),
            );
            setState(() {});
          },
          button_22: () {
            setState(() {
              Provider.of<FileHandlerForAttendance>(context, listen: false)
                  .createTable();
            });
          },
          button_33: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => MonthlyAnalaysisForAttendance(
                    dailyShopFilteredForYear: dailyAttendanceFilteredForYear),
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
}
