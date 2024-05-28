import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'category_screen.dart';

class DetailsScreen extends StatefulWidget {
  final String newsImage, newsTitle, newsDate, author, description, content, source;
  const DetailsScreen({super.key,
    required this.source,
    required this.description,
    required this.author,
    required this.content,
    required this.newsDate,
    required this.newsImage,
    required this.newsTitle,
  });

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height * 1;
    final width = MediaQuery.sizeOf(context).width * 1;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
      ),
      body: ListView(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 12.0),
                child: Container(
                  color: Colors.green,
                  width: width * 0.72,
                  child: Text(widget.newsTitle,style: GoogleFonts.poppins(
                        fontSize: 17,
                        fontWeight: FontWeight.w700),
                  ),
                ),
              ),
              Container(
                height: height * 0.25,
                width: width * 0.99,
                padding: EdgeInsets.symmetric(
                    horizontal: height * 0.01),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: CachedNetworkImage(
                    imageUrl: widget.newsImage,
                    fit: BoxFit.fitWidth,
                    placeholder: (context, url) => Container(
                      child: spinkit2,
                    ),
                    errorWidget: (context, url, error) => Icon(
                      Icons.error_outline,
                      color: Colors.red,
                    ),
                  ),
                ),
              ),

            ],
          ),
        ],
      )
    );
  }
}
