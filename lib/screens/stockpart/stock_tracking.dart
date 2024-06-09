import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:katot_elektronik/bloc/stocktrackingbloc/stocktracking_bloc.dart';
import 'package:katot_elektronik/bloc/stocktrackingbloc/stocktracking_event.dart';
import 'package:katot_elektronik/bloc/stocktrackingbloc/stocktracking_state.dart';
import 'package:katot_elektronik/screens/stockpart/category_add.dart';
import 'package:katot_elektronik/widgets/category_card.dart';

class StockTracking extends StatefulWidget {
  const StockTracking({Key? key}) : super(key: key);

  @override
  _StockTrackingState createState() => _StockTrackingState();
}

class _StockTrackingState extends State<StockTracking> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("STOK TAKİP"), actions: [
        IconButton(
          icon: Icon(Icons.search),
          onPressed: () {},
        ),
      ]),
      body: BlocBuilder<StocktrackingBloc, StocktrackingState>(
        builder: (context, state) {
          if (state is StocktrackingInitial) {
            context.read<StocktrackingBloc>().add(GetCategoriesEvent());
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is StocktrackingLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is StocktrackingLoaded) {
            return Container(
              child: Column(
                  children: state.category
                      .map((e) => CategoryCard(
                            title: e.title,
                            image: e.image!,
                            categoryId: e.categoryId,
                            quantity: e.quantity,
                          ))
                      .toList()),
            );
          } else if (state is StocktrackingError) {
            return const Center(child: Text("That's an error"));
          } else {
            return const Center(
              child: Text("Something went wrong"),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CategoryAdd(),
              ));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
