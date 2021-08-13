import 'package:flutter/material.dart';
import 'package:frontend/src/helper/UserInformation/userHelper.dart';
import 'package:frontend/src/models/userProfile_model.dart';
import 'package:frontend/src/models/util_model.dart';
import 'package:frontend/src/provider/user_provider.dart';
import 'package:frontend/src/widgets/NavigationBar/navigationbar.dart';
import 'package:frontend/src/widgets/Profile/profile_picture_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_svg/svg.dart';

class ProfileScreen extends StatefulWidget {
  createState() {
    return _profileState();
  }
}

late Future<UserProfileModel>? userDetails;
//TextEditingController phoneNumberController = new TextEditingController();

class _profileState extends State<ProfileScreen> {
  var user;
  String name = "";
  String description = "";
  int employeeLevel = 1;
  int officeLocation = 1;
  int userRole = 9;
  String phoneNumber = "";
  int userProfileCurrentID = -1;
  String dropdownDeveloperValue = "Unassigned";
  String dropdownLevelValue = "Level: 0";
  String dropdownLocationValue = "Pretoria";
  TextEditingController? _controller;

  final util = new UtilModel();
  UserHelper userHelper = UserHelper();

  initState() {
    super.initState();
    var userProfile = new UserProvider();
    userHelper.getUserID().then((value) {
      //print(value);
      userProfileCurrentID = value;
    });
    setState(() {
      userDetails = userProfile.getUserProfile();
      user = FirebaseAuth.instance.currentUser;
    });
    initFunction(userDetails);
    //print(user);
  }

  Widget build(context) {
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

  determineOffice() {
    if (officeLocation == 1) {
      return 'Braamfontein';
    }
    return 'Pretoria';
  }

  determineofficeReversed(String location) {
    if (location == 'Braamfontein') {
      return 1;
    }
    return 3;
  }

  determineRoleReversed(String role) {
    switch (role) {
      case 'Developer':
        return 1;
      case 'Designer':
        return 2;
      case 'Care Taker':
        return 3;
      case 'Scrum Master':
        return 4;
      case 'CAM':
        return 5;
      case 'Director':
        return 6;
      case 'Graduate':
        return 7;
      case 'Intern':
        return 8;
      default:
        return 9;
    }
  }

  determineRole() {
    switch (userRole) {
      case 1:
        return 'Developer';
      case 2:
        return 'Designer';
      case 3:
        return 'Care Taker';
      case 4:
        return 'Scrum Master';
      case 5:
        return 'CAM';
      case 6:
        return 'Director';
      case 7:
        return 'Graduate';
      case 8:
        return 'Intern';
      default:
        return 'Unassigned';
    }
  }

  initFunction(userDetails) async {
    setState(() {
      name = userDetails.name;
      description = userDetails.description;
      employeeLevel = userDetails.empLevel;
      officeLocation = userDetails.officeLocation;
      userRole = userDetails.userRoles;
      phoneNumber = userDetails.phoneNumber;
    });
  }

  Widget profileBuilder() {
    return FutureBuilder<UserProfileModel>(
      future: userDetails,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        List<Widget> children = [];

        if (snapshot.hasData) {
          name = snapshot.data.name;
          description = snapshot.data.description;
          employeeLevel = snapshot.data.empLevel;
          officeLocation = snapshot.data.officeLocation;
          userRole = snapshot.data.userRoles;
          phoneNumber = snapshot.data.phoneNumber;

          children = <Widget>[
            Column(
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ProfilePicture(),
                    Text(
                      user.displayName,
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
                              width: MediaQuery.of(context).size.width * 0.9,
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                border: Border.all(
                                  color: Color.fromRGBO(171, 255, 79, 1),
                                  width: 2,
                                ),
                              ),
                              child: DropdownDeveloper(),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 10, bottom: 10),
                          child: InkWell(
                            onTap: () {},
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.9,
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
                              width: MediaQuery.of(context).size.width * 0.9,
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                border: Border.all(
                                  color: Color.fromRGBO(171, 255, 79, 1),
                                  width: 2,
                                ),
                              ),
                              child: DropdownLevel(),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 10, bottom: 10),
                          child: InkWell(
                            onTap: () {},
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.9,
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                border: Border.all(
                                  color: Color.fromRGBO(171, 255, 79, 1),
                                  width: 2,
                                ),
                              ),
                              child: phoneNumberWidget(),
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
                                  borderRadius: BorderRadius.circular(12.0),
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
                                        color: Colors.white, fontSize: 32),
                                    title: Text("Save Changes"),
                                    contentTextStyle: TextStyle(
                                        color: Colors.white, fontSize: 16),
                                    content: Text(
                                        "Are you sure you want to save these changes?"),
                                    actions: [
                                      IconButton(
                                        icon: const Icon(
                                          Icons.check,
                                          color:
                                              Color.fromRGBO(171, 255, 79, 1),
                                          size: 24.0,
                                        ),
                                        tooltip: 'Save',
                                        onPressed: () async {
                                          // ignore: unused_local_variable
                                          final deleteResponse =
                                              await SaveAllUserDetails(
                                                  userProfileCurrentID,
                                                  name,
                                                  description,
                                                  determineRoleReversed(
                                                      dropdownDeveloperValue!),
                                                  determineofficeReversed(
                                                      dropdownLocationValue!),
                                                  int.parse(dropdownLevelValue!
                                                      .substring(7)),
                                                  _controller!.text);
                                          UtilModel.route(
                                              () => ProfileScreen(), context);
                                        },
                                      ),
                                      IconButton(
                                        icon: const Icon(
                                          Icons.close,
                                          color: Color.fromRGBO(255, 79, 79, 1),
                                          size: 24.0,
                                        ),
                                        tooltip: 'Cancel',
                                        onPressed: () {
                                          //final deleteResponse = await deleteThread(this.id);
                                          UtilModel.route(
                                              () => ProfileScreen(), context);
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            }),
                      ],
                    )),
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

  Widget phoneNumberWidget() {
    _controller = TextEditingController(text: phoneNumber);
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

  Widget DropdownDeveloper() {
    return DropdownButton<String>(
      dropdownColor: Color.fromRGBO(33, 33, 33, 1),
      value: dropdownDeveloperValue,
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
      onChanged: (String? selectedRole) {
        setState(() {
          userRole = determineRoleReversed(selectedRole!);
          print(determineRole());
          dropdownDeveloperValue = selectedRole;
        });
      },
      items: userRoleList.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Padding(
            padding: EdgeInsets.only(left: 30),
            child: Text(value),
          ),
        );
      }).toList(),
    );
  }

  Widget DropdownOffice() {
    return DropdownButton<String>(
      dropdownColor: Color.fromRGBO(33, 33, 33, 1),
      value: dropdownLocationValue,
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
          officeLocation = determineofficeReversed(selectedOffice!);
          dropdownLocationValue = selectedOffice;
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

  Widget DropdownLevel() {
    return DropdownButton<String>(
      dropdownColor: Color.fromRGBO(33, 33, 33, 1),
      value: dropdownLevelValue,
      icon: const Padding(
        padding: EdgeInsets.only(left: 85),
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
      onChanged: (String? selectedLVL) {
        setState(() {
          employeeLevel = int.parse(selectedLVL!.substring(7));
          dropdownLevelValue = selectedLVL;
        });
      },
      items: levelList.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Padding(
            padding: EdgeInsets.only(left: 30),
            child: Text(value),
          ),
        );
      }).toList(),
    );
  }

  List<String> levelList = [
    "Level: 0",
    "Level: 1",
    "Level: 2",
    "Level: 3",
    "Level: 4",
    "Level: 5",
    "Level: 6",
    "Level: 7",
    "Level: 8",
    "Level: 9"
  ];

  List<String> officeList = [
    'Braamfontein',
    'Pretoria',
  ];

  List<String> userRoleList = [
    'Developer',
    'Designer',
    'Care Taker',
    'Scrum Master',
    'CAM',
    'Director',
    'Graduate',
    'Intern',
    'Unassigned'
  ];
}
