// ignore_for_file: camel_case_types, prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers

import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:recipe_app/model.dart';

class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  List<RecipeModel> recipeList = <RecipeModel>[];
  TextEditingController searchController = new TextEditingController();

  getRecipe(String query) async {
    String url =
        "https://api.edamam.com/search?q=$query&app_id=5dfab011&app_key=588b6eba4ea65c3c1db73a38c7ba6ca4";
    Response response = await get(Uri.parse(url));
    Map data = jsonDecode(response.body);

    log(data.toString());

    data["hits"].forEach((element) {
      RecipeModel recipeModel = new RecipeModel();
      recipeModel = RecipeModel.fromMap(element["recipe"]);
      recipeList.add(recipeModel);
    });
    recipeList.forEach((Recipe) {
      log(Recipe.applabel);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getRecipe("Jamun");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [
            Color.fromARGB(237, 80, 50, 33),
            Color.fromARGB(232, 133, 69, 0)
          ])),
        ),
        SingleChildScrollView(
          child: Column(
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
                            getRecipe(searchController.text);
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
              Container(
                padding: EdgeInsets.only(left: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("WHAT DO YOU WANT TO COOK TODAY?",
                        style: TextStyle(
                          fontSize: 35,
                          color: Colors.white38,
                        )),
                    Text("Let's cook something new!!!",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white24,
                        ))
                  ],
                ),
              ),
              Container(
                child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: recipeList.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {},
                        child: Card(
                          margin: EdgeInsets.all(10),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          elevation: 0.0,
                          child: Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: Image.network(
                                  recipeList[index].appimguUrl,
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                  height: 300,
                                ),
                              ),
                              Positioned(
                                  left: 0,
                                  right: 0,
                                  bottom: 0,
                                  child: Container(
                                      padding: EdgeInsets.all(10),
                                      decoration:
                                          BoxDecoration(color: Colors.black26),
                                      child: Text(
                                        recipeList[0].applabel,
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 20),
                                      ))),
                              Positioned(
                                  left: 0,
                                  right: 0,
                                  bottom: 0,
                                  child: Container(
                                      padding: EdgeInsets.all(10),
                                      decoration:
                                          BoxDecoration(color: Colors.black26),
                                      child: Text(
                                        recipeList[0].appcalories,
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 20),
                                      )))
                            ],
                          ),
                        ),
                      );
                    }),
              ),
            ],
          ),
        ),
      ],
    ));
  }
}
