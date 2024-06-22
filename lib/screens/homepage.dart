import 'package:flutter/material.dart';
import 'package:katot_elektronik/screens/jobpart/job_tracking.dart';
import 'package:katot_elektronik/screens/profile.dart';
import 'package:katot_elektronik/screens/stockpart/stock_tracking.dart';
import 'package:katot_elektronik/widgets/custom_card.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20),
              Image.asset(
                "assets/logo.png", // Logo
                scale: 3.3,
              ),
              Text("Katot Elektronik Anasayfasına Hoşgeldiniz"),
              SizedBox(height: 20),
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 20,
                  padding: EdgeInsets.all(20),
                  children: [
                    CustomCard(
                      title: "İş Takip",
                      imagePath: "assets/card1.png",
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => JobTracking(),
                            ));
                      },
                    ),
                    CustomCard(
                      title: "Stok Takip",
                      imagePath: "assets/card2.png",
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => StockTracking(),
                            ));
                      },
                    ),
                    CustomCard(
                      title: "Not Defteri",
                      imagePath: "assets/card3.png",
                      onTap: () {
                        // Not Defteri sayfasına yönlendirme
                      },
                    ),
                    CustomCard(
                      title: "Profil",
                      imagePath: "assets/card3.png",
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Profile(),
                            ));
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
