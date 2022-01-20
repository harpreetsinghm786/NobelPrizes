import 'package:bikayi/constants.dart';
import 'package:bikayi/entity/Persondata.dart';
import 'package:flutter/material.dart';


class Details extends StatefulWidget {
  List<Person> l;
  Details({Key? key,required this.l}) : super(key: key);

  @override
  _DetailsState createState() => _DetailsState(l:this.l);
}

class _DetailsState extends State<Details> {
  List<Person> l;
  _DetailsState({required this.l});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(

          child:  SingleChildScrollView(
         scrollDirection: Axis.vertical,
         child: Container(
           padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width>900?150:0),

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
               ListView.builder(
                 shrinkWrap: true,
                   itemCount: l.length,
                   physics: ScrollPhysics(),
                   itemBuilder: (context,index){
                     return Card(
                       color: textcolor,
                         child: Container(
                           child: Row(
                             children: [
                               Container(
                                 padding: EdgeInsets.all(15),
                                 child: Column(
                                   crossAxisAlignment: CrossAxisAlignment.start,
                                   children: [

                                     Text(l[index].firstname.toString()+" "+l[index].surname.toString(),style: getstyle(20, FontWeight.w500, Colors.white)),
                                     SizedBox(height: 5,),
                                     Text("Id : "+l[index].id.toString(),style: getstyle(13, FontWeight.normal, Colors.white)),
                                     SizedBox(height: 5,),
                                     Container(
                                         child: Text(l[index].motivation.toString(),style: getstyle(13, FontWeight.normal, Colors.white),overflow: TextOverflow.ellipsis,maxLines: 1,)),
                                     SizedBox(height: 5,),
                                     Row(children: [
                                       Text("Shares",style: getstyle(13, FontWeight.w500, Colors.white),),
                                       SizedBox(width: 5,),

                                       Text(l[index].share.toString(),style: getstyle(15, FontWeight.w500, Colors.white),textAlign: TextAlign.center,),

                                       Icon(Icons.share,color: Colors.white,size: 20,),
                                     ],)


                                   ],
                                 ),
                               )
                             ],
                           ),
                         ),
                       );
                   }),
             ],
           ),
         ),
       )
      ),
    );
  }
}
