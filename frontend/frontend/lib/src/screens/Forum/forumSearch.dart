import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:frontend/src/models/Forum/forumModel.dart';
import 'package:frontend/src/models/utilModel.dart';
import 'package:frontend/src/screens/Forum/forumThreadScreen.dart';

class ForumSearch extends StatefulWidget {
  final List<Widget> cards;
  const ForumSearch(this.cards);

  @override
  _ForumSearchState createState() => new _ForumSearchState();
}

class _ForumSearchState extends State<ForumSearch> {
  Icon icon = new Icon(
    Icons.search,
    color: Colors.white,
  );
  final globalKey = new GlobalKey<ScaffoldState>();
  final TextEditingController _controller = new TextEditingController();
  List<dynamic> _list = [];
  bool _isSearching = false;
  List<dynamic> searchresult = [];

  @override
  void initState() {
    super.initState();
    _isSearching = false;
    values();
  }

  void values() {
    _list = widget.cards;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: globalKey,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(55.0), child: buildAppBar(context)),
      body: new Container(
        color: Color.fromRGBO(33, 33, 33, 1),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            new Flexible(
              child: searchresult.length != 0 || _controller.text.isNotEmpty
                  ? new ListView.builder(
                      shrinkWrap: true,
                      itemCount: searchresult.length,
                      itemBuilder: (BuildContext context, int index) {
                        String listData =
                            searchresult[index].forumTitle.toString();
                        return new InkWell(
                          onTap: () {
                            currentForumID = searchresult[index].forumId;
                            currentForumName = searchresult[index].forumTitle;
                            UtilModel.route(() => ForumThreadScreen(), context);
                          },
                          child: ListTile(
                            title: new Text(
                              listData.toString(),
                              style: TextStyle(
                                  color: Color.fromRGBO(171, 255, 79, 1),
                                  fontSize: 25),
                            ),
                            contentPadding:
                                EdgeInsets.only(left: 20, right: 15),
                            shape: Border.all(
                                color: Color.fromRGBO(171, 255, 79, 1)),
                          ),
                        );
                      },
                    )
                  : new ListView.builder(
                      shrinkWrap: true,
                      itemCount: _list.length,
                      itemBuilder: (BuildContext context, int index) {
                        String listData = _list[index].forumTitle;
                        return new Column(children: [
                          InkWell(
                            onTap: () {
                              currentForumID = _list[index].forumId;
                              currentForumName = _list[index].forumTitle;
                              UtilModel.route(
                                  () => ForumThreadScreen(), context);
                            },
                            child: ListTile(
                              title: new Text(
                                listData.toString(),
                                style: TextStyle(
                                    color: Color.fromRGBO(171, 255, 79, 1),
                                    fontSize: 25),
                              ),
                              contentPadding:
                                  EdgeInsets.only(left: 20, right: 15),
                              shape: Border.all(
                                  color: Color.fromRGBO(171, 255, 79, 1),
                                  style: BorderStyle.solid,
                                  width: 2),
                            ),
                          ),
                          const Divider(
                              height: 10,
                              color: Color.fromRGBO(171, 255, 79, 1))
                        ]);
                      }),
            )
          ],
        ),
      ),
    );
  }

  Widget buildAppBar(BuildContext context) {
    return new AppBar(
      centerTitle: true,
      backgroundColor: new Color.fromRGBO(57, 57, 57, 1),
      title: TextField(
        cursorColor: Color.fromRGBO(171, 255, 79, 1),
        controller: _controller,
        style: new TextStyle(
          color: Color.fromRGBO(171, 255, 79, 1),
        ),
        decoration: new InputDecoration(
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Color.fromRGBO(171, 255, 79, 1),
            ),
          ),
          hintText: "Search...",
          hintStyle: new TextStyle(
            color: Color.fromRGBO(171, 255, 79, 1),
          ),
        ),
        onChanged: (String value) {
          _handleSearchStart();
          searchOperation(value);
        },
      ),
    );
  }

  void _handleSearchStart() {
    setState(() {
      _isSearching = true;
    });
  }

  void searchOperation(String searchText) {
    searchresult.clear();
    if (_isSearching != false) {
      for (int i = 0; i < _list.length; i++) {
        ForumCard data = _list[i];
        if (data.forumTitle
            .toString()
            .toLowerCase()
            .contains(searchText.toLowerCase())) {
          searchresult.add(data);
          setState(() {});
        }
      }
    }
  }
}
