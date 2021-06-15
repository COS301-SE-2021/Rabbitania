import 'package:flutter/material.dart';

class NoticeboardCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        color: Colors.white,
        shadowColor: Colors.green,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0)
        ),
        clipBehavior: Clip.antiAlias,
        elevation: 10,
          child: Column(
            children: [
              ListTile(
                contentPadding: EdgeInsets.all(10.0),
                leading: Icon(Icons.account_circle_outlined, size: 70, color: Colors.green,),
                title: Text( "API TEXT",
                  style: TextStyle(letterSpacing: 3.0),
                ),
                subtitle: Text("INSERT API TEXT"),
              ),

            ],
          ),
      ),
    );
  }
}
