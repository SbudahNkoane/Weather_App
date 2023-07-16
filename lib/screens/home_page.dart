import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/screens/widgets/widgets.dart';

import '../services/data_services.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void dispose() {
    cityNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.read<DataService>().getWeather('Bloemfontein');

    return Consumer<DataService>(
      builder: (context, value, child) => Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        body: Center(
          child: Container(
            constraints: const BoxConstraints.expand(),
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/blue.jpg"),
                  fit: BoxFit.cover),
            ),
            child: Consumer<DataService>(
              builder: (context, value, child) => Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                      width: 350.0,
                      height: 50.0,
                      child: Consumer<DataService>(
                        builder: (context, value, child) => searchbox(value),
                      )),
                  Visibility(visible: !value.isVisible, child: searchButton()),
                  value.noDataFound == true
                      ? Visibility(
                          visible: value.isVisible, child: refreshButton())
                      : const SizedBox(),
                  const SizedBox(
                    height: 20.0,
                  ),
                  value.noDataFound == true && value.error == true
                      ? Center(
                          child: Text(
                            value.errorMessage,
                            style: const TextStyle(
                              color: Colors.red,
                              fontSize: 15.0,
                            ),
                          ),
                        )
                      : cityNameController.text.isNotEmpty &&
                              value.noDataFound == true
                          ? Container(
                              constraints: const BoxConstraints.expand(),
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage("assets/images/blue.jpg"),
                                    fit: BoxFit.cover),
                              ),
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    CircularProgressIndicator(
                                      backgroundColor: Colors.white,
                                    ),
                                    Text('Please Wait',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15.0))
                                  ],
                                ),
                              ),
                            )
                          : cityNameController.text.isNotEmpty &&
                                  value.weartherData.cityName == null
                              ? Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      CircularProgressIndicator(
                                        backgroundColor: Colors.white,
                                      ),
                                      Text('Please Wait...',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15.0))
                                    ],
                                  ),
                                )
                              : Visibility(
                                  visible: value.isVisible,
                                  child: const WeatherInformation(),
                                ),
                  const SizedBox(
                    height: 20,
                  ),
                  Visibility(
                    visible: value.isVisible,
                    child: Text(
                      'Last Refreshed at ${value.currentTime.hour}:${value.currentTime.minute}',
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
