import 'package:book/Components/Views/AddBook.dart';
import 'package:book/Components/Views/BookView.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'Components/Controller/Binding.dart';
import 'Components/Controller/BookRWHelper.dart';

void main(){
  WidgetsFlutterBinding.ensureInitialized();
   runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  GetMaterialApp(
      initialRoute: '/home',
      initialBinding: AddBooksBinding(),
      getPages: [
        GetPage(name:"/home", page:()=>const AllBookView()),
        GetPage(name:"/addBook", page:()=>const AddBooks(),binding: AddBooksBinding(), transition: Transition.fadeIn),

      ],
    );
  }
}

