import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mama_k_app_admin/models/babyModel.dart';
import 'package:mama_k_app_admin/services/databaseService.dart';
import 'package:path/path.dart' as Path;
import 'package:image_picker/image_picker.dart';

class BabyDevAdd extends StatefulWidget {
  int week;
  BabyDevAdd(this.week);
  @override
  _BabyDevAddState createState() => _BabyDevAddState();
}

class _BabyDevAddState extends State<BabyDevAdd> {
  final _formKey = GlobalKey<FormState>();
  DatabaseService _databaseService = DatabaseService();
  Stream userStream;
  Baby babyWeek = Baby();
  double size, weight;
  String description, imageURL;
  File _imageFile;

  Future getImage() async {
    await ImagePicker.pickImage(source: ImageSource.gallery).then((image) {
      setState(() {
        _imageFile = image;
        imageURL = image.path;
      });
    });
  }

  clearImage() {
    setState(() {
      _imageFile = null;
      imageURL = null;
    });
  }

  @override
  void initState() {
    _imageFile = null;
    userStream = _databaseService.getBabyWeekForAdmin(this.widget.week);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    this.babyWeek.week = this.widget.week;
    return StreamBuilder(
      stream: userStream,
      builder: (context, currentStream) {
        if (currentStream.hasData && currentStream.data.exists) {
          this.babyWeek.size = currentStream.data['size'];
          this.babyWeek.weight = currentStream.data['weight'];
          this.babyWeek.tipDescription = currentStream.data['tipDescription'];
          this.babyWeek.imageURL = currentStream.data['imageURL'];
          imageURL = currentStream.data['imageURL'];

          return SafeArea(
            child: Scaffold(
              body: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.only(top: 40.0, left: 30.0, right: 30.0),
                  width: double.infinity,
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          InkWell(
                            child: Container(
                              margin: EdgeInsets.only(right: 1.0),
                              padding: EdgeInsets.all(5.0),
                              decoration: BoxDecoration(
                                color: Colors.green[200].withOpacity(0.4),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(25.0),
                                ),
                              ),
                              child: Icon(
                                Icons.arrow_back,
                                color: Colors.black26,
                              ),
                            ),
                            onTap: () {
                              Navigator.pop(context);
                            },
                          ),
                          Container(
                            child: Text(
                              "Baby's development",
                              style: TextStyle(
                                fontWeight: FontWeight.w300,
                                fontSize: 18.0,
                                color: Colors.black54,
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                            decoration: BoxDecoration(
                              color: Colors.green.withOpacity(0.2),
                              borderRadius: BorderRadius.all(
                                Radius.circular(50.0),
                              ),
                            ),
                            child: Text(
                              "Week " + this.widget.week.toString(),
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 18.0,
                                color: Colors.green[900],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 50.0),
                      Container(
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: <Widget>[
                              Container(
                                child: TextFormField(
                                  initialValue: (this.babyWeek.size != 0.0)
                                      ? this.babyWeek.size.toString()
                                      : null,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.all(10.0),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.transparent),
                                      borderRadius: BorderRadius.all(Radius.circular(50.0)),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.transparent),
                                      borderRadius: BorderRadius.all(Radius.circular(50.0)),
                                    ),
                                    prefixIcon: Icon(Icons.keyboard),
                                    hintText: "Size ",
                                    filled: true,
                                    fillColor: Colors.green[50],
                                    border: InputBorder.none,
                                  ),
                                  onChanged: (value) {
                                    setState(() {
                                      this.size = double.parse(value);
                                    });
                                  },
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'size is required';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              SizedBox(height: 20.0),
                              Container(
                                child: TextFormField(
                                  initialValue: (this.babyWeek.weight != 0.0)
                                      ? this.babyWeek.weight.toString()
                                      : null,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.all(10.0),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.transparent),
                                      borderRadius: BorderRadius.all(Radius.circular(50.0)),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.transparent),
                                      borderRadius: BorderRadius.all(Radius.circular(50.0)),
                                    ),
                                    prefixIcon: Icon(Icons.keyboard),
                                    hintText: "Weight ",
                                    filled: true,
                                    fillColor: Colors.green[50],
                                    border: InputBorder.none,
                                  ),
                                  onChanged: (value) {
                                    setState(() {
                                      this.weight = double.parse(value);
                                    });
                                  },
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'weight is required';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              SizedBox(height: 20.0),
                              Container(
                                child: TextFormField(
                                  maxLines: null,
                                  initialValue: (this.babyWeek.tipDescription != '')
                                      ? this.babyWeek.tipDescription
                                      : null,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.all(10.0),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.transparent),
                                      borderRadius: BorderRadius.all(Radius.circular(50.0)),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.transparent),
                                      borderRadius: BorderRadius.all(Radius.circular(50.0)),
                                    ),
                                    prefixIcon: Icon(Icons.keyboard),
                                    hintText: "Description ",
                                    filled: true,
                                    fillColor: Colors.green[50],
                                    border: InputBorder.none,
                                  ),
                                  onChanged: (value) {
                                    setState(() {
                                      this.description = value;
                                    });
                                  },
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'description is required';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              SizedBox(height: 20.0),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    child: Text(
                                      "Pick a Image",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w300,
                                        fontSize: 17.0,
                                        color: Colors.black54,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 50.0),
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 6.0),
                                    decoration: BoxDecoration(
                                      color: Colors.green.withOpacity(0.2),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10.0),
                                      ),
                                    ),
                                    child: InkWell(
                                      child: Icon(
                                        Icons.add_a_photo,
                                        size: 20.0,
                                        color: Colors.green[800],
                                      ),
                                      onTap: () {
                                        getImage();
                                      },
                                    ),
                                  ),
                                  SizedBox(width: 20.0),
                                  (imageURL != null)
                                      ? Container(
                                          padding:
                                              EdgeInsets.symmetric(horizontal: 6.0, vertical: 6.0),
                                          decoration: BoxDecoration(
                                            color: Colors.green.withOpacity(0.2),
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(10.0),
                                            ),
                                          ),
                                          child: InkWell(
                                            child: Icon(
                                              Icons.delete,
                                              size: 20.0,
                                              color: Colors.green[800],
                                            ),
                                            onTap: () {
                                              clearImage();
                                            },
                                          ),
                                        )
                                      : Container(),
                                ],
                              ),
                              SizedBox(height: 20.0),
                              Container(
                                  height: 150.0,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.4),
                                        spreadRadius: 3,
                                        blurRadius: 10,
                                        offset: Offset(0, 3),
                                      ),
                                    ],
                                    image: DecorationImage(
                                      image: loadImage(),
                                      fit: BoxFit.cover,
                                    ),
                                    borderRadius: BorderRadius.all(Radius.circular(5)),
                                  )),
                              SizedBox(height: 20.0),
                              Container(
                                height: 45.0,
                                width: double.infinity,
                                child: FlatButton(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50.0),
                                    side: BorderSide(color: Colors.green[400]),
                                  ),
                                  color: Colors.green[400],
                                  textColor: Colors.white,
                                  splashColor: Colors.green[200],
                                  child: Text(
                                    "Submit",
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  onPressed: () {
                                    if (this.size != null) this.babyWeek.size = this.size;
                                    if (this.weight != null) this.babyWeek.weight = this.weight;
                                    if (this.size != null)
                                      this.babyWeek.tipDescription = this.description;
                                    if (_formKey.currentState.validate()) {
                                      if (_imageFile != null) {
                                        String imagePath = "babyWeek/week" +
                                            this.widget.week.toString() +
                                            "-" +
                                            Path.basename(_imageFile.path).toString();
                                        _databaseService.uploadImage(
                                            imagePath, _imageFile, this.babyWeek, context);
                                      } else {
                                        print("image can't be null");
                                      }
                                    } else {
                                      print("form validate fail");
                                    }
                                  },
                                ),
                              ),
                              SizedBox(height: 20.0),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        } else {
          return SafeArea(
            child: Scaffold(
              body: Container(
                child: Text("Loading"),
              ),
            ),
          );
        }
      },
    );
  }

  loadImage() {
    if (imageURL == "" && _imageFile == null) {
      return AssetImage("images/imageSelect.png"); // load defaluld icon
    } else if (_imageFile != null) {
      return AssetImage(_imageFile.path); // load selected image
    } else {
      return NetworkImage(this.babyWeek.imageURL); // load from database
    }
  }
}