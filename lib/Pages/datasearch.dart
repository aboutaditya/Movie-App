import 'package:flutter/material.dart';
import 'home.dart';

class DataSearch extends StatefulWidget {
  final List<dynamic> data;

  DataSearch({required this.data});

  @override
  _DataSearchState createState() => _DataSearchState();
}

class _DataSearchState extends State<DataSearch> {
  late List<dynamic> filteredData;
  late TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    filteredData = widget.data;
    _searchController = TextEditingController();
  }

  void search(String query) {
    setState(() {
      filteredData = widget.data
          .where((item) =>
              item['show']['name'].toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.black,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black,
        title: TextField(
          controller: _searchController,
          onChanged: (value) {
            search(value);
          },
          decoration: InputDecoration(
            hintText: 'Search...',
            hintStyle: TextStyle(color: Colors.white),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
          ),
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.clear,
              color: Colors.white,
            ),
            onPressed: () {
              _searchController.clear();
              search('');
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: filteredData.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: GestureDetector(
              onTap: () {
                
              },
              child: MovieCard(
                image: filteredData[index]['show']['image']['original'],
                desc: filteredData[index]['show']['summary'],
                link: filteredData[index]['show']['_links']['self']['href'],
                title: filteredData[index]['show']['name'],
              ),
            ),
          );
        },
      ),
    );
  }
}
