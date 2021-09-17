import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:frontend/src/helper/JWT/securityHelper.dart';
import 'package:frontend/src/helper/URL/urlHelper.dart';
import 'package:frontend/src/helper/UserInformation/userHelper.dart';
import 'package:frontend/src/models/utilModel.dart';
import 'package:frontend/src/provider/user_provider.dart';
import 'package:frontend/src/widgets/Profile/profile_picture_widget.dart';
import 'package:flutter_svg/svg.dart';
import '../Noticeboard/noticeboardScreen.dart';
import 'package:http/http.dart' as http;

class InfoForm extends StatefulWidget {
  final user;
  InfoForm(this.user);
  @override
  State<StatefulWidget> createState() {
    return InfoFormState();
  }
}

class InfoFormState extends State<InfoForm> {
  UserHelper loggedUser = new UserHelper();
  SecurityHelper securityHelper = new SecurityHelper();
  URLHelper url = new URLHelper();
  final utilModel = UtilModel();

  var user;
  final _formKey = GlobalKey<FormState>();
  final userBioController = TextEditingController();
  final phoneNumberController = TextEditingController();
  String _dropDownRoleValue = 'Developer';
  String _dropDownLevelValue = '0';
  String _dropDownOfficeValue = 'Pretoria';

  initState() {
    super.initState();
    setState(() {
      user = widget.user;
    });
  }

  httpCallGetUser() async {
    final userProvider = new UserProvider();
    final userID = await userProvider.getUserID();
    return userID;
  }

  httpCallUpdateUserInfo() async {
    int officeLocationInt = 0;
    if (_dropDownOfficeValue == 'Braamfontein') {
      officeLocationInt = 1;
    }

    determineRole(_dropDownRoleValue) {
      switch (_dropDownRoleValue) {
        case "developer":
          return 0;
        case "Designer":
          return 1;
        case "Care Taker":
          return 2;
        case "Scrum Master":
          return 3;
        case "CAM":
          return 4;
        case "Director":
          return 5;
        case "Graduate":
          return 6;
        case "Intern":
          return 7;
        default:
          return 0;
      }
    }

    int userRole = determineRole(_dropDownRoleValue);

    final token = await securityHelper.getToken();
    final baseURL = await url.getBaseURL();
    final int userID = await httpCallGetUser();
    final response = await http.put(
      Uri.parse(baseURL + '/api/User/EditProfile'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode(<String, dynamic>{
        'userId': userID,
        'name': user.displayName,
        'userImage': user.photoURL,
        'phoneNumber': phoneNumberController.text,
        'userDescription': userBioController.text,
        'officeLocation': officeLocationInt,
        'employeeLevel': _dropDownLevelValue,
        'userRoles': userRole,
      }),
    );

    if (response.statusCode == 200) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => NoticeBoard()));
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
            title: Text('Something went wrong'),
            content:
                Text('something went wrong while updating your information'),
            actions: [
              ElevatedButton(
                child: Text('return'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ]),
      );
    }
  }

  Widget build(context) => MaterialApp(
        home: Scaffold(
          backgroundColor: Color.fromRGBO(33, 33, 33, 1),
          body: Stack(
            children: <Widget>[
              SvgPicture.string(utilModel.svgBackground),
              Container(
                alignment: Alignment.center,
                child: Form(
                  key: _formKey,
                  child: ListView(
                    padding: EdgeInsets.all(30),
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(top: 1),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: Color.fromRGBO(171, 255, 79, 0.6),
                              ),
                              child: Column(
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.all(12),
                                    child: ProfilePicture(40),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(5),
                                    child: Container(
                                      width: 300,
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        color: Colors.transparent,
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Center(
                                        child: Text(
                                          user.displayName!,
                                          style: TextStyle(
                                            fontSize: 18,
                                            color: Color.fromRGBO(
                                                238, 238, 238, 1),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(5),
                                    child: Container(
                                      width: 300,
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        color: Colors.transparent,
                                      ),
                                      child: Center(
                                        child: Text(
                                          user.providerData[0].email!,
                                          style: TextStyle(
                                            fontSize: 18,
                                            color: Color.fromRGBO(
                                                238, 238, 238, 1),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding:
                                  EdgeInsets.only(top: 15, left: 15, right: 15),
                              width: MediaQuery.of(context).size.width,
                              child: Center(
                                child: Text(
                                  'Please enter missing information to proceed',
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Color.fromRGBO(171, 255, 79, 1)),
                                ),
                              ),
                            ),
                            Divider(
                              thickness: 3,
                              color: Color.fromRGBO(171, 255, 79, 1),
                            ),
                            Container(
                              padding: EdgeInsets.only(top: 20),
                              child: ButtonTheme(
                                alignedDropdown: true,
                                child: Center(
                                  child: DropdownButton<String>(
                                    dropdownColor:
                                        Color.fromRGBO(33, 33, 33, 1),
                                    value: _dropDownRoleValue,
                                    underline: Container(
                                      height: 2,
                                      color: Color.fromRGBO(171, 255, 79, 1),
                                    ),
                                    onChanged: (String? newValue) {
                                      setState(() =>
                                          {_dropDownRoleValue = newValue!});
                                    },
                                    items: <String>[
                                      'Developer',
                                      'Designer',
                                      'Care Taker',
                                      'Scrum Master',
                                      'CAM',
                                      'Director',
                                      'Graduate',
                                      'Intern'
                                    ].map<DropdownMenuItem<String>>(
                                        (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Container(
                                          width: 305,
                                          child: Text(
                                            value,
                                            style: TextStyle(
                                              color: Color.fromRGBO(
                                                  171, 255, 79, 1),
                                            ),
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(top: 20),
                              width: MediaQuery.of(context).size.width,
                              child: ButtonTheme(
                                alignedDropdown: true,
                                child: Center(
                                  child: DropdownButton<String>(
                                    dropdownColor:
                                        Color.fromRGBO(33, 33, 33, 1),
                                    value: _dropDownOfficeValue,
                                    underline: Container(
                                      height: 2,
                                      color: Color.fromRGBO(171, 255, 79, 1),
                                    ),
                                    onChanged: (String? newValue) {
                                      setState(() =>
                                          {_dropDownOfficeValue = newValue!});
                                    },
                                    items: <String>['Pretoria', 'Braamfontein']
                                        .map<DropdownMenuItem<String>>(
                                            (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Container(
                                          width: 305,
                                          child: Text(
                                            value,
                                            style: TextStyle(
                                              color: Color.fromRGBO(
                                                  171, 255, 79, 1),
                                            ),
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(top: 20),
                              width: MediaQuery.of(context).size.width,
                              child: ButtonTheme(
                                alignedDropdown: true,
                                child: Center(
                                  child: TextFormField(
                                    style: TextStyle(
                                        color: Color.fromRGBO(171, 255, 79, 1)),
                                    autocorrect: true,
                                    decoration: InputDecoration(
                                      hintStyle: TextStyle(
                                          color: Color.fromRGBO(
                                              171, 255, 79, 0.6)),
                                      focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                        color: Color.fromRGBO(171, 255, 79, 1),
                                      )),
                                      hintText: 'Phone Number',
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color.fromRGBO(
                                                171, 255, 79, 1)),
                                      ),
                                    ),
                                    controller: phoneNumberController,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter text';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ),
                            ),
                            Center(
                              child: Container(
                                padding: EdgeInsets.only(top: 20),
                                width: 340,
                                child: TextFormField(
                                  style: TextStyle(
                                      color: Color.fromRGBO(171, 255, 79, 1)),
                                  autocorrect: true,
                                  decoration: InputDecoration(
                                    hintStyle: TextStyle(
                                        color:
                                            Color.fromRGBO(171, 255, 79, 0.6)),
                                    focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                      color: Color.fromRGBO(171, 255, 79, 1),
                                    )),
                                    hintText: 'User bio',
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color:
                                              Color.fromRGBO(171, 255, 79, 1)),
                                    ),
                                  ),
                                  controller: userBioController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter text';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 40),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    width: 170,
                                    height: 55,
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 15),
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          onSurface: Colors.transparent,
                                          primary:
                                              Color.fromRGBO(171, 255, 79, 1),
                                          side: BorderSide(
                                            width: 0.5,
                                            color:
                                                Color.fromRGBO(171, 255, 79, 1),
                                          ),
                                        ),
                                        child: Text(
                                          'Proceed',
                                          style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.black,
                                          ),
                                        ),
                                        onPressed: () async {
                                          await httpCallUpdateUserInfo();

                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  NoticeBoard(),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}
