import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:path/path.dart';
import 'dart:typed_data';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobilyft/Crud_File/crud1.dart';
class profile extends StatefulWidget {
  final String email;
  profile({Key key, this.email}) : super(key: key);
  @override
  _profileState createState() => _profileState();
}

class _profileState extends State<profile> {
  var firstColor = Color(0xff5b86e5), secondColor = Color(0xff36d1dc);
  CRUD1 crudobj = new CRUD1();
  String _email;
  String _password;
  String _phone;
  String _name;
  String _pin;
  final formKey = GlobalKey<FormState>();
  Uint8List imagef;
  StorageReference photoref = FirebaseStorage.instance.ref().child("profile");

  bool validateAndSave() {
    final form = formKey.currentState;
    form.save();
    if (form.validate()) {
      form.save();
      return true;
    } else
      return false;
  }

  QuerySnapshot pro;
  @override
  void initState() {
    int MAX_SIZE = 7 * 1024 * 1024;

    photoref.child("${widget.email}").getData(MAX_SIZE).then((data) {
      this.setState(() {
        imagef = data;
      });
    }).catchError((error) {});
    crudobj.getData('user').then((result) {
      setState(() {
        pro = result;
      });
    });
  }

  File _image;
  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
      print('Image Path $_image');
    });
    uploadPic(context);
  }

  Future uploadPic(context) async {
    String fileName = "profile/" + basename(widget.email);
    StorageReference firebaseStorageRef =
        FirebaseStorage.instance.ref().child(fileName);
    StorageUploadTask uploadTask = firebaseStorageRef.putFile(_image);
    StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
    this.setState(() {
      print("Profile Picture uploaded");
      int MAX_SIZE = 7 * 1024 * 1024;

      photoref.child("${widget.email}").getData(MAX_SIZE).then((data) {
        this.setState(() {
          imagef = data;
        });
      }).catchError((error) {});
    });
  }

  int l = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: <Widget>[
          if (pro != null)
            for (int i = 0; i < pro.documents.length; i++)
              Container(
                child: profilepage(i),
              ),
          Padding(padding: EdgeInsets.only(top: 20.0)),
          if (pro == null)
            Column(
              children: <Widget>[
                Center(child: CircularProgressIndicator()),
              ],
            )
        ],
      ),
    );
  }

  Widget profilepage(int i) {
    if (pro != null) {
      if (widget.email == pro.documents[i].data["email"]) {
        return Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 30.0,left: 30.0),
              child: new Stack(fit: StackFit.loose, children: <Widget>[
                new Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Align(
                      alignment: Alignment.center,
                      child: CircleAvatar(
                        radius: 85,
                        //backgroundColor:,
                        child: ClipOval(
                          child: new SizedBox(
                            width: 170.0,
                            height: 170.0,
                            child: (imagef != null)
                                ? Image.memory(
                                    imagef,
                                    fit: BoxFit.fill,
                                  )
                                : Padding(
                                    padding: EdgeInsets.only(top: 0.0),
                                    child: IconButton(
                                      icon: Icon(
                                        Icons.account_circle,
                                        size: 155.0,
                                      ),
                                      onPressed: () {
                                        //  getImage();
                                      },
                                    ),
                                  ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 60.0),
                      child: IconButton(
                        icon: Icon(
                          FontAwesomeIcons.camera,
                          size: 30.0,
                        ),
                        onPressed: () {
                          getImage();
                        },
                      ),
                    ),
                  ],
                ),
              ]),
            ),
            Padding(
                padding: EdgeInsets.only(left: 55.0, top: 15.0),
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                        padding: EdgeInsets.only(left: 25.0, right: 25.0),
                        child: new Row(
                          children: <Widget>[
                            new Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                new Text(
                                  'Personal Information',
                                  style: TextStyle(
                                      fontSize: 25.0,
                                      fontWeight: FontWeight.w700),
                                ),
                              ],
                            ),
                          ],
                        )),
                  ],
                )),
           
            Padding(
                padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 25.0),
                child: new Row(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    new Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        new Text(
                          'Name',
                          style: TextStyle(
                              fontSize: 25.0, fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                         IconButton(
                           icon: Icon(Icons.edit,size: 20.0,color: Colors.black54,), 
                           onPressed: (){
                            //  updateCarNo(context, pro.documents[i].documentID);
                             } 
                          ),
                      ],
                    ),
                  ],
                )),
            Padding(
                padding: EdgeInsets.only(left: 25.0, right: 25.0),
                child: new Row(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    new Flexible(
                        child: Text(
                      "${pro.documents[i].data["name"]}",
                      style: TextStyle(
                          fontSize: 20.0, fontFamily: 'sans-serif-light'),
                    )),
                  ],
                )),


                Padding(
                padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 25.0),
                child: new Row(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    new Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        new Text(
                          'Email ID',
                          style: TextStyle(
                              fontSize: 25.0, fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                         IconButton(
                           icon: Icon(Icons.edit,size: 20.0,color: Colors.black54,), 
                           onPressed: (){
                            //  updateCarNo(context, pro.documents[i].documentID);
                             } 
                          ),
                      ],
                    ),
                  ],
                )),
            Padding(
                padding: EdgeInsets.only(left: 25.0, right: 25.0),
                child: new Row(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    new Flexible(
                        child: Text(
                      "${pro.documents[i].data["email"]}",
                      style: TextStyle(
                          fontSize: 20.0, fontFamily: 'sans-serif-light'),
                    )),
                  ],
                )),


                Padding(
                padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 25.0),
                child: new Row(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    new Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        new Text(
                          'Mobile',
                          style: TextStyle(
                              fontSize: 25.0, fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                         IconButton(
                           icon: Icon(Icons.edit,size: 20.0,color: Colors.black54,), 
                           onPressed: (){
                            //  updateCarNo(context, pro.documents[i].documentID);
                             } 
                          ),
                      ],
                    ),
                  ],
                )),
            Padding(
                padding: EdgeInsets.only(left: 25.0, right: 25.0),
                child: new Row(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    new Flexible(
                        child: Text(
                      "${pro.documents[i].data["phone"]}",
                      style: TextStyle(
                          fontSize: 20.0, fontFamily: 'sans-serif-light'),
                    )),
                  ],
                )),

                Padding(
                padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 25.0),
                child: new Row(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    new Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        new Text(
                          'Pin Code',
                          style: TextStyle(
                              fontSize: 25.0, fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                         IconButton(
                           icon: Icon(Icons.edit,size: 20.0,color: Colors.black54,), 
                           onPressed: (){
                            //  updateCarNo(context, pro.documents[i].documentID);
                             } 
                          ),
                      ],
                    ),
                  ],
                )),
            Padding(
                padding: EdgeInsets.only(left: 25.0, right: 25.0),
                child: new Row(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    new Flexible(
                        child: Text(
                      "${pro.documents[i].data["pincode"]}",
                      style: TextStyle(
                          fontSize: 20.0, fontFamily: 'sans-serif-light'),
                    )
                  ),
                ],
              ),
            )
          ],
        );
      } else
        return Container();
    } else {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
  }
}