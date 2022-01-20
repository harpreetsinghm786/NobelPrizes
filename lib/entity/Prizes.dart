class Prizes{
  String? year,category;


  Prizes({this.year,this.category});
  Prizes.fromJson(Map<String,dynamic> json){
    year=json["year"];
    category=json["category"];

  }
}