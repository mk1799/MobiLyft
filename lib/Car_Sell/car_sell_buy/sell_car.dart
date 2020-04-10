import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:mobilyft/Car_Sell/car_sell_dashboard/current_ads.dart';
import 'package:mobilyft/Car_Sell/car_sell_home.dart';
import 'package:mobilyft/Crud_File/crud1.dart';
import 'package:nice_button/NiceButton.dart';
import 'package:simple_autocomplete_formfield/simple_autocomplete_formfield.dart';
class car_sell extends StatefulWidget {
  final String email;
  car_sell({Key key, this.email}) : super(key: key);
  @override
  _car_sellState createState() => _car_sellState();
}
class _car_sellState extends State<car_sell> {
  var firstColor = Color(0xff5b86e5), secondColor = Color(0xff36d1dc);
  String carnum,caruse,carprice,pernum,peradd;
  Years selectedyear;
  Company selectedcompany;
  Model selectedmodel;
  Fuel selectedfuel;
  Gear selectedgear;
  Col selectedcolor;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();
  bool autovalidate = false;
  CRUD1 crudobj = new CRUD1(); 
  DateTime now = DateTime.now();
  DateTime ti;//=null;
  String _time = "Not Set";
  String formattedDate = DateFormat.yMMMMd("en_US").format(DateTime.now());
  Future<bool> alert(BuildContext context) async {
      return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Center(              
              child: Text(
                "Select Time First!!",
                style: TextStyle(
                  fontSize: 22.0,
                  color: Colors.grey[700],
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
        }
      );
   }
  bool validateAndSave() {

    final form = formKey.currentState;
    form.save();
    if (form.validate()) {
      form.save();
      return true;
    } else
      return false;
  }
  void insert(BuildContext context) {
    
    Map<String, dynamic> data = {
      'email': widget.email,
      'car Registration Year': selectedyear.toString(),
      'car Manufacturer Company': selectedcompany.toString(),
      'car Model': selectedmodel.toString(),
      'car fuel type':selectedfuel.toString(),
      'car gear type':selectedgear.toString(),
      'car color':selectedcolor.toString(),
      'km of use':caruse,
      'car price':carprice,
      'car number':carnum,
      'Contact number':pernum,
      'Address person':peradd,       
    };
    Map<String, dynamic> noti = {
      'email': widget.email,
      // 'notice': "Your Ride From ${selectedpickup.toString()} To ${selecteddest.toString()} Is Added Successfully!",  
      'detail' : "Get Ready For Ride\n${formattedDate}""   ""${now.hour}:${now.minute}",
    };
    crudobj.adddata(data, context,"sell car").then((result) {}).catchError((e) {
      print(e);
      }
    );
    crudobj.adddata(noti, context,"notify").then((result) {}).catchError((e) {
      print(e);
      }
    );    
  }
  
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key:scaffoldKey,
        body: ListView(
          children: <Widget>[
            Form(
              key: formKey,
              autovalidate: autovalidate,
              child: Column(
                children: <Widget>[
                
                Padding(
                  padding: EdgeInsets.only(top:10.0),
                  child:SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height*0.11,
                    child: Icon(Icons.directions_car,
                      size: 80.0,
                      color: Colors.blue[700],
                    ),
                  ),
                ),

                Padding(padding: EdgeInsets.only(top:5.0),
                  child:SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.07,             
                    child:Center(
                      child: RichText(
                        text:TextSpan(
                          text:'Car',
                          style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.w800,
                            color: Colors.black
                          ),
                          children: <TextSpan>[
                            TextSpan(text: ' Detail', 
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
                  ),
                ),

                Padding(
                  padding: EdgeInsets.only(top: 10.0, left: 15.0, right: 10.0),
                  child: Card(
                    color: Colors.white,
                    child: SimpleAutocompleteFormField<Years>(
                      suggestionsHeight: 80.0,
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w300
                      ),
                      decoration: InputDecoration(
                        labelText: 'Registration Year',
                        focusColor: Color.fromRGBO(100, 50, 100, 0.8),
                        border: OutlineInputBorder(),
                        labelStyle: TextStyle(
                          color: Colors.grey[900], 
                          fontSize: 20.0,
                          fontWeight: FontWeight.w400
                        ),            
                      ),
                      controller: TextEditingController(),
                      itemBuilder: (context, years) => Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(years.name,
                              style: TextStyle(
                                fontWeight: FontWeight.bold
                              )
                            ),
                          ]
                        ),
                      ),
                      onSearch: (search) async => years
                      .where((years) =>years.name.toLowerCase().contains(search.toLowerCase())).toList(),                      
                      itemFromString: (string) => years.singleWhere(
                        (years) => years.name.toLowerCase() == string.toLowerCase(),
                        orElse: () => null),
                      // onChanged: (value) => setState(() => selectedpickup = value),
                      onSaved: (value) => setState(() => selectedyear = value),
                      validator: (years) => years == null ? 'Invalid Pick-up Point.' : null,           
                    ),
                  ),
                ),

                Padding(
                  padding: EdgeInsets.only(top: 10.0, left: 15.0, right: 10.0),
                  child: Card(
                    color: Colors.white,
                    child: SimpleAutocompleteFormField<Company>(
                      suggestionsHeight: 80.0,
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w300
                      ),
                      decoration: InputDecoration(
                        labelText: 'Manufacture Comapany',
                        focusColor: Color.fromRGBO(100, 50, 100, 0.8),
                        border: OutlineInputBorder(),
                        labelStyle: TextStyle(
                          color: Colors.grey[900], 
                          fontSize: 20.0,
                          fontWeight: FontWeight.w400
                        ),            
                      ),
                      controller: TextEditingController(),
                      itemBuilder: (context, company) => Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(company.name,
                              style: TextStyle(
                                fontWeight: FontWeight.bold
                              )
                            ),
                          ]
                        ),
                      ),
                      onSearch: (search) async => company
                      .where((company) =>company.name.toLowerCase().contains(search.toLowerCase())).toList(),                      
                      itemFromString: (string) => company.singleWhere(
                        (company) => company.name.toLowerCase() == string.toLowerCase(),
                        orElse: () => null),
                      // onChanged: (value) => setState(() => selectedpickup = value),
                      onSaved: (value) => setState(() => selectedcompany = value),
                      validator: (company) => company == null ? 'Invalid Company Name.' : null,           
                    ),
                  ),
                ),


                Padding(
                  padding: EdgeInsets.only(top: 10.0, left: 15.0, right: 10.0),
                  child: Card(
                    color: Colors.white,
                    child: SimpleAutocompleteFormField<Model>(
                      suggestionsHeight: 80.0,
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w300
                      ),
                      decoration: InputDecoration(
                        labelText: 'Model',
                        focusColor: Color.fromRGBO(100, 50, 100, 0.8),
                        border: OutlineInputBorder(),
                        labelStyle: TextStyle(
                          color: Colors.grey[900], 
                          fontSize: 20.0,
                          fontWeight: FontWeight.w400
                        ),            
                      ),
                      controller: TextEditingController(),
                      itemBuilder: (context, model) => Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(model.name,
                              style: TextStyle(
                                fontWeight: FontWeight.bold
                              )
                            ),
                          ]
                        ),
                      ),
                      onSearch: (search) async => model
                      .where((model) =>model.name.toLowerCase().contains(search.toLowerCase())).toList(),                      
                      itemFromString: (string) => model.singleWhere(
                        (model) => model.name.toLowerCase() == string.toLowerCase(),
                        orElse: () => null),
                      // onChanged: (value) => setState(() => selectedpickup = value),
                      onSaved: (value) => setState(() => selectedmodel = value),
                      validator: (model) => model == null ? 'Invalid Model.' : null,           
                    ),
                  ),
                ),

                Padding(
                  padding: EdgeInsets.only(top: 10.0, left: 15.0, right: 10.0),
                  child: Card(
                    color: Colors.white,
                    child: SimpleAutocompleteFormField<Fuel>(
                      suggestionsHeight: 80.0,
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w300
                      ),
                      decoration: InputDecoration(
                        labelText: 'Fuel Type',
                        focusColor: Color.fromRGBO(100, 50, 100, 0.8),
                        border: OutlineInputBorder(),
                        labelStyle: TextStyle(
                          color: Colors.grey[900], 
                          fontSize: 20.0,
                          fontWeight: FontWeight.w400
                        ),            
                      ),
                      controller: TextEditingController(),
                      itemBuilder: (context, fuel) => Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(fuel.name,
                              style: TextStyle(
                                fontWeight: FontWeight.bold
                              )
                            ),
                          ]
                        ),
                      ),
                      onSearch: (search) async => fuel
                      .where((fuel) =>fuel.name.toLowerCase().contains(search.toLowerCase())).toList(),                      
                      itemFromString: (string) => fuel.singleWhere(
                        (fuel) => fuel.name.toLowerCase() == string.toLowerCase(),
                        orElse: () => null),
                      // onChanged: (value) => setState(() => selectedpickup = value),
                      onSaved: (value) => setState(() => selectedfuel = value),
                      validator: (fuel) => fuel == null ? 'Invalid Fuel Type.' : null,           
                    ),
                  ),
                ),

                Padding(
                  padding: EdgeInsets.only(top: 10.0, left: 15.0, right: 10.0),
                  child: Card(
                    color: Colors.white,
                    child: SimpleAutocompleteFormField<Gear>(
                      suggestionsHeight: 80.0,
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w300
                      ),
                      decoration: InputDecoration(
                        labelText: 'Gear Type',
                        focusColor: Color.fromRGBO(100, 50, 100, 0.8),
                        border: OutlineInputBorder(),
                        labelStyle: TextStyle(
                          color: Colors.grey[900], 
                          fontSize: 20.0,
                          fontWeight: FontWeight.w400
                        ),            
                      ),
                      controller: TextEditingController(),
                      itemBuilder: (context, gear) => Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(gear.name,
                              style: TextStyle(
                                fontWeight: FontWeight.bold
                              )
                            ),
                          ]
                        ),
                      ),
                      onSearch: (search) async => gear
                      .where((gear) =>gear.name.toLowerCase().contains(search.toLowerCase())).toList(),                      
                      itemFromString: (string) => gear.singleWhere(
                        (gear) => gear.name.toLowerCase() == string.toLowerCase(),
                        orElse: () => null),
                      // onChanged: (value) => setState(() => selectedpickup = value),
                      onSaved: (value) => setState(() => selectedgear = value),
                      validator: (gear) => gear == null ? 'Invalid Gear Type.' : null,           
                    ),
                  ),
                ),

                Padding(
                  padding: EdgeInsets.only(top: 10.0, left: 15.0, right: 10.0),
                  child: Card(
                    color: Colors.white,
                    child: SimpleAutocompleteFormField<Col>(
                      suggestionsHeight: 80.0,
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w300
                      ),
                      decoration: InputDecoration(
                        labelText: 'Color',
                        focusColor: Color.fromRGBO(100, 50, 100, 0.8),
                        border: OutlineInputBorder(),
                        labelStyle: TextStyle(
                          color: Colors.grey[900], 
                          fontSize: 20.0,
                          fontWeight: FontWeight.w400
                        ),            
                      ),
                      controller: TextEditingController(),
                      itemBuilder: (context, col) => Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(col.name,
                              style: TextStyle(
                                fontWeight: FontWeight.bold
                              )
                            ),
                          ]
                        ),
                      ),
                      onSearch: (search) async => col
                      .where((col) =>col.name.toLowerCase().contains(search.toLowerCase())).toList(),                      
                      itemFromString: (string) => col.singleWhere(
                        (col) => col.name.toLowerCase() == string.toLowerCase(),
                        orElse: () => null),
                      // onChanged: (value) => setState(() => selectedpickup = value),
                      onSaved: (value) => setState(() => selectedcolor = value),
                      validator: (col) => col == null ? 'Invalid Color.' : null,           
                    ),
                  ),
                ),


                Padding(padding: EdgeInsets.only(top:10.0,left:15.0,right:15.0),
                  child: Card(
                    child:TextFormField(
                          style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w300
                        ),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Use',
                            labelStyle:
                              TextStyle(color: Colors.grey[900],  fontSize: 20.0,fontWeight: FontWeight.w400),
                              hintText: '100kM'
                              ),
                          validator: (value) =>
                            value.isEmpty ? "Use can't be empty" : null,
                          onChanged: (value) {
                            this.caruse = value;
                          },
                        )
                      )
                ),

                Padding(padding: EdgeInsets.only(top:10.0,left:15.0,right:15.0),
                  child: Card(
                    child:TextFormField(
                          style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w300
                        ),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Price',
                            labelStyle:
                              TextStyle(color: Colors.grey[900],  fontSize: 20.0,fontWeight: FontWeight.w400),
                              hintText: '1.5Lakh'
                              ),
                          validator: (value) =>
                            value.isEmpty ? "Price can't be empty" : null,
                          onChanged: (value) {
                            this.carprice = value;
                          },
                        )
                      )
                ),



                Padding(padding: EdgeInsets.only(top:10.0,left:15.0,right:15.0),
                  child: Card(
                    child:TextFormField(
                          style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w300
                        ),
                          controller: TextEditingController(),
                          textCapitalization: TextCapitalization.characters, 
                          inputFormatters: [MaskTextInputFormatter(
                            mask: "## ** ## ****", 
                            filter: { "#": RegExp(r'[A-Z]') , "*":RegExp(r'[0-9]')})],
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Car Number',
                            labelStyle:
                              TextStyle(color: Colors.grey[900],  fontSize: 20.0,fontWeight: FontWeight.w400),
                              hintText: 'GJ 05 AA 1111'
                              ),
                          validator: (value) =>
                            value.isEmpty ? "Car Number can't be empty" : null,
                          onChanged: (value) {
                            this.carnum = value;
                          },
                        )
                      )
                  ),

                  Padding(padding: EdgeInsets.only(top:10.0,left:15.0,right:15.0),
                  child: Card(
                    child:TextFormField(
                          style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w300
                        ),
                          controller: TextEditingController(),
                          keyboardType: TextInputType.number, 
                          inputFormatters: [MaskTextInputFormatter(
                            mask: "**********", 
                            filter: { "*":RegExp(r'[0-9]')})],
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Phone Number',
                            labelStyle:
                              TextStyle(color: Colors.grey[900],  fontSize: 20.0,fontWeight: FontWeight.w400),
                              hintText: '8899900000'
                              ),
                          validator: (value) =>
                            value.isEmpty ? "Phone Number can't be empty" : null,
                          onChanged: (value) {
                            this.pernum = value;
                          },
                        )
                      )
                  ),

                  Padding(padding: EdgeInsets.only(top:10.0,left:15.0,right:15.0),
                  child: Card(
                    child:TextFormField(
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.w300
                          ),
                          keyboardType: TextInputType.multiline,
                          maxLines: 3,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Current Address',                           
                            labelStyle:
                              TextStyle(color: Colors.grey[900],  fontSize: 20.0,fontWeight: FontWeight.w400),
                              hintText: '100,Adajan,Surat'
                              ),
                          validator: (value) =>
                            value.isEmpty ? "Current Address can't be empty" : null,
                          onChanged: (value) {
                            this.peradd = value;
                          },
                        )
                      )
                  ),

                
                  Padding(padding: EdgeInsets.only(top:20.0)),
                  SizedBox(
                    // width: MediaQuery.of(context).size.width*0.1,
                    // height: MediaQuery.of(context).size.height * 0.100,
                      child:NiceButton(
                        text: 'Add',
                        gradientColors: [secondColor, firstColor],
                        background: null,
                        fontSize: 30,
                        onPressed: () {
                          if (validateAndSave()) {
                            if(ti == null){
                              print("not complete!!");
                              alert(context);
                            }
                            insert(context);
                            Navigator.pop(context);
                            Navigator.pop(context);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) =>
                                car_ads(email: widget.email)
                              )
                            );
                            setState(() => autovalidate = true);                   
                          }
                        }
                      )               
                    )                            
                ]
              )
            )
          ]
        )
      )
    );
  }
  final years = <Years>[
    Years('2000'),Years('2001'),Years('2002'),Years('2003'),Years('2004'),Years('2005'),Years('2006'),Years('2007'),Years('2008'),
    Years('2009'),Years('2010'),Years('2011'),Years('2012'),Years('2013'),Years('2014'),Years('2015'),Years('2016'),Years('2017'),
    Years('2019'),Years('2020'), 
  ];

  final company=<Company>[Company('Audi'),Company('BMW'),Company('Datsun'),Company('Fiat'),Company('Ford'),Company('Honda'),Company('Hyundai'),
  Company('Jeep'),Company('Mahindra'),Company('Maruti-Suzuki'),Company('Nissan'),Company('Renault'),Company('Skoda'),Company('Tata'),
  Company('Toyota'),Company('Volvo'),Company('VolksWagen')];

  final model=<Model>[Model('Audi A3'),Model('Audi A3 Cabriolet'),Model('Audi A4'),Model('Audi A5'),Model('Audi A5 Cabriolet'),Model('Audi A6'),
  Model('Audi A8L'),Model('Audi Q3'),Model('Audi Q5'),Model('Audi Q7'),Model('Audi Q8'),Model('Audi RS5'),Model('Audi RS7 SportBack'), 
  Model('BMW 3 Series'),Model('BMW 3 Series GT'),Model('BMW 5 Series'),Model('BMW 6 Series GT'),Model('BMW 7 Series'),
  Model('BMW M2'),Model('BMW M5'),Model('BMW X1'),Model('BMW X3'),Model('BMW X5'),Model('BMW X6'),Model('BMW Z4'),Model('Datsun Go'),
  Model('Datsun Go Plus'),Model('Datsun Redi-Go X Facelift'),Model('Fiat Abarth Punto'),Model('Fiat Avventara'),Model('Fiat Linea'),
  Model('Fiat Linea Classic'),Model('Fiat Panto Evo'),Model('Fiat Urban Cross'),Model('Ford Aspire'),Model('Ford EcoSport'),
  Model('Ford Endeavour'),Model('Ford FreeStyle'),Model('Ford Figo'),Model('Ford Mustang'),Model('Honda Accord'),Model('Honda Amaze'),
  Model('Honda City'),Model('Honda Civic'),Model('Honda CR-V'),Model('Honda Jazz'),Model('Hyundai Auro'),Model('Hyundai Creta'),
  Model('Hyundai Elantra'),Model('Hyundai Elite i20'),Model('Hyundai Grand i10'),Model('Hyundai Kona Electric'),Model('Hyundai Santro'),
  Model('Hyundai Venue'),Model('Hyundai Verna'),Model('Jeep Compass'),Model('Jeep Grand Cherokee'),Model('Jeep Wrangler'),
  Model('Mahindra Alturas G4'),Model('Mahindra Bolero'),Model('Mahindra E20 Plus'),Model('Mahindra Marazzo'),Model('Mahindra Kuv100 NXT'),
  Model('Mahindra Thar'),Model('Mahindra Tuv300'),Model('Mahindra Tuv300 Plus'),Model('Mahindra Scorpio'),Model('Mahindra Verito'),
  Model('Mahindra Verito Vibe CS'),Model('Mahindra XUV300'),Model('Mahindra XUV500'), Model('Maruti-Suzuki Alto'),Model('Maruti-Suzuki Alto K10'),
  Model('Maruti-Suzuki Baleno'),Model('Maruti-Suzuki Ciaz'),Model('Maruti-Suzuki Celerio X'),Model('Maruti-Suzuki Dzire'),
  Model('Maruti-Suzuki Eeco'),Model('Maruti-Suzuki Ertiga'),Model('Maruti-Suzuki Lgnis'),Model('Maruti-Suzuki S-Cross'),
  Model('Maruti-Suzuki Swift'),Model('Maruti-Suzuki S-Presso'),Model('Maruti-Suzuki Wagon R'),Model('Maruti-Suzuki XL6'),Model('Nissan GT-R'),
  Model('Nissan Kick'),Model('Nissan Micra'),Model('Nissan Micra Active'),Model('Nissan Sunny'),Model('Nissan Terrano'),Model('Renault Captur'),
  Model('Renault Duster'),Model('Renault Kwid'),Model('Renault Lodgy'),Model('Renault Triber'),Model('Skoda Kodiaq'),Model('Skoda Octavia'),
  Model('Skoda Superb'),Model('Skoda Rapid'),Model('Tata Altroz'),Model('Tata Bolt'),Model('Tata Harrier'),Model('Tata Nano'),
  Model('Tata Nano Genx'),Model('Tata Nexon'),Model('Tata Safari Storme'),Model('Tata Tiago'),Model('Tata Tirgo'),Model('Tata Tirgo JTP'),
  Model('Toyota Camry'),Model('Toyota Corolla Altis'),Model('Toyota Etios Liva'),Model('Toyota Etios Cross'),Model('Toyota Fortuner'),
  Model('Toyota Lnnova Crysta'),Model('Toyota Vellfire'),Model('Toyota Yaris'),Model('Volvo S90'),Model('Volvo V90 Cross Country'),
  Model('Volvo XC40'),Model('Volvo XC60'),Model('Volvo XC90'),Model('VolksWagen Ameo'),Model('VolksWagen Tiguan'),Model('VolksWagen T-Roc'),
  Model('VolksWagen Polo'),Model('VolksWagen Vento'), ];

  final fuel=<Fuel>[Fuel("CNG"),Fuel("Diesel"),Fuel("Petrol")];

  final gear=<Gear>[Gear("Auto"),Gear("Manual")];

  final col=<Col>[Col('Black'),Col('Blue'),Col('Brown'),Col('Grey'),Col('Red'),Col('Yellow'),Col('White'), ];
}

class Years {
  Years(this.name);
  final String name;
  @override
  String toString() => name;
}

class Company {
  Company(this.name);
  final String name;
  @override
  String toString() => name;
}

class Model {
  Model(this.name);
  final String name;
  @override
  String toString() => name;
}

class Fuel {
  Fuel(this.name);
  final String name;
  @override
  String toString() => name;
}

class Gear {
  Gear(this.name);
  final String name;
  @override
  String toString() => name;
}

class Col {
  Col(this.name);
  final String name;
  @override
  String toString() => name;
}
