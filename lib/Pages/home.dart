import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:quadbtech/Pages/infopage.dart';
import 'package:quadbtech/Pages/search.dart';

import 'models/api_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<dynamic> data;
  late List<dynamic> filteredData = [];
  @override
  void initState() {
    super.initState();
    APIController.getMovie().then((result) {
      setState(() {
        data = result;
        filteredData = data;
      });
    });
  }

  void search(String query) {
    setState(() {
      filteredData = data
          .where((item) =>
              item['show']['name'].toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    var _currentIndex=0;
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white,
        backgroundColor: Colors.black,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
          if (_currentIndex == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SearchPage(data: data),
              ),
            );
          }
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home,color: Colors.white,),
            label: 'Home',
            backgroundColor: Colors.white
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search,color: Colors.white,),
            label: 'Search',
            
          ),
        ],
      ),
      backgroundColor: Colors.black87,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black87,
        title: Text(
          'Movie App',
          style: TextStyle(color: Colors.redAccent, fontSize: 24),
        ),
      ),
      body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
              physics: AlwaysScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              itemCount: filteredData.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return MovieCard(
                  image: filteredData[index]['show']['image']['original'],
                  desc: filteredData[index]['show']['summary'],
                  link: filteredData[index]['show']['_links']['self']['href'],
                  title: filteredData[index]['show']['name'],
                );
              }))
    );
  }
}

class MovieCard extends StatelessWidget {
  MovieCard(
      {super.key,
      required this.desc,
      required this.image,
      required this.link,
      required this.title});
  String image, title, link, desc;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 20),
      child: GestureDetector(
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => MoviePage(link: link)));
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              height: MediaQuery.of(context).size.height / 4.5,
              width: MediaQuery.of(context).size.width / 2.8,
              child: Image.network(
                image,
                fit: BoxFit.fill,
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width / 2,
              height: MediaQuery.of(context).size.height / 4.5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.montserrat(
                        fontSize: 24, color: Colors.redAccent),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    desc,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 5,
                    style: GoogleFonts.montserrat(color: Colors.white),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
