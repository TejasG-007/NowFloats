import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Controller/Controller.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final TextEditingController _cityController = TextEditingController();




@override
  void initState() {
   WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
     Provider.of<WeatherProvider>(context,listen: false).fetchCurrentLocationWeatherData();
   });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<WeatherProvider>(context);
    return Scaffold(
        body: SingleChildScrollView(
          child: SafeArea(
      child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  "Weather App",
                  style: TextStyle(
                      color: Colors.blue,
                      fontSize: 40,
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 2, horizontal: 10),
              child: TextFormField(
                controller: _cityController,
                decoration: InputDecoration(
                    labelText: "Enter City ",
                    hintText: "Search Weather For City",
                    suffixIcon: IconButton(
                      icon: const Icon(
                        Icons.search,
                        color: Colors.red,
                      ),
                      onPressed: () {
                        if (_cityController.text.isNotEmpty) {
                          provider.getWeatherData(_cityController.text);
                          _cityController.clear();
                        }
                      },
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                            width: 2, color: Colors.purpleAccent))),
              ),
            ),
            provider.weather != null
                ? Container(
                    alignment: Alignment.center,
                    height: 200,
                    width: MediaQuery.of(context).size.width - 40,
                    margin: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25),
                        boxShadow: const [
                          BoxShadow(
                              blurRadius: 9,
                              color: Colors.grey,
                              offset: Offset(.4, .4))
                        ]),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Tooltip(
                              message: "Add to Favourite",
                              child: IconButton(
                                  onPressed: () {
                                    if(provider.checker(provider.weather!.cityName)){
                                      provider.remFav(provider.weather);
                                      ScaffoldMessenger.of(context).showSnackBar(
                                          
                                          SnackBar(
                                            behavior: SnackBarBehavior.floating,
                                              margin: const EdgeInsets.symmetric(horizontal: 30,vertical: 20),
                                              content: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(40)
                                        ),
                                        child: const Text("Removed From Favourite",style: TextStyle(color: Colors.red),),)));
                                    }else{
                                      provider.setFav(provider.weather);
                                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                          behavior: SnackBarBehavior.floating,
                                          margin:const EdgeInsets.symmetric(horizontal: 30,vertical: 20),
                                          content: Container(
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(40)
                                        ),
                                        child: const Text("Added to Favourite",style: TextStyle(color: Colors.green),),)));
                                    }
                                  },
                                  icon:provider.checker(provider.weather!.cityName)? Icon(
                                    Icons.favorite,
                                    color: Colors.red,
                                    size: 30,
                                  ):Icon(Icons.favorite_border_outlined)),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "${provider.weather?.cityName??"..."}",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 35,
                                      color: Color(0xFFF42476d)),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text("${provider.weather?.temperature??"..."}°C",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 38)),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text("${provider.weather?.description??"..."}",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                        color: Colors.green)),
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  )
                : Container(),
            provider.isLoading
                ? Container(
              margin: const EdgeInsets.all(10),
              child: CircularProgressIndicator(color: Colors.blue.shade200,),
            )
                :Container(
              alignment: Alignment.center,
              height: 200,
              width: MediaQuery.of(context).size.width - 40,
              margin: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: const [
                    BoxShadow(
                        blurRadius: 9,
                        color: Colors.grey,
                        offset: Offset(.4, .4))
                  ]),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin:EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          children: const[
                            Icon(Icons.location_on,color: Colors.green,),
                             Text("Current Location",style: TextStyle(
                              color: Colors.black,fontWeight: FontWeight.bold
                            ),),
                          ],
                        )
                      ),
                      Container(
                        margin:EdgeInsets.symmetric(horizontal: 10),
                        child: Tooltip(
                          message: "Add to Favourite",
                          child: IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.favorite,
                                color: Colors.red,
                                size: 30,
                              )),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "${provider.currentWeather?.cityName}",
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 35,
                                color: Color(0xFFF42476d)),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text("${provider.currentWeather?.temperature}°C",
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 38)),
                          const SizedBox(
                            height: 5,
                          ),
                          Text("${provider.currentWeather?.description}",
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Colors.green)),
                        ],
                      )
                    ],
                  )
                ],
              ),
            )
          ],
      ),
    ),
        ));
  }
}
