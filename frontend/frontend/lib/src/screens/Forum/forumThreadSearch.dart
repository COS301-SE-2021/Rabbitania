import 'package:flutter/material.dart';
import 'package:frontend/src/models/Forum/forumModel.dart';
import 'package:frontend/src/models/utilModel.dart';
import 'package:frontend/src/screens/Forum/forumCommentScreen.dart';

class ForumThreadSearch extends StatefulWidget {
  final List<Widget> cards;
  const ForumThreadSearch(this.cards);

  @override
  _ForumThreadSearchState createState() => new _ForumThreadSearchState();
}

class _ForumThreadSearchState extends State<ForumThreadSearch> {
  Widget appBarTitle = new Text(
    "Search Example",
    style: new TextStyle(color: Colors.white),
  );
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
            preferredSize: Size.fromHeight(75.0), child: buildAppBar(context)),
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
                                searchresult[index].forumThreadTitle.toString();
                            return new InkWell(
                                onTap: () {
                                  currentThreadID =
                                      searchresult[index].forumThreadId;
                                  currentThreadName =
                                      searchresult[index].forumThreadTitle;
                                  currentThreadBody =
                                      searchresult[index].forumThreadBody;
                                  currentThreadImage =
                                      searchresult[index].imageURL;
                                  UtilModel.route(
                                      () => ForumCommentScreen(), context);
                                },
                                child: ListTile(
                                  title: new Text(
                                    listData.toString(),
                                    style: TextStyle(
                                        color: Color.fromRGBO(171, 255, 79, 1),
                                        fontSize: 25),
                                  ),
                                ));
                          },
                        )
                      : new ListView.builder(
                          shrinkWrap: true,
                          itemCount: _list.length,
                          itemBuilder: (BuildContext context, int index) {
                            String listData = _list[index].forumThreadTitle;
                            return new InkWell(
                                onTap: () {
                                  currentThreadID =
                                      searchresult[index].forumThreadId;
                                  currentThreadName =
                                      searchresult[index].forumThreadTitle;
                                  currentThreadBody =
                                      searchresult[index].forumThreadBody;
                                  currentThreadImage =
                                      searchresult[index].imageURL;
                                  UtilModel.route(
                                      () => ForumCommentScreen(), context);
                                },
                                child: ListTile(
                                  title: new Text(
                                    listData.toString(),
                                    style: TextStyle(
                                        color: Color.fromRGBO(171, 255, 79, 1),
                                        fontSize: 25),
                                  ),
                                ));
                          },
                        ))
            ],
          ),
        ));
  }

  Widget buildAppBar(BuildContext context) {
    return new AppBar(
      centerTitle: true,
      backgroundColor: new Color.fromRGBO(57, 57, 57, 1),
      title: TextField(
        controller: _controller,
        style: new TextStyle(
          color: Colors.white,
        ),
        decoration: new InputDecoration(
            prefixIcon: new Icon(Icons.search, color: Colors.black),
            hintText: "Search...",
            hintStyle: new TextStyle(color: Color.fromRGBO(171, 255, 79, 1))),
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
        ForumThreadCard data = _list[i];
        if (data.forumThreadTitle
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
