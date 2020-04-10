import 'package:animated_card/animated_card.dart';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobilyft/Crud_File/crud1.dart';
import 'package:mobilyft/Ride_Share/HomePage/car_share_home_page.dart';
class ridesearch extends StatefulWidget {
  final String email;
  ridesearch({Key key, this.email}) : super(key: key);
  @override
  ridesearchState createState() => ridesearchState();
}
class ridesearchState extends State<ridesearch> {
   GlobalKey<AutoCompleteTextFieldState<String>> keyComp = new GlobalKey();
  String currentText = "";
  CRUD1 crudobj = new CRUD1();
  QuerySnapshot ride, user, car;
  String src, dest, seat, emailcr,namecr,lic,email,time,carnum;
  @override
  void initState() {
    crudobj.getData('current ride').then((result) {
      setState(() {
        ride = result;
      });
    });
    crudobj.getData('user').then((result) {
      setState(() {
        user = result;
      });
    });

    crudobj.getData('car_detail').then((result) {
      setState(() {
        car = result;
      });
    });
  }
  void insert(BuildContext context) {
    Map<String, dynamic> data = {
      'Emailreq': widget.email,
      'Emailcr' : emailcr,
      'Namecr' : namecr,
      'PickUp' : src,
      'Destination' : dest,
      'Time' : time,
      'Seat' :seat,
    };
    crudobj.adddata(data, context,"ride request").then((result) {}).catchError((e) {
      print(e);
    });
  }
  

void submit(int i) async {
  src=ride.documents[i].data["source"];
  dest=ride.documents[i].data["dest"];
  time=ride.documents[i].data["time"];
  seat=ride.documents[i].data["Seat"];
  insert(context);
    Navigator.pop(context,true);
    Navigator.pop(context,true);
    Navigator.pop(context,true);
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => Home_page(email: widget.email))
          );
}
  void initiateSearch(String val) {
    setState(() {
      city = val.trim();
    });
  }
  int l = 0;
  String city = "";
  @override
  Widget build(BuildContext context) {
    return SafeArea(
            child: Scaffold(
              appBar: AppBar(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(25),
                  ),
                ),
                backgroundColor: Colors.white,
                iconTheme: IconThemeData(
                  color: Colors.black
                ),
                title:SimpleAutoCompleteTextField(
                  key: keyComp,
                  decoration: InputDecoration(
                    hintText: 'Search Place...',
                    focusColor: Color.fromRGBO(100, 50, 100, 0.8),
                    border: InputBorder.none,
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 30.0),            
                  ),
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.w600 
                ),
                controller: TextEditingController(),
                suggestions: suggestionsPlace,
                textChanged: (text) => currentText = text,
                textSubmitted:(val)=>initiateSearch(val),
                submitOnSuggestionTap: true,
                clearOnSubmit: false,
              ),              
            ),
            body: ListView(
              children: <Widget>[
                if (ride != null)
                for (int i = 0; i < ride.documents.length; i++)
                if (city == ride.documents[i].data["dest"] || city == ride.documents[i].data["source"])
                  Column(
                    children: <Widget>[
                      returnride(i),
                    ],
                  ),
            Padding(padding: EdgeInsets.only(top: 250.0)),
            if (ride == null)
              Column(
                children: <Widget>[
                  Center(child: CircularProgressIndicator()),
                ],
              )
          ],
        ),
      ),
    );
  }

  Widget returnride(int i) {
    if (ride != null) {
      if (widget.email != ride.documents[i].data["email"]) {
        return Padding(
            padding: EdgeInsets.only(top: 10.0,left: 10.0,right: 10.0,),
            child: AnimatedCard(
              direction: AnimatedCardDirection.right, 
              initDelay: Duration(milliseconds: 0), 
              duration: Duration(seconds: 2), 
              child:Card(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(10.0)),
                child: ListTile(
                  leading: Icon(
                    Icons.account_circle,
                    size: 40.0,
                  ),
                  title: Text(
                      "${ride.documents[i].data["source"]}\tto\t${ride.documents[i].data["dest"]}",
                      style: TextStyle(fontSize:30.0,fontWeight:FontWeight.w400),),
                  subtitle: Text("Time : "
                      "${ride.documents[i].data["time"]}\nSeat : ${ride.documents[i].data["Seat"]}",
                      style: TextStyle(fontSize:20.0,fontWeight:FontWeight.w300),),
                  onTap: () {
                     emailcr = ride.documents[i].data["email"];
                    print(emailcr);
                     for (int i = 0; i < user.documents.length; i++)
                      if(emailcr == user.documents[i].data["email"])
                      {
                       namecr= user.documents[i].data["name"];
                      }
                      for (int i = 0; i < car.documents.length; i++){
                      if(emailcr == car.documents[i].data["email"])
                      {
                       carnum= car.documents[i].data["car Number"];
                      }}
                    showDialog<void>(
                      context: context,
                      barrierDismissible: false, // user must tap button!
                      builder: (BuildContext context) {
                        return CupertinoAlertDialog(
                          title: Center(
                            child: Text(
                              'Ride Details',
                              style: TextStyle(
                                fontFamily: 'helvetica_neue_light',
                                fontWeight: FontWeight.bold,
                                fontSize: 30.0,
                              ),
                            ),
                          ),
                          content: SingleChildScrollView(
                            child: ListBody(
                              children: <Widget>[
                                Padding(
                                    padding: EdgeInsets.only(top: 5.0),
                                    child: new Column(children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          Icon(
                                            Icons.person,
                                            // location_on
                                            size: 40.0,
                                          ),
                                          
                                          Icon(Icons.chevron_right),
                                          Expanded(
                                            child: Text(
                                              namecr,
                                              textAlign: TextAlign.start,
                                              style: TextStyle(fontSize: 22.0,fontWeight: FontWeight.w300),
                                            ),
                                            flex: 1,
                                          )
                                        ],
                                      )
                                    ])),
                                Padding(
                                    padding: EdgeInsets.only(top: 5.0),
                                    child: new Column(children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          Icon(
                                            Icons.verified_user,
                                            size: 40.0,
                                          ),
                                          
                                          Icon(Icons.chevron_right),
                                          
                                          Expanded(
                                            child: Text(
                                              "${carnum}",
                                              textAlign: TextAlign.start,
                                              style: TextStyle(fontSize: 22.0,fontWeight: FontWeight.w300),
                                            ),
                                            flex: 1,
                                          )
                                        ],
                                      )
                                    ])),
                        
                                Padding(
                                    padding: EdgeInsets.only(top: 5.0),
                                    child: new Column(children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          Icon(
                                            Icons.location_searching,
                                            size: 40.0,
                                          ),
                                          
                                          Icon(Icons.chevron_right),
                                          
                                          Expanded(
                                            
                                            child: Text(
                                              "${ride.documents[i].data["source"]}",
                                              textAlign: TextAlign.start,
                                              style: TextStyle(fontSize: 22.0,fontWeight: FontWeight.w300),
                                            ),
                                            flex: 1,
                                          )
                                        ],
                                      )
                                    ])),
                                Padding(
                                    padding: EdgeInsets.only(top: 5.0),
                                    child: new Column(children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          Icon(
                                            Icons.location_on,
                                            size: 40.0,
                                          ),
                                         
                                          Icon(Icons.chevron_right),
                                          
                                          Expanded(
                                            
                                            child: Text(
                                              "${ride.documents[i].data["dest"]}",
                                              textAlign: TextAlign.start,
                                              style: TextStyle(fontSize: 22.0,fontWeight: FontWeight.w300),
                                            ),
                                            flex: 1,
                                          )
                                        ],
                                      )
                                    ])),
                                Padding(
                                    padding: EdgeInsets.only(top: 5.0),
                                    child: new Column(children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          Icon(
                                            Icons.access_time,
                                            size: 40.0,
                                          ),
                                          
                                          Icon(Icons.chevron_right),
                                          
                                          Expanded(
                                            
                                            child: Text(
                                              "${ride.documents[i].data["time"]}",
                                              textAlign: TextAlign.start,
                                              style: TextStyle(fontSize: 22.0,fontWeight: FontWeight.w300),
                                            ),
                                            flex: 1,
                                          )
                                        ],
                                      )
                                    ])),
                                Padding(
                                    padding: EdgeInsets.only(top: 5.0),
                                    child: new Column(children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          Icon(
                                            Icons.airline_seat_recline_normal,
                                            size: 40.0,
                                          ),
                                          
                                          Icon(Icons.chevron_right),
                                         
                                          Expanded(
                                              child: Text(
                                              "${ride.documents[i].data["Seat"]}",
                                              textAlign: TextAlign.start,
                                              style: TextStyle(fontSize: 22.0,fontWeight: FontWeight.w300),
                                            ),
                                            flex: 1,
                                          )
                                        ],
                                      )
                                    ])),
                              ],
                            ),
                          ),
                          actions: <Widget>[
                            FlatButton(
                              child: Text(
                                "   Request   ",
                                style: TextStyle(fontSize: 25.0,fontWeight: FontWeight.w300),
                              ),
                              onPressed: () {
                                submit(i);
                              },
                            ),
                            Padding(padding:EdgeInsets.only(left:10.0) ),
                            FlatButton(
                              child: Text(
                                "   Cancel   ",
                                style: TextStyle(fontSize: 25.0,fontWeight: FontWeight.w300),
                              ),
                              onPressed: () {
                                Navigator.pop(context, true);
                              },
                            )
                          ],
                        );
                      },
                    );
                  },
                ))));
      } else
        return Container(
        );
    } else {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
  }

  List<String> suggestionsPlace=[
  "ALTHAN TENAMENT","AASHIRWAD DOCTOR HOUSE","AASPAS DADA TEMPLE","ABG SHIPYARD","ABHVA GAAM",
  "ADAJAN BRTS","ADAJAN GSRTC","ADAJAN PATIYA BRTS","AJRAMAR CHOWK","AKHAND ANAND COLLEGE",
  "AL AMIN","ALKAPURI CIRCLE","ALTHAN","ALTHAN BHARTHANA BRTS","ALTHAN COMMUNITY HALL",
  "AMAZIA AMUSEMENT PARK BRTS","AMBEDKAR TRUST","AMIDHARA WADI","AMROLI CHAR RASTA","AMROLI CROSS ROAD",
  "ANAND MAHAL ROAD","ANAND MAHAL ROAD BRTS","ANUWRAT DWAR JUNCTION BRTS","APMC SARDAR MARKET",
  "ARCHNA SCHOOL","AROGYA KENDRA","ARYA SAMAJ MARG","ASHAPURA MATA MANDIR","ASHIRVAD ENCLAVE CANAL ROAD",
  "ATHWAGATE","ATOP NAGAR BHATAR","AVSHAR BUNGALOW","AZAD CHOWK",

  "BAHUMALI","BAL ASHRAM","BALAJI MANDIR","BALASHRAM CHAR RASTA","BAMROLI","BAMROLI KHADI",
  "BAPA SITARAM CHOWK BRTS","BAPA SITARAM PETROL PUMP","BAPUJINI WADI","BARODA PRISTAGE",
  "BARODA PRISTAGE BRTS","BHAGAL","BHAGAL CHAR RASTA","BHAGATALAV","BHAGVAN NAGAR SARTHANA",
  "BHAIYA NAGAR JUNCTION","BHAJIWALI POL","BHARTHANA GAAM","BHATAR FLYOVER UDHANA","BHATHA GAM",
  "BHATHENA CANAL","BHAVANI CIRCLE","BHESTAN","BHESTAN GARDEN","BHESTAN NAHER BRTS","BHIMPORE",
  "BHIMPORE FAATA","BHULKA BHAVAN","BILAL MASJID OLPAD","BSNL OFFICE","BSNL OFFICE MAMTA PARK",
  "BUDIYA GAM","C.K.PITHAWALA ENG. COLLEGE","CANCER HOSPITAL KUMBHARIYA","CENTRAL WARE HOUSE",
  "CENTRE FOR SOCIAL STUDY","CHAPRA BHATHA","CHIKUWADI BRTS","CHILDREN PARK ADAJAN","CHOWK BAZAR",
  "CITY CIVIK CENTRE","COLOURTEX"


  "D.G.V.C.L.URJA SADAN BTRS","DABHOLI CHAR RASTA","DABHOLI GAM","DELAAD PATIYA","DELAAD TALAV","DELHI GATE",
  "DEVADH GAM","DGVCL LASKANA","DGVCL MOTA VARACHHA","DIAMOND NAGAR BRTS","DINDAYAL SOCIETY","DINDOLI GAM",
  "DINDOLI KHARWASA ROAD","DINDOLI VARIGRUH","DR. SHYAMAPRASAD MUKHARJI LAKE GARDEN","DUMAS KUVADA"
  "DUMAS LANGAR","DUTCH GARDEN","FULPADA ROAD BRTS",

  "G.N.PANDYA COLLEGE","GABHENI GAAM","GADHPUR TOWNSHIP","GAJERA CIRCLE","GALAXY ENCLAVE","GANDHI COLLEGE",
  "GANDHI KUTIR","GANDHIKUTIR JUNCTION UDHANA MAGDALLA ROAD","GANESH NAGAR","GAVIYAR GAM","GAYATRI MANDIR DABHOLI",
  "GHANSHYAM NAGAR","GIRLS POLYTECHNIC","GODADARA SCHOOL","GOLDEN POINT","GOPI TALAV","GOPI TALAV MARKET",
  "GOTALAWADI","GOVERDHAN NATHJI HAVELI","GREEN CITY BHATHA","GREEN PARK BRTS","GUJARAT GAS COMPANY LTD. MORA",
  "GUJRATI SCHOOL GHOD DOD ROAD","‘GURUKUM SCHOOL SARTHANA",


  "HARE KRISHNA CIRCLE","HIDAYAT NAGAR POLICE STATION","HIJDAWAD","HIRABAUG BRTS","HONEY PARK CROSS ROAD",

  "I.C.GANDHI SCHOOL","I.P. MISSION SCHOOL","ICCHANATH MAHADEV TEMPLE","ICCHAPOR GAAM FAATA",
  "ICCHAPORE LAKE","ISHANPOR","ISHWAR NAGAR","ISKON CIRCLE",

  "J.B. DIAMOND","J.H. AMBANI SCHOOL BRTS","J.T.NAGAR","JAANI FARSAN","JAGDISHCHANDRA BOSE GARDEN",
  "JAHANGIRPURA COMMUNITY HALL","JAMNA NAGAR JUNCTION","JANTA HOSPITAL","JAWAHARLAL NEHRU GARDEN",
  "JIAV GAAM","JILANI BRIDGE APPROACH KATARGAM","JOLLY  RESIDENCY","JYOTINDRA DAVE GARDEN",

  "K.P. COMMERCE COLLEG","KAADI FALIYA DUMAS","KADODARA","KAKIWAD","KAKRAPAR CANAL ROAD",
  "KAMNATH MAHADEV BRTS","KANTARESHWAR MAHADEV","KANTHIRIYA HANUMAN MANDIR","KAPODARA FIRE STATION",
  "KAPODRA","KARGIL CHOWK BRTS","KASKIWAD","KATARGAM","KATARGAM DARWAJA","KATARGAM FIRE STATION",
  "KATARGAM POLICE STATION","KATHODARA GAAM","KAVI KALAPI GARDEN","KAVI SHREE AMRUT GHAYAL SCHOOL VARIAV",
  "KHAADI MOHALLA SHAALA","KHADSAD GAM","KHAJOD GAM","KHARWARNAGAR BRTS","‘KHATODARA GIDC","KHODIYARNAGAR",
  "KHWAJA DANA NEW ROAD","KINNARY CINEMA","KIRAN HOSPITAL","‘KOSAD","KOSAD FIRE STATION BRTS",
  "KOSAD HOUSING BOARD","KOSAD TALAV","KOT SAFIL ROAD","KRIBHCO NAGAR","KUNJ GALI","KV HAGRENAD ROAD",

  "L.P.SAVANI VIDHYABHVAN","LAABHESHWAR CHOWK","LAJAMNI CHOWK","LAL DARWAJA","LAL GATE","LALITA CIRCLE",
  "LALWATALAAV OLPAD","LAMBE HANUMAN TEMPLE","LANCER ARMY SCHOOL","LAXMINAGAR CHOWK","LEPROSY HOSPITAL",
  "LIMBAYAT HEALTH CENTER","LIMDA CHOWK","LINEAR BUS STOP",

  "MAAHILA I.T.I","MAANGADH CHOWK","MAGADALLA GAM BRTS","MAGDALLA PORT","MAGOB GAM","MAHA LAXMI TEMPLE",
  "MAHARAJA KRUSHNAKUMAR SCHOOL","MAHARANA PRATAP BRIDGE","MAHARANA PRATAP GARDEN","MAHAVIE CHOWK",
  "MAHIDHARPURA POST OFFICE","MAJURA GATE","MAJURA GATE FIRE STATION","MAJURAGATE CIVIL HOSPITAL",
  "MAKBARA MASJID","MAKKAI POOL","MAMBARA MASJID","MANGAL PANDEY HALL","MATAWADI CHOWK",
  "MAULANA AZAD ENGLISH SCHOOL","MILLENIUM PARK","MINI VIRPUR","MORA BHAGAL","MORA CHAR  RASTA",
  "MORABHAGAL","MOTA VARACHHA FIRE STATION","MOTA VARACHHA LAKE","MOTA VARACHHA PRATHMIK SCHOOL",
  "MOTA VARACHHA PUMPING STATION","MOTA VARACHHA WARD OFFICE","MOTI BAJAR DUMAS","MOTI VED",


  "N C THAKKAR SCHOOL","NANA VARACHHA POLICE STATION","NANA VARACHHA VARI GRUH","NANI BAHUCHARAJI TEMPLE",
  "NANI BAJAR DUMAS","NANI VED","NANPURA POST OFFICE","NARMADA CENTRAL LIBRARY","NATVAR NAGAR",
  "NAVAPARA VARIAV","NAVJIVAN CIRLE UDHANA","NAVSARI BAZAR","NAVYUG COLLEGE","NEHRU BRIDGE",
  "NEW CIVIL HOSPITAL","NEW ERA SCHOOL","NILGIRI CIRCLE","NIYOL PATIYA","NOORANI MASJID","NTPC",

  "OLPAD GIDC","ONGC COLONY","ONGC ROAD",

  "PADESARA GIDC","PAL PATIYA","PAL R.T.O. BRTS","PALANPUR GAM TALAV","PALANPUR JAKATNAKA",
  "PALANPUR PATIYA BRTS","PALANPUR SHALA","PALSANA CHOKDI","PANDESARA","PANDESARA GIDC",
  "PANDESARA INDUSTRIES ESTATE","PANDIT SHYAMJI KRISHNA VERMA BRIDGE","PANDOL POLICE CHOWK",
  "PARDI KANDE","PARLE POINT","PARSIWAD","PARVAT GAM","PARVAT PATIYA JUNCTION","PASODARA GAM BRTS",
  "PATELWADI","PIPARDIWALA SCHOOL","PIPLOD BRTS","PISAD PUMPING STATION","PIYUSH COMPLEX",
  "POLICE COMMISSIONER OFFICE","PRAJAPATI BRAHMAKUMARI MARG","PRIME ARCADE","PUMPING CHAR RASTA",
  "PUNA CANAL BTRS","PUNA SAROLI JUNCTION","PUNAGAM JUNCTION",

  "RACHANA CIRCLE","RAILWAY STATION TERMINAL","RAILWAY STATION TERMINAL","RAILWAY STATION TERMINAL",
  "RAMNAGAR","RANDER GAAM","RANDER NAHER COLONY","RATNA JYOTI TOWER VESU ABHVA ROAD","RENUKA BHAVAN",
  "ROYAL HERITAGE","RUNDHNATH MAHADEV MANDIR","RUPALI JUCTION BRTS","RUSTAMPURA SWMMING POOL","raj",

  "S M C HEALTH CLUB","S.D. JAIN SCHOOL BRTS","S.M.C CENTRAL ZONE OFFICE","S.M.C SPORTS COMPLEX",
  "S.M.C WATER DEPARTMENT","S.M.C WEST ZONE OFFICE","S.M.C. BOTNICAL GARDEN","S.M.C. SANKUL",
  "S.M.C. SPORTS COMPLEX","S.V.N.I.T. BRTS","SACHIN GIDC JUNCTION","SACHIN PRIMARY SCHOOL",
  "SAHARA DARWAJA","SAIYADPURA VEGETABLE MARKET","SAMARPAN HOSPITAL","SAMATA NAGAR","SANGEET SARITA",
  "SANJEEV KUMAR AUDITORIUM","SANSKAR BHAVAN","SANTOSH NAGAR","SARASANA GAM","SARDAR CHOWK",
  "SARDAR SMRUTI BHAVAN","SARGAM SHOPPING CENTRE","SAROLI GAAM","SARTHANA NAKA","SARTHANA NATURE PARK BRTS",
  "SAURASTRA GREEN CITY","SAVJIKORAT BRIDGE","SAYAN RAILWAY STATION","SACHIN GIDC","SHAKTI NIKETAN MANDIR",
  "SHARDA SCHOOL","SHARDA VIDHYA MANDIR","SHIVAJI NAGAR","SHREE SANT KHETESHWAR CIRLCE",
  "SHREE SWAMI DAYANAND SARSWATI BRIDGE","SHREE SWAMINARAYAN MANDIR","SHRIMAD VALLABHCHARYA CHOWK",
  "SHYAM DHAM CHOWK","SHYAMDHAM MANDIR","SICKON CIRCLE","SIDDHI VINAYAK TEMPLE","SILICON FLATS PARVAT",
  "SILVER STONE ARCADE","SIMADA GAM","SIMADA JUNCTION","SINGANPORE CIRCLE","SINGANPORE S.T.P",
  "SINGANPORE VEGETABLE MARKET","SITANAGAR BRTS","SITARAM CHOWK","SMC COMMUNITY HAL UDHNA",
  "SMC HALL SINGANPORE","SMC KAPODRA WARD OFFICE","SMC PARTY PLOT PAL","SMC SANKUL","SMC SOUTH ZONE OFFICE",
  "SMC WATER WORKS KOSAD","SMIMMER HOSPITAL BRTS","SOHAM CIRCLE","SOMESHWAR JUCTION BRTS","SOSYO CIRCLE",
  "SOUTH GUJARAT MEDICAL COLLEGE","SPIPA","ST.XAVIER’S HIGH SCHOOL GHOD DOD ROAD","STAR BAZAR","SUBHAS GARDEN",
  "SUDAMA CHOWK","SULTANABAD","SUMUL DAIRY","SURAT AIRPORT","SURAT DISTRICT COURT","SUSHRUT HOSPITAL",
  "SWAMI NARAYA GURUKUL","SWAMINARAYAN CHOWK","SWURAJ MANDASL JAIN TEMPLE"

  "TADWADI","TALAWADI SAGRAMPURA","TEXTILE MARKET"

  "UDHANA ACADEMY COLLEGE BRTS","UDHANA DARWAJA BTRS","UDHANA GIDC MAHATMA GANDHI ROAD",
  "UDHANA RAILWAY STATION","UDHNA GIDC MAHATMA GANDHI ROAD","UGAT S.M.C. WATER TREATMENT PLANT",
  "UMA BHAVAN BHATAR ROAD","UMIYA CHOWK","UMRA HEALTH CENTRE","UMRA NAKA","UNIQUE HOSPITAL",
  "UNN CHAR RASTA","UNN GAM","UNN INDUSTRIAL ESTATE","UTRAN","UTRAN LAKE GARDEN","UTRAN POWER HOUSE",

  "V.N.GODHANI SCHOOL","V.N.S.G.U UNIVERSITY","V.T.CHOKSI COLLEGE","VAADINATH CHOWK","VADOD GAM",
  "VALAK GAM BRTS","VALLABHACHARYA ROAD BRTS","VANITA VISHRAM GROUND","VANMALI JUNCTION BTRS","VARELI",
  "VARIAV GAM","VARIYALI BAZAR POLICE CHOWKI","VARIYAV JAKATNAKA","VASANT BHIKHA NI VADI","VASVARI GAAM",
  "VASVARI LAKE","VEDCHA PATIYA","VELANJA GAAM","VENUS ESTATE","VESU GAAM","VICTORIA PALM","VIDHATA TOWNSHIP PARVAT",
  "VIDHI BHAWAN","VISHWAKARMA JUNCTION","VIVEKANAND COLLEGE",

  "WADI FALIYA","WESTERN CITY",

  "Y JUNCTION DUMAS ROAD","YOGI CHOWK","YOGI NAGAR JUNCTION"
  ];
  
}