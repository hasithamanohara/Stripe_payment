import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:payment/components/textfeild.dart';
import 'package:payment/screens/Payment/payment.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController amountChanged = TextEditingController();
  TextEditingController desChanged = TextEditingController();
  TextEditingController nameChanged = TextEditingController();
  TextEditingController addresChanged = TextEditingController();
  TextEditingController cityChanged = TextEditingController();
  TextEditingController stateChanged = TextEditingController();
  TextEditingController countryChanged = TextEditingController();
  TextEditingController pinChanged = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final _formKey1 = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();
  final _formKey3 = GlobalKey<FormState>();
  final _formKey4 = GlobalKey<FormState>();
  final _formKey5 = GlobalKey<FormState>();
  final _formKey6 = GlobalKey<FormState>();
  final _formKey7 = GlobalKey<FormState>();

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

  //paymentsheet
  Future<void> initPaymentSheet() async {
    try {
      // 1. create payment intent on the server
      final data = await createPayment(
          amount: amountChanged.text,
          currency: selectedCurrency,
          description: desChanged.text);

      // 2. initialize the payment sheet
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          // Set to true for custom flow
          customFlow: false,
          // Main params
          merchantDisplayName: 'Stripe Test',
          paymentIntentClientSecret: data['client_secret'],
          // Customer keys
          customerEphemeralKeySecret: data['ephemeralKey'],
          customerId: data['id'],

          // Extra options
          // applePay: const PaymentSheetApplePay(
          //   merchantCountryCode: 'US',
          // ),
          // googlePay: const PaymentSheetGooglePay(
          //   merchantCountryCode: 'US',
          //   testEnv: true,
          // ),
          style: ThemeMode.dark,
        ),
      );
      // setState(() {
      //   _ready = true;
      // });
      print("222222222222222222222");
      print(data.toString());
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
      print("payment not successfull");
      rethrow;
    }
  }

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
          child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Text('Donate to the project'),
            const SizedBox(
              height: 20,
            ),
            //amount
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
            ),

            //desc
            Container(
              margin: const EdgeInsets.all(10),
              child: CustomReusbleTextFeild(
                formKey: _formKey7,
                title: "Description",
                hintText: "This is a test description",
                controller: desChanged,
                isNumber: false,
              ),
            ),

            //description
            Container(
              margin: const EdgeInsets.all(10),
              child: CustomReusbleTextFeild(
                formKey: _formKey1,
                title: "Address",
                hintText: "Thanamalwila",
                controller: addresChanged,
                isNumber: false,
              ),
            ),
            //Address line 1
            Container(
              margin: const EdgeInsets.all(10),
              child: CustomReusbleTextFeild(
                formKey: _formKey2,
                title: "Address",
                hintText: "Thanamalwila",
                controller: addresChanged,
                isNumber: false,
              ),
            ),

            //city
            Container(
              margin: const EdgeInsets.all(10),
              child: CustomReusbleTextFeild(
                formKey: _formKey3,
                title: "City",
                hintText: "Thanamalwila",
                controller: cityChanged,
              ),
            ),

            //state
            Container(
              margin: const EdgeInsets.all(10),
              child: CustomReusbleTextFeild(
                  formKey: _formKey4,
                  title: "State",
                  hintText: "Southern",
                  controller: stateChanged),
            ),

            //Country
            Container(
              margin: const EdgeInsets.all(10),
              child: CustomReusbleTextFeild(
                  formKey: _formKey5,
                  title: "Country",
                  hintText: "Sri lanka",
                  controller: countryChanged),
            ),

            //pin
            Container(
              margin: const EdgeInsets.all(10),
              child: CustomReusbleTextFeild(
                  formKey: _formKey6,
                  title: "Pin Code",
                  hintText: "0100",
                  controller: pinChanged),
            ),

            ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate() &&
                      _formKey7.currentState!.validate()) {
                    await initPaymentSheet();
                    try {
                      await Stripe.instance.presentPaymentSheet();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Payment successful')),
                      );
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: Text(
                          'Error: $e',
                        )),
                      );
                      print("payment not successfull");
                      rethrow;
                    }
                  }
                },
                child: Text("Continue to pay"))
          ],
        ),
      )),
    );
  }
}
