import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:homescreen/values/values.dart';
import 'package:homescreen/widgets/potbelly_button.dart';
import 'package:homescreen/widgets/spaces.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'LoginScreen.dart';
import 'dart:async';
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  var divWidth;
  bool _autoValidate = false;
  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  final TextEditingController _firstNameTextController =
      new TextEditingController();
  final TextEditingController _lastNameTextController =
      new TextEditingController();
  final TextEditingController _phoneTextController =
      new TextEditingController();
  final TextEditingController _passwordTextController =
      new TextEditingController();
  final TextEditingController _emailTextController =
      new TextEditingController();
  final TextEditingController _ilTextController =
    new TextEditingController();
  final TextEditingController _dogumTextController =
    new TextEditingController();

  var kMarginPadding = 16.0;
  var kFontSize = 13.0;
  String url ="https://www.easyrescuer.com/yenikayit.php";



    void addData() async{
      var response = await http.post(Uri.parse(url),
          body: {
            "email": _emailTextController.text.trim(),
            "isim": _firstNameTextController.text.trim(),
            "soyisim": _lastNameTextController.text.trim(),
            "dogumyili": _dogumTextController.text.trim(),
            "tel": _phoneTextController.text.trim(),
            "il": _ilTextController.text.trim(),
            "password": _passwordTextController.text.trim(),
          }
      );
      var jsonData = jsonDecode(response.body);
      var jsonString = jsonData['message'];
      // obtain shared preferences
      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.setString(_ilTextController.text, _ilTextController.text);
      var dogumyili = jsonData['dogumyili'];
      if(jsonString=='Ba??ar??yla kay??t oldunuz!!'){
        print(dogumyili);
        Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context) => LoginScreen()));
        myToast(jsonString);
        //You can route to your desire page here

      }else{
        myToast(jsonString);
      }
    }


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    divWidth = MediaQuery.of(context).size.width;
    return Container(
      child: Scaffold(
        backgroundColor: Colors.purple,
        // home: Image.asset('assets/bg.jpg'),

        //backgroundColor: Colors.white,
        body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/backg.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: Center(
              child: SingleChildScrollView(
                child: Form(
                    key: _formKey,
                    autovalidate: _autoValidate,
                    child: Column(
                      children: <Widget>[_buildEmailSignUpForm()],
                    )),
              ),
            )),
      ),
    );
  }

  Widget _buildEmailSignUpForm() {
    //Form 1
    return new Column(
      children: <Widget>[
        new Container(
            /*decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/backg.png"),
              fit: BoxFit.cover,
            ),
          ),*/
            ),
        new Container(
          child: new Container(),
        ),
        new Container(
            padding: EdgeInsets.only(bottom: 5,top: 60),
            margin: EdgeInsets.only(
                top: 0.0, left: kMarginPadding, right: kMarginPadding),
            child: new Text(
              "HESAP OLU??TUR ",
              style: Styles.customTitleTextStyle(
                  color: Colors.white70, fontSize: 30),
              maxLines: 1,
            )),
   SpaceH8(),
        new Container(
          height: 65,
          width: 250,
          padding: EdgeInsets.only(
            left: 10,
            right: 50,
          ),
          margin: EdgeInsets.only(left: 10.0, right: 10.0),
          decoration: BoxDecoration(
            color: Color.fromRGBO(255, 255, 255, 0.3),
            borderRadius: BorderRadius.circular(12),
          ),
          child: new TextFormField(
            style: Styles.normalTextStyle,
            controller: _firstNameTextController,
            validator: _validateFields,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.account_box),
              // labelText: "Ad??n??z*",
              hintText: "Ad??n??z",
              hintStyle: Styles.customNormalTextStyle(fontSize: 13),
              labelStyle: Styles.customNormalTextStyle(fontSize: 16),
            ),
          ),
        ),
        SpaceH16(),
        new Container(
          height: 65,
          width: 250,
          decoration: BoxDecoration(
            color: Color.fromRGBO(255, 255, 255, 0.3),
            borderRadius: BorderRadius.circular(10),
          ),
          padding: EdgeInsets.only(
            left: 10,
            right: 50,
          ),
          margin: EdgeInsets.only(left: 10.0, right: 10.0),
          child: new TextFormField(
              style: Styles.normalTextStyle,
              controller: _lastNameTextController,
              validator: _validateFields,
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.account_box),
                  //labelText: "Soyad??n??z*",
                  hintText: "Soyad??n??z",
                  hintStyle: Styles.customNormalTextStyle(fontSize: 13),
                  labelStyle: Styles.customNormalTextStyle(fontSize: 16))),
        ),
        SpaceH16(),
        new Container(
          height: 65,
          width: 250,
          decoration: BoxDecoration(
            color: Color.fromRGBO(255, 255, 255, 0.3),
            borderRadius: BorderRadius.circular(10),
          ),
          padding: EdgeInsets.only(left: 10, right: 50),
          margin: EdgeInsets.only(left: 10.0, right: 10.0),
          child: new TextFormField(
              style: Styles.normalTextStyle,
              controller: _phoneTextController,
              inputFormatters: [
                new BlacklistingTextInputFormatter(new RegExp('[\\.|\\,|\\-]')),
              ],
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value.length == 0) {
                  return "L??tfen telefon numaran??z?? girin.";
                } else {
                  return null;
                }
              },
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.phone),
                  //  labelText: "Telefon Numaran??z",
                  hintStyle: Styles.customNormalTextStyle(fontSize: 13),
                  hintText: "Numaran??z?? girin",
                  labelStyle: Styles.customNormalTextStyle(
                    fontSize: 16,
                  ))),
        ),
        SpaceH16(),
        new Container(
          height: 65,
          width: 250,
          decoration: BoxDecoration(
            boxShadow: [Shadows.primaryShadow],
            color: Color.fromRGBO(255, 255, 255, 0.3),
            borderRadius: BorderRadius.circular(10),
          ),
          padding: EdgeInsets.only(
            left: 10,
            right: 50,
          ),
          margin: EdgeInsets.only(left: 10.0, right: 10.0),
          child: 
    new TextFormField(
            style: Styles.normalTextStyle,
            controller: _ilTextController,
            validator: _validateFields,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.add_location),
              //  labelText: "E-posta*",
              hintText: '??l',
              hintStyle: Styles.customNormalTextStyle(
                  fontSize: 13, color: Colors.white),
              labelStyle: Styles.customNormalTextStyle(fontSize: 16),
            ),
          ),
        ),  
        SpaceH16(),
        new Container(
          height: 65,
          width: 250,
          decoration: BoxDecoration(
            boxShadow: [Shadows.primaryShadow],
            color: Color.fromRGBO(255, 255, 255, 0.3),
            borderRadius: BorderRadius.circular(10),
          ),
          padding: EdgeInsets.only(
            left: 10,
            right: 50,
          ),
          margin: EdgeInsets.only(left: 10.0, right: 10.0),
          child: new TextFormField(
            style: Styles.normalTextStyle,
            controller: _emailTextController,
            validator: _validateEmail,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.email_outlined),
              //  labelText: "E-posta*",
              hintText: 'E-posta',
              hintStyle: Styles.customNormalTextStyle(
                  fontSize: 13, color: Colors.white),
              labelStyle: Styles.customNormalTextStyle(fontSize: 16),
            ),
          ),
        ),
        SpaceH16(),
        new Container(
          height: 65,
          width: 250,
          decoration: BoxDecoration(
            boxShadow: [Shadows.primaryShadow],
            color: Color.fromRGBO(255, 255, 255, 0.3),
            borderRadius: BorderRadius.circular(10),
          ),
          padding: EdgeInsets.only(
            left: 10,
            right: 50,
          ),
          margin: EdgeInsets.only(left: 10.0, right: 10.0),
          child: new TextFormField(
            controller: _dogumTextController,
            style: Styles.normalTextStyle,
            validator: _validateFields,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.date_range_outlined),
              //  labelText: "E-posta*",
              hintText: 'Do??um y??l??n??z',
              hintStyle: Styles.customNormalTextStyle(
                  fontSize: 13, color: Colors.white),
              labelStyle: Styles.customNormalTextStyle(fontSize: 16),
            ),
          ),
        ),
        SpaceH16(),
        new Container(
          height: 65,
          width: 250,
          decoration: BoxDecoration(
            color: Color.fromRGBO(255, 255, 255, 0.3),
            borderRadius: BorderRadius.circular(10),
          ),
          padding: EdgeInsets.only(
            left: 10,
            right: 50,
          ),
          margin: EdgeInsets.only(left: 10.0, right: 10.0),
          child: new TextFormField(
              style: Styles.customNormalTextStyle(),
              obscureText: true,
              controller: _passwordTextController,
              validator: (value) {
                if (value.length == 0) {
                  return "??ifre ge??ersiz";
                } else if (value.length < 8) {
                  return "En az 8 karakter";
                } else {
                  return null;
                }
              },
              decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.lock,
                    size: 20,
                  ),
                  //  labelText: "Password*",
                  hintStyle: Styles.customNormalTextStyle(fontSize: 13),
                  hintText: "??ifre olu??tur",
                  labelStyle: Styles.customNormalTextStyle(fontSize: 16))),
        ),
        SpaceH16(),
        new PotbellyButton(
          StringConst.REGISTER,
          onTap: () => _signUpButtonTaped(),
        ),
        TextButton(
            onPressed: () {
              print("TextButton");
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => LoginScreen()));
            },
            child: Text("Hesab??n??z varsa giri?? yap??n.")),
      ],
    );
  }

  //onPressed: () => _signUpButtonTaped(),
  String _validateFields(String text) {
    if (text.length == 0) {
      return "Bo?? kalmamal??";
    } else {
      return null;
    }
  }

  _signUpButtonTaped() {
    FocusScope.of(context).requestFocus(new FocusNode());
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      //sign up user..
      addData();
    } else {
      setState(() {
        _autoValidate = true;
      });
    }
  }
}

String _validateEmail(String email) {
  Pattern pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regex = new RegExp(pattern);
  if (regex.hasMatch(email))
    return null;
  else
    return "Ge??erli bir e-posta girin";
}
