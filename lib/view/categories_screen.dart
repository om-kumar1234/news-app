import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/models/categories_news_model.dart';
import 'package:news_app/view_model/news_view_model.dart';
import 'package:intl/intl.dart';

class CategoriesScrren extends StatefulWidget {
  const CategoriesScrren({super.key});

  @override
  State<CategoriesScrren> createState() => _CategoriesScrrenState();
}

class _CategoriesScrrenState extends State<CategoriesScrren> {

  NewsViewModel newsViewModel = NewsViewModel();


  final format = DateFormat('MMMM dd, yyyy');

  String categoryName = 'general' ;

  final List<String> localImages = [
    'images/66059.jpg',
    'images/10334062.jpg',
    'images/man-looking-stock-market-news-computer.jpg',
    'images/random_image.jpg',
  ];

  final Random random = Random();

  List<String> categoriesList = [
    'General',
    'Entertainment',
    'Health',
    'Sports',
    'Business',
    'Technology',
  ];

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width * 1;
    final height = MediaQuery.sizeOf(context).height * 1;

    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(
              height: 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categoriesList.length,
                  itemBuilder: (context, index){
                  return InkWell(
                    onTap: (){
                      categoryName = categoriesList[index];
                      setState(() {
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 12),
                      child: Container(
                        decoration: BoxDecoration(
                          color: categoryName == categoriesList[index] ? Colors.blue : Colors.grey,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Center(child: Text(categoriesList[index].toString(), style: GoogleFonts.poppins(
                            fontSize: 13,
                            color: Colors.white
                          ),)),
                        ),
                      ),
                    ),
                  );
                  }),
            ),
            SizedBox(height: 20,),
            Expanded(
              child: FutureBuilder<CategoriesNewsModel>(
                future: newsViewModel.fetchCategoriesNewsApi(categoryName),
                builder: (BuildContext context, snapshot) {
                  if(snapshot.connectionState == ConnectionState.waiting){
                    return const Center(
                      child: SpinKitCircle(
                        size: 50,
                        color: Colors.blue,
                      ),
                    );
                  }else{
                    return ListView.builder(
                        itemCount: snapshot.data!.articles!.length,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index){
              
                          DateTime datetime = DateTime.parse(snapshot.data!.articles![index].publishedAt.toString());
                          String randomImage = localImages[random.nextInt(localImages.length)];

                          return Padding(
                            padding: const EdgeInsets.only(bottom: 15),
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: Image.asset(
                                    randomImage,
                                    fit: BoxFit.cover,
                                    height: height * .18,
                                    width: width * .3,
                                  ),
                                ),
                                SizedBox(width: 10),
                                Expanded(
                                    child: Container(
                                      height: height * .18,
                                      padding : EdgeInsets.only(left: 15),
                                      child: Column(
                                        children: [
                                          Text(snapshot.data!.articles![index].title.toString(),
                                          maxLines: 3,
                                          style: GoogleFonts.poppins(
                                            fontSize: 15,
                                            color: Colors.black54,
                                            fontWeight: FontWeight.w700,
                                          ),
                                          ),
                                          Spacer(),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(snapshot.data!.articles![index].source!.name.toString(),
                                                maxLines: 3,
                                                style: GoogleFonts.poppins(
                                                  fontSize: 15,
                                                  color: Colors.black54,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                              Text(format.format(datetime),
                                                style: GoogleFonts.poppins(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                ),
                              ],
                            ),
                          );
                        }
                    );
                  }
                },
              ),
            ),
          ],
            ),
      ),
    );
  }
}
