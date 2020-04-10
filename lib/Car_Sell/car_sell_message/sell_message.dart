import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mobilyft/Crud_File/crud1.dart';
import 'package:url_launcher/url_launcher.dart';
class sell_msg extends StatefulWidget {
  final String email;
  sell_msg({Key key, this.email}) : super(key: key);
  @override
  _sell_msgState createState() => _sell_msgState();
}

class _sell_msgState extends State<sell_msg> {
  CRUD1 crudobj = new CRUD1();
  QuerySnapshot req, user;
  String requester,namereq,phonereq,car;
   @override
  void initState() {
    crudobj.getData('intrest request').then((result) {
      setState(() {
        req = result;
      });
    });
    crudobj.getData('user').then((result) {
      setState(() {
        user = result;
      });
    });
  }

  int l = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: <Widget>[
          if (req != null)
            for (int i = 0; i < req.documents.length; i++)
             
              Column(
                children: <Widget>[
                  returnintrest(i),
                ],
              ),
          Padding(padding: EdgeInsets.only(top: 250.0)),
          if (req == null)
            Column(
              children: <Widget>[
                Center(child: CircularProgressIndicator()),
              ],
            )
        ],
      ),
    );
  }
   Widget returnintrest(int i) {
    if (req != null) {
      if (widget.email == req.documents[i].data["Emailcr"]) {
        requester = req.documents[i].data["Emailreq"];
        car=req.documents[i].data["Car Company"];
        phonereq = req.documents[i].data["Contact number"];
        if(user != null){
          for(int i=0;i < user.documents.length; i++)
            if(requester == user.documents[i].data["email"])
              namereq=user.documents[i].data["name"];
        }
        return Padding(
            padding: EdgeInsets.all( 2.0),
            child: Card(               
                shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(10.0)),
                child: ListTile(
                  leading: Icon(
                    Icons.account_circle,
                    size: 60.0,
                  ),
                  title: Text(
                      "$namereq""\t""is Intrested to Buy Your""\t" "$car",
                      style: TextStyle(fontSize: 20.0 ,fontWeight: FontWeight.w400),),
                  
                 trailing: IconButton(
                   icon: Icon(Icons.call), 
                   onPressed: ()=>launch("tel:$phonereq")
                   ),
                )));
      } else
        return Container();
    } else {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
  }
}