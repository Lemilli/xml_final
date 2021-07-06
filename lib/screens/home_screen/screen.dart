import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:xml_final/components/my_bottom_navigation_bar.dart';
import 'package:xml_final/data/models/dog_walker.dart';
import 'package:xml_final/data/repository.dart';
import 'package:xml_final/screens/dog_walker_profile_screen/screen.dart';
import 'package:xml_final/screens/home_screen/widgets/dog_walkers_row.dart';
import 'package:xml_final/theme/color_theme.dart';
import 'package:xml_final/theme/custom_text_theme.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final Repository _repository;
  late final List<DogWalker> _dogWalkers;
  bool isLoading = true;
  bool isError = false;

  @override
  void initState() {
    super.initState();
    _getData();
  }

  void _getData() async {
    _repository = Repository();
    _dogWalkers = await _repository.getDogWalkers();
    if (_dogWalkers.isEmpty) {
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
      bottomNavigationBar: MyBottomNavigationBar(),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.fromLTRB(16, 40, 0, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Home", style: CustomTextTheme.appBarHeading),
                    Text(
                      "Explore dog walkers",
                      style: CustomTextTheme.appBarSubheading,
                    ),
                    SizedBox(height: 14),
                    Theme(
                      data: ThemeData(
                        colorScheme: ThemeData().colorScheme.copyWith(
                            primary: ColorPalette.orange.withOpacity(0.8)),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(right: 16),
                        child: TypeAheadField(
                          suggestionsCallback: (query) {
                            final matchingNames =
                                List<DogWalker>.empty(growable: true);
                            _dogWalkers.forEach((element) {
                              if (element.name
                                  .toLowerCase()
                                  .contains(query.toLowerCase())) {
                                matchingNames.add(element);
                              }
                            });
                            return matchingNames;
                          },
                          textFieldConfiguration: TextFieldConfiguration(
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: ColorPalette.textFieldBg,
                              prefixIcon: Icon(Icons.person),
                              hintText: 'Search by name',
                              hintStyle: CustomTextTheme.textFieldHint,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                          onSuggestionSelected: (DogWalker suggestion) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => DogWalkerProfileScreen(
                                    dogWalker: suggestion),
                              ),
                            );
                          },
                          itemBuilder:
                              (BuildContext context, DogWalker itemData) {
                            return ListTile(
                              leading: CircleAvatar(
                                foregroundImage:
                                    NetworkImage(itemData.imageLink),
                              ),
                              title: Text(
                                itemData.name,
                                style: TextStyle(fontFamily: 'Poppins'),
                              ),
                              subtitle: Text(
                                'Rating: ' + itemData.rating.toString(),
                                style: TextStyle(fontFamily: 'Poppins'),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      "Top Walkers",
                      style: CustomTextTheme.appBarHeading,
                    ),
                    SizedBox(height: 10),
                    isError
                        ? Center(
                            child: Text(
                            "Error connecting to server. Try later.",
                            style: CustomTextTheme.appBarSubheading,
                          ))
                        : DogWalkersRow(
                            isSuggested: false, dogWalkers: _dogWalkers),
                    SizedBox(height: 10),
                    Divider(
                      color: Colors.grey.withOpacity(0.5),
                      endIndent: 16,
                      height: 1.5,
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Suggested",
                      style: CustomTextTheme.appBarHeading,
                    ),
                    SizedBox(height: 10),
                    DogWalkersRow(
                      isSuggested: true,
                      dogWalkers: _dogWalkers,
                    ),
                    SizedBox(height: 15),
                  ],
                ),
              ),
            ),
    );
  }
}
