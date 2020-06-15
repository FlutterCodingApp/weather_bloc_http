import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_bloc_http/blocs/settings_bloc.dart';
import 'package:weather_bloc_http/blocs/simple_bloc_delegate.dart';
import 'package:weather_bloc_http/repositories/repositories.dart';
import 'package:http/http.dart' as http;
import 'package:weather_bloc_http/blocs/blocs.dart';
import 'package:weather_bloc_http/widgets/widgets.dart';

void main() {
  final WeatherRepository weatherRepository = WeatherRepository(
      weatherApiClient: WeatherApiClient(
          httpClient: http.Client()
      ),
  );

  BlocSupervisor.delegate = SimpleBlocDelegate();
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider<ThemeBloc>(
        create: (contex) => ThemeBloc(),
      ),
      BlocProvider<SettingsBloc>(
        create: (contex) => SettingsBloc(),
      )
    ],
    child: App(weatherRepository: weatherRepository),
  ));
}

class App extends StatelessWidget {
  final WeatherRepository weatherRepository;

  App({Key key, @required this.weatherRepository})
      : assert(weatherRepository != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, themeState) {
          return MaterialApp(
            title: 'Flutter Weather',
            home: BlocProvider(
              create: (context) =>
                  WeatherBloc(weatherRepository: weatherRepository),
              child: Weather(),
            ),
          );
        },
    );
  }
}
