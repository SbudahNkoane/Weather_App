import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/screens/widgets/widgets.dart';

import '../services/data_services.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({Key? key}) : super(key: key);

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  bool isVisible = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/blue.jpg'), fit: BoxFit.cover),
        ),
        width: double.infinity,
        padding: const EdgeInsets.all(18.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Divider(
              thickness: 5,
            ),
            const SizedBox(
              height: 10.0,
            ),
            const Text(
              'More Details',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 40.0,
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            SizedBox(
              height: 300,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Consumer<DataService>(
                    builder: (context, value, child) => Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          value.weartherData.sunrise!.hour < 10 &&
                                  value.weartherData.sunrise!.minute < 10
                              ? 'Sunrise          :  0${value.weartherData.sunrise!.hour}:0${value.weartherData.sunrise!.minute} '
                              : value.weartherData.sunrise!.hour < 10
                                  ? 'Sunrise          :  0${value.weartherData.sunrise!.hour}:${value.weartherData.sunrise!.minute} '
                                  : value.weartherData.sunrise!.minute < 10
                                      ? 'Sunrise          :  ${value.weartherData.sunrise!.hour}:0${value.weartherData.sunrise!.minute} '
                                      : 'Sunrise          :  ${value.weartherData.sunrise!.hour}:${value.weartherData.sunrise!.minute} ',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                          ),
                        ),
                        const Divider(),
                        const SizedBox(height: 18.0),
                        Text(
                          'Sunset           :  ${value.weartherData.sunset!.hour}:${value.weartherData.sunset!.minute} ',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                          ),
                        ),
                        const Divider(),
                        const SizedBox(height: 18.0),
                        Text(
                          'Wind speed  :  ${value.weartherData.windspeed!} km/h',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                          ),
                        ),
                        const Divider(),
                        const SizedBox(height: 18.0),
                        Text(
                          'Pressure       :  ${value.weartherData.pressure!.toInt().toString()} mbar',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            const Divider(
              thickness: 5,
            ),
            const SizedBox(
              height: 40.0,
            ),
            Center(
              child: ElevatedButton(
                style: const ButtonStyle(),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Back to Home Page'),
              ),
            ),
            refreshButton(),
            const SizedBox(
              height: 20,
            ),
            Consumer<DataService>(
              builder: (context, value, child) => Visibility(
                visible: value.isVisible,
                child: Text(
                  'Last Refreshed at ${value.currentTime.hour}:${value.currentTime.minute}',
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  // void _search() async {
  //   final value = await _dataservice.getWeather(cityNameController.text);
  //   if (kDebugMode) {
  //     print(value.sunrise);
  //   }
  //   setState(
  //     () => _response = value,
  //   );
  // }

  // void initial() async {
  //   final city = await _dataservice.getWeather('Bloemfontein');

  //   setState(() {
  //     _response = city;
  //   });
  // }
}
