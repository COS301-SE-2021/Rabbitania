import 'package:frontend/src/provider/questionnaire_provider.dart';
import 'package:flutter/material.dart';
import 'package:frontend/src/models/utilModel.dart';
import 'package:flutter_svg/svg.dart';
import 'package:toggle_switch/toggle_switch.dart';

// Create a Form widget.
class QuestionnaireForm extends StatefulWidget {
  const QuestionnaireForm({Key? key}) : super(key: key);

  @override
  QuestionnaireFormState createState() {
    return QuestionnaireFormState();
  }
}

// test_date,cough,fever,sore_throat,shortness_of_breath,head_ache,corona_result,age_60_and_above,gender,test_indication
class QuestionnaireFormState extends State<QuestionnaireForm> {
  UtilModel utilModel = UtilModel();
  Map<String, bool?> symptoms = {
    'Cough': false,
    'Fever': false,
    'Sore Throat': false,
    'Shortness Of Breath': false,
    'Headache': false,
    'Contact With Someone Who Has Covid': false,
  };
  String maleFemale = 'male';
  int toggleIndex = 0;

  @override
  Widget build(BuildContext context) {
    UtilModel utilModel = UtilModel();
    final QuestionnaireProvider questionnaireProvider =
        new QuestionnaireProvider();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: 100,
        elevation: 1,
        backgroundColor: Colors.transparent,
        title: Text(
          'Symptoms Questionnaire',
          style: TextStyle(
            fontSize: 30,
            color: Color.fromRGBO(171, 255, 79, 1),
          ),
        ),
      ),
      backgroundColor: utilModel.greyColor,
      body: Stack(
        children: <Widget>[
          SvgPicture.string(
            utilModel.svgBackground,
            fit: BoxFit.contain,
          ),
          Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'Symptoms',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25.0,
                    color: Color.fromRGBO(171, 255, 79, 1),
                  ),
                ),
              ),
              Center(
                  child: ToggleSwitch(
                cornerRadius: 20.0,
                initialLabelIndex: this.toggleIndex,
                totalSwitches: 2,
                minWidth: 90.0,
                activeBgColor: [utilModel.greenColor],
                activeFgColor: utilModel.greyColor,
                inactiveBgColor: Color.fromRGBO(232, 232, 232, 150),
                inactiveFgColor: Colors.white,
                labels: ['Male', 'Female'],
                onToggle: (toggleIndex) {
                  if (maleFemale == 'male') {
                    maleFemale = 'female';
                  } else {
                    maleFemale = 'male';
                  }
                },
              )),
              Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      children: symptoms.keys
                          .map(
                            (symptom) => CheckboxListTile(
                              tileColor: Colors.transparent,
                              checkColor: utilModel.greyColor,
                              activeColor: utilModel.greenColor,
                              selectedTileColor: Colors.white,
                              title: Text(
                                symptom,
                                style: TextStyle(
                                    color: utilModel.greenColor, fontSize: 18),
                              ),
                              value: symptoms[symptom],
                              onChanged: (bool? value) {
                                setState(() {
                                  symptoms[symptom] = value;
                                  maleFemale = maleFemale;
                                  if (maleFemale == 'male') {
                                    toggleIndex = 0;
                                  } else {
                                    toggleIndex = 1;
                                  }
                                });
                              },
                            ),
                          )
                          .toList(),
                    ),
                  ),
                  flex: 1),
              Container(
                  child: TextButton(
                    onPressed: () =>
                        questionnaireProvider.predictAI(symptoms, maleFemale),
                    child: Text("Submit",
                        style: TextStyle(
                            color: utilModel.greenColor,
                            backgroundColor: utilModel.greyColor,
                            fontSize: 30)),
                  ),
                  padding: EdgeInsets.only(bottom: 30)),
            ],
          ),
        ],
      ),
    );
  }
}
