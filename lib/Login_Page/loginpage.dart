import 'dart:io';
import 'package:email_validator/email_validator.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:mobilyft/First_Page/firstpage.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:mobilyft/Crud_File/crud1.dart';
import 'package:mobilyft/choice_page/selection.dart';

void main() {
  runApp(LoginPage());
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

enum FormType { login, register }

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  FirstPageeState ob1 = new FirstPageeState();
  CRUD1 crudobj = new CRUD1();
  final formKey = GlobalKey<FormState>();
  String _pin, lic, rc, model;

  String _email;
  FormType _formType = FormType.login;
  String _name;
  String _password;
  String _phone;
  bool _toggleVisibility = true;
  bool isLoading = true;
  LoginPage ob;

  bool validateAndSave() {
    final form = formKey.currentState;
    form.save();
    if (form.validate()) {
      form.save();
      return true;
    } else {
      setState(() {
        isLoading = true;
      });
      return false;
    }
  }

  void insert1(BuildContext context) {
    print(_email);
    print(_password);
    print(_phone);
    print(_name);
    print(_pin);
    Map<String, dynamic> signupdata = {
      'name': _name,
      'email': _email,
      'pass': _password,
      'phone': _phone,
      'pincode': _pin
    };
    crudobj.addData(signupdata, context).then((result) {}).catchError((e) {
      print(e);
    });
  }

  void submit() async {
    bool temp = true;
    bool v = true;
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('connected');
      }
      if (validateAndSave()) {
        if (_formType == FormType.login) {
          setState(() {
            isLoading = false;
          });
          FirebaseAuth.instance
              .signInWithEmailAndPassword(email: _email, password: _password)
              .then((user) {
            v = false;
            Navigator.pop(context);
            ob1.addStringToSF(_email);
            var route = new MaterialPageRoute(
              // builder: (BuildContext context) =>Home_page(email: _email, ),
              builder: (BuildContext context) => section_page(
                email: _email,
              ),
            );
            Navigator.of(context).push(route);
          }).catchError((e) {
            print("hello");
            setState(() {
              isLoading = true;
            });
            var alertDialog1 = AlertDialog(
              title: Text("Error"),
              content: Text("your email/password is wrong"),
            );
            showDialog(
                context: context,
                builder: (BuildContext context) => alertDialog1);
            print(e);
          });
        } else {
          FirebaseAuth.instance
              .createUserWithEmailAndPassword(
                  email: _email, password: _password)
              .then((user) {
            setState(() {
              insert1(context);
            });
            var alertDialog = AlertDialog(
              title: Text("Account Created Successfully"),
              content: Text("Please Do Login"),
              actions: <Widget>[
                FlatButton(
                    child: new Text("Ok"),
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (BuildContext context) => LoginPage()));
                    },
                  ),
              ],
            );

            showDialog(
                context: context,
                builder: (BuildContext context) => alertDialog);
          }
        );
      }
    }
  } on SocketException catch (_) {
      setState(() {
        isLoading = true;
      });
      var alertDialog = AlertDialog(
        title: Text("Oops,there is no internet connection"),
        content: Text("please switch on mobile data"),
      );

      showDialog(
          context: context, builder: (BuildContext context) => alertDialog);
    }
  }

  void signin() {
    formKey.currentState.reset();
    setState(() {
      _formType = FormType.register;
    });
  }

  void login() {
    formKey.currentState.reset();
    setState(() {
      _formType = FormType.login;
    });
  }

  List<Widget> buildInput() {
    String validateName(String value) {
      if (value.length == 0) {
        return 'Password can\'t be empty!';
      } else {
        if (value.length < 8)
          return 'Password must be more than 7 charater';
        else
          return null;
      }
    }

    String validateEmail(String value) {
      Pattern pattern =
          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
      RegExp regex = new RegExp(pattern);
      if (value.length == 0) {
        return 'Email can\'t be empty!';
      } else {
        if (!regex.hasMatch(value))
          return 'Enter Valid Email';
        else
          return null;
      }
    }

    return [
      Center(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top:30.0),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.15,             
              child:Icon(
                Icons.contact_mail, 
                size: 90.0, 
                color: Colors.blueGrey[700]),
              ),
            )
          ],
        ),
      ),

      Column(
        children: <Widget>[
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.07,             
          child:Center(
            child: RichText(
              text:TextSpan(
                text:'Mobi',
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.w800,
                  color: Colors.black
                ),
                children: <TextSpan>[
                  TextSpan(text: 'Lyft', 
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: Colors.blue,
                    fontSize: 40
                    )
                  )
                ]
              ),
            ),
          )
        )
      ],
    ),

    Padding(padding: EdgeInsets.only(top:10.0)),
     
    SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.109,
      child:Padding(
        padding: EdgeInsets.only(right: 25.0, left: 15.0),
        child: Card(
          color: Colors.blue[50],
          shape: RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(150.0)),
          child: TextFormField(
            style: TextStyle(color: Colors.black, fontSize: 20.0,fontWeight: FontWeight.w400),
            inputFormatters: [LengthLimitingTextInputFormatter(30)],
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              hoverColor: Colors.black,
              focusColor: Colors.black12,
              labelText: ' Email',
              border: InputBorder.none,
              hintText: ' abc@gmail.com',
              hintStyle: TextStyle(color: Colors.black54),
              labelStyle: TextStyle(color: Colors.black, fontSize: 20.0),
              prefixIcon: Padding(
                child: const Icon(
                  Icons.mail,
                  size: 40.0,
                  color: Colors.teal,
                ),
                padding: EdgeInsets.only(left: 30, right: 10),
              ),
            ),
            validator: (value) =>validateEmail(value),      
            onSaved: (value) => _email = value,
          ),
        ),
      ),
    ),

  Padding(padding: EdgeInsets.only(top:10.0)),

    SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.109,
      child: Padding(
        padding: EdgeInsets.only(right: 25.0, left: 15.0),
          child: Card(
            color: Colors.blue[50],
            shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(150.0)),
            child: TextFormField(
              style: TextStyle(color: Colors.black, fontSize: 20.0,fontWeight: FontWeight.w400),
              //maxLength: 15,
              maxLengthEnforced: true,
              decoration: InputDecoration(
                labelText: ' Password',
                hintText: ' *********',
                border: InputBorder.none,
                hintStyle: TextStyle(color: Colors.black54),
                focusColor: Color.fromRGBO(255, 0, 0, 0.8),
                labelStyle: TextStyle(color: Colors.black, fontSize: 20.0),
                prefixIcon: Padding(
                  padding: EdgeInsets.only(left: 30, right: 10),
                  child: const Icon(
                    Icons.vpn_key,
                    size: 40.0,
                    color: Colors.teal,
                  ),
                ),
                suffixIcon: Padding(
                  padding: EdgeInsets.only(left: 10, right: 10, bottom: 0),
                  child: IconButton(
                    onPressed: () {
                      setState(() {
                        _toggleVisibility = !_toggleVisibility;
                      });
                    },
                    icon: _toggleVisibility
                        ? Icon(Icons.visibility_off)
                        : Icon(Icons.visibility),
                  ),
                ),
              ),
              obscureText: _toggleVisibility,
              validator: (value) => validateName(value),
              onSaved: (value) => _password = value,
            ),
          ),
        ),
      ),
    ];
  }

  List<Widget> buildSubmitButton() {
  String validateMobile(String value) {
// Indian Mobile number are of 10 digit only
      if (value.length == 0) {
        return 'Mobile No. can\'t be empty!';
      } else {
        if (value.length != 10)
          return 'Mobile Number must be of 10 digit';
        else
          return null;
      }
    }

    if (_formType == FormType.login) {
      return [
        Padding(
          padding: EdgeInsets.only(top: 15.0, left: 100.0, right: 100.0),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.088,
            color: Colors.transparent,
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.green[400],
                  borderRadius: BorderRadius.circular(50.0)),
              child: InkWell(
                onTap: () {
                  submit();
                },
                child: Center(
                  child: Text('Login',
                      style: TextStyle(
                          fontSize: 25.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Montserrat')),
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 20.0),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'New to MobiLyft ?',
              style: TextStyle(
                  color: Colors.blueGrey[700],
                  fontSize: 19.0,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w400
                ),
            ),
            //SizedBox(width: 5.0),
            Padding(
              padding: EdgeInsets.only(top: 15.0),
            ),
            InkWell(
                onTap: () {
                  signin();
                },
                child: Text(
                  '  Register',
                  style: TextStyle(
                    color: Colors.deepOrange[300],
                    fontSize: 18.0,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w900,
                    //decoration: TextDecoration.underline
                  ),
                )
              )
            ],
          ),
        ];
      } else {
      return [

       Padding(padding: EdgeInsets.only(top:10.0)),
        
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.109,
            child: Padding(
            padding: EdgeInsets.only(right: 25.0, left: 15.0),
            child: Card(
              color: Colors.blue[50],
              shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(150.0)),
              child: TextFormField(
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  labelText: ' Name',
                  hintText: ' john',
                  focusColor: Color.fromRGBO(100, 50, 100, 0.8),
                  border: InputBorder.none,
                  hintStyle: TextStyle(color: Colors.black54),
                  labelStyle: TextStyle(color: Colors.black, fontSize: 20.0,fontWeight: FontWeight.w400),
                  prefixIcon: Padding(
                    padding: EdgeInsets.only(left: 30, right: 10),
                    child: const Icon(
                      Icons.person,
                      size: 40.0,
                      color: Colors.teal,
                    ),
                  ),
                ),
                keyboardType: TextInputType.text,
                validator: (value) =>
                    value.isEmpty ? "Name can't be empty" : null,
                onChanged: (value) => _name = value,
              ),
            ),
          ),
        ),
      
       Padding(padding: EdgeInsets.only(top:10.0)),

        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.109,
            child: Padding(
            padding: EdgeInsets.only(right: 25.0, left: 15.0),
            child: Card(
              color: Colors.blue[50],
              shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(150.0)),
              child: TextFormField(
               // controller: TextEditingController(), 
                inputFormatters: [MaskTextInputFormatter(
                  mask: "##########", 
                  filter: { "#": RegExp(r'[0-9]') 
                  })],
                style: TextStyle(color: Colors.black),               
                decoration: InputDecoration(                 
                  labelText: ' Phone',
                  hintText: ' 9845388000',
                  border: InputBorder.none,
                  focusColor: Color.fromRGBO(100, 50, 100, 0.8),
                  hintStyle: TextStyle(color: Colors.black54),
                  labelStyle: TextStyle(color: Colors.black, fontSize: 20.0,fontWeight: FontWeight.w400),
                  prefixIcon: Padding(
                    padding: EdgeInsets.only(left: 30, right: 10),
                    child: const Icon(Icons.phone_iphone,
                        size: 40.0, color: Colors.teal),
                  ),
                ),
                keyboardType: TextInputType.number,
                validator: (value) => validateMobile(value),
                onSaved: (value) => _phone = value,
              ),
            ),
          ),
        ),

        Padding(padding: EdgeInsets.only(top:10.0)),

        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.109,
          child: Padding(
            padding: EdgeInsets.only(left: 15.0, right: 25),
            child: Card(
              color: Colors.blue[50],
              shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(150.0)),
              child: TextFormField(
               // controller: TextEditingController(), 
                inputFormatters: [MaskTextInputFormatter(
                  mask: "######", 
                  filter: { "#": RegExp(r'[0-9]') 
                  })],
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  labelText: ' Pincode',
                  hintText: ' 300396',
                  focusColor: Color.fromRGBO(100, 50, 100, 0.8),
                  hintStyle: TextStyle(color: Colors.black54),
                  border: InputBorder.none,
                  labelStyle: TextStyle(color: Colors.black, fontSize: 20.0,fontWeight: FontWeight.w400),
                  prefixIcon: Padding(
                    padding: EdgeInsets.only(left: 30, right: 10),
                    child: const Icon(
                      Icons.person_pin_circle,
                      size: 40.0,
                      color: Colors.teal,
                    ),
                  ),
                ),
                keyboardType: TextInputType.number,
                validator: (value) =>
                    value.isEmpty ? "Pincode can't be empty" : null,
                onSaved: (value) => _pin = value,
              ),
            ),
          ),
        ),

        Padding(padding: EdgeInsets.only(top:10.0)),

        Padding(
          padding: EdgeInsets.only(top: 15.0, left: 100.0, right: 100.0),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.085,
            color: Colors.transparent,
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.yellow[700],
                  borderRadius: BorderRadius.circular(50.0)),
              child: InkWell(
                onTap: () {
                  submit();
                },
                child: Center(
                  child: Text('SignUp',
                      style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Montserrat')),
                ),
              ),
            ),
          ),
        ),

        Padding(
          padding: EdgeInsets.only(top: 10.0),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Have an Account?',
              style: TextStyle(
                  color: Colors.blueGrey[700],
                  fontFamily: 'Montserrat',
                  fontSize: 20.0,
                  fontWeight: FontWeight.w400
                  ),
            ),
            SizedBox(width: 5.0),
            InkWell(
                onTap: () {
                  login();
                },
                child: Text(
                  'Login',
                  style: TextStyle(
                    color: Colors.red[400],
                    fontFamily: 'Montserrat',
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600,
                    //decoration: TextDecoration.underline
                  ),
                )),
          ],
        ),
        Padding(
          padding: EdgeInsets.only(top: 50.0),
        ),
      ];
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
          child: Scaffold(
          resizeToAvoidBottomPadding: false,
          body: ListView(
            children: <Widget>[
              Form(
                key: formKey,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: buildInput() + buildSubmitButton()),
              ),
            ],
          )),
    );
  }
}
