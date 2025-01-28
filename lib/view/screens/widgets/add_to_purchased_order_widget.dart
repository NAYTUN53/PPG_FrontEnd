import 'package:flutter/material.dart';
import '../../../constants.dart';

class AddToPurchasedOrderWidget extends StatefulWidget {
  final Function(String) onValueChanged;
  final TextEditingController totalAmountController;
  final TextEditingController quantityController;
  final TextEditingController orderDateController;


  const AddToPurchasedOrderWidget(
      {super.key,
      required this.onValueChanged,
      required this.totalAmountController,
      required this.quantityController,
      required this.orderDateController});

  @override
  State<AddToPurchasedOrderWidget> createState() =>
      _AddToPurchasedOrderWidgetState();
}

class _AddToPurchasedOrderWidgetState extends State<AddToPurchasedOrderWidget> {
  List<String> orderStatus = ["ordered", "purchased"];
  String? selectedDeliveredStatus = '';


  @override
  Widget build(BuildContext context) {

    // _deliveredStatus();
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        TextField(
          controller: widget.orderDateController,
          decoration: const InputDecoration(
              prefixIcon: Icon(Icons.calendar_today),
              labelText: "Order Date",
              border: OutlineInputBorder()),
          readOnly: true,
          onTap: (){
            _selectDate();
          },
        ),

        const SizedBox(
          height: 10,
        ),

        // Quantity Text form field
        TextFormField(
          keyboardType: TextInputType.number,
          controller: widget.quantityController,
          validator: (value) {
            if (value!.isEmpty) {
              return 'Please enter quantity';
            } else {
              return null;
            }
          },
          decoration: InputDecoration(
              label: const Text("Quantity"),
              hintText: "Quantity",
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
        // Order Date

        // Total Amount Text form field
        TextFormField(
          keyboardType: TextInputType.number,
          controller: widget.totalAmountController,
          validator: (value) {
            if (value!.isEmpty) {
              return 'Please enter total amount';
            } else {
              return null;
            }
          },
          decoration: InputDecoration(
              label: const Text("Total Amount"),
              hintText: "Total Amount",
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
            // value: selectedDeliveredStatus,
            decoration: InputDecoration(
                labelText: "Delivery Status",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10))),
            items: orderStatus
                .map((e) => DropdownMenuItem(
                      value: e,
                      child: Text(e),
                    ))
                .toList(),
            onChanged: (value) {
              setState(() {
                selectedDeliveredStatus = value as String;
              });
            })
      ],
    );
  }

  Future<void> _selectDate() async {
    DateTime? selectedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2023),
        lastDate: DateTime.now().add(const Duration(days: 365)));

    if(selectedDate != null){
      setState(() {
        widget.orderDateController.text = selectedDate.toString().split(" ")[0];

      });
    }
  }
}
