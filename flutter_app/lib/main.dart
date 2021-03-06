import 'dart:async';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:flutter_app/states-provider/model/ui.dart';
import 'package:flutter_app/states-provider/home.dart';
import 'package:flutter_app/states-provider/about.dart';
import 'package:flutter_app/states-provider/setting.dart';
import 'package:flutter_app/states-provider/drawer-menu.dart';

// main(List<String> arguments) {
//   // The ways to create a Stream.
//   // Listener a Stream.
//   // Stream Single Subscription or Broadcast.
//   // Stream in Tranformer
//
//   // var data = Future<int>.delayed(Duration(seconds: 3), () => 100);
//   // Stream<int> stream = Stream<int>.fromFuture(data);
//   // stream.listen((event) {
//   //   print(event.toString());
//   // }, onDone: () {
//   //   print("Done cmnr!!!");
//   // });
//
//   Stream<int> stream = Stream.periodic(Duration(seconds: 1), (value) {
//     return value;
//   });
//   var subscription = stream.take(10).listen((event) {
//           print(event.toString());
//         }, onDone: () {
//           print("DONE!!!");
//       });
//
//   print('before Delayed');
//   Future.delayed(Duration(seconds: 3), () => {
//     print('pausing...'),
//     subscription.pause()
//   });
//   Future.delayed(Duration(seconds: 6), () => subscription.resume());
//   print('after Delayed');
// }

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [ChangeNotifierProvider(create: (_) => UI())],
        child: MaterialApp(initialRoute: '/', routes: {
          '/': (context) => Home(),
          '/about': (context) => About(),
          '/setting': (context) => Setting()
        }));
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Demo StateFull'),
        ),
        body: Center(
          child: Container(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text('Home Page'),
              // FutureWidget()
              // DemoInh(
              //   // child: OngBa(),
              //   child: MyContainer(
              //     child: Counter()
              //   ),
              // )
            ]),
          ),
        ));
  }
}
// ----------- BLoC ----------------
// ### What?
// + BLoc a.k.a Business Logic Component
// + BLoC kh??ng ch??? gi???i quy???t v???n ????? chia s??? code m?? c??n t???n d???ng ch???c n??ng Streams ????? qu???n l?? v?? th??ng b??o c??c thay ?????i tr???ng th??i trong Flutter
// + BLoC gi??p ch??ng ta t??ch Business Logic ra kh???i UI. N??i c??ch kh??c, c??c th??nh ph???n UI ch??? n??n take care v??? m???c UI ch??? kh??ng ph???i logic
//
// ### How?
// BLoC s??? d???ng Streams, ch??ng ta c?? th??? suy ra nh???ng ??i???u sau:
//  - Input ???????c l???y th??ng qua sink property
//  - Output ???????c cung c???p b???ng c??ch s??? d???ng stream property
//  - Widgets b???n event t???i BLoC th??ng qua sinks
//  - BLoC notify thay ?????i ?????n Widget th??ng qua stream
//  - B??t gi??? th?? Business Logic v?? UI component ???? ???????c t??ch ra, ch??ng ta c?? th??? thay ?????i business logic m???i l??c m?? kh??ng l??m ???nh h?????ng ?????n c??c th??nh ph???n UI
//  - T????ng t???, ch??ng ta c?? th??? thay ?????i c??c UI component m?? kh??ng c?? b???t k??? t??c ?????ng n??o ?????n business logic
//
// ### Why bloc?
//  * setState
//  - Ph????ng th???c setState () s??? notify ?????n framework r???ng tr???ng th??i c???a object b??n trong setState() ???? thay ?????i
//  v?? ??i???u n??y khi???n cho framework s??? build l???i tr???ng th??i m???i cho ?????i t?????ng
//  ==> C??c v???n ????? v???i c??ch l??m nh?? tr??n:
//  - To??n b??? c??y widget ???????c build l???i m???i khi tr???ng th??i c???a m???t widget duy nh???t that ?????i
//  - Kh??ng gi??p t??ch bi???t c??c th??nh ph???n UI v?? business logic
//
//  * InheritedWidget
//  - N?? l?? m???t lo???i widget ?????c bi???t x??c ?????nh context t???i root c???a c??c c??y con v?? c?? th??? ph??n b??? c??c context n??y ?????n m???i widget trong c??y con ???? m???t c??ch hi???u qu???
//  Advance:
//    + Truy???n d??? li???u xu???ng c??y
//    + C???p nh???t l???i c??c widget khi c?? th??y ?????i
//  Disadvance:
//    + State ???????c set final ??i???u n??y c?? ngh??a l?? n?? b???t bi???n
//    + N?? kh??ng cung c???p b???t k??? ph????ng ph??p n??o ????? gi???i ph??ng t??i nguy??n v?? tr??nh r?? r??? d??? li???u
//
//
// ----------- STREAM --------------
//  + Stream kh??ng l?? g?? ngo??i m???t lu???ng d??? li???u li??n t???c
// H??y l???y v?? d??? v??? b??ng chuy???n. M???t b???ng chuy???n c?? hai ?????u, m???t v???t ph???m ???????c ????a v??o t??? m???t ?????u (?????u v??o) sau ???? n?? ???????c x??? l?? v?? ???????c l???y ra t??? m???t ?????u kh??c (?????u ra) C??c kh??i ni???m:
//  + Stream, b??ng chuy???n hay g???i l?? lu???ng
//  + StreamController, l?? th??? ??i???u khi???n Stream
//  + StreamTransformer, l?? th??? x??? l?? d??? li???u ?????u v??o
//  + StreamBuilder, l?? ph????ng th???c l???y Stream l??m ?????u v??o v?? provide m???t builder m???i khi c?? gi?? tr??? m???i c???a Stream ???????c ????a ra
// sink, thu???c t??nh l???y ?????u v??o
//  + stream, thu???c t??nh cung c???p ?????u ra kh???i lu???ng
// ----------------------------------
//
// ----------- FUTURE --------------
// class FutureWidget extends StatefulWidget {
//   @override
//   _FutureWidgetState createState() => _FutureWidgetState();
// }
//
// class _FutureWidgetState extends State<FutureWidget> {
//   int count = 0;
//
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Container(
//         child: Column (
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             // future: function handle logic code
//             // builder: receive data from future and render data.
//             FutureBuilder <int> (
//                 future: delayNumber(),
//                 // future: testExceptionError(),
//                 builder: (context, snapshot) {
//                   print(count++);
//                   print(snapshot);
//                   print(snapshot.data);
//                   if (snapshot.hasError) { // snapshot is repsonsed value
//                     return Text(snapshot.error.toString(),
//                         style: TextStyle(fontSize: 40, color: Colors.blue)
//                     );
//                   }
//
//                   if (snapshot.hasData) {
//                     return Text(
//                       snapshot.data.toString(),
//                       style: TextStyle(color: Colors.red),
//                     );
//                   }
//
//                   return Text(
//                     "Loading...",
//                     style: TextStyle(color: Colors.red),
//                   );
//                 }
//             ),
//             FlatButton(
//                 onPressed: () async {
//                   // 1. asyncMethod();
//
//                   // 2. var number = await delayNumber();
//                   // print(number);
//
//                   // 3.
//                   // getAnge().then((x) => {
//                   //   print(x)
//                   // });
//
//                   // 4.
//                   try {
//                     var err = await testExceptionError();
//                     print(err);
//                   } catch (e) {
//                     print(e.toString());
//                   }
//
//                   print(123);
//                 },
//                 child: Text("Demo Future"))
//           ],
//         ),
//       ),
//     );
//   }
// }
// // 1.
// Future<void> asyncMethod () {
//   return Future.delayed(Duration(seconds: 2), () => print("async Method"));
// }
// // 2. If return a value then use async await or other way to get data.
// Future<int> delayNumber () {
//   return Future.delayed(Duration(seconds: 3), () => 1234567);
// }
// // 3.
// Future<int> getAnge () {
//   final c = Completer();
//   Future.delayed(Duration(seconds: 2), () {
//     c.complete(100);
//   });
//
//   return c.future;
// }
// // 4.
// Future<int> testExceptionError () {
//   return Future.delayed(Duration(seconds: 2),
//           () => throw Exception('Error!!!'));
// }

// // -------- Inherited Widget -----------
//
// // demo2
// class MyContainer extends StatefulWidget {
//   Widget child;
//
//   MyContainer({this.child});
//
//   @override
//   _MyContainerState createState() => _MyContainerState();
// }
//
// class _MyContainerState extends State<MyContainer> {
//   int count = 0;
//
//   increasement() {
//     setState(() {
//       print('1');
//       count++;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) { // rebuild when state change
//     print('2');
//
//     return DemoInh( // insert this to rebuild inh when state change
//       state: this,
//       child: widget.child // widget is MyContainer and child of MyContainer is Counter (be passed as Constructor)
//     );
//   }
// }
//
// class Counter extends StatefulWidget {
//   @override
//   _CounterState createState() => _CounterState();
// }
//
// class _CounterState extends State<Counter> { // dependency of inh widget.
//   @override
//   Widget build(BuildContext context) { // rebuild when have a notification from inh widget
//                                       //  (depend on updateShouldNotify true or false)
//     DemoInh demo = context.dependOnInheritedWidgetOfExactType();
//     print('3');
//
//     return Center(
//       child: Column (
//         children: <Widget> [
//           Text(demo.state.count.toString()),
//           ElevatedButton (
//               onPressed: () {
//                 demo.state.increasement();
//               },
//               child: (
//                 Text('Click me!!!', style: TextStyle(color: Colors.white))
//               )
//           )
//         ],
//       )
//     );
//   }
// }
//
//
// class DemoInh extends InheritedWidget {
//
//   // demo1
//   // int count = 1000;
//
//   // demo2
//   Widget child;
//   _MyContainerState state;
//
//   DemoInh({this.state, this.child});
//
//   @override
//   // Khi h??m updateShouldNotify return true th?? m???t khi InheritedWidget rebuild,
//   // n?? c??ng b???t c??c widget con ??ang ph??? thu???c v??o n??, hay n??i c??ch kh??c l??
//   // widget con ??ang s??? d???ng data c???a n?? ph???i rebuild. Widget con ph??? thu???c
//   // t???c l?? widget con ??ang s??? d???ng data c???a n?? b???ng h??m MyInheritedWidget.of ???y.
//   bool updateShouldNotify(DemoInh old) {
//     return true;
//   }
// }

// demo1
// class OngBa extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: ChaMe()
//     );
//   }
// }
//
// class ChaMe extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: ConGai()
//     );
//   }
// }
//
// class ConGai extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     DemoInh demo = context.dependOnInheritedWidgetOfExactType();
//
//     return Container(
//       child:
//         Text(
//           demo.count.toString(),
//           style: TextStyle(fontSize: 40)
//         )
//     );
//   }
// }

// class MyStatefullWidget extends StatefulWidget {
//   @override
//   _MyStatefullWidgetState createState() => _MyStatefullWidgetState();
// }
//
// class _MyStatefullWidgetState extends State<MyStatefullWidget> {
//   int count = 0;
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Column(
//         children: <Widget>[
//           Text('$count', style: TextStyle(fontSize: 40)),
//           ElevatedButton (
//               onPressed: () {
//                 setState(() {
//                   count++;
//                 });
//               },
//               child: (
//                 Text('Click me!!!', style: TextStyle(color: Colors.white))
//               ),
//               // color: Colors.red,
//               // shape: RoundedRectangleBorder(
//               //   borderRadius: BorderRadius.circular(10)
//               // ),
//           )
//         ]
//       ),
//     );
//   }
// }
//
//
// class LoginPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Login Page')
//       ),
//       body: Container(
//         padding: EdgeInsets.all(50),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             TextFormField(
//               decoration: InputDecoration(
//                 icon: Icon(Icons.email),
//                 hintText: 'email@gmail.com',
//                 labelText: 'Email'
//               ),
//             ),
//
//             SizedBox(height: 15),
//
//             TextFormField(
//               obscureText: true,
//               decoration: InputDecoration(
//                   icon: Icon(Icons.access_alarm),
//                   hintText: 'email@gmail.com',
//                   labelText: 'Email'
//               ),
//             ),
//
//             SizedBox(height: 15),
//
//             RaisedButton(
//               onPressed: (){},
//               color: Colors.blueGrey,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(10)
//               ),
//               child:
//                 Text(
//                   'Login',
//                   style: TextStyle(color: Colors.white),
//                 ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

/*
*   --- Stateless Widget ---
*  extends StatelessWidget
* @overide
*
* S??? d???ng khi ko c???n qtam ?????n state c???a widget sau khi hi???n th???
* Ko c?? h??m setState()
* Kh??ng th??? t??? rebuild ch??nh n?? (re-render)
* C?? th??? rebuild stateless t??? b??n ngo??i
*
*    --- Statefull Widget ---
* Ng?????c v???i b??n tr??n
*
*
* class Student {
  String name;
  int age;

  String _email;

  set email(e) => _email = e;
  String get email => _email;
}


// ========= FUNCTION ========
// --- Optional param ---
// param in {} is called optional param
// do not care position of filled param.
void register({String fullname,String email, String phone}) {
  print(fullname);
  print(email);
  print(phone);
}

// --- Positional param ---
// param in [] is called Positional param
// do not care position of filled param.
void register2([String fullname,String email, String phone]) {
  print(fullname);
  print(email);
  print(phone);
}

// --- Default param ---
// --- Lamda function ---
int getAge() => 10;

// --- @required annotation ---
// void register3({@required String fullname, String email, String phone}) {
//   print(fullname);
//   print(email);
//   print(phone);
// }

void main() {
  // 3rd param can be filled or not
  register(fullname: 'khoa', email: 'khoatd@gmail.com');
  // can invert pos of param
  register(email: "khoa@gmail.cpm", fullname: "khoa", phone: "1233");

  int a = 1;
  double b = 1.1;
  String c = "string c";
  String d = 'string d';
   bool e = false;


  // string interpolation
  String f = '${b}';

  if (c.isEmpty)
    print(f);

  String number = "1" + "2"; // bad way - cause memory will init 2 var for 1 and 2.

  StringBuffer sbf = StringBuffer();
  sbf.write("1");
  sbf.write("2");
  print(sbf.toString());

  // Multiple line
  var multiLine = '''
      ??da
  ''';

  // ======== Lists, Sets, Maps ========

  // Lists

  List<int> list = [1,2,3,4];

  print(list);
  list.add(5);

  List<Object> list1 = [1, 'string', 2];

  // collection if
  var age = 18;
  var languages = [
    'java',
    'c++',
    if (age == 18) 'dart'
  ];
  print(languages);

  // collection for
  var listOfString = [
    for (var i = 0; i < 10; i++)
      'item $i'
  ];
  print(listOfString);

  // Sets - will be filter duplicated value
  var sets = {1,2,3,4,3,4,1,1};
  print(sets);

  // Maps (key - value)
  var maps = {
    'id': 1,
    'name': 'khoatd15'
  };
  print(maps);
  print(maps['id']);

  // ========= OOP =========
  var st = Student();
  st.name = 'khoatd15';
  st.age = 24;
  st._email = "1512261";
  print(st._email);
 }
 *
 * --------------- LIFECYCLE -----------------
 * [- Init State -]
 * - ???????c g???i khi ?????i t?????ng ???????c th??m v??o widget tree
 * - ???????c g???i m???t l???n n???a khi state object ???????c t???o,
 * - Khi override method n??y th?? lu??n ph???i ??i k??m super.initState()
 *
 * [- didChangeDependencies -]
 * - ???????c g???i khi dependencies c???a State Object thay ?????i
 * vd: State Obj tham chi???u t???i Inherited Widget (Dependency) v?? khi Widget n??y thay ?????i th?? State s??? nh???n bi???t
 * v?? h??m n??y s??? re-run
 *
 * [- didUpdateWidget -]
 * - ???????c g???i khi c?? s??? thay ?????i v??? c???u tr??c Widget Tree (Widget Configuration Change)
 * - build method s??? ???????c g???i ngay sau didUpdateWidget
 *
 * [- dispose -]
 * - ???????c g???i khi widget b??? remove kh???i widget tree.
 *
 * ---------------------------------------------------
 *
 * ---------------- INHERITED WIDGET --------------
 * [https://viblo.asia/p/hoc-flutter-tu-co-ban-den-nang-cao-phan-4-lot-tran-inheritedwidget-3P0lPDbmlox]
 *  - InheritedWidget l?? m???t n??i l??u tr??? data v?? cung c???p data cho widget con trong widget tree.
 * T???t c??? widget con c???a InheritedWidget ?????u c?? th??? truy c???p v??o InheritedWidget ????? l???y data
 *
 * class MyInheritedWidget extends InheritedWidget {
  //   // 1
  //   MyInheritedWidget({Widget child, this.myData}) : super(child: child);
  //
  //   // 2
  //   final int myData;
  //
  //   // 3
  //   @override
  //   bool updateShouldNotify(MyInheritedWidget oldWidget) {
  //     return false;
  //   }
  //   // 4: H??m of l?? m???t h??m static, h??m n??y truy???n v??o m???t BuildContext,
  *    s??? gi??p c??c widget truy c???p tr???c ti???p v??o MyInheritedWidget ????? l???y data b???ng c??ch g???i MyInheritedWidget.of(context).
  *   static MyInheritedWidgett of(BuildContext context){
  *
  //      // 5. H??m dependOnInheritedWidgetOfExactType truy???n v??o Widget type.
  *     N?? s??? gi??p ta get ???????c Widget cha g???n v??? tr?? context nh???t theo c??i Type m??nh truy???n v??o.
  *     Trong code n??y, m??nh truy???n v??o type l?? MyInheritedWidget n??n n?? s??? t??m widget cha c?? type
  *     l?? MyInheritedWidget m?? g???n v??? tr?? context nh???t
  //     return context.dependOnInheritedWidgetOfExactType<MyInheritedWidget>();
  //   }
  // }
* */
