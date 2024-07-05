import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:katot_elektronik/bloc/notebloc/note_bloc.dart';
import 'package:katot_elektronik/bloc/notebloc/note_event.dart';
import 'package:katot_elektronik/bloc/notebloc/note_state.dart';
import 'package:katot_elektronik/screens/notepart/note_add.dart';
import 'package:katot_elektronik/widgets/note_card.dart';

class Notepage extends StatefulWidget {
  const Notepage({Key? key}) : super(key: key);

  @override
  _NotepageState createState() => _NotepageState();
}

class _NotepageState extends State<Notepage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFFF8F6E3),
                  Color(0xFFD0E8F2),
                ], // Gradient renklerini buraya ekleyin
                begin: Alignment.topLeft, // Gradientin başlama noktası
                end: Alignment.bottomRight, // Gradientin bitiş noktası
              ),
            ),
          ),
          BlocBuilder<NoteBloc, NoteState>(
            builder: (context, state) {
              if (state is NoteInitial) {
                context.read<NoteBloc>().add(GetNotes());
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is NoteLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is NoteLoaded) {
                return Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      Image.asset(
                        "assets/logo.png",
                        scale: 3.3,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      const Text(
                        "- Not Defteri Sayfası -",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.85,
                        height: MediaQuery.of(context).size.height * 0.05,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.6),
                              spreadRadius: 1,
                              blurRadius: 3,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            SizedBox(
                                width:
                                    MediaQuery.of(context).size.height * 0.02),
                            Icon(Icons.search, color: Colors.grey),
                            SizedBox(
                                width:
                                    MediaQuery.of(context).size.height * 0.002),
                            Expanded(
                              child: TextField(
                                decoration: const InputDecoration(
                                  hintText: "Ara",
                                  border: InputBorder.none,
                                ),
                                onChanged: (value) {},
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.004,
                      ),
                      Container(
                        child: Column(
                            children: state.notes
                                .map((e) => NoteCard(
                                    title: e.title, content: e.content))
                                .toList()),
                      ),
                    ],
                  ),
                );
              } else if (state is NoteError) {
                return const Center(child: Text("That's an error"));
              } else {
                return const Center(
                  child: Text("Something went wrong"),
                );
              }
            },
          ),
        ]),
        floatingActionButton: FloatingActionButton(
          backgroundColor: const Color(0xFF79A3B1),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const NoteAdd(),
              ),
            );
          },
          child: Icon(
            Icons.add_circle,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
