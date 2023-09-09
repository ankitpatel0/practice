import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../search/search.dart';
import '../search/to_search_screen.dart'; // for formatting dates

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  DateTime selectedDate = DateTime.now();
  String formattedSelectedDate = DateFormat.yMMMMd().format(DateTime.now());
  String callDescription = '';
  bool tomorrowDateIncremented = false;


  @override
  Widget build(BuildContext context) {
  final String? selectedData = ModalRoute.of(context)!.settings.arguments as String?;
  final String? selectedToData = ModalRoute.of(context)!.settings.name as String?;

    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffd44d57),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 30),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 80),
                child: Text(
                  "Bus tickets",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 30),
                child: Text("Exciting offer & discount"),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30),
                child: Text("24*7 customer service (call/chat)"),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          SizedBox(
              height: 200,
              width: 450,
              child: Card(
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    color: Colors.black,
                  ),
                  borderRadius: BorderRadius.circular(20.0), //<-- SEE HERE
                ),
                child: Container(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    children: [
                      InkWell(
                        onTap: (){
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SearchScreen(),));
                        },
                        child: Row(
                          children: [
                            Padding(
                              padding:  EdgeInsets.all(8.0),
                              child: Column(
                                children: [Icon(Icons.bus_alert_outlined)],
                              ),
                            ),
                            SizedBox(width: 10),
                            // Add some spacing between icon and text
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("From"),
                                selectedData == null?Text(""):
                                Text(
                                  "$selectedData",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Divider(thickness: 2,),
                      InkWell(
                        onTap: (){
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ToSearchScreen(),));
                        },
                        child: Row(
                          children: [
                            Padding(
                              padding:  EdgeInsets.all(8.0),
                              child: Column(
                                children: [Icon(Icons.bus_alert_outlined)],
                              ),
                            ),
                            SizedBox(width: 10),
                            // Add some spacing between icon and text
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("To"),
                                selectedToData == null?Text(""):
                                Text(
                                  "$selectedToData",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Divider(thickness: 2),
                      Row(
                        children: [
                          Column(
                            children: [Icon(Icons.calendar_month)],
                          ),
                          SizedBox(width: 10),
                          // Add some spacing between icon and text
                          InkWell(
                            onTap: () {
                              _selectDate(context);
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Date of Journey"),
                                Text(
                                  formattedSelectedDate,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 10),
                          SizedBox(
                            width: 80,
                            height: 30,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red, // background color
                              ),
                              onPressed: () {
                                setState(() {
                                  selectedDate = DateTime.now();
                                  formattedSelectedDate =
                                      DateFormat.yMMMMd().format(selectedDate);
                                  tomorrowDateIncremented = false;
                                });
                              },
                              child: const Text('Today'),
                            ),
                          ),
                          SizedBox(width: 10),
                          SizedBox(
                            width: 85,
                            height: 30,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red, // background color
                              ),
                              onPressed: () {
                                setState(() {
                                  if (!tomorrowDateIncremented) {
                                    selectedDate = selectedDate.add(const Duration(days: 1));
                                    formattedSelectedDate = DateFormat.yMMMMd()
                                        .format(selectedDate);
                                    tomorrowDateIncremented = true;
                                  }
                                });
                              },
                              child: const Text(
                                'Tomorrow',
                                style: TextStyle(fontSize: 10),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )),
          SizedBox(height: 15,),
          Container(
            padding: const EdgeInsets.only(left: 40),
            height: 50,
            width: size.width * 0.8,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                foregroundColor: Colors.white,
                backgroundColor: Color(0xffd44d57),
                elevation: 10,  // Elevation
                shadowColor: Color(0xffd44d57), // Shadow Color
              ),
              child: const Text('Search Buses'),
            ),
          ),
          SizedBox(height: 20),
          Center(
            child: Text(
              "You Can Also Book",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 18),
            ),
          ),
          SizedBox(
            height: 12,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Card(
                elevation: 5,
                margin: EdgeInsets.all(10),
                child: Container(
                  width: 100,
                  margin: EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Icon(
                        Icons.bus_alert,
                        color: Color(0xffd44d57),
                        size: 40,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Cab/Bus Hire",
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      )
                    ],
                  ),
                ),
              ),
              Card(
                elevation: 5,
                margin: EdgeInsets.all(10),
                child: Container(
                  width: 100,
                  margin: EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Icon(
                        Icons.train,
                        color: Color(0xffd44d57),
                        size: 40,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Red Rail",
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            alignment: Alignment.topLeft,
            margin: EdgeInsets.only(left: 20),
            child: Text(
              "Return Trip",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 18),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            width: size.width *1,
            height: 70,
            child: Card(
              elevation: 5,
              child: Container(
                width: 20,
                margin: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Jamnagar to Rajkot",
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                    ),
                    TextButton(
                        onPressed: () {},
                        child: Text("Book Now", style: TextStyle(fontSize: 15)))
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        formattedSelectedDate = DateFormat.yMMMMd().format(selectedDate);
      });
    }
  }
}
