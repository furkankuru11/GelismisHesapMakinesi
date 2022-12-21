import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class HesapMakinesi extends StatefulWidget {
  HesapMakinesi({Key? key}) : super(key: key);

  @override
  State<HesapMakinesi> createState() => _HesapMakinesiState();
}

class _HesapMakinesiState extends State<HesapMakinesi> {
  String sonuc = "";
  String denklem = "";
  String ifade = "";
  double denklemBoyutu = 40.0;

  double sonucBoyutu = 50.0;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromARGB(255, 11, 14, 20),
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
            child: Text(
              denklem,
              style: TextStyle(fontSize: denklemBoyutu),
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 30, 10, 0),
            child: Text(
              sonuc,
              style: TextStyle(fontSize: sonucBoyutu),
            ),
          ),
          Expanded(child: Divider()),
          Row(
            children: [
              Container(
                width: MediaQuery.of(context).size.width * .75,
                child: Table(
                  children: [
                    TableRow(children: [
                      Buttonlar("C", 1, Color.fromARGB(255, 146, 142, 142)),
                      Buttonlar("+/-", 1, Color.fromARGB(255, 146, 142, 142)),
                      Buttonlar("⌫", 1, Color.fromARGB(255, 146, 142, 142)),
                    ]),
                    TableRow(children: [
                      Buttonlar("7", 1, Color.fromARGB(96, 163, 161, 161)),
                      Buttonlar("8", 1, Color.fromARGB(96, 163, 161, 161)),
                      Buttonlar("9", 1, Color.fromARGB(96, 163, 161, 161)),
                    ]),
                    TableRow(children: [
                      Buttonlar("4", 1, Color.fromARGB(96, 163, 161, 161)),
                      Buttonlar("5", 1, Color.fromARGB(96, 163, 161, 161)),
                      Buttonlar("6", 1, Color.fromARGB(96, 163, 161, 161)),
                    ]),
                    TableRow(children: [
                      Buttonlar("1", 1, Color.fromARGB(96, 163, 161, 161)),
                      Buttonlar("2", 1, Color.fromARGB(96, 163, 161, 161)),
                      Buttonlar("3", 1, Color.fromARGB(96, 163, 161, 161)),
                    ]),
                    TableRow(children: [
                      Buttonlar(".", 1, Color.fromARGB(96, 163, 161, 161)),
                      Buttonlar("0", 1, Color.fromARGB(96, 163, 161, 161)),
                      Buttonlar("00", 1, Color.fromARGB(96, 163, 161, 161)),
                    ]),
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.25,
                child: Table(
                  children: [
                    TableRow(children: [
                      Buttonlar("/", 1, Colors.orange),
                    ]),
                    TableRow(children: [
                      Buttonlar("*", 1, Colors.orange),
                    ]),
                    TableRow(children: [
                      Buttonlar("+", 1, Colors.orange),
                    ]),
                    TableRow(children: [
                      Buttonlar("-", 1, Colors.orange),
                    ]),
                    TableRow(children: [
                      Buttonlar("=", 1, Colors.orange),
                    ]),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget Buttonlar(
      String buttonIcerik, double buttonYukseklik, Color buttonRenk) {
    return Container(
      margin: EdgeInsets.only(top: 1),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40), color: buttonRenk),
      height: MediaQuery.of(context).size.height * 0.1 * buttonYukseklik,
      //color: buttonRenk,
      child: FlatButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        padding: EdgeInsets.all(0),
        onPressed: () => buttonPress(buttonIcerik),
        child: Text(
          buttonIcerik,
          style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.normal,
              color: Colors.white),
        ),
      ),
    );
  }

  buttonPress(buttonIcerik) {
    setState(() {
      if (buttonIcerik == "C") {
        denklem = "0";
        sonuc = "0";
      } else if (buttonIcerik == "⌫") {
        denklem = denklem.substring(0, denklem.length - 1);
        if (denklem == "") {
          denklem = "0";
        }
      } else if (buttonIcerik == "=") {
        ifade = denklem;

        try {
          Parser p = Parser();
          Expression exp = p.parse(ifade);
          ContextModel Cm = ContextModel();
          sonuc = "${exp.evaluate(EvaluationType.REAL, Cm)}";
        } catch (e) {
          sonuc = "Hata";
        }
      } else {
        if (denklem == "0") {
          denklem = buttonIcerik;
        } else {
          denklem = denklem + buttonIcerik;
        }
      }
    });
  }
}
