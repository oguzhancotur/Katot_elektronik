import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:katot_elektronik/bloc/jobtrackingblog/jobtracking_bloc.dart';
import 'package:katot_elektronik/bloc/stocktrackingbloc/stocktracking_bloc.dart';
import 'package:katot_elektronik/screens/bottomnavigationbar.dart';
import 'package:katot_elektronik/firebase_options.dart';
import 'package:katot_elektronik/repository/firebase_repo.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MultiBlocProvider(providers: [
    BlocProvider<JobtrackingBloc>(
      create: (context) => JobtrackingBloc(firestoreRepo: FirestoreRepo()),
    ),
    BlocProvider<StocktrackingBloc>(
      create: (context) => StocktrackingBloc(firestoreRepo: FirestoreRepo()),
    ),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MainScreen(),
    );
  }
}
