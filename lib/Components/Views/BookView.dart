import 'package:book/Components/Controller/BookRWHelper.dart';
import 'package:book/Model/bookModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AllBookView extends StatefulWidget {
  const AllBookView({Key? key}) : super(key: key);

  @override
  State<AllBookView> createState() => _AllBookViewState();
}

BookReadWriteHelper _rwHelper = Get.put(BookReadWriteHelper());

class _AllBookViewState extends State<AllBookView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.purple,
        onPressed: () {
          Get.toNamed("/addBook");
        },
        label: const Text("Add Book"),
        icon: const Icon(Icons.add),
      ),
      backgroundColor: Colors.purple.shade50,
      appBar: AppBar(
        leading: Container(),
        title: const Text("Books Gallery"),
        centerTitle: true,
        backgroundColor: Colors.purple,
      ),
      body: ListView.builder(
        physics: const ScrollPhysics(
            parent: BouncingScrollPhysics()
        ),
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemBuilder: (BuildContext context, int index) {
          Books data = Books.fromJson(_rwHelper.booksData[index]);
          String title = data.title;
          String author = data.author;
          return Container(
            // decoration: BoxDecoration(
            //   borderRadius: BorderRadius.circular(10)
            // ),
            margin: const EdgeInsets.symmetric(vertical: 5,horizontal: 10),
            child: ListTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10)
              ),
              tileColor: Colors.white,
              style: ListTileStyle.list,
              contentPadding: const EdgeInsets.symmetric(vertical: 2,horizontal: 10),
              title: Text(title),
              subtitle: Text(author),

            ),
          );
        },
        itemCount: _rwHelper.booksData.length,
      ),
    );
  }
}
