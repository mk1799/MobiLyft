import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:horizontal_time_picker/horizontal_time_picker.dart';
import 'package:intl/intl.dart';
import 'package:mobilyft/Crud_File/crud1.dart';
import 'package:mobilyft/Ride_Share/HomePage/car_share_home_page.dart';
import 'package:nice_button/NiceButton.dart';
import 'package:simple_autocomplete_formfield/simple_autocomplete_formfield.dart';
class Create extends StatefulWidget {
  final String email;
  Create({Key key, this.email}) : super(key: key);
  @override
  _CreateState createState() => _CreateState();
}
class _CreateState extends State<Create> {
  var firstColor = Color(0xff5b86e5), secondColor = Color(0xff36d1dc);
  String selectedLetter;
  Places selectedpickup,selecteddest;
  Seat selectedSeat;
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
      'source': selectedpickup.toString(),
      'dest': selecteddest.toString(),
      'time': _time.toString(),
      'Seat': selectedSeat.toString(),
    };
    Map<String, dynamic> noti = {
      'email': widget.email,
      'notice': "Your Ride From ${selectedpickup.toString()} To ${selecteddest.toString()} Is Added Successfully!",  
      'detail' : "Get Ready For Ride\n${formattedDate}""   ""${now.hour}:${now.minute}",
    };
    crudobj.adddata(data, context,"current ride").then((result) {}).catchError((e) {
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
                    child: Icon(Icons.transfer_within_a_station,
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
                          text:'Ride',
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
                    child: SimpleAutocompleteFormField<Places>(
                      suggestionsHeight: 80.0,
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w300
                      ),
                      decoration: InputDecoration(
                        prefixIcon: Padding(
                          child: const Icon(
                            Icons.location_searching,
                            size: 40.0,
                            color: Colors.blue,
                          ),
                          padding: EdgeInsets.only(left: 10,right: 15.0),
                        ),              
                        labelText: 'Pick-up',
                        focusColor: Color.fromRGBO(100, 50, 100, 0.8),
                        border: OutlineInputBorder(),
                        labelStyle: TextStyle(
                          color: Colors.grey[900], 
                          fontSize: 20.0,
                          fontWeight: FontWeight.w400
                        ),            
                      ),
                      controller: TextEditingController(),
                      itemBuilder: (context, place) => Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(place.name,
                              style: TextStyle(
                                fontWeight: FontWeight.bold
                              )
                            ),
                          ]
                        ),
                      ),
                      onSearch: (search) async => place
                      .where((place) =>place.name.toLowerCase().contains(search.toLowerCase())).toList(),                      
                      itemFromString: (string) => place.singleWhere(
                        (place) => place.name.toLowerCase() == string.toLowerCase(),
                        orElse: () => null),
                      // onChanged: (value) => setState(() => selectedpickup = value),
                      onSaved: (value) => setState(() => selectedpickup = value),
                      validator: (place) => place == null ? 'Invalid Pick-up Point!' : null,           
                    ),
                  ),
                ),

                Padding(
                  padding: EdgeInsets.only(top: 10.0, left: 15.0, right: 10.0),
                  child: Card(
                    color: Colors.white,
                    child: SimpleAutocompleteFormField<Places>(
                      suggestionsHeight: 80.0,
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w300
                      ),
                      decoration: InputDecoration(
                        prefixIcon: Padding(
                          child: const Icon(
                            Icons.location_on,
                            size: 40.0,
                            color: Colors.blue,
                          ),
                          padding: EdgeInsets.only(left: 10,right: 15.0),
                        ),              
                        labelText: 'Destination',
                        focusColor: Color.fromRGBO(100, 50, 100, 0.8),
                        border: OutlineInputBorder(),
                        labelStyle: TextStyle(
                          color: Colors.grey[900], 
                          fontSize: 20.0,
                          fontWeight: FontWeight.w400
                        ),            
                      ),
                      controller: TextEditingController(),
                      itemBuilder: (context, place) => Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(place.name,
                              style: TextStyle(
                                fontWeight: FontWeight.bold
                              )
                            ),
                          ]
                        ),
                      ),
                      onSearch: (search) async => place
                      .where((place) =>place.name.toLowerCase().contains(search.toLowerCase())).toList(),                      
                      itemFromString: (string) => place.singleWhere(
                        (place) => place.name.toLowerCase() == string.toLowerCase(),
                        orElse: () => null),
                      // onChanged: (value) => setState(() => selectedpickup = value),
                      onSaved: (value) => setState(() => selecteddest = value),
                      validator: (place) => place == null ? 'Invalid Destination Point!' : null,           
                    ),
                  ),
                ),


                Padding(
                  padding: EdgeInsets.only(top: 10.0, left: 15.0, right: 10.0),
                  child: Card(
                    color: Colors.white,
                    child: SimpleAutocompleteFormField<Seat>(
                      suggestionsHeight: 80.0,
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w300
                      ),
                      decoration: InputDecoration(  
                        prefixIcon: Padding(
                          child: const Icon(
                            Icons.event_seat,
                            size: 40.0,
                            color: Colors.blue,
                          ),
                          padding: EdgeInsets.only(left: 10,right: 15.0),
                        ),              
                        labelText: 'Seat',
                        focusColor: Color.fromRGBO(100, 50, 100, 0.8),
                        border: OutlineInputBorder(),
                        labelStyle: TextStyle(
                          color: Colors.grey[900], 
                          fontSize: 20.0,
                          fontWeight: FontWeight.w400
                        ),            
                      ),
                      controller: TextEditingController(),
                      itemBuilder: (context, seat) => Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(seat.name,
                              style: TextStyle(
                                fontWeight: FontWeight.bold
                              )
                            ),
                          ]
                        ),
                      ),
                      onSearch: (search) async => seat
                      .where((seat) =>seat.name.toLowerCase().contains(search.toLowerCase())).toList(),                      
                      itemFromString: (string) => seat.singleWhere(
                        (seat) => seat.name.toLowerCase() == string.toLowerCase(),
                        orElse: () => null),
                      // onChanged: (value) => setState(() => selectedpickup = value),
                      onSaved: (value) => setState(() => selectedSeat = value),
                      validator: (seat) => seat == null ? 'Invalid Number of Seat!' : null,           
                    ),
                  ),
                ),

                Padding(padding: EdgeInsets.only(top:12.0)),

                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.22,             
                  child:Padding(
                    padding: const EdgeInsets.only(left: 20.0,right: 20.0),
                    child: Container(
                      color: Colors.white,
                      child: Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(Icons.av_timer,
                                size: 40.0,
                                color: Colors.blue,
                              ),
                              Text("\t""Time",
                                style: TextStyle(
                                  fontSize: 30.0,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black45
                                )
                              )
                            ],
                          ),
                          Container(
                            child: HorizontalTimePicker(
                                key: UniqueKey(),
                                onTimeSelected: (time){                                 
                                    _time='${time.hour} : ${time.minute}';
                                },
                                startTimeInHour: 7,
                                endTimeInHour: 24,
                                dateForTime: DateTime.now(),
                                selectedTimeTextStyle: TextStyle(
                                  color: Colors.white,
                                  fontFamily: "Helvetica Neue",
                                  fontWeight: FontWeight.w300,
                                  fontSize: 16,
                                  height: 1.0,
                                ),
                                timeTextStyle: TextStyle(
                                  color: Colors.black,
                                  fontFamily: "Helvetica Neue",
                                  fontWeight: FontWeight.w300,
                                  fontSize: 16,
                                  height: 1.0,
                                ),
                                defaultDecoration: const BoxDecoration(
                                    color: Colors.white,
                                    border:Border.fromBorderSide(
                                      BorderSide(
                                        color: Color.fromARGB(255, 151, 151, 151),   
                                        width: 1,                               
                                        style: BorderStyle.solid,
                                      )
                                    ),                                                                                                                                               
                                    borderRadius: BorderRadius.all(Radius.circular(5)),
                                  ),
                                selectedDecoration: const BoxDecoration(
                                    color: Colors.black,
                                    border:Border.fromBorderSide(
                                        BorderSide(
                                          color: Color.fromARGB(255, 151, 151, 151),
                                          width: 1,
                                          style: BorderStyle.solid,
                                        )
                                      ),
                                    borderRadius: BorderRadius.all(Radius.circular(5)),
                                  ),
                                disabledDecoration: const BoxDecoration(
                                    color: Colors.black26,
                                    border:Border.fromBorderSide(
                                        BorderSide(
                                            color: Color.fromARGB(255, 151, 151, 151),
                                            width: 1,
                                            style: BorderStyle.solid,
                                          )
                                        ),
                                      borderRadius: BorderRadius.all(Radius.circular(5)),
                                  ),
                                  showDisabled: true,
                                )
                          ),
                        ],
                      ),
                    ),
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
                              Home_page(email: widget.email)
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
  final place = <Places>[
    Places('ALTHAN TENAMENT'),Places('AASHIRWAD DOCTOR HOUSE'),Places('AASPAS DADA TEMPLE'),
    Places('ABG SHIPYARD'),Places('ABHVA GAAM'),Places('ADAJAN BRTS'),Places('ADAJAN GSRTC'),
    Places('ADAJAN PATIYA BRTS'),Places('AJRAMAR CHOWK'),Places('AKHAND ANAND COLLEGE'),
    Places('AL AMIN'),Places('ALKAPURI CIRCLE'),Places('ALTHAN'),Places('ALTHAN BHARTHANA BRTS'),
    Places('ALTHAN COMMUNITY HALL'),Places('AMAZIA AMUSEMENT PARK BRTS'),Places('AMBEDKAR TRUST'),
    Places('AMIDHARA WADI'),Places('AMROLI CHAR RASTA'),Places('AMROLI CROSS ROAD'),
    Places('ANAND MAHAL ROAD'),Places('ANAND MAHAL ROAD BRTS'),Places('ANUWRAT DWAR JUNCTION BRTS'),
    Places('APMC SARDAR MARKET'),Places('ARCHNA SCHOOL'),Places('AROGYA KENDRA'),Places('ARYA SAMAJ MARG'),
    Places('ASHAPURA MATA MANDIR'),Places('ASHIRVAD ENCLAVE CANAL ROAD'),Places('ATHWAGATE'),
    Places('ATOP NAGAR BHATAR'),Places('AVSHAR BUNGALOW'),Places('AZAD CHOWK'),
    Places('BAHUMALI'),Places('BAL ASHRAM'),Places('BALAJI MANDIR'),Places('BALASHRAM CHAR RASTA'),
    Places('BAMROLI'),Places('BAMROLI KHADI'),Places('BAPA SITARAM CHOWK BRTS'),
    Places('BAPA SITARAM PETROL PUMP'),
    Places('BAPUJINI WADI'),Places('BARODA PRISTAGE'),Places('BARODA PRISTAGE BRTS'),Places('BHAGAL'),
    Places('BHAGAL CHAR RASTA'),Places('BHAGATALAV'),Places('BHAGVAN NAGAR SARTHANA'),
    Places('BHAIYA NAGAR JUNCTION'),
    Places('BHAJIWALI POL'),Places('BHARTHANA GAAM'),Places('BHATAR FLYOVER UDHANA'),Places('BHATHA GAM'),
    Places('BHATHENA CANAL'),Places('BHAVANI CIRCLE'),Places('BHESTAN'),Places('BHESTAN GARDEN'),
    Places('BHESTAN NAHER BRTS'),
    Places('BHIMPORE'),Places('BHIMPORE FAATA'),Places('BHULKA BHAVAN'),Places('BILAL MASJID OLPAD'),
    Places('BSNL OFFICE'),Places('BSNL OFFICE MAMTA PARK'),Places('BUDIYA GAM'),
    Places('C.K.PITHAWALA ENG. COLLEGE'),Places('CANCER HOSPITAL KUMBHARIYA'),Places('CENTRAL WARE HOUSE'),
    Places('CENTRE FOR SOCIAL STUDY'),Places('CHAPRA BHATHA'),Places('CHIKUWADI BRTS'),
    Places('CHILDREN PARK ADAJAN'),Places('CHOWK BAZAR'),Places('CITY CIVIK CENTRE'),Places('COLOURTEX'), 

    Places('D.G.V.C.L.URJA SADAN BTRS'),Places('DABHOLI CHAR RASTA'),Places('DABHOLI GAM'),
    Places('DELAAD PATIYA'),Places('DELAAD TALAV'),Places('DELHI GATE'),Places('DEVADH GAM'),
    Places('DGVCL LASKANA'),Places('DGVCL MOTA VARACHHA'),Places('DIAMOND NAGAR BRTS'),
    Places('DINDAYAL SOCIETY'),Places('DINDOLI GAM'),Places('DINDOLI KHARWASA ROAD'),
    Places('DINDOLI VARIGRUH'),Places('DR.SHYAMAPRASAD MUKHARJI LAKE GARDEN'),Places('DUMAS KUVADA'),
    Places('DUMAS LANGAR'),Places('DUTCH GARDEN'),Places('FULPADA ROADBRTS'), 

    Places('G.N.PANDYA COLLEGE'),Places('GABHENI GAAM'),Places('GADHPUR TOWNSHIP'),Places('GAJERA CIRCLE'),
    Places('GALAXY ENCLAVE'),Places('GANDHI COLLEGE'),Places('GANDHI KUTIR'),
    Places('GANDHIKUTIR JUNCTION UDHANA MAGDALLA ROAD'),Places('GANESH NAGAR'),Places('GAVIYAR GAM'),
    Places('GAYATRI MANDIR DABHOLI'),Places('GHANSHYAM NAGAR'),Places('GIRLS POLYTECHNIC'),
    Places('GODADARA SCHOOL'),Places('GOLDEN POINT'),Places('GOPI TALAV'),Places('GOPI TALAV MARKET'),
    Places('GOTALAWADI'),Places('GOVERDHAN NATHJIHAVELI'),Places('GREEN CITY BHATHA'),
    Places('GREEN PARK BRTS'),Places('GUJARAT GAS COMPANY LTD. MORA'),Places('GUJRATI SCHOOL GHOD DOD ROAD'),
    Places('‘GURUKUM SCHOOL SARTHANA'),

    Places('HARE KRISHNA CIRCLE'),Places('HIDAYAT NAGAR POLICE STATION'),Places('HIJDAWAD'),
    Places('HIRABAUG BRTS'),Places('HONEY PARK CROSS ROAD'),Places('I.C.GANDHI SCHOOL'),
    Places('I.P. MISSION SCHOOL'),Places('ICCHANATH MAHADEV TEMPLE'), Places('ICCHAPOR GAAM FAATA'),
    Places('ICCHAPORE LAKE'),Places('ISHANPOR'),Places('ISHWAR NAGAR'),Places('ISKON CIRCLE'),
    Places('J.B. DIAMOND'),Places('J.H. AMBANI SCHOOL BRTS'),Places('J.T.NAGAR'),Places('JAANI FARSAN'),
    Places('JAGDISHCHANDRA BOSE GARDEN'),Places('JAHANGIRPURA COMMUNITY HALL'),Places('JAMNA NAGAR JUNCTION'),
    Places('JANTA HOSPITAL'),    Places('JAWAHARLAL NEHRU GARDEN'),Places('JIAV GAAM'),
    Places('JILANI BRIDGE APPROACH KATARGAM'),Places('JOLLY  RESIDENCY'),Places('JYOTINDRA DAVE GARDEN'),

    Places('K.P. COMMERCE COLLEG'),Places('KAADI FALIYA DUMAS'),Places('KADODARA'),Places('KAKIWAD'),
    Places('KAKRAPAR CANAL ROAD')  ,Places('KAMNATH MAHADEV BRTS'),Places('KANTARESHWAR MAHADEV'),
    Places('KANTHIRIYA HANUMAN MANDIR'),Places('KAPODARA FIRE STATI  ON'),Places('KAPODRA'),
    Places('KARGIL CHOWK BRTS'),Places('KASKIWAD'),Places('KATARGAM'),Places('KATARGAM DARWAJA'),
    Places('KA  TARGAM FIRE STATION'),Places('KATARGAM POLICE STATION'),Places('KATHODARA GAAM'),
    Places('KAVI KALAPI GARDEN'),Places('KAVI SHR  EE AMRUT GHAYAL SCHOOL VARIAV'),
    Places('KHAADI MOHALLA SHAALA'),Places('KHADSAD GAM'),Places('KHAJOD GAM'),Places('KHARWARNAGA  R BRTS'),
    Places('‘KHATODARA GIDC'),Places('KHODIYARNAGAR'),Places('KHWAJA DANA NEW ROAD'),Places('KINNARY CINEMA'),
    Places('KIR  AN HOSPITAL'),Places('‘KOSAD'),Places('KOSAD FIRE STATION BRTS'),Places('KOSAD HOUSING BOARD'),
    Places('KOSAD TALAV'),Places('KOT SAFIL ROAD'),Places('KRIBHCO NAGAR'),Places('KUNJ GALI'),
    Places('KV HAGRENAD ROAD'),Places('L.P.SAVANI VIDHYABHVAN'),Places  ('LAABHESHWAR CHOWK'),
    Places('LAJAMNI CHOWK'),Places('LAL DARWAJA'),Places('LAL GATE'),Places('LALITA CIRCLE'),
    Places('LALWATA  LAAV OLPAD'),Places('LAMBE HANUMAN TEMPLE'),Places('LANCER ARMY SCHOOL'),
    Places('LAXMINAGAR CHOWK'),Places('LEPROSY HOSPITAL')  ,Places('LIMBAYAT HEALTH CENTER'),
    Places('LIMDA CHOWK'),Places('LINEAR BUS STOP'),Places('MAAHILA I.T.I'),Places('MAANGADH CHOWK'),
    Places('MAGADALLA GAM BRTS'),Places('MAGDALLA PORT'),Places('MAGOB GAM'),Places('MAHA LAXMI TEMPLE'),
    Places('MAHARAJA KRUSHNAKUMAR SCHOOL'),Places('MAHARANA PRATAP BRIDGE'),Places('MAHARANA PRATAP GARDEN'),
    Places('MAHAVIE CHOWK'),Places('MAHIDHARP  URA POST OFFICE'),Places('MAJURA GATE'),
    Places('MAJURA GATE FIRE STATION'),Places('MAJURAGATE CIVIL HOSPITAL'),Places('MAKBARA MASJID'),
    Places('MAKKAI POOL'),Places('MAMBARA MASJID'),Places('MANGAL PANDEY HALL'),Places('MATAWADI CHOWK'),
    Places('MAULANAAZAD ENGLISH SCHOOL'),Places('MILLENIUM PARK'),Places('MINI VIRPUR'),Places('MORA BHAGAL'),
    Places('MORA CHAR  RASTA'),Places('MORABHAGAL'),Places('MOTA VARACHHA FIRE STATION'),
    Places('MOTA VARACHHA LAKE'),Places('MOTA VARACHHA PRATHMIK SCHOOL'),Places('MOTA VARACHHA PUMPING STATION'),
    Places('MOTA VARACHHA WARD OFFICE'),Places('MOTI BAJAR DUMAS'),Places('MOTI VED'),Places('NC THAKKAR SCHOOL'),
    Places('NANA VARACHHA POLICE STATION'),Places('NANA VARACHHA VARI GRUH'),Places('NANI BAHUCHARAJI TEMPLE'),  
    Places('NANI BAJAR DUMAS'),Places('NANI VED'),Places('NANPURA POST OFFICE'),
    Places('NARMADA CENTRAL LIBRARY'),Places('NATVAR NAGAR'),Places('NAVAPARA VARIAV'),
    Places('NAVJIVAN CIRLE UDHANA'),Places('NAVSARI BAZAR'),Places('NAVYUG COLLEGE'),Places('NEHRU BRIDGE'),
    Places('NEW CIVIL HOSPITAL'),Places('NEW ERA SCHOOL'),Places('NILGIRI CIRCLE'),Places('NIYOL PATIYA'),
    Places('NOORANI MASJID'),Places('NTPC'),Places('OLPAD GIDC'),Places('ONGC COLONY'),Places('ONGC ROAD'),
    Places('PADESARA GIDC'),Places('PAL PATIYA'),Places('PAL R.T.O. BRTS'),Places('PALANPUR GAM TALAV'),
    Places('PALANPUR JAKATNAKA'),Places('PALANPUR PATIYA BRTS'),Places('PALANPUR SHALA'),
    Places('PALSANA CHOKDI'),Places('PANDESARA'),Places('PANDESARA GIDC'),
    Places('PANDESARA INDUSTRIES ESTATE'),Places('PANDIT SHYAMJI KRISHNA VERMA BRIDGE'),
    Places('PANDOL POLICE CHOWK'),Places('PARDI KANDE'),Places('PARLE POINT'),Places('PARSIWAD'),
    Places('PARVAT GAM'),Places('PARVAT PATIYA JUNCTION'),Places('PASODARA GAM BRTS'),Places('PATELWADI'),
    Places('PIPARDIWALA SCHOOL'),Places('PIPLOD BRTS'),Places('PISAD PUMPING STATION'),Places('PIYUSH COMPLEX'),
    Places('POLICE COMMISSIONER OFFICE'),Places('PRAJAPATI BRAHMAKUMARI MARG'),Places('PRIME ARCADE'),
    Places('PUMPING CHAR RASTA'),Places('PUNA CANAL BTRS'),Places('PUNA SAROLI JUNCTION'),
    Places('PUNAGAM JUNCTION'),Places('RACHANA CIRCLE'),Places('RAILWAY STATION TERMINAL'),
    Places('RAILWAY STATION TERMINAL'),Places('RAILWAY STATION TERMINAL'),Places('RAMNAGAR'),  
    Places('RANDER GAAM'),Places('RANDER NAHER COLONY'),Places('RATNA JYOTI TOWER VESU ABHVA ROAD'),
    Places('RENUKA BHAVAN'),Places('ROYAL HERITAGE'),Places('RUNDHNATH MAHADEV MANDIR'),
    Places('RUPALI JUCTION BRTS'),Places('RUSTAMPURA SWMMING POOL'), 

    Places('S M C HEALTH CLUB'),Places('S.D. JAIN SCHOOL BRTS'),Places('S.M.C CENTRAL ZONE OFFICE'),
    Places('S.M.C SPORTS COMPLEX')  ,Places('S.M.C WATER DEPARTMENT'),Places('S.M.C WEST ZONE OFFICE'),
    Places('S.M.C. BOTNICAL GARDEN'),Places('S.M.C. SANKUL'),Places('S.M.C. SPORTS COMPLEX'),
    Places('S.V.N.I.T. BRTS'),Places('SACHIN GIDC JUNCTION'),Places('SACHIN PRIMARY SCHOOL'),
    Places('SAHARA DARWAJA'),Places('SAIYADPURA VEGETABLE MARKET'),Places('SAMARPAN HOSPITAL'),
    Places('SAMATA NAGAR'),Places('SANGEET SARITA'),Places('SANJEEV KUMAR AUDITORIUM'),
    Places('SANSKAR BHAVAN'),Places('SANTOSH NAGAR'),Places('SARASANA GAM'),Places('SARDAR CHOWK'),
    Places('SARDAR SMRUTI BHAVAN'),Places('SARGAM SHOPPING CENTRE'),Places('SAROLI GAAM'),
    Places('SARTHANA NAKA'),Places('SARTHANA NATURE PARK BRTS'),Places('SAURASTRA GREEN CITY'),
    Places('SAVJIKORAT BRIDGE'),Places('SAYAN RAILWAY STATION'),Places('SACHIN GIDC'),
    Places('SHAKTI NIKETAN MANDIR'),Places('SHARDA SCHOOL'),Places('SHARDA VIDHYA MANDIR'),
    Places('SHIVAJI NAGAR'),Places('SHREE SANT KHETESHWAR CIRLCE'),
    Places('SHREE SWAMI DAYANAND SARSWATI BRIDGE'),Places('SHREE SWAMINARAYAN MANDIR'),
    Places('SHRIMAD VALLABHCHARYA CHOWK'),Places('SHYAM DHAM CHOWK'),Places('SHYAMDHAM MANDIR'),
    Places('SICKON CIRCLE'),Places('SIDDHI VINAYAK TEMPLE'),Places('SILICON FLATS PARVAT'),
    Places('SILVER STONE ARCADE'),Places('SIMADA GAM'),Places('SIMADA JUNCTION'),Places('SINGANPORE CIRCLE'),
    Places('SINGANPORE S.T.P'),Places('SINGANPORE VEGETABLE MARKET'),Places('SITANAGAR BRTS'),
    Places('SITARAM CHOWK'),Places('SMC COMMUNITY HAL UDHNA'),Places('SMC HALL SINGANPORE'),
    Places('SMC KAPODRA WARD OFFICE'),Places('SMC PARTY PLOT PAL'),Places('SMC SANKUL'),
    Places('SMC SOUTH ZONE OFFICE'),Places('SMC WATER WORKS KOSAD'),Places('SMIMMER HOSPITAL BRTS'),
    Places('SOHAM CIRCLE'),Places('SOMESHWAR JUCTION BRTS'),Places('SOSYO CIRCLE'),
    Places('SOUTH GUJARAT MEDICAL COLLEGE'),Places('SPIPA'),Places('ST.XAVIER’S HIGH SCHOOL GHOD DOD ROAD'),
    Places('STAR BAZAR'),Places('SUBHAS GARDEN'),Places('SUDAMACHOWK'),Places('SULTANABAD'),
    Places('SUMUL DAIRY'),Places('SURAT AIRPORT'),Places('SURAT DISTRICT COURT'),Places('SUSHRUT HOSPITAL'),
    Places('SWAMI NARAYA GURUKUL'),Places('SWAMINARAYAN CHOWK'),Places('SWURAJ MANDASL JAIN TEMPLE'),
    Places('TADWADI'),Places('TALAWADI SAGRAMPURA'),Places('TEXTILE MARKET'),
    Places('UDHANA ACADEMY COLLEGE BRTS'),Places('UDHANA DARWAJA BTRS'),
    Places('UDHANA GIDC MAHATMA GANDHI ROAD'),Places('UDHANA RAILWAY STATION'),
    Places('UDHNA GIDC MAHATMA GANDHI ROAD'),Places('UGAT S.M.C. WATER TREATMENT PLANT'),
    Places('UMA BHAVAN BHATAR ROAD'),Places('UMIYA CHOWK'),Places('UMRA HEALTH CENTRE'),Places('UMRA NAKA'),
    Places('UNIQUE HOSPITAL'),Places('UNN CHAR RASTA'),Places('UNN GAM'),Places('UNN INDUSTRIAL ESTATE'),
    Places('UTRAN'),Places('UTRAN LAKE GARDEN'),Places('UTRAN POWER HOUSE'),Places('V.N.GODHANI SCHOOL'),
    Places('V.N.S.G.U UNIVERSITY'),Places('V.T.CHOKSI COLLEGE'),Places('VAADINATH CHOWK'),Places('VADOD GAM'),
    Places('VALAK GAM BRTS'),Places('VALLABHACHARYA ROAD BRTS'),Places('VANITA VISHRAM GROUND'),
    Places('VANMALI JUNCTION BTRS'),Places('VARELI'),Places('VARIAV GAM'),Places('VARIYALI BAZAR POLICE CHOWKI'),
    Places('VARIYAV JAKATNAKA'),Places('VASANT BHIKHA NI VADI'),Places('VASVARI GAAM'),Places('VASVARI LAKE'),
    Places('VEDCHA PATIYA'),Places('VELANJA GAAM'),Places('VENUS ESTATE'),Places('VESU GAAM'),
    Places('VICTORIA PALM'),Places('VIDHATA TOWNSHIP PARVAT'),Places('VIDHI BHAWAN'),
    Places('VISHWAKARMA JUNCTION'),Places('VIVEKANAND COLLEGE'),Places('WADI FALIYA'),
    Places('  WESTERN CITY'),Places('Y JUNCTION DUMAS ROAD'),Places('YOGI CHOWK'),
    Places('YOGI NAGAR JUNCTION'), 
  ];

  final seat=<Seat>[Seat('1'),Seat('2'),Seat('3'),Seat('4')];
}

class Places {
  Places(this.name);
  final String name;
  @override
  String toString() => name;
}


class Seat{
  Seat(this.name);
  final String name;
  @override
  String toString()=>name;
}