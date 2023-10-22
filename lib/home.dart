// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';

class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  TextEditingController searchController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  colors: [Color(0xff213A50), Color(0xff071938)])),
        ),
        Column(
          children: [
            SafeArea(
              child: Container(
                // Container for search
                padding: EdgeInsets.symmetric(horizontal: 10),
                margin: EdgeInsets.symmetric(horizontal: 14, vertical: 30),

                decoration: BoxDecoration(
                    color: Colors.white10,
                    borderRadius: BorderRadius.circular(25)),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        if (searchController.text.replaceAll(" ", "") == "") {
                          //pass
                        } else {
                          Navigator.pushReplacementNamed(context, "/loading",
                              arguments: {
                                "searchText":
                                    searchController.text.replaceAll(" ", ""),
                              });
                        }
                      },
                      child: Container(
                        margin: EdgeInsets.fromLTRB(5, 0, 10, 0),
                        child: Icon(Icons.search),
                      ),
                    ),
                    Expanded(
                        child: TextField(
                      controller: searchController,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Let's cook something..."),
                    ))
                  ],
                ),
              ),
            ),
          ],
        )
      ],
    ));
  }
}
