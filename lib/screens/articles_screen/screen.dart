import 'package:flutter/material.dart';
import 'package:flutter_typeahead/cupertino_flutter_typeahead.dart';
import 'package:xml_final/components/my_bottom_navigation_bar.dart';
import 'package:xml_final/data/models/article.dart';
import 'package:xml_final/data/repository.dart';
import 'package:xml_final/screens/article_details_screen/screen.dart';
import 'package:xml_final/screens/home_screen/screen.dart';
import 'package:xml_final/theme/color_theme.dart';
import 'package:xml_final/theme/custom_text_theme.dart';

class ArticlesScreen extends StatefulWidget {
  @override
  _ArticlesScreenState createState() => _ArticlesScreenState();
}

class _ArticlesScreenState extends State<ArticlesScreen> {
  late final Repository _repository;
  late final List<Article> _articles;
  bool isLoading = true;
  bool isError = false;

  @override
  void initState() {
    super.initState();
    _getData();
  }

  void _getData() async {
    _repository = Repository();
    _articles = await _repository.getArticles();
    if (_articles.isEmpty) {
      setState(() {
        isError = true;
      });
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalette.white,
      bottomNavigationBar: MyBottomNavigationBar(),
      body: SafeArea(
        child: isLoading
            ? Center(child: CircularProgressIndicator())
            : Padding(
                padding: EdgeInsets.fromLTRB(16, 40, 16, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Articles',
                      style: CustomTextTheme.appBarHeading,
                    ),
                    Text(
                      'Fresh news and information for you',
                      style: CustomTextTheme.appBarSubheading,
                    ),
                    SizedBox(height: 22),
                    Expanded(
                      child: ListView.builder(
                        itemCount: _articles.length,
                        itemBuilder: (_, index) => GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => ArticleDetailsScreen(
                                  article: _articles[index],
                                ),
                              ),
                            );
                          },
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: ColorPalette.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 3,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),
                            margin: EdgeInsets.only(bottom: 22),
                            clipBehavior: Clip.antiAlias,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.network(
                                  _articles[index].imageLink,
                                  width: double.infinity,
                                  height: 160,
                                  fit: BoxFit.cover,
                                ),
                                SizedBox(height: 10),
                                Padding(
                                  padding: EdgeInsets.only(left: 10),
                                  child: Text(
                                    _articles[index].heading,
                                    style: CustomTextTheme.black_bold_17,
                                  ),
                                ),
                                SizedBox(height: 2),
                                Padding(
                                  padding: EdgeInsets.only(left: 10),
                                  child: Text(
                                    'Time to read: ' +
                                        _articles[index].timeToRead.toString() +
                                        ' minutes',
                                    style: CustomTextTheme.profile_details_grey,
                                  ),
                                ),
                                SizedBox(height: 10),
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
      ),
    );
  }
}
