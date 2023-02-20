class Books{
  late String title;
  late String author;

 Books(this.title,this.author);


 Books.fromJson(Map<String,dynamic> jsonData)
  : title=jsonData["title"],
  author = jsonData["author"];

 Map<String,dynamic> toJson()=>
    {
     "title":title,
     "author":author
   };


}