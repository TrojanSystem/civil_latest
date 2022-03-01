import 'dart:math';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'attendance_form.dart';
import 'attendance_update_form.dart';
import 'database/database_helper.dart';
import 'file.dart';
import 'labour.dart';

class AttendanceList extends StatefulWidget {
  static const routeName = '/AttendanceList';

  const AttendanceList({Key key}) : super(key: key);

  @override
  State<AttendanceList> createState() => _AttendanceListState();
}

class _AttendanceListState extends State<AttendanceList> {
  int red = 0;
  int green = 0;
  int blue = 0;
  int id = 0;

  @override
  void initState() {
    var rng = Random();
    red = rng.nextInt(251);
    green = rng.nextInt(251);
    blue = rng.nextInt(251);
    print('red: $red green: $green blue: $blue');
    super.initState();
  }

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                Provider.of<FileHandler>(context, listen: false).createTable();
              });
            },
            icon: const Icon(Icons.save),
          ),
        ],
        backgroundColor: Color.fromRGBO(red, green, blue, 1),
        title: const Text('Attendance List'),
        centerTitle: true,
      ),
      body: StreamBuilder<List<Labours>>(
        stream: DatabaseHelper.getInstance().getAllItems(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.red,
              ),
            );
          }
          final items = snapshot.data;
          final newLabour = snapshot.data
              .map((e) => FileModel(
                  price: e.price,
                  name: e.name,
                  title: e.title,
                  date: DateFormat.yMMMEd().format(
                    DateTime.parse(e.date),
                  ),
                  phone: e.phoneNumber))
              .toList();
          Provider.of<FileHandler>(context, listen: false).fileList = newLabour;
          return SizedBox(
            height: double.infinity,
            child: ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return Slidable(
                    endActionPane: ActionPane(
                      motion: const ScrollMotion(),
                      children: [
                        const SizedBox(
                          width: 50,
                        ),
                        IconButton(
                          color: Colors.red,
                          onPressed: () => DatabaseHelper.getInstance().remove(
                            items[index],
                          ),
                          icon: const Icon(
                            Icons.delete_forever,
                            size: 50,
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
                          onPressed: () =>
                              _callContact(context, items[index].phoneNumber),
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
                          onPressed: () =>
                              _smsContact(context, items[index].phoneNumber),
                          icon: const Icon(
                            Icons.message_rounded,
                            size: 40,
                          ),
                        ),
                      ],
                    ),
                    child: InkWell(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (ctx) => AttendanceUpdateForm(
                            id: items[index].id,
                            name: items[index].name,
                            date: DateTime.parse(items[index].date),
                            price: items[index].price,
                            title: items[index].title,
                            phoneNumber: items[index].phoneNumber,
                          ),
                        );
                      },
                      child: Container(
                        margin: const EdgeInsets.all(8),
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(8),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: const Offset(
                                  0, 3), // changes position of shadow
                            ),
                          ],
                          gradient: LinearGradient(
                            colors: [
                              Color.fromRGBO(red, green, blue, 1)
                                  .withOpacity(0.7),
                              const Color.fromRGBO(76, 175, 80, 1),
                            ],
                          ),
                        ),
                        child: ListTile(
                          contentPadding: const EdgeInsets.only(left: 0),
                          leading: CircleAvatar(
                            radius: 45,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Text('ETB'),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(items[index].price),
                              ],
                            ),
                          ),
                          title: Text(
                            items[index].name,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                items[index].title,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                DateFormat.yMMMEd()
                                    .format(DateTime.parse(items[index].date)),
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromRGBO(red, green, blue, 1).withOpacity(0.7),
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (ctx) => const AttendanceForm(),
          );
          setState(() {});
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (ctx) => const AttendanceFormScreen(),
          //   ),
          // );
        },
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }
}
