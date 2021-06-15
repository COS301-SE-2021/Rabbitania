import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

var list = [{'Title':"Covid 21","Body":"No more work for 2021"},{'Title':"Returning","Body":"Work is Not stopping"},{'Title':"Party Time","Body":"This is a message to all employees"}];

class NoticeboardCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child:ListView(
        children: <Widget>[

          for(var item in list)
          Card(
            color: Color.fromRGBO(250,250,255,1),
            shadowColor: Color.fromRGBO(171, 255, 79, 1),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0)
            ),
            clipBehavior: Clip.antiAlias,
            elevation: 10,
              child: Column(
                children: [
                  ListTile(
                    contentPadding: EdgeInsets.all(10.0),
                    leading: Icon(Icons.account_circle_outlined, size: 70, color: Color.fromRGBO(171, 255, 79, 1),),
                    title: Text( item['Title'].toString(),
                      style: TextStyle(letterSpacing: 3.0),
                    ),
                    subtitle: Text(item['Body'].toString()),
                  ),
                  Image.asset("images/TestImage1.png"),
                ],

              ),
          ),

        ]
      ),

    );
  }
}
