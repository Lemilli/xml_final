import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:xml_final/components/my_bottom_navigation_bar.dart';
import 'package:xml_final/data/models/dog_walker.dart';
import 'package:xml_final/data/repository.dart';
import 'package:xml_final/data/socket_chat.dart';
import 'package:xml_final/screens/chat_room/screen.dart';
import 'package:xml_final/theme/color_theme.dart';
import 'package:xml_final/theme/custom_text_theme.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
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

    // final socket = SocketChat();
    // await socket.initSocket();
    // socket.sendMessage('Message');
    // if (_dogWalkers.isEmpty) {
    //   setState(() {
    //     isError = true;
    //   });
    // }
    // setState(() {
    //   isLoading = false;
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: MyBottomNavigationBar(),
      body: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                SizedBox(height: 40),
                Text(
                  'Chat',
                  style: CustomTextTheme.appBarHeading,
                ),
                SizedBox(height: 20),
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
                      onSuggestionSelected: (DogWalker suggestion) =>
                          Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) {
                            return ChatRoomScreen(receiver: suggestion.name);
                          },
                        ),
                      ),
                      itemBuilder: (BuildContext context, DogWalker itemData) {
                        return ListTile(
                          leading: CircleAvatar(
                            radius: 24,
                            foregroundImage: NetworkImage(
                              itemData.imageLink,
                            ),
                          ),
                          title: Text(
                            itemData.name,
                            style: TextStyle(fontFamily: 'Poppins'),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
