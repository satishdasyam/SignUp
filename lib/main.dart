import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Employee Signup Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String? selectedCountry;
  String? selectedCity;

  List<String>? countryList = ["India", "Russia", "China", "Japan"];
  List<String>? cityList = [];
  Map<String, List<String>> countryCityMap = {
    "India": ["Hyderabad", "Pune", "Ahmedabad", "Warangal"],
    "China": ["Beijing", "Shanghai", "Wuhan"],
    "Japan": ["Tokyo", "Hiroshima", "Yokohama"],
    "Russia": ["Moscow", "Saint Petersburg"]
  };

  var snackBar = const SnackBar(content: Text("Submit Clicked"));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          // TRY THIS: Try changing the color here to a specific color (to
          // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
          // change color while the other colors stay the same.
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(widget.title),
        ),
        body: Center(
          // Center is a layout widget. It takes a single child and positions it
          // in the middle of the parent.
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            width: double.infinity,
            height: double.infinity,
            child: ListView(
              //mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const TextField(
                  textInputAction: TextInputAction.next,
                  style: TextStyle(fontSize: 20),
                  decoration: InputDecoration(
                      hintText: "First Name",
                      contentPadding:
                          EdgeInsets.only(left: 8, right: 8, top: 8)),
                ),
                const TextField(
                  textInputAction: TextInputAction.next,
                  style: TextStyle(fontSize: 20),
                  decoration: InputDecoration(
                      hintText: "Last Name",
                      contentPadding:
                          EdgeInsets.only(left: 8, right: 8, top: 8)),
                ),
                const TextField(
                  textInputAction: TextInputAction.next,
                  style: TextStyle(fontSize: 20),
                  decoration: InputDecoration(
                      hintText: "Email",
                      contentPadding:
                          EdgeInsets.only(left: 8, right: 8, top: 8)),
                ),
                TextField(
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  style: const TextStyle(fontSize: 20),
                  decoration: const InputDecoration(
                      hintText: "Mobile Number",
                      contentPadding:
                          EdgeInsets.only(left: 8, right: 8, top: 8)),
                ),
                DropdownButton(
                    hint: const Text("Countries"),
                    value: selectedCountry,
                    items: countryList?.map((String items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Text(items),
                      );
                    }).toList(),
                    onChanged: onCountryDropDownChanged),
                DropdownButton(
                    hint: const Text("Cities"),
                    value: selectedCity,
                    items: cityList?.map((String items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Text(items),
                      );
                    }).toList(),
                    onChanged: onCityDropDownChanged),
                const TextField(
                  style: TextStyle(fontSize: 20),
                  decoration: InputDecoration(
                      hintText: "Address",
                      contentPadding:
                          EdgeInsets.only(left: 8, right: 8, top: 8)),
                ),
                Container(
                    margin: const EdgeInsets.only(top: 20),
                    child: ElevatedButton(
                        onPressed: submitButtonClick,
                        child: const Text("Submit"))),
              ],
            ),
          ),
        ));
  }

  void onCityDropDownChanged(newValue) {
    setState(() {
      selectedCity = newValue!;
    });
  }

  void onCountryDropDownChanged(newValue) {
    setState(() {
      selectedCountry = newValue!;
      cityList = countryCityMap[selectedCountry];
      selectedCity = cityList?[0];
    });
  }

  void submitButtonClick() {
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
