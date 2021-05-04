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
// + BLoC không chỉ giải quyết vấn đề chia sẻ code mà còn tận dụng chức năng Streams để quản lý và thông báo các thay đổi trạng thái trong Flutter
// + BLoC giúp chúng ta tách Business Logic ra khỏi UI. Nói cách khác, các thành phần UI chỉ nên take care về mặc UI chứ không phải logic
//
// ### How?
// BLoC sử dụng Streams, chúng ta có thể suy ra những điều sau:
//  - Input được lấy thông qua sink property
//  - Output được cung cấp bằng cách sử dụng stream property
//  - Widgets bắn event tới BLoC thông qua sinks
//  - BLoC notify thay đổi đến Widget thông qua stream
//  - Bât giờ thì Business Logic và UI component đã được tách ra, chúng ta có thể thay đổi business logic mọi lúc mà không làm ảnh hưởng đến các thành phần UI
//  - Tương tự, chúng ta cõ thể thay đổi các UI component mà không có bất kỳ tác động nào đến business logic
//
// ### Why bloc?
//  * setState
//  - Phương thức setState () sẽ notify đến framework rằng trạng thái của object bên trong setState() đã thay đổi
//  và điều này khiến cho framework sẽ build lại trạng thái mới cho đối tượng
//  ==> Các vẫn đề với cách làm như trên:
//  - Toàn bộ cây widget được build lại mỗi khi trạng thái của một widget duy nhất that đổi
//  - Không giúp tách biệt các thành phần UI và business logic
//
//  * InheritedWidget
//  - Nó là một loại widget đặc biệt xác định context tại root của các cây con và có thể phân bổ các context này đến mọi widget trong cây con đó một cách hiệu quả
//  Advance:
//    + Truyền dữ liệu xuống cây
//    + Cập nhật lại các widget khi có thây đổi
//  Disadvance:
//    + State được set final điều này có nghĩa là nó bất biến
//    + Nó không cung cấp bất kỳ phương pháp nào để giải phóng tài nguyên và tránh rò rỉ dữ liệu
//
//
// ----------- STREAM --------------
//  + Stream không là gì ngoài một luồng dữ liệu liên tục
// Hãy lấy ví dụ về băng chuyền. Một bằng chuyền có hai đầu, một vật phẩm được đưa vào từ một đầu (đầu vào) sau đó nó được xử lý và được lấy ra từ một đầu khác (đầu ra) Các khái niệm:
//  + Stream, băng chuyền hay gọi là luồng
//  + StreamController, là thứ điều khiển Stream
//  + StreamTransformer, là thứ xử lý dữ liệu đầu vào
//  + StreamBuilder, là phương thức lấy Stream làm đầu vào và provide một builder mỗi khi có giá trị mới của Stream được đưa ra
// sink, thuộc tính lấy đầu vào
//  + stream, thuộc tính cung cấp đầu ra khỏi luồng
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
//   // Khi hàm updateShouldNotify return true thì một khi InheritedWidget rebuild,
//   // nó cũng bắt các widget con đang phụ thuộc vào nó, hay nói cách khác là
//   // widget con đang sử dụng data của nó phải rebuild. Widget con phụ thuộc
//   // tức là widget con đang sử dụng data của nó bằng hàm MyInheritedWidget.of ấy.
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
* Sử dụng khi ko cần qtam đến state của widget sau khi hiển thị
* Ko có hàm setState()
* Không thể tự rebuild chính nó (re-render)
* Có thể rebuild stateless từ bên ngoài
*
*    --- Statefull Widget ---
* Ngược với bên trên
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
      áda
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
 * - Được gọi khi đối tượng được thêm vào widget tree
 * - Được gọi một lần nữa khi state object được tạo,
 * - Khi override method này thì luôn phải đi kèm super.initState()
 *
 * [- didChangeDependencies -]
 * - Được gọi khi dependencies của State Object thay đổi
 * vd: State Obj tham chiếu tới Inherited Widget (Dependency) và khi Widget này thay đổi thì State sẽ nhận biết
 * và hàm này sẽ re-run
 *
 * [- didUpdateWidget -]
 * - Được gọi khi có sự thay đổi về cấu trúc Widget Tree (Widget Configuration Change)
 * - build method sẽ được gọi ngay sau didUpdateWidget
 *
 * [- dispose -]
 * - Được gọi khi widget bị remove khỏi widget tree.
 *
 * ---------------------------------------------------
 *
 * ---------------- INHERITED WIDGET --------------
 * [https://viblo.asia/p/hoc-flutter-tu-co-ban-den-nang-cao-phan-4-lot-tran-inheritedwidget-3P0lPDbmlox]
 *  - InheritedWidget là một nơi lưu trữ data và cung cấp data cho widget con trong widget tree.
 * Tất cả widget con của InheritedWidget đều có thể truy cập vào InheritedWidget để lấy data
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
  //   // 4: Hàm of là một hàm static, hàm này truyền vào một BuildContext,
  *    sẽ giúp các widget truy cập trực tiếp vào MyInheritedWidget để lấy data bằng cách gọi MyInheritedWidget.of(context).
  *   static MyInheritedWidgett of(BuildContext context){
  *
  //      // 5. Hàm dependOnInheritedWidgetOfExactType truyền vào Widget type.
  *     Nó sẽ giúp ta get được Widget cha gần vị trí context nhất theo cái Type mình truyền vào.
  *     Trong code này, mình truyền vào type là MyInheritedWidget nên nó sẽ tìm widget cha có type
  *     là MyInheritedWidget mà gần vị trí context nhất
  //     return context.dependOnInheritedWidgetOfExactType<MyInheritedWidget>();
  //   }
  // }
* */
