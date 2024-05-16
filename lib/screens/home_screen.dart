import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:payment/components/textfeild.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController amountChanged = new TextEditingController();
  TextEditingController nameChanged = new TextEditingController();
  TextEditingController addresChanged = new TextEditingController();
  TextEditingController cityChanged = new TextEditingController();
  TextEditingController stateChanged = new TextEditingController();
  TextEditingController countryChanged = new TextEditingController();
  TextEditingController pinChanged = new TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final _formKey1 = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();
  final _formKey3 = GlobalKey<FormState>();
  final _formKey4 = GlobalKey<FormState>();
  final _formKey5 = GlobalKey<FormState>();
  final _formKey6 = GlobalKey<FormState>();

  List<String> currencyList = <String>[
    'USD',
    'EUR',
    'GBP',
    'JPY',
    'AUD',
    'CAD',
    'CHF',
    'CNY',
    'HKD',
    'IDR',
    'ILS',
  ];

  String selectedCurrency = 'USD';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'payment',
          style: TextStyle(
            color: Color.fromARGB(255, 0, 0, 0),
            fontSize: 20,
          ),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            Text('Donate'),
            SizedBox(
              height: 20,
            ),
            Container(
              margin: const EdgeInsets.all(10),
              child: Row(
                children: [
                  Expanded(
                    flex: 5,
                    child: CustomReusbleTextFeild(
                      title: "amount",
                      hintText: "0.00",
                      formKey: _formKey,
                      controller: amountChanged,
                      isNumber: true,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  DropdownMenu<String>(
                    inputDecorationTheme: InputDecorationTheme(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onSelected: (String? value) {
                      setState(() {
                        selectedCurrency = value!;
                      });
                    },
                    dropdownMenuEntries:
                        currencyList.map<DropdownMenuEntry<String>>(
                      (String value) {
                        return DropdownMenuEntry<String>(
                          value: value,
                          label: value,
                        );
                      },
                    ).toList(),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}