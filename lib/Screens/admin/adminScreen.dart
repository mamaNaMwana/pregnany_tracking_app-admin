import 'package:flutter/material.dart';
import 'package:mama_k_app_admin/Screens/admin/babysDev/babysDev.dart';

class AdminScreen extends StatefulWidget {
  @override
  _AdminScreenState createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(top: 40.0, left: 30.0, right: 30.0),
            width: double.infinity,
            child: Column(
              children: <Widget>[
                Text(
                  "Admind Dashboard",
                  style: TextStyle(
                    color: Colors.teal[900],
                    fontSize: 30.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 50.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(10.0),
                      width: 150.0,
                      height: 100.0,
                      child: RaisedButton(
                        child: Text("Baby's development"),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BabysDev(),
                            ),
                          );
                        },
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(10.0),
                      width: 150.0,
                      height: 100.0,
                      child: RaisedButton(
                        child: Text("Mothers's development"),
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10.0),
                Row(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(10.0),
                      width: 150.0,
                      height: 100.0,
                      child: RaisedButton(
                        child: Text("Tips"),
                        onPressed: () {},
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(10.0),
                      width: 150.0,
                      height: 100.0,
                      child: RaisedButton(
                        child: Text("Payments"),
                        onPressed: () {},
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}