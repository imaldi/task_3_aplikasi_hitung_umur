import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
// import 'package:fluttertoast/fluttertoast.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int d, m, y;
  // int maxDay = 31;
  String days1 = "",
      month1 = "",
      year1 = "";
  String currentDate = "",
      currentMonth = "",
      currentYear = "";

  final _formKey = GlobalKey<FormState>();

  final tanggalController = TextEditingController();
  final bulanController = TextEditingController();
  final tahunController = TextEditingController();

  @override
  void dispose() {
    tanggalController.dispose();
    bulanController.dispose();
    tahunController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(child: Column(children: <Widget>[
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //   children: [
        Form(
          key: _formKey, child: Column(children: [
          SizedBox(height: 20.0 ,),
            Text("Tanggal"),
          TextFormField(
            controller: tanggalController,
            validator: (String value) {
              if(value.isEmpty){
                return "Tanggal Harus Diisi";
              }else if (int.parse(value) < 1 || int.parse(value) > finddays(int.parse(bulanController.text), int.parse(tahunController.text))) {
                return "Tanggal tidak bisa lebih dari "+finddays(int.parse(bulanController.text), int.parse(tahunController.text)).toString();
              }
              return null;
            },
            decoration: InputDecoration(
              hintText: "Tanggal",
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4.0)),
            ),
            keyboardType: TextInputType.number,
          ),
          SizedBox(height: 20.0 ,),
          Text("Bulan"),
          TextFormField(
            controller: bulanController,
            validator: (String value) {
              if(value.isEmpty){
                return "Bulan Harus Diisi";
              }else if (int.parse(value) < 1 || int.parse(value) > 12) {
                return "Bulan hanya ada 12";
              }
              return null;
            },
            decoration: InputDecoration(
              hintText: "Bulan",
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4.0)),
            ),
            keyboardType: TextInputType.number,
          ),
          SizedBox(height: 20.0 ,),
          Text("Tahun"),
          TextFormField(
            controller: tahunController,
            validator: (String value) {
              if(value.isEmpty){
                return "Tahun Harus Diisi";
              }else if (int.parse(value) < 1 || int.parse(value) > 2020) {
                return "Tahun tidak bisa setelah 2020";
              }
              return null;
            },
            decoration: InputDecoration(
              hintText: "Tahun",
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4.0)),
            ),
            keyboardType: TextInputType.number,
          ),
        ]
          ,)
          ,),
        // ],),
        SizedBox(height: 20.0 ,),
        RaisedButton(child: Text("Cek Umur"),onPressed: (){
          if (_formKey.currentState.validate()) {
            f1(tanggalController.text, bulanController.text,
                tahunController.text);
          }
        },),
        Text(year1 + " " + month1 + " " + days1)
      ],),),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     // f1();
      //     if (_formKey.currentState.validate()) {
      //       f1(tanggalController.text, bulanController.text,
      //           tahunController.text);
      //       // Fluttertoast.showToast(
      //       //     msg: "" + currentDate + "/" + currentMonth + "/" + currentYear,
      //       //     toastLength: Toast.LENGTH_SHORT,
      //       //     gravity: ToastGravity.CENTER,
      //       //     timeInSecForIos: 1,
      //       //     backgroundColor: Colors.green,
      //       //     textColor: Colors.white,
      //       //     fontSize: 16.0
      //       // );
      //     }
      //   },
      //   tooltip: 'Increment',
      //   child: Icon(Icons.add),
      // ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  // Future f1() async {
  void f1(String tanggal, String bulan, String tahun) {
    // DateTime date1= await showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(1900), lastDate: DateTime.now());
    setState(() {
      d = int.parse(tanggal);
      m = int.parse(bulan);
      y = int.parse(tahun);
      // d=int.parse(DateFormat("dd").format(date1));
      // m=int.parse(DateFormat("MM").format(date1));
      // y=int.parse(DateFormat("yy").format(date1));
      int d1 = int.parse(DateFormat("dd").format(DateTime.now()));
      int m1 = int.parse(DateFormat("MM").format(DateTime.now()));
      int y1 = int.parse(DateFormat("yyyy").format(DateTime.now()));
      currentDate = DateFormat("dd").format(DateTime.now());
      currentMonth = DateFormat("MM").format(DateTime.now());
      currentYear = DateFormat("yyyy").format(DateTime.now());
      int day = finddays(m1, y1);
      if (d1 - d >= 0) {
        days1 = (d1 - d).toString() + " days";
      } else {
        days1 = (d1 + day - d).toString() + " days";
        m1 = m1 - 1;
      }

      if (m1 - m > 0)
        month1 = (m1 - m).toString() + " months";
      else {
        month1 = (m1 + 12 - m).toString() + " months";
        y1 = y1 - 1;
      }
      year1 = (y1 - y).toString() + " years";
    });
  }

  int finddays(int m2, int y2) {
    int day2;
    if (m2 == 1 || m2 == 3 || m2 == 5 || m2 == 7 || m2 == 8 || m2 == 10 ||
        m2 == 12) {
      day2 = 31;
    } else if (m2 == 4 || m2 == 6 || m2 == 9 || m2 == 11) {
      day2 = 30;
    } else {
      if (y2 % 4 == 0) {
        day2 = 29;
      } else {
        day2 = 28;
      }
    }
    // maxDay = day2;
    return day2;
  }
}
