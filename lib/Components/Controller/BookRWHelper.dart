import 'package:get/get.dart';

import '../../Model/bookModel.dart';

class BookReadWriteHelper extends GetxController {



   List<Map<String,dynamic>> booksData = <Map<String,dynamic>>[
    {"title": "Ramayana", "author": "Valmiki"},
    {"title": "The Jungle", "author": "Tom"},
    {"title": "Iron-Man", "author": "Stan-Lee"},
    {"title": "Avengers", "author": "Stan-Lee"},
    {"title": "Story of Moon", "author": "AJ Verma"},
    {"title": "Interstellar", "author": "K-N"},
    {"title": "The Dark", "author": "Master Jim"},
  ].obs;

  addBook(Books data){
   try{
    booksData.add(data.toJson());
    return true;
   }catch(e){
    throw "Unable to add data.\n due to $e";
   }
  }

}
