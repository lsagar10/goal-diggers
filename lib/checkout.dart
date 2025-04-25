import 'package:esewa_flutter_sdk/esewa_config.dart';
import 'package:esewa_flutter_sdk/esewa_flutter_sdk.dart';
import 'package:esewa_flutter_sdk/esewa_payment.dart';
import 'package:esewa_flutter_sdk/esewa_payment_success_result.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goal_diggers/order_success.dart';
import 'package:goal_diggers/src/feature/home/presentation/homepage.dart';
import 'package:http/http.dart' as http;

class Checkout extends StatefulWidget {
  final String totalPrice;
  const Checkout({super.key, required this.totalPrice});

  @override
  State<Checkout> createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  String? selectedPayment;
  final TextEditingController _locationController = TextEditingController();
  final FocusNode _locationFocusNode = FocusNode();

  final List<String> _locationSuggestions = [
    'Kathmandu',
    'Pokhara',
    'Lalitpur',
    'Bhaktapur',
    'Butwal',
    'Dharan',
  ];

  List<String> _filteredLocations = [];
  bool _showSuggestions = false;

  // Sample ordered products (replace with actual cart data if needed)
  final List<String> orderedProducts = [
    "Retro Jersey",
    "Football Boots",
    "Goalkeeper Gloves",
  ];

  @override
  void initState() {
    super.initState();
    _locationFocusNode.addListener(() {
      setState(() {
        _showSuggestions = _locationFocusNode.hasFocus;
        _filteredLocations = _locationSuggestions;
      });
    });
  }

  @override
  void dispose() {
    _locationController.dispose();
    _locationFocusNode.dispose();
    super.dispose();
  }

  void _placeOrder() {
    if (_locationController.text.isEmpty || selectedPayment == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Please select location and payment method')),
      );
      return;
    } else {
      if (selectedPayment == 'esewa') {
        payEsewa();
      } else {
        _goToSuccessPage();
      }
    }
  }

  payEsewa() {
    try {
      EsewaFlutterSdk.initPayment(
        esewaConfig: EsewaConfig(
          environment: Environment.test,
          clientId: 'JB0BBQ4aD0UqIThFJwAKBgAXEUkEGQUBBAwdOgABHD4DChwUAB0R',
          secretId: 'BhwIWQQADhIYSxILExMcAgFXFhcOBwAKBgAXEQ==',
        ),
        esewaPayment: EsewaPayment(
          productId: "1",
          productName: "Jersey",
          productPrice: widget.totalPrice,
          callbackUrl: '',
        ),
        onPaymentSuccess: (EsewaPaymentSuccessResult data) async {
          debugPrint(":::SUCCESS::: => $data");
          verifyTransactionStatus(data);
        },
        onPaymentFailure: (data) {
          debugPrint(":::FAILURE::: => $data");
        },
        onPaymentCancellation: (data) {
          debugPrint(":::CANCELLATION::: => $data");
        },
      );
    } on Exception catch (e) {
      debugPrint("EXCEPTION : ${e.toString()}");
    }
  }

  void verifyTransactionStatus(
    EsewaPaymentSuccessResult result,
  ) async {
    Map data = result.toJson();

    var response = await callVerificationApi(data['refId']);
    print("The Response Is: ${response.body}");
    print("The Response Status Code Is: ${response.statusCode}");

    if (response.statusCode.toString() == "200") {
      _goToSuccessPage();
    } else {
      showDialog(
          context: context,
          builder: (context) => const AlertDialog(
                content: Text('Verification Failed'),
              ));
    }
  }

  callVerificationApi(result) async {
    print("TxnRefd Id: " + result);

    var response = await http.get(
      Uri.parse("https://esewa.com.np/mobile/transaction?txnRefId=$result"),
      headers: {
        'Content-Type': 'application/json',
        'merchantSecret': 'BhwIWQQADhIYSxILExMcAgFXFhcOBwAKBgAXEQ==',
        'merchantId': 'JB0BBQ4aD0UqIThFJwAKBgAXEUkEGQUBBAwdOgABHD4DChwUAB0R ',
      },
    );
    print("Call Verification Api: ${response.statusCode}");
    return response;
  }

  void _goToSuccessPage() {
    Get.offAll(() => const OrderSuccess());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Confirm Order'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Select Location',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: _locationController,
                    focusNode: _locationFocusNode,
                    decoration: InputDecoration(
                      hintText: 'Choose your delivery location',
                      prefixIcon: const Icon(Icons.location_on),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        _filteredLocations = _locationSuggestions
                            .where((loc) =>
                                loc.toLowerCase().contains(value.toLowerCase()))
                            .toList();
                      });
                    },
                  ),
                  const SizedBox(height: 5),
                  if (_showSuggestions)
                    ..._filteredLocations.map(
                      (location) => ListTile(
                        title: Text(location),
                        onTap: () {
                          _locationController.text = location;
                          _locationFocusNode.unfocus();
                          setState(() => _showSuggestions = false);
                        },
                      ),
                    ),
                  const SizedBox(height: 30),
                  const Text(
                    'Select Payment Method',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  _buildPaymentTile(
                    title: 'eSewa',
                    value: 'esewa',
                    imagePath: 'assets/images/esewa.png',
                  ),
                  _buildPaymentTile(
                    title: 'Khalti',
                    value: 'khalti',
                    imagePath: 'assets/images/khalti.png',
                  ),
                  _buildPaymentTile(
                    title: 'Cash on Delivery',
                    value: 'cod',
                    imagePath: 'assets/images/cash.png',
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(16, 10, 16, 20),
            color: Colors.white,
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: _placeOrder,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Purchase',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentTile({
    required String title,
    required String value,
    required String imagePath,
  }) {
    final isSelected = selectedPayment == value;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      decoration: BoxDecoration(
        border: Border.all(
          color: isSelected ? Colors.blue : Colors.grey.shade300,
          width: isSelected ? 2 : 1,
        ),
        borderRadius: BorderRadius.circular(12),
        color: isSelected ? Colors.blue.withOpacity(0.05) : Colors.white,
      ),
      child: ListTile(
        leading: Image.asset(imagePath, height: 30),
        title: Text(title),
        trailing: isSelected
            ? const Icon(Icons.check_circle, color: Colors.blue)
            : null,
        onTap: () {
          setState(() {
            selectedPayment = value;
          });
        },
      ),
    );
  }
}
