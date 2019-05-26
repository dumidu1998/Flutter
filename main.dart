import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: "My first App",
    home: SIform(),
    theme: ThemeData(
      brightness: Brightness.dark,
      primaryColor: Colors.indigo,
      accentColor: Colors.amber,
    ),
  ));
}

class SIform extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SIformstate();
  }
}

class SIformstate extends State<SIform> {

  var formKey= GlobalKey<FormState>();
  var currencies = ['Rupees', 'Dollers', 'Euro', 'Others'];
  final _minimumPadding = 5.0;
  var currentlyselected = 'Rupees';
  var display = '';

  TextEditingController principal = TextEditingController();
  TextEditingController rate = TextEditingController();
  TextEditingController term = TextEditingController();

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.title;

    return Scaffold(
      //resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text("Simple Interest Calculator"),
      ),
      body: Form(
        key: formKey,
        child: Padding(
            padding: EdgeInsets.all(_minimumPadding * 2),
            child: ListView(
              children: <Widget>[
                getimageasset(),
                Padding(
                    padding: EdgeInsets.only(
                        top: _minimumPadding, bottom: _minimumPadding),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      style: textStyle,
                      controller: principal,
                      validator: (String value){
                        if (value.isEmpty){
                          return 'Please Enter Principal Amount';
                        }
                      },
                      decoration: InputDecoration(
                          labelText: 'Principal',
                          hintText: 'Enter Principal eg. 12000',
                          labelStyle: textStyle,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0))),
                    )),
                Padding(
                    padding: EdgeInsets.only(
                        top: _minimumPadding, bottom: _minimumPadding),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      style: textStyle,
                      controller: rate,
                      validator: (String value){
                          if (value.isEmpty){
                            return 'Please Enter the Rate of Interest';
                          }
                        },
                      decoration: InputDecoration(
                          labelText: 'Rate of Interest',
                          hintText: 'In percent',
                          labelStyle: textStyle,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0))),
                    )),
                Padding(
                    padding: EdgeInsets.only(
                        top: _minimumPadding, bottom: _minimumPadding),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                            child: TextFormField(
                          keyboardType: TextInputType.number,
                          style: textStyle,
                          controller: term,
                          validator: (String value){
                                if (value.isEmpty){
                                  return 'Please Enter Time';
                                }
                              },
                          decoration: InputDecoration(
                              labelText: 'Term',
                              hintText: 'Time in Years',
                              labelStyle: textStyle,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0))),
                        )),
                        Container(
                          width: _minimumPadding * 5,
                        ),
                        Expanded(
                            child: DropdownButton(
                          items: currencies.map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          value: currentlyselected,
                          onChanged: (String newValueSelected) {
                            onDropDownSelected(newValueSelected);
                          },
                        ))
                      ],
                    )),
                Padding(
                    padding: EdgeInsets.only(
                        bottom: _minimumPadding, top: _minimumPadding),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: RaisedButton(
                              color: Theme.of(context).accentColor,
                              textColor: Theme.of(context).primaryColorDark,
                              onPressed: () {
                                setState(() {
                                  if (formKey.currentState.validate()) {
                                    this.display = calculateReturn();
                                  }});
                              },
                              child: Text(
                                'Calculate',
                                textScaleFactor: 1.5,
                              )),
                        ),
                        Expanded(
                          child: RaisedButton(
                              elevation: 0.1,
                              color: Theme.of(context).primaryColorDark,
                              textColor: Theme.of(context).primaryColorLight,
                              onPressed: () {
                                setState(() {
                                  reset();
                                });
                              },
                              child: Text(
                                'RESET',
                                textScaleFactor: 1.5,
                              )),
                        )
                      ],
                    )),
                Padding(
                  padding: EdgeInsets.all(_minimumPadding * 2),
                  child: Text(
                    this.display,
                    style: textStyle,
                  ),
                )
              ],
            )),
      ),
    );
  }

  Widget getimageasset() {
    AssetImage assetImage = AssetImage('images/bb.png');
    Image image = Image(
      image: assetImage,
      width: 150.0,
      height: 100.0,
    );

    return Container(
      child: image,
      margin: EdgeInsets.all(_minimumPadding * 4),
    );
  }

  void onDropDownSelected(String newValueSelected) {
    setState(() {
      this.currentlyselected = newValueSelected;
    });
  }

  String calculateReturn() {
    double principalv = double.parse(principal.text);
    double ratev = double.parse(rate.text);
    double termv = double.parse(term.text);

    double tot = principalv + (principalv * ratev * termv) / 100;

    String result =
        'After $termv years, your investment will be worth $tot $currentlyselected';
    return result;
  }

  void reset() {
    principal.text = '';
    rate.text = '';
    term.text = '';
    display = '';
    currentlyselected = currencies[0];
  }
}
