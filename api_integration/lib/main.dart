import 'package:api_integration/post.dart';
import 'package:http/http.dart'as http;
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter_spinkit/flutter_spinkit.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme:  const AppBarTheme(
          iconTheme: IconThemeData(color: Colors.white),
          titleTextStyle: TextStyle(color: Colors.white,fontSize: 28),

          centerTitle: true,
        ),
        textTheme: const TextTheme(
          bodyText2: TextStyle(fontSize: 18,fontWeight: FontWeight.bold)
        ),
        iconTheme: const IconThemeData(
          color: Colors.amber,
        ), 
          primarySwatch: Colors.amber, 
          elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(foregroundColor: MaterialStateColor.resolveWith((states) => Colors.white),)
      )
      ),
      home: const Home(),
    );
  }
}
String? stringResponse;
Map? mapResponse;
late List dataList;
int page_num=0;
int total_pages=0;
class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future getData()async{
    http.Response response = await http.get(Uri.parse('https://reqres.in/api/users?page=2'));
    if(response.statusCode==200){
      mapResponse=json.decode(response.body);
      dataList=mapResponse!['data'];
      page_num=mapResponse!['page'];
      total_pages=mapResponse!['total_pages'];
      setState(() {});
    }
  }
  @override
  void initState() {
    getData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('API DETAILS'),
        actions: [
          IconButton(onPressed: (){
            setState(() {
              Navigator.push(context, MaterialPageRoute(builder:  (context) => const PostPage(),));
            });
          }, icon: const Icon(Icons.add,size: 40,)),
          const SizedBox(width: 10,),
        ],
      ),
      body: mapResponse==null?const Center(
        child: SpinKitFoldingCube(
          color: Colors.amber,
        ),
      ):
      ListView.separated(
          itemBuilder: (context,index){
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(dataList[index]['avatar']),
                    backgroundColor: Colors.amber,
                    radius: 30,
                  ),
                  const SizedBox(width: 15,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            height: 25,
                              width: 25,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.grey[400],
                              ),
                              child: Center(child: Text(dataList[index]['id'].toString()))),
                          const SizedBox(width: 5,),
                          Text('${dataList[index]['first_name']} ${dataList[index]['last_name']}'),
                        ],
                      ),
                      const SizedBox(height: 10,),
                      Text('Email: ${dataList[index]['email']}')
                    ],
                  )
                ],
              ),
            );
          },
        itemCount: dataList.length,
        separatorBuilder: (BuildContext context, int index) {
            return const Divider(height: 20,thickness: 1,);
        },
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(onPressed: (){}, icon: const Icon(Icons.arrow_back_ios_new_outlined,size: 35,)),
            Text('$page_num/$total_pages',style: const TextStyle(fontSize: 35,letterSpacing: 7),),
            IconButton(onPressed: (){}, icon: const Icon(Icons.arrow_forward_ios,size: 35,)),
          ],
        ),
      )
    );
  }
}
