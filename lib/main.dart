import 'dart:convert';

import 'package:bikayi/constants.dart';
import 'package:bikayi/entity/Persondata.dart';
import 'package:bikayi/entity/Prizes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'Details.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Nobel Prizes',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: Home(),
    );
  }
}


class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  List<dynamic> data=[];
  List<List<Person>> data2=[];


  Future<Map<String,dynamic>> fetchAlbum() async {
    var response=await http.get(Uri.parse('http://api.nobelprize.org/v1/prize.json'));
    if(response.statusCode==200){


      return json.decode(response.body);
    }

    throw Exception("data not found");

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }



  @override
  Widget build(BuildContext context) {


    return Scaffold(
      backgroundColor: Colors.black,


      body: FutureBuilder<Map<String,dynamic>>(
        future: fetchAlbum(),
          builder: (context,snapshot){


          if(snapshot.hasData){
            return SafeArea(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width>600?150:0),
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 20,horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [

                            Row(
                              children: [
                                Container(
                                    height: 30,
                                    width: 30,
                                    child: Image(image: AssetImage("assets/images/prize.png",))),
                                SizedBox(width: 5,),
                                Text("Nobel Prize",style: getstyle(25, FontWeight.w500, Colors.white)),

                              ],
                            ),
                            IconButton(onPressed: (){}, icon: Icon(Icons.search,color: Colors.white,))
                          ],
                        ),
                      ),
                      Image(image: AssetImage("assets/images/nobel.png")),
                      SizedBox(height: 15,),
                      Container(
                          padding: EdgeInsets.only(top: 20,right: 20,left: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("About Nobel",style: getstyle(18, FontWeight.w500, Colors.white),
                              ),

                            ],
                          )
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 20,right: 20,left: 20),
                          child: Text("According to his will and testament read in Stockholm on 30 December 1896, a foundation established by Alfred Nobel would reward those who serve humanity. The Nobel Prize was funded by Alfred Nobel's personal fortune. According to the official sources, Alfred Nobel bequeathed most of his fortune to the Nobel Foundation that now forms the economic base of the Nobel Prize.",style: getstyle(13, FontWeight.normal, Colors.white),)),
                  Container(
                      padding: EdgeInsets.only(top: 20,right: 20,left: 20),
                      child: Text("In accordance with Nobel's will, the primary task of the foundation is to manage the fortune Nobel left. Robert and Ludvig Nobel were involved in the oil business in Azerbaijan, and according to Swedish historian E. Bargengren, who accessed the Nobel family archive, it was this decision to allow withdrawal of Alfreds money from Baku that became the decisive factor that enabled the Nobel Prizes to be established",style: getstyle(13, FontWeight.normal, Colors.white),)),


                      Container(
                          padding: EdgeInsets.only(top: 20,right: 20,left: 20,bottom: 20),
                       child: Row(
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                         Text("Nobel Prize Winners",style: getstyle(18, FontWeight.w500, Colors.white),
                         ),
                            IconButton(onPressed: (){}, icon: Icon(Icons.sort,color: Colors.white,))
                          ],
                        )
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                          itemCount: 50,
                          physics: ScrollPhysics(),
                          itemBuilder: (context,index){
                            List<Person> personlist=[];
                            for(int i=0;i<snapshot.data!["prizes"][index]["laureates"].length;i++) {
                              var l = snapshot.data!["prizes"][index]["laureates"][i];
                              Person p=new Person(id: l["id"],firstname: l["firstname"],surname: l["surname"],motivation: l["motivation"],share: l["share"]);
                              personlist.add(p);
                            }

                            return  GestureDetector(
                              onTap: (){

                                Navigator.push(context, MaterialPageRoute(builder: (context)=>Details(l: personlist)));
                              },
                              child: Card(
                                color: textcolor,
                                child: Container(
                                  padding: EdgeInsets.all(15),

                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text("Year : "+snapshot.data!["prizes"][index]["year"].toString(),style: getstyle(20, FontWeight.w600, Colors.white),),
                                          SizedBox(height: 5,),
                                          Text("Category : "+snapshot.data!["prizes"][index]["category"].toString(),style: getstyle(13, FontWeight.normal, Colors.white)),

                                        ],
                                      ),
                                      Icon(Icons.arrow_forward,color: Colors.white,)
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }),
                      SizedBox(height: 50,),

                    ],

                  ),
                ),
              ),
            );

          }

          return Center(child: CircularProgressIndicator(color: Colors.white,),);

      }),

    );
  }


}



