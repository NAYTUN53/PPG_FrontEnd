import 'package:flutter/material.dart';
import '../../../constants.dart';

class SaleVoucherWidget extends StatefulWidget {
  // const SaleVoucherWidget({super.key});
  final Function(String) onChangedValue;
  final TextEditingController totalAmountController;
  final TextEditingController discountController;
  final TextEditingController taxController;
  final TextEditingController saleDateController;

  const SaleVoucherWidget({
    super.key,
    required this.totalAmountController,
    required this.discountController,
    required this.taxController,
    required this.saleDateController,
    required this.onChangedValue
  });

  @override
  State<SaleVoucherWidget> createState() => _SaleVoucherWidgetState();
}

class _SaleVoucherWidgetState extends State<SaleVoucherWidget> {
  String selectedPaymentMethod = '';
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        TextFormField(
          controller: widget.totalAmountController,
          keyboardType: TextInputType.number,
          validator: (value) {
            if (value!.isEmpty) {
              return 'Please enter grand total';
            } else {
              return null;
            }
          },
          decoration: InputDecoration(
              label: const Text("Grand Total"),
              hintText: "Grand Total",
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
        // Discount Text form field
        TextFormField(
          controller: widget.discountController,
          keyboardType: TextInputType.number,
          validator: (value) {
            if (value!.isEmpty) {
              return 'Please enter discount';
            } else {
              return null;
            }
          },
          decoration: InputDecoration(
              label: const Text("Discount"),
              hintText: "Discount",
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

        // Tax text form field
        TextFormField(
          controller: widget.taxController,
          keyboardType: TextInputType.number,
          validator: (value) {
            if (value!.isEmpty) {
              return 'Please enter tax';
            } else {
              return null;
            }
          },
          decoration: InputDecoration(
              label: const Text("Tax"),
              hintText: "Tax",
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
        DropdownButtonFormField(
          decoration: InputDecoration(
            labelText: "Payment Method",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          items: const [
            DropdownMenuItem(value: 'Cash', child: Text("Cash")),
            DropdownMenuItem(value: 'KBZ Pay', child: Text("KBZ Pay")),
            DropdownMenuItem(value: 'Wave Pay', child: Text("Wave Pay")),
            DropdownMenuItem(value: 'CB Pay', child: Text("CB Pay")),
            DropdownMenuItem(value: 'AYA Pay', child: Text("AYA Pay")),
          ],
          onChanged: (value) {
            setState(() {
              selectedPaymentMethod = value!;
            });
          },
        ),
        const SizedBox(
          height: 10,
        ),
        TextField(
          controller: widget.saleDateController,
          decoration: InputDecoration(
              prefixIcon: const Icon(Icons.calendar_today),
              labelText: "Sale Date",
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0))),
          readOnly: true,
          onTap: () {
            _selectDate();
          },
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }

  Future<void> _selectDate() async {
    DateTime? selectedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2023),
        lastDate: DateTime.now().add(const Duration(days: 365)));

    if (selectedDate != null) {
      setState(() {
        widget.saleDateController.text = selectedDate.toString().split(" ")[0];
      });
    }
  }
}
