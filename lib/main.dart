import 'package:employee_sign_up/home_page.dart';
import 'package:employee_sign_up/signup_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:email_validator/email_validator.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EmployeeApp',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SignUpPage(title: 'Employee Signup Page'),
    );
  }
}

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key, required this.title});

  final String title;

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  String? selectedCountry;
  String? selectedCity;

  List<String>? countryList = ["India", "Russia", "China", "Japan"];
  List<String>? cityList = [];
  List<TextEditingController> textFieldControllerList =
      List.filled(5, TextEditingController());
  Map<String, List<String>> countryCityMap = {
    "India": ["Warangal", "Hyderabad", "Ahmedabad", "Pune"],
    "China": ["Beijing", "Shanghai", "Wuhan"],
    "Japan": ["Tokyo", "Hiroshima", "Yokohama"],
    "Russia": ["Moscow", "Saint Petersburg"]
  };

  late bool isProgressIndicatorToBeShown;

  _SignUpPageState() {
    for (int i = 1; i < textFieldControllerList.length; i++) {
      textFieldControllerList[i] = TextEditingController();
    }
  }

  //final Widget currentPage = const SignUpPage(title: 'Employee Signup Page');

  @override
  void initState() {
    super.initState();
    isProgressIndicatorToBeShown = false;
  }

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
          centerTitle: false,
          title: Text(widget.title),
          leading: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.home),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.more_vert),
            ),
          ],
        ),
        body: Center(
          // Center is a layout widget. It takes a single child and positions it
          // in the middle of the parent.
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            width: double.infinity,
            height: double.infinity,
            child: Stack(children: <Widget>[
              ListView(
                //mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextField(
                    controller: textFieldControllerList[0],
                    textInputAction: TextInputAction.next,
                    style: const TextStyle(fontSize: 20),
                    decoration: const InputDecoration(
                        hintText: "First Name",
                        contentPadding:
                            EdgeInsets.only(left: 8, right: 8, top: 8)),
                  ),
                  TextField(
                    controller: textFieldControllerList[1],
                    textInputAction: TextInputAction.next,
                    style: const TextStyle(fontSize: 20),
                    decoration: const InputDecoration(
                        hintText: "Last Name",
                        contentPadding:
                            EdgeInsets.only(left: 8, right: 8, top: 8)),
                  ),
                  Form(
                      autovalidateMode: AutovalidateMode.always,
                      child: TextFormField(
                        controller: textFieldControllerList[2],
                        textInputAction: TextInputAction.next,
                        style: const TextStyle(fontSize: 20),
                        validator: (value) => EmailValidator.validate(value!)
                            ? null
                            : "Please enter a valid email",
                        decoration: const InputDecoration(
                            hintText: "Email",
                            contentPadding:
                                EdgeInsets.only(left: 8, right: 8, top: 8)),
                      )),
                  TextField(
                    controller: textFieldControllerList[3],
                    textInputAction: TextInputAction.next,
                    maxLength: 12,
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
                  TextField(
                    controller: textFieldControllerList[4],
                    style: const TextStyle(fontSize: 20),
                    decoration: const InputDecoration(
                        hintText: "Address",
                        contentPadding:
                            EdgeInsets.only(left: 8, right: 8, top: 8)),
                  ),
                  Container(
                      margin: const EdgeInsets.only(top: 20),
                      child: ElevatedButton(
                          onPressed: validateFormFields,
                          child: const Text("Submit"))),
                ],
              ),
              Visibility(
                  visible: isProgressIndicatorToBeShown,
                  child: const Center(
                    child: CircularProgressIndicator(),
                  )),
            ]),
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

  void validateFormFields() {
    var snackBar = const SnackBar(content: Text("Please fill all fields"));
    bool areFieldsExempted = false;
    for (int i = 0; i < textFieldControllerList.length; i++) {
      if (kDebugMode) {
        print("TEST:${textFieldControllerList[i].text}");
      }
      if (textFieldControllerList[i].text.isEmpty) {
        areFieldsExempted = true;
        break;
      }
    }
    if (areFieldsExempted || selectedCountry == null) {
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      registerDataInBackend();
    }
  }

  void registerDataInBackend() async {
    setState(() {
      isProgressIndicatorToBeShown = true;
    });

    SignupModel signupModel = SignupModel(
        firstName: textFieldControllerList[0].text,
        lastName: textFieldControllerList[1].text,
        email: textFieldControllerList[2].text,
        phoneNumber: textFieldControllerList[3].text,
        country: selectedCountry ?? "",
        city: selectedCity ?? "",
        address: textFieldControllerList[4].text);
    http.Response response =
        await http.get(Uri.parse("https://jsonplaceholder.typicode.com/users"));
    // List<dynamic> userList = jsonDecode(response.body);
    setState(() {
      isProgressIndicatorToBeShown = false;
    });
    if (response.statusCode == 200) {
      showSuccessAlert(signupModel);
    } else {
      //Failed
    }
  }

  void showSuccessAlert(SignupModel registeredData) {
    Widget okButton = TextButton(
      child: const Text("OK"),
      onPressed: () {
        Navigator.pop(context); // Dismiss dialog
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => HomePage(
                    signupModel: registeredData,
                  )),
        );
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("SignUp Success"),
      content: const Text("Signup is success"),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
