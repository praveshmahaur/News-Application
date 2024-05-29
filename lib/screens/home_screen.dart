import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:top_news/screens/category_screen.dart';
import 'package:top_news/screens/details_screen.dart';
import 'package:top_news/view_model/news_view_model.dart';
import '../models/categories_news_model.dart';
import '../models/news_channal_headlines_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

enum FilterList { thehindu, bbcNews, bbcsport, hackerNews }

class _HomeScreenState extends State<HomeScreen> {
  FilterList? selectedMenu;
  final format = DateFormat('MMMM d, yyyy');
  String name = 'the-hindu';
  NewsViewModel newsViewModel = NewsViewModel();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height * 1;
    final width = MediaQuery.sizeOf(context).width * 1;
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
                decoration: const BoxDecoration(color: Colors.red),
                child: Text(
                  "NewsHeadline",
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                )),
            InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const CategoryScreen()));
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Category Wise News",
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const FaIcon(
                          FontAwesomeIcons
                              .arrowRight, // Choose the icon you want
                          size: 20, // Adjust the size as needed
                          color: Colors.red, // Choose the color you want
                        ),
                      ],
                    ),
                  ),
                ))
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.red,
        centerTitle: true,
        title: Text(
          "NewsHeadline",
          style: GoogleFonts.poppins(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
        actions: [
          PopupMenuButton<FilterList>(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10.0),
                ),
              ),
              initialValue: selectedMenu,
              icon: const Icon(
                Icons.more_vert,
                color: Colors.black,
              ),
              onSelected: (FilterList item) {
                if (FilterList.bbcNews == item) {
                  name = 'bbc-news';
                }
                if (FilterList.hackerNews == item) {
                  name = 'hacker-news';
                }
                if (FilterList.bbcsport == item) {
                  name = 'bbc-sport';
                }
                if (FilterList.thehindu == item) {
                  name = 'the-hindu';
                }

                newsViewModel.fetchNewsChannalHeadlinesApi(name);
                setState(() {
                  selectedMenu = item;
                });
              },
              itemBuilder: (context) => <PopupMenuEntry<FilterList>>[
                    const PopupMenuItem<FilterList>(
                      value: FilterList.bbcNews,
                      child: Text("BBC News"),
                    ),
                    const PopupMenuItem<FilterList>(
                      value: FilterList.hackerNews,
                      child: Text("Hacker News"),
                    ),
                    const PopupMenuItem<FilterList>(
                      value: FilterList.bbcsport,
                      child: Text("BBC sport"),
                    ),
                    const PopupMenuItem<FilterList>(
                      value: FilterList.thehindu,
                      child: Text("The Hindu"),
                    ),
                  ]),
        ],
      ),
      body: ListView(
        children: [
          Container(
            height: height * .3,
            width: width,
            decoration: const BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.only(
                  bottomLeft:
                      Radius.circular(15), // Circular bottom-left corner
                  bottomRight:
                      Radius.circular(15), // Circular bottom-right corner
                )),
            child: FutureBuilder<NewsChannalHeadlinesModel>(
              future: newsViewModel.fetchNewsChannalHeadlinesApi(name),
              builder: (BuildContext context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: SpinKitCircle(
                      size: 40,
                      color: Colors.blue,
                    ),
                  );
                } else {
                  return ListView.builder(
                      itemCount: snapshot.data!.articles!.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        // DateTime dateTime = DateTime.parse(snapshot
                        //     .data!.articles![index].publishedAt
                        //     .toString());
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DetailsScreen(
                                        source: snapshot
                                            .data!.articles![index].source!.name
                                            .toString(),
                                        description: snapshot
                                            .data!.articles![index].description
                                            .toString(),
                                        author: snapshot.data!.articles![index].author
                                            .toString(),
                                        content: snapshot.data!.articles![index].content
                                            .toString(),
                                        newsDate: snapshot
                                            .data!.articles![index].publishedAt
                                            .toString(),
                                        newsImage: snapshot
                                            .data!.articles![index].urlToImage
                                            .toString(),
                                        newsTitle: snapshot.data!.articles![index].title.toString())));
                          },
                          child: SizedBox(
                            // UP part-> ->
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  alignment: Alignment.bottomCenter,
                                  padding: const EdgeInsets.only(left: 15, bottom: 5),
                                  height: height * 0.07,
                                  child: Container(
                                    width: width * 0.72,
                                    child: Text(
                                      snapshot.data!.articles![index].title
                                          .toString(),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.poppins(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ),
                                ),
                                Container(
                                  height: height * 0.22,
                                  width: width * 0.95,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: height * 0.01),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: CachedNetworkImage(
                                      imageUrl: snapshot
                                          .data!.articles![index].urlToImage
                                          .toString(),
                                      fit: BoxFit.cover,
                                      placeholder: (context, url) => const SpinKitFadingCircle(
                                        color: Colors.amber,
                                        size: 50,
                                      ),
                                      errorWidget: (context, url, error) =>
                                          Image.asset(
                                              "images/breakingNews.jpg"),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      });
                }
              },
            ),
          ),
          //Down part-> ->
          Container(
            height: height * 0.67,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: FutureBuilder<CategoriesNewsModel>(
                future: newsViewModel.fetchCategoriesNewsApi('general'),
                builder: (BuildContext context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: SpinKitCircle(
                        size: 40,
                        color: Colors.blue,
                      ),
                    );
                  } else {
                    return ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: snapshot.data!.articles!.length,
                        itemBuilder: (context, index) {
                          DateTime dateTime = DateTime.parse(snapshot
                              .data!.articles![index].publishedAt
                              .toString());
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 15.0),
                            child: GestureDetector(
                              onTap:() {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => DetailsScreen(
                                            source: snapshot
                                                .data!.articles![index].source!.name
                                                .toString(),
                                            description: snapshot
                                                .data!.articles![index].description
                                                .toString(),
                                            author: snapshot.data!.articles![index].author
                                                .toString(),
                                            content: snapshot.data!.articles![index].content
                                                .toString(),
                                            newsDate: snapshot
                                                .data!.articles![index].publishedAt
                                                .toString(),
                                            newsImage: snapshot
                                                .data!.articles![index].urlToImage
                                                .toString(),
                                            newsTitle: snapshot.data!.articles![index].title.toString())));
                              },
                              child: Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: CachedNetworkImage(
                                      imageUrl: snapshot
                                          .data!.articles![index].urlToImage
                                          .toString(),
                                      fit: BoxFit.cover,
                                      height: height * 0.19,
                                      width: width * 0.3,
                                      placeholder: (context, url) => const SpinKitFadingCircle(
                                        color: Colors.amber,
                                        size: 50,
                                      ),
                                      errorWidget: (context, url, error) =>
                                          Image.asset(
                                              "images/breakingNewsDown.jpg"),
                                    ),
                                  ),
                                  Expanded(
                                      child: Container(
                                    height: height * 0.18,
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          snapshot.data!.articles![index].title
                                              .toString(),
                                          maxLines: 3,
                                          style: GoogleFonts.poppins(
                                              fontSize: 15,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w700),
                                        ),
                                        Text(
                                          snapshot
                                              .data!.articles![index].source!.name
                                              .toString(),
                                          style: GoogleFonts.poppins(
                                              fontSize: 13,
                                              color: Colors.black54,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        const Spacer(),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Text(
                                              format.format(dateTime),
                                              style: GoogleFonts.poppins(
                                                  fontSize: 15,
                                                  color: Colors.black38,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  )),
                                ],
                              ),
                            ),
                          );
                        });
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
