import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pwar_pwar_gyi_app/controller/customer_controller.dart';
import 'package:pwar_pwar_gyi_app/view/screens/widgets/sale_vouncher_widget.dart';
import '../../constants.dart';

class SaleScreen extends StatefulWidget {
  const SaleScreen({super.key});

  @override
  State<SaleScreen> createState() => _SaleScreenState();
}

class _SaleScreenState extends State<SaleScreen> {
  final TextEditingController customerNameController = TextEditingController();
  final TextEditingController customerEmailController = TextEditingController();
  final TextEditingController customerPhoneController = TextEditingController();
  final TextEditingController customerAddressController =
      TextEditingController();
  final TextEditingController totalAmountController = TextEditingController();
  final TextEditingController discountController = TextEditingController();
  final TextEditingController taxController = TextEditingController();
  final TextEditingController saleDateController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isLoading = false;
  bool isChecked = false;
  String selectedPaymentMethod = '';
  CustomerController customerController = CustomerController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Sale",
          style: GoogleFonts.montserrat(
              fontSize: 20, fontWeight: FontWeight.bold, letterSpacing: 1),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 10,
                ),

                // Customer Name Text form field
                TextFormField(
                  controller: customerNameController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter customer name';
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                      label: const Text("Customer Name"),
                      hintText: "Customer Name",
                      hintStyle: const TextStyle(
                        color: Colors.grey,
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: MyColor.color1,
                          ))),
                ),

                const SizedBox(
                  height: 10,
                ),

                // Customer Email Text form field
                TextFormField(
                  controller: customerEmailController,
                  decoration: InputDecoration(
                      label: const Text("Customer Email"),
                      hintText: "Customer Email",
                      hintStyle: const TextStyle(
                        color: Colors.grey,
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: MyColor.color1,
                          ))),
                ),

                const SizedBox(
                  height: 10,
                ),

                // Customer Phone Text form field
                TextFormField(
                  controller: customerPhoneController,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter customer phone';
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                      label: const Text("Customer Phone"),
                      hintText: "Customer Phone",
                      hintStyle: const TextStyle(
                        color: Colors.grey,
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: MyColor.color1,
                          ))),
                ),

                const SizedBox(
                  height: 10,
                ),

                // Customer Address Text form field
                TextFormField(
                  controller: customerAddressController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter customer address';
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                      label: const Text("Customer Address"),
                      hintText: "Customer Address",
                      hintStyle: const TextStyle(
                        color: Colors.grey,
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: MyColor.color1,
                          ))),
                ),

                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Checkbox(
                        value: isChecked,
                        onChanged: (bool? value) {
                          setState(() {
                            isChecked = value!;
                          });
                        }),
                    Text(
                      "Open Sale Voucher",
                      style: GoogleFonts.montserrat(
                        fontSize: 14,
                      ),
                    )
                  ],
                ),
                isChecked
                    ?

                    // Grand Total Text form field
                    SaleVoucherWidget(
                        totalAmountController: totalAmountController,
                        discountController: discountController,
                        taxController: taxController,
                        saleDateController: saleDateController,
                        onChangedValue: (value){
                          setState(() {
                            selectedPaymentMethod = value;

                          });
                        })
                    : Container(),
              ],
            ),
          ),
        ),
      ),
      bottomSheet: // Login Button
          InkWell(
        onTap: () async {
          if (formKey.currentState!.validate()) {
            setState(() {
              isLoading = true;
            });
            await customerController
                .uploadCustomer(
                    id: '',
                    customerName: customerNameController.text.trim(),
                    email: customerEmailController.text.trim(),
                    phone: customerPhoneController.text.trim(),
                    address: customerAddressController.text.trim(),
                    context: context)
                .whenComplete(() {
              setState(() {
                isLoading = false;
                customerNameController.text = '';
                customerEmailController.text = '';
                customerPhoneController.text = '';
                customerAddressController.text = '';
              });
            });
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Please enter all fields')));
          }
        },
        child: Container(
          margin: const EdgeInsets.only(bottom: 20),
          width: MediaQuery.of(context).size.width * 0.95,
          height: 50,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: const Color.fromARGB(255, 3, 51, 84)),
          child: Center(
            child: isLoading
                ? const Center(
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  )
                : Text(
                    "Save",
                    style: GoogleFonts.montserrat(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
          ),
        ),
      ),
    );
  }
}
