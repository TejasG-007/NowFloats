import 'package:book/Components/Controller/BookRWHelper.dart';
import 'package:book/Model/bookModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddBooks extends StatefulWidget {
  const AddBooks({Key? key}) : super(key: key);

  @override
  State<AddBooks> createState() => _AddBooksState();
}

class _AddBooksState extends State<AddBooks> {

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _authorController = TextEditingController();

   final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  BookReadWriteHelper controller = Get.find();
  @override
  void dispose() {
    // TODO: implement dispose
    _titleController.dispose();
    _authorController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(onWillPop: (){
     Navigator.of(context).pushNamedAndRemoveUntil("/home", (route) => false);
      return Future.value(true);
    }, child: Scaffold(
      backgroundColor: Colors.purple.shade50,
      appBar: AppBar(
        title: const Text("Add Books"),
        centerTitle: true,
        backgroundColor: Colors.purple,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Form(
              key: _formkey,
                child: Column(
                  children: [
                    Container(
                      margin:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                      child: TextFormField(
                          controller: _titleController,
                          keyboardType: TextInputType.text,
                          validator: (val) {
                            if (val!.isEmpty) {
                              return "Book title Should not be empty";
                            } else {
                              return null;
                            }
                          },
                          decoration: const InputDecoration(
                              labelText: "Book Title",
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.purple)),
                              prefixIcon: Icon(
                                Icons.book,
                                color: Colors.purpleAccent,
                              ),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    width: 2,
                                  )))),
                    ),
                    Container(
                      margin:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                      child: TextFormField(
                          controller: _authorController,
                          keyboardType: TextInputType.text,
                          validator: (val) {
                            if (val!.isEmpty) {
                              return "Author Name Should not be empty";
                            } else {
                              return null;
                            }
                          },
                          decoration: const InputDecoration(
                              labelText: "Author Name",
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.purple)),
                              prefixIcon: Icon(
                                Icons.person,
                                color: Colors.purpleAccent,
                              ),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    width: 2,
                                  )))),
                    ),
                  ],
                )),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.purple),
              onPressed: () {
                _onButtonPressedAddBook(context);
              },
              icon: const Icon(
                Icons.add,
                color: Colors.white,
              ),
              label: const Text("Add Book"),
            )
          ],
        ),
      ),
    ));
  }

   _onButtonPressedAddBook(BuildContext context){

    try {
      if(_formkey.currentState!.validate()){
        bool check = controller.addBook(Books(_titleController.text, _authorController.text));
        return showDialog(
            context: context,
            builder: (context) =>  AlertDialog(
              actions: [
                TextButton(
                    onPressed: ()=>Get.offAndToNamed("home"), child: const Text("OKAY"))
              ],
              title: const Text(
                "Book Added Successfully.",
                style: TextStyle(
                    color: Colors.black, fontWeight: FontWeight.bold),
              ),
              icon: const Icon(
                Icons.done,
                color: Colors.green,
              ),
            ));
      }

    } catch (e) {
      return showDialog(
          context: context,
          builder: (context) =>  AlertDialog(
            actions: [
              TextButton(
                  onPressed: ()=>Navigator.of(context).pushNamedAndRemoveUntil("/home", (route) => false), child: const Text("OKAY"))
            ],
            title: Text(
              "Book Not Added.\n$e",
              style:const  TextStyle(
                  color: Colors.black, fontWeight: FontWeight.bold),
            ),
            icon:const Icon(
              Icons.done,
              color: Colors.green,
            ),
          ));
    }
  }
}
