import 'package:age_estimation_neon/repositories/estimation_repository.dart';
import 'package:age_estimation_neon/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'bloc/estimation_bloc.dart';

var kDarkColorScheme = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(255, 147, 229, 250),
  brightness: Brightness.dark,
  surface: const Color.fromARGB(255, 42, 51, 59),
);

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Altersschätzung',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        useMaterial3: true,
        colorScheme: kDarkColorScheme,
        scaffoldBackgroundColor: const Color.fromARGB(255, 50, 58, 60),
        textTheme: GoogleFonts.latoTextTheme().copyWith(
          bodyMedium: TextStyle(color: kDarkColorScheme.onBackground),
        ),
      ),
      home: RepositoryProvider(
        create: (context) => EstimationRepository(),
        child: const Home(),
      ),
    );
  }
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EstimationBloc(
        estimationRepository:
            RepositoryProvider.of<EstimationRepository>(context),
      ),
      child: Scaffold(
        body: BlocListener<EstimationBloc, EstimationState>(
          listener: (context, state) {
            if (state is EstimationFetched) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text('Nutzerdaten eingeholt'),
                duration: Duration(seconds: 1),
              ));
            }
          },
          child: BlocBuilder<EstimationBloc, EstimationState>(
            builder: (context, state) {
              if (state is EstimationFetching) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is EstimationError) {
                return const Center(
                  child: Text('Fehler beim Laden der Daten'),
                );
              } else if (state is EstimationFetched) {
                // user an den Homescreen übergeben, wenn der state loaded ist
                return HomeScreen(user: state.user);
              }
              return const HomeScreen();
            },
          ),
        ),
      ),
    );
  }
}
