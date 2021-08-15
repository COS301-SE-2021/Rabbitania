import 'package:flutter/material.dart';
import 'package:frontend/src/helper/UserInformation/userHelper.dart';
import 'package:frontend/src/models/Profile/profileModel.dart';
import 'package:frontend/src/models/util_model.dart';
import 'package:frontend/src/provider/user_provider.dart';
import 'package:frontend/src/screens/Noticeboard/noticeboardScreen.dart';
import 'package:frontend/src/widgets/NavigationBar/navigationbar.dart';
import 'package:frontend/src/widgets/Profile/profile_picture_widget.dart';
import 'package:flutter_svg/svg.dart';

class ProfileScreen extends StatefulWidget {
  createState() {
    return _profileState();
  }
}

late Future<ProfileUser>? furtureUserDetails;
late Future<String>? saveFutureRecived;

class _profileState extends State<ProfileScreen> {
  final util = new UtilModel();

  UserHelper userHelper = UserHelper();
  int profileUserId = -1;

  int? userProfileCurrentID;
  String dropdownLocationValue = "";
  String dropdownLocationHolder = "";
  TextEditingController? _controller = new TextEditingController(text: "");

  TextEditingController? _controllerDescription =
      new TextEditingController(text: "");

  void initState() {
    super.initState();
    userHelper.getUserID().then((value) {
      setState(() {
        this.profileUserId = value;
      });
      furtureUserDetails = getUserProfileObj(profileUserId);
      //print(furtureUserDetails);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: bnb(context),
      appBar: AppBar(
        leading: const BackButton(),
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Center(
          child: Text(
            'Profile      ',
            style: TextStyle(
              color: Color.fromRGBO(171, 255, 79, 1),
              fontSize: 35,
            ),
          ),
        ),
        actions: [],
      ),
      backgroundColor: Color.fromRGBO(33, 33, 33, 1),
      body: Center(
        child: Stack(
          children: <Widget>[
            SvgPicture.string(
              util.svg_background,
              fit: BoxFit.contain,
            ),
            Container(
              padding: EdgeInsets.only(bottom: 0),
              child: profileBuilder(),
            ),
          ],
        ),
      ),
    );
  }

  Widget profileBuilder() {
    return FutureBuilder<ProfileUser>(
      future: furtureUserDetails,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        List<Widget> children = [];
        if (snapshot.hasData) {
          // print(snapshot.data.userId);
          // print(snapshot.data.userName);
          // print(snapshot.data.userImage);
          // print(snapshot.data.userDescription);
          // print(snapshot.data.userNumber);
          // print(snapshot.data.userEmployeeLvl);
          // print(snapshot.data.userOfficeLocation);
          // print(snapshot.data.userRoles);
          dropdownLocationValue = snapshot.data.userOfficeLocation;

          children = <Widget>[
            Column(
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ProfilePicture(30),
                    Text(
                      snapshot.data.userName,
                      style: TextStyle(
                        color: Color.fromRGBO(171, 255, 79, 1),
                        fontSize: 25,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: 5),
                  child: Divider(
                    color: Color.fromRGBO(171, 255, 79, 1),
                    indent: MediaQuery.of(context).size.width * 0.10,
                    endIndent: MediaQuery.of(context).size.width * 0.10,
                    thickness: 1,
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "Role: " + snapshot.data.userRoles,
                      style: TextStyle(
                        color: Color.fromRGBO(171, 255, 79, 1),
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      "Lvl: " + snapshot.data.userEmployeeLvl.toString(),
                      style: TextStyle(
                        color: Color.fromRGBO(171, 255, 79, 1),
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
                InkWell(
                    onTap: () {
                      FocusScope.of(context).unfocus();
                    },
                    child: Column(children: <Widget>[
                      Padding(
                          padding: EdgeInsets.only(top: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(top: 10, bottom: 10),
                                child: InkWell(
                                  onTap: () {},
                                  child: Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.9,
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      border: Border.all(
                                        color: Color.fromRGBO(171, 255, 79, 1),
                                        width: 2,
                                      ),
                                    ),
                                    child: descriptionWidget(
                                        snapshot.data.userDescription),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 10, bottom: 10),
                                child: InkWell(
                                  onTap: () {},
                                  child: Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.9,
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      border: Border.all(
                                        color: Color.fromRGBO(171, 255, 79, 1),
                                        width: 2,
                                      ),
                                    ),
                                    child: DropdownOffice(),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 10, bottom: 10),
                                child: InkWell(
                                  onTap: () {},
                                  child: Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.9,
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      border: Border.all(
                                        color: Color.fromRGBO(171, 255, 79, 1),
                                        width: 2,
                                      ),
                                    ),
                                    child: phoneNumberWidget(
                                        snapshot.data.userNumber),
                                  ),
                                ),
                              ),
                              ElevatedButton(
                                  key: Key('saveButton'),
                                  style: ButtonStyle(
                                    elevation: MaterialStateProperty.all(11),
                                    backgroundColor: MaterialStateProperty.all(
                                      Color.fromRGBO(172, 255, 79, 1),
                                    ),
                                    shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                        side: BorderSide(
                                          style: BorderStyle.none,
                                        ),
                                      ),
                                    ),
                                  ),
                                  child: Text(
                                    "Save",
                                    style: TextStyle(
                                      fontSize: 30,
                                      color: Color.fromRGBO(33, 33, 33, 1),
                                    ),
                                  ),
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          elevation: 5,
                                          backgroundColor:
                                              Color.fromRGBO(33, 33, 33, 1),
                                          titleTextStyle: TextStyle(
                                              color: Colors.white,
                                              fontSize: 32),
                                          title: Text("Save Changes"),
                                          contentTextStyle: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16),
                                          content: Text(
                                              "Are you sure you want to save these changes?"),
                                          actions: [
                                            IconButton(
                                              icon: const Icon(
                                                Icons.check,
                                                color: Color.fromRGBO(
                                                    171, 255, 79, 1),
                                                size: 24.0,
                                              ),
                                              tooltip: 'Save',
                                              onPressed: () async {
                                                showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    saveFutureRecived =
                                                        SaveAllUserDetails(
                                                            profileUserId,
                                                            snapshot
                                                                .data.userName,
                                                            _controllerDescription!
                                                                .text,
                                                            snapshot
                                                                .data.userRoles,
                                                            dropdownLocationHolder,
                                                            snapshot.data
                                                                .userEmployeeLvl,
                                                            _controller!.text);
                                                    return FutureBuilder<
                                                        String>(
                                                      future: saveFutureRecived,
                                                      builder:
                                                          (context, snapshot) {
                                                        if (snapshot.hasData) {
                                                          return AlertDialog(
                                                            elevation: 5,
                                                            backgroundColor:
                                                                Color.fromRGBO(
                                                                    33,
                                                                    33,
                                                                    33,
                                                                    1),
                                                            content: Text(
                                                                snapshot.data!),
                                                            titleTextStyle:
                                                                TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        32),
                                                            title: Text(
                                                                snapshot.data!),
                                                            contentTextStyle:
                                                                TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        16),
                                                            actions: [
                                                              IconButton(
                                                                icon:
                                                                    const Icon(
                                                                  Icons.check,
                                                                  color: Color
                                                                      .fromRGBO(
                                                                          171,
                                                                          255,
                                                                          79,
                                                                          1),
                                                                  size: 24.0,
                                                                ),
                                                                tooltip:
                                                                    'Continue',
                                                                onPressed:
                                                                    () async {
                                                                  UtilModel.route(
                                                                      () =>
                                                                          NoticeBoard(),
                                                                      context);
                                                                },
                                                              ),
                                                            ],
                                                          );
                                                        } else if (snapshot
                                                            .hasError) {
                                                          return AlertDialog(
                                                              elevation: 5,
                                                              backgroundColor:
                                                                  Color
                                                                      .fromRGBO(
                                                                          33,
                                                                          33,
                                                                          33,
                                                                          1),
                                                              content: Text(
                                                                  '${snapshot.error}'));
                                                        }
                                                        return AlertDialog(
                                                            elevation: 5,
                                                            backgroundColor:
                                                                Color.fromRGBO(
                                                                    33,
                                                                    33,
                                                                    33,
                                                                    1),
                                                            content:
                                                                CircularProgressIndicator());
                                                      },
                                                    );
                                                  },
                                                );
                                              },
                                            ),
                                            IconButton(
                                              icon: const Icon(
                                                Icons.close,
                                                color: Color.fromRGBO(
                                                    255, 79, 79, 1),
                                                size: 24.0,
                                              ),
                                              tooltip: 'Cancel',
                                              onPressed: () {
                                                //final deleteResponse = await deleteThread(this.id);
                                                UtilModel.route(
                                                    () => ProfileScreen(),
                                                    context);
                                              },
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  }),
                            ],
                          )),
                    ])),
              ],
            ),
          ];
        } else if (snapshot.hasError) {
          children = <Widget>[
            const Icon(
              Icons.error_outline,
              color: Colors.red,
              size: 60,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Text('Error: ${snapshot.error}'),
            )
          ];
        } else {
          children = <Widget>[
            Center(
              child: Stack(children: <Widget>[
                Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    decoration: new BoxDecoration(
                      color: Color.fromRGBO(33, 33, 33, 1),
                    ),
                    child: Center(
                      widthFactor: 0.5,
                      heightFactor: 0.5,
                      child: CircularProgressIndicator(
                        color: Color.fromRGBO(171, 255, 79, 1),
                      ),
                    )),
              ]),
            ),
          ];
        }
        return Center(
          child: ListView(
            children: children,
          ),
        );
      },
    );
  }

  Widget phoneNumberWidget(String pn) {
    if (_controller!.text == "") {
      _controller = TextEditingController(text: pn);
    }

    return TextFormField(
      maxLines: 1,
      style: TextStyle(fontSize: 30, color: Color.fromRGBO(171, 255, 79, 1)),
      controller: _controller,
      cursorColor: Color.fromRGBO(171, 255, 79, 1),
      decoration: InputDecoration(
        border: InputBorder.none,
        focusedBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
        errorBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
        contentPadding:
            EdgeInsets.only(left: 20, bottom: 11, top: 11, right: 15),
      ),
    );
  }

  Widget descriptionWidget(String des) {
    if (_controllerDescription!.text == "") {
      _controllerDescription = TextEditingController(text: des);
    }
    return TextFormField(
      minLines: 1,
      maxLines: 20,
      style: TextStyle(fontSize: 30, color: Color.fromRGBO(171, 255, 79, 1)),
      controller: _controllerDescription,
      cursorColor: Color.fromRGBO(171, 255, 79, 1),
      decoration: InputDecoration(
        border: InputBorder.none,
        focusedBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
        errorBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
        contentPadding:
            EdgeInsets.only(left: 20, bottom: 11, top: 11, right: 15),
      ),
    );
  }

  Widget DropdownOffice() {
    if (dropdownLocationHolder == "") {
      dropdownLocationHolder = dropdownLocationValue;
    }
    return DropdownButton<String>(
      dropdownColor: Color.fromRGBO(33, 33, 33, 1),
      value: dropdownLocationHolder,
      icon: const Padding(
        padding: EdgeInsets.symmetric(),
        child:
            Icon(Icons.arrow_downward, color: Color.fromRGBO(171, 255, 79, 1)),
      ),
      iconSize: 30,
      elevation: 8,
      style: const TextStyle(
        fontSize: 30,
        color: Color.fromRGBO(172, 255, 79, 1),
      ),
      underline: Container(
        height: 0,
        color: Color.fromRGBO(33, 33, 33, 1),
      ),
      onChanged: (String? selectedOffice) {
        setState(() {
          dropdownLocationHolder = selectedOffice!;
        });
      },
      items: officeList.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Padding(
            padding: EdgeInsets.only(left: 35),
            child: Text(value),
          ),
        );
      }).toList(),
    );
  }

  List<String> officeList = ['Braamfontein', 'Pretoria', 'Unassigned'];
}
