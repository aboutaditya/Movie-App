import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'models/api_controller.dart';

class MoviePage extends StatelessWidget {
  MoviePage({super.key, required this.link});
  String link;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
        ),
        body: FutureBuilder(
            future: APIController.getInfo(link),
            builder: (
              context,
              AsyncSnapshot snapshot,
            ) {
              if (!snapshot.hasData) {
                return Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasData) {
                //   return Container(
                //   height: MediaQuery.of(context).size.height,
                //   width: double.infinity,
                //   decoration: BoxDecoration(
                //       image: DecorationImage(
                //           image: NetworkImage(
                //               snapshot.data['image']['original']),
                //           fit: BoxFit.fill)),
                //   child: Column(),
                // );
                return Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: SingleChildScrollView(
                      child: Column(
                        // crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.height / 2.5,
                            width: MediaQuery.of(context).size.width / 1.5,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                image: DecorationImage(
                                    image: NetworkImage(
                                        snapshot.data['image']['original']),
                                    fit: BoxFit.fill)),
                          ),
                          SizedBox(
                            height: 50,
                          ),
                          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                snapshot.data['name'],
                                style: GoogleFonts.montserrat(
                                    color: Colors.redAccent,
                                    fontSize: 35,
                                    fontWeight: FontWeight.w800),
                              ),
                              Row(
                                children: [
                                  Text(
                                    (snapshot.data['rating']['average']).toString(),
                                    style: GoogleFonts.montserrat(
                                        color: Colors.white,
                                        fontSize: 26,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Icon(Icons.star,color: Colors.white,)
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height/20,
                            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ListView.builder(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemCount: snapshot.data['genres'].length,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding:  EdgeInsets.only(right: MediaQuery.of(context).size.width/10),
                                        child: Text(
                                          snapshot.data['genres'][index],
                                          style: GoogleFonts.montserrat(
                                              color: Colors.white,
                                              fontSize: 21,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      );
                                    }),
                                    Container(
                                      height: MediaQuery.of(context).size.height/20,
                                      child: Text(snapshot.data['premiered'],
                                      style: GoogleFonts.montserrat(
                                                color: Colors.white,
                                                fontSize: 21,
                                                fontWeight: FontWeight.w600),
                                      ),
                                    )
                              ],
                            ),
                          ),
                          // SizedBox(
                          //   height: 20,
                          // ),
                          Text(
                            snapshot.data['summary'],
                            style: GoogleFonts.montserrat(
                                color: Colors.white,
                                fontSize: 26,
                                fontWeight: FontWeight.w200),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }
              return Container();
            }));
  }
}
