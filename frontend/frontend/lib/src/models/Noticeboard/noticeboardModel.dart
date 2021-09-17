import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/src/helper/Noticeboard/noticeboardHelper.dart';
import 'package:frontend/src/models/utilModel.dart';
import 'package:frontend/src/provider/noticeboard_provider.dart';
import 'package:frontend/src/screens/Noticeboard/noticeSingleScreen.dart';
import 'package:frontend/src/screens/Noticeboard/noticeboardEditThread.dart';

//model to model a notice board thread object
class NoticeBoardThreads {
  final List<dynamic> threadList;

  NoticeBoardThreads({
    required this.threadList,
  });

  factory NoticeBoardThreads.fromJson(Map<String, dynamic> json) {
    return NoticeBoardThreads(
      threadList: json["noticeBoard"],
    );
  }
}

//model to model a Thread object
class Thread {
  final int threadId;
  final String threadTitle;
  final String threadContent;
  final int minEmployeeLevel;
  final String imageUrl;
  final int permittedUserRoles;
  final int userId;
  final int icon1;
  final int icon2;
  final int icon3;
  final int icon4;

  Thread(
      {required this.threadId,
      required this.threadTitle,
      required this.threadContent,
      required this.minEmployeeLevel,
      required this.imageUrl,
      required this.permittedUserRoles,
      required this.userId,
      required this.icon1,
      required this.icon2,
      required this.icon3,
      required this.icon4});

  factory Thread.fromJson(Map<String, dynamic> json) {
    return Thread(
      threadId: json['threadId'],
      threadTitle: json['threadTitle'],
      threadContent: json['threadContent'],
      minEmployeeLevel: json['minEmployeeLevel'],
      imageUrl: json['imageUrl'],
      permittedUserRoles: json['permittedUserRoles'],
      userId: json['userId'],
      icon1: json['icon1'],
      icon2: json['icon2'],
      icon3: json['icon3'],
      icon4: json['icon4'],
    );
  }
}

class NoticeboardHomeCard extends StatelessWidget {
  final int id;
  final String theThreadTitle;
  final String theThreadContent;
  final String theImageURL;

  const NoticeboardHomeCard({
    required this.id,
    required this.theThreadTitle,
    required this.theThreadContent,
    required this.theImageURL,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 8, top: 8),
      child: InkWell(
        onTap: () {
          noticeID = this.id;
          UtilModel.route(() => Notice(), context);
        },
        child: Card(
          color: Color.fromRGBO(57, 57, 57, 25),
          shadowColor: Colors.black,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
          clipBehavior: Clip.antiAlias,
          elevation: 2,
          child: Column(
            children: [
              ListTile(
                contentPadding:
                    EdgeInsets.only(bottom: 10.0, top: 10, left: 20, right: 10),
                title: Container(
                  padding: EdgeInsets.only(bottom: 8),
                  child: Text(
                    theThreadTitle,
                    style: TextStyle(
                        letterSpacing: 2.0, color: Colors.white, fontSize: 22),
                  ),
                ),
                subtitle: Text(
                  theThreadContent,
                  style: TextStyle(color: Colors.white),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Container(
                constraints: const BoxConstraints(
                    minWidth: 500,
                    maxWidth: double.infinity,
                    minHeight: 0.0,
                    maxHeight: 300),
                padding: EdgeInsets.only(top: 5),
                child: Image.memory(Base64Decoder().convert(theImageURL),
                    fit: BoxFit.cover, width: 10000),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SingleNoticeCardObj extends StatelessWidget {
  final int id;
  final String theThreadTitle;
  final String theThreadContent;
  final String imageFile;
  final int icon1;
  final int icon2;
  final int icon3;
  final int icon4;

  SingleNoticeCardObj(
      {required this.id,
      required this.theThreadTitle,
      required this.theThreadContent,
      required this.imageFile,
      required this.icon1,
      required this.icon2,
      required this.icon3,
      required this.icon4});

  @override
  Widget build(BuildContext context) {
    print(icon1);
    return Container(
      child: Card(
        color: Color.fromRGBO(57, 57, 57, 1),
        shadowColor: Colors.black,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
        clipBehavior: Clip.antiAlias,
        elevation: 2,
        child: Column(
          children: [
            Container(
                child: Image.memory(
              Base64Decoder().convert(imageFile),
              fit: BoxFit.fill,
            )),
            ListTile(
              contentPadding:
                  EdgeInsets.only(bottom: 10.0, top: 10, left: 20, right: 10),
              title: Container(
                padding: EdgeInsets.only(bottom: 8),
                child: Text(
                  theThreadTitle,
                  style: TextStyle(
                      letterSpacing: 2.0, color: Colors.white, fontSize: 22),
                ),
              ),
              subtitle: Text(
                theThreadContent,
                style: TextStyle(color: Colors.white),
              ),
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width * 0.06,
                            bottom: MediaQuery.of(context).size.width * 0.06,
                            right: MediaQuery.of(context).size.width * 0.06,
                            top: MediaQuery.of(context).size.width * 0.01),
                        child: Row(
                          children: [
                            NoticeboardReactions(
                                icon1,
                                Icons.thumb_up_alt_rounded,
                                Color.fromRGBO(172, 255, 79, 1)),
                            NoticeboardReactions(icon2,
                                Icons.thumb_down_alt_rounded, Colors.red),
                            NoticeboardReactions(icon3, Icons.emoji_emotions,
                                Color.fromRGBO(172, 255, 79, 1)),
                            NoticeboardReactions(
                                icon4, Icons.bookmarks, Colors.red),
                          ],
                        ),
                      ),
                    ],
                  )
                ]),
          ],
        ),
      ),
    );
  }
}

class NoticeboardReactions extends StatefulWidget {
  final int amount;
  final IconData? iconSelected;
  final Color colorSelected;
  const NoticeboardReactions(
      this.amount, this.iconSelected, this.colorSelected);

  @override
  NoticeboardReactionsState createState() => NoticeboardReactionsState();
}

class NoticeboardReactionsState extends State<NoticeboardReactions> {
  int temp = 0;
  void initState() {
    super.initState();
    temp = widget.amount;
  }

  @override
  Widget build(BuildContext context) {
    if (widget.amount < 0) {
      return SizedBox.shrink();
    } else {
      return InkWell(
        onTap: () {
          setState(() {
            if (temp == widget.amount) {
              temp++;
              print(widget.iconSelected.toString());
              increaseEmoji(widget.iconSelected.toString());
              //++ Emoji amount in DB
            } else {
              temp--;
              decreaseEmoji(widget.iconSelected.toString());
              //-- Emoji amount in DB
            }
          });
        },
        child: Card(
            color: Color.fromRGBO(33, 33, 33, 33),
            child: Row(
              children: [
                Icon(widget.iconSelected,
                    size: 25, color: widget.colorSelected),
                Text(
                  temp.toString(),
                  style: TextStyle(
                      letterSpacing: 2.0, color: Colors.white, fontSize: 15),
                ),
              ],
            )),
      );
    }
  }
}

class NoticeboardEditCard extends StatelessWidget {
  final int id;
  final String theThreadTitle;
  final String theThreadContent;
  final String theThreadImageFile;

  const NoticeboardEditCard(
      {required this.id,
      required this.theThreadTitle,
      required this.theThreadContent,
      required this.theThreadImageFile});

  @override
  Widget build(BuildContext context) {
    titleControllerNoticeboardEdit.text = theThreadTitle;
    contentControllerNoticeboardEdit.text = theThreadContent;
    return Container(
      padding: EdgeInsets.all(16),
      child: Card(
        color: Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
        clipBehavior: Clip.antiAlias,
        elevation: 0,
        child: Column(
          children: [
            TextFormField(
                style: TextStyle(color: Colors.white),
                controller: titleControllerNoticeboardEdit,
                cursorColor: Color.fromRGBO(171, 255, 79, 1),
                decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: Color.fromRGBO(171, 255, 79, 1)),
                  ),
                  labelText: 'Title',
                  labelStyle: TextStyle(color: Color.fromRGBO(171, 255, 79, 1)),
                )),
            TextFormField(
              minLines: 1,
              maxLines: 20,
              style: TextStyle(color: Colors.white),
              controller: contentControllerNoticeboardEdit,
              cursorColor: Color.fromRGBO(171, 255, 79, 1),
              decoration: InputDecoration(
                focusedBorder: UnderlineInputBorder(
                  borderSide:
                      BorderSide(color: Color.fromRGBO(171, 255, 79, 1)),
                ),
                labelText: 'Content',
                labelStyle: TextStyle(color: Color.fromRGBO(171, 255, 79, 1)),
              ),
            ),
            Container(
                margin: EdgeInsets.only(top: 20),
                child: Container(
                  alignment: Alignment.bottomCenter,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      IconButton(
                          icon: const Icon(Icons.add_photo_alternate_outlined),
                          iconSize: 50,
                          color: Color.fromRGBO(171, 255, 79, 1),
                          tooltip: "Add Image",
                          onPressed: () async {
                            await noticeboardEditGetFromGallery();
                            UtilModel.route(
                                () => NoticeBoardEditThread(), context);
                          }),
                      Text(
                        "Add Image",
                        style:
                            TextStyle(color: Color.fromRGBO(171, 255, 79, 1)),
                      ),
                    ],
                  ),
                )),
            Container(
              margin: EdgeInsets.only(top: 20),
              child: noticeboardEditIsImageWidget(theThreadImageFile),
            ),
          ],
        ),
      ),
    );
  }
}
