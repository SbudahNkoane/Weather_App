import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../routes/routes.dart';
import '../../services/data_services.dart';

class WeatherInformation extends StatelessWidget {
  const WeatherInformation({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      print('building info');
    }
    return Consumer<DataService>(
      builder: (context, value, child) =>
          value.error == false && value.weartherData.cityName == null
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      CircularProgressIndicator(
                        backgroundColor: Colors.white,
                      ),
                      Text('Please Wait',
                          style: TextStyle(color: Colors.black, fontSize: 15.0))
                    ],
                  ),
                )
              : Column(
                  children: [
                    Text(
                      '${value.weartherData.cityName}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 30.0,
                      ),
                    ),
                    const SizedBox(
                      height: 5.0,
                    ),
                    Image.network(
                      value.weartherData.iconUrl!,
                    ),
                    Text(
                      '${value.weartherData.temperature!.toInt().toString()}°C',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 40.0,
                      ),
                    ),
                    const SizedBox(
                      height: 5.0,
                    ),
                    Text(
                      '${value.weartherData.weatherDescription}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 30.0,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    const Divider(),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 350,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text(
                                    'Feels Like',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18.0,
                                    ),
                                  ),
                                  Divider(),
                                  SizedBox(height: 18.0),
                                  Text(
                                    'Humidity',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18.0,
                                    ),
                                  )
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${value.weartherData.feelsLike!.toInt().toString()}°C',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18.0,
                                    ),
                                  ),
                                  const Divider(),
                                  const SizedBox(height: 18.0),
                                  Text(
                                    '${value.weartherData.humidity!.toInt().toString()} %',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18.0,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        const Divider(),
                        const SizedBox(
                          height: 30.0,
                        ),
                      ],
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed(
                          RouteManager.detailsPage,
                        );
                      },
                      child: const Text('More Details'),
                    ),
                    refreshButton(),
                  ], //add here
                ),
    );
  }
}

final cityNameController = TextEditingController();
TextField searchbox(DataService value) {
  return TextField(
    //textfield

    controller: cityNameController,

    onSubmitted: (data) {
      if (data.isNotEmpty) {
        value.weartherData.cityName = null;
        value.getWeather(cityNameController.text);

        if (value.error == false) {
          value.visibility = true;
        }
      } else if (data.isEmpty) {
        const Text('Type in a City');
      }
    },
    onTap: () {
      if (value.isVisible == true) {
        value.visibility = false;
      }
    },
    textCapitalization: TextCapitalization.sentences,
    textInputAction: TextInputAction.search,
    keyboardType: TextInputType.text,
    style: const TextStyle(
        color: Colors.black,
        fontSize: 25.0,
        fontWeight: FontWeight.w600,
        letterSpacing: 3.0),
    decoration: InputDecoration(
      fillColor: Colors.white70,
      filled: true,
      border: const OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.white,
        ),
        borderRadius: BorderRadius.all(Radius.circular(30.0)),
      ),
      hintText: 'Search for a City',
      hintStyle: const TextStyle(
        color: Colors.black87,
        fontSize: 18.0,
      ),
      prefixIcon: IconButton(
        icon: const Icon(Icons.search, color: Colors.black),
        onPressed: () {},
      ),
    ),
  );
}

searchButton() {
  return Consumer<DataService>(
    builder: (context, value, child) => ElevatedButton(
      onPressed: () {
        if (cityNameController.text.isNotEmpty) {
          value.weartherData.cityName = null;
          value.getWeather(cityNameController.text);

          if (value.error == false) {
            value.visibility = true;
          }
        } else if (cityNameController.text.isEmpty) {
          const Text('Type A City');
        }
      },
      child: const Text('Search'),
    ),
  );
}

refreshButton() {
  return Consumer<DataService>(
    builder: (context, value, child) => ElevatedButton(
      onPressed: () {
        if (value.weartherData.cityName != null) {
          value.getWeather(value.weartherData.cityName);
        } else if (value.noDataFound == true) {
          value.getWeather('Bloemfontein');
        }
      },
      child: const Text('Refresh'),
    ),
  );
}
