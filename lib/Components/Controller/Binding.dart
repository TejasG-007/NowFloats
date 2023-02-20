import 'package:book/Components/Controller/BookRWHelper.dart';
import 'package:get/get.dart';


class AddBooksBinding implements Bindings{


  @override
  void dependencies() {
   Get.put(BookReadWriteHelper(),permanent: true);
  }

}
