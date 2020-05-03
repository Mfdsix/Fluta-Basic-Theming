import 'package:flutter/material.dart';
import 'dart:math';

import 'package:mortgage_payment_starter_app/util/colors.dart';

class MortgageApp extends StatefulWidget {
  @override
  _MortgageAppState createState() => _MortgageAppState();
}

class _MortgageAppState extends State<MortgageApp> {
  double _interest = 0.0;
  int _lengthOfLoan = 0;
  double _homePrice = 0.0;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: ()=> debugPrint("hello"),
        child: Icon(Icons.add),
        ),
       appBar: AppBar(
          title: Text("Mortgage Payments", style: TextStyle(
            fontFamily: "BreeSerif",
          ),),
       ),
    body: Container(
       alignment: Alignment.center,
       padding: EdgeInsets.all(10.0),
      child: ListView(
          scrollDirection: Axis.vertical,
        children: <Widget>[
          Container(
            height: 130,
             child: Card(
                elevation: 5,
               child: Column(
                 mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                      Text("Monthly Payment", style: TextStyle(
                        color: colorPrimary,
                        fontFamily: "BreeSerif",
                      ),),
                      SizedBox(height: 9),
                    Text(" ${ ( _homePrice > 0 && _interest > 0.0) ? "\$${calculateMonthlyPayment(_homePrice, _interest, _lengthOfLoan)}" : "\$0.0"}",
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 28,
                      color: colorPrimaryDark
                    ),)
                  ],
               ),
             ),
          ),

          Container(
            margin: EdgeInsets.only(top: 20),
             decoration: BoxDecoration(
               color: Colors.transparent,
               border: Border.all(
                  color: colorSecondary, //TODO: theme this!
                 style: BorderStyle.solid// //TODO: theme this!
               ),
               borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                 children: <Widget>[
                    TextField(
                      keyboardType: TextInputType.numberWithOptions(decimal: true),
                      style: TextStyle(color: colorPrimaryDark,
                      fontWeight: FontWeight.w500),//TODO: theme this!
                      decoration: InputDecoration(
                         hintText: "Basic Price",
                         enabledBorder: OutlineInputBorder(
                           borderSide: BorderSide(
                             color: colorPrimaryLight,
                             width: 1.5,
                           ),
                           borderRadius: BorderRadius.circular(12)
                         ),
                         focusedBorder: OutlineInputBorder(
                           borderSide: BorderSide(
                             color: colorPrimary,
                             width: 1.5,
                           ),
                           borderRadius: BorderRadius.circular(12)
                         ),
                         hintStyle: TextStyle(
                           fontFamily: "Play",
                         ),
                         prefixIcon: Icon(Icons.attach_money)),
                      onChanged: (String value) {
                        try {
                          _homePrice = double.parse(value);

                        }catch (exception) {
                           _homePrice = 0.0;
                        }

                      },//TODO: theme this!
                    ),
                   Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: <Widget>[
                       Text("Length of Loan (years)"), //TODO: Theme this!

                       Row(
                         children: <Widget>[
                           InkWell(
                             onTap: () {
                               setState(() {
                                 if(_lengthOfLoan > 0) {
                                   _lengthOfLoan -= 5;
                                 }else {
                                   // do nothing
                                 }
                               });
                             },
                             child: Container(
                               width: 40,
                               height: 40,
                               margin: EdgeInsets.all(10),
                               decoration: BoxDecoration(
                                   borderRadius: BorderRadius.circular(16),
                                   color: colorSecondary,
                               ),
                               child: Center(child: Text("-", style: TextStyle(
                                 color: textOnSecondary,
                                 fontWeight: FontWeight.w900,
                               ),),
                               ), //TODO: Style Theme it!
                             ),
                           ),
                           Text("$_lengthOfLoan", style: TextStyle(
                             fontWeight: FontWeight.w900,
                           ),), //TODO: Style Theme it!
                           InkWell(
                               onTap: () {
                                  setState(() {

                                     _lengthOfLoan += 5;
                                  });
                               },
                             child: Container(
                                width: 40,
                               height: 40,
                               margin: EdgeInsets.all(10),
                               decoration: BoxDecoration(
                                   color: colorSecondary,
                                 borderRadius: BorderRadius.circular(16)
                               ),
                               child: Center(child:Text("+", style: TextStyle(
                                 color: textOnSecondary,
                                 fontWeight: FontWeight.w900,
                               ),)), //TODO: theme this!
                             ),
                           )
                         ],
                       )
                     ],
                   ),

                   //Interest
                   Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: <Widget>[
                        Text("Interest"), ////TODO: theme this!
                       Padding(padding: EdgeInsets.all(18), child:Text("${_interest.toStringAsFixed(2)} %",style: TextStyle(
                         color: colorPrimary,
                         fontWeight: FontWeight.w900,
                       ),) )
                     ],
                   ),

                   //Slider
                   Column(
                      children: <Widget>[
                        Slider(
                            min: 0.0,
                            max: 10.0,
                            activeColor: colorPrimaryDark , //TODO: Theme this!
                            inactiveColor: colorPrimaryLight, //TODO: Theme this!
                           // divisions: 10,
                            value: _interest,
                            onChanged: (double newValue) {
                                  setState(() {

                                     _interest = newValue;
                                  });
                            })
                      ],
                   )

                 ],
              ),
            ),
          )
          
          
        ],
      ),
    ),
    );
    
  }

  //Monthly Payment Formula
  /*
   n = number of payments
   c = monthly interest rate

   int n = 12 * years;
   double c = rate / 12.0 / 100.0;
   double payment = loan * c * Math.pow(1 + c, n) /
                    (Math.pow(1 + c, n) - 1);
   */
   calculateMonthlyPayment(double homePrice, double interest, int loanLength ) {
     int n = 12 * loanLength;
     double c = interest / 12.0 / 100.0;
     double monthlyPayment = 0.0;

     if (homePrice < 0 || homePrice.toString().isEmpty || homePrice == null) {
        //no go!
      // _homePrice = 0.0;
     }else {
       monthlyPayment = homePrice * c * pow(1 + c, n) / (pow(1 + c, n) - 1);
     }


     return monthlyPayment.toStringAsFixed(2);
  }
}
