import 'package:flutter/material.dart';
import '../../../constants.dart';

class SupplierInformationWidget extends StatefulWidget {
   TextEditingController supplierNameController;
   TextEditingController emailController;
   TextEditingController phoneController;
   TextEditingController addressController;

  SupplierInformationWidget(
      {super.key,
      required this.supplierNameController,
      required this.emailController,
      required this.phoneController,
      required this.addressController});

  @override
  State<SupplierInformationWidget> createState() =>
      _SupplierInformationWidgetState();
}

class _SupplierInformationWidgetState extends State<SupplierInformationWidget> {

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [


        const SizedBox(
          height: 10,
        ),
        // Name Text form field
        TextFormField(
          controller: widget.supplierNameController,
          validator: (value) {
            if (value!.isEmpty) {
              return 'Please enter supplier name';
            } else {
              return null;
            }
          },
          decoration: InputDecoration(
              label: const Text("Supplier Name"),
              hintText: "Supplier Name",
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

        // Supplier Email
        TextFormField(
          controller: widget.emailController,
          validator: (value) {
            if (value!.isEmpty) {
              return 'Please enter supplier email';
            } else {
              return null;
            }
          },
          decoration: InputDecoration(
              label: const Text("Supplier Email"),
              hintText: "Supplier Email",
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

        // Supplier phone
        TextFormField(
          keyboardType: TextInputType.number,
          controller: widget.phoneController,
          validator: (value) {
            if (value!.isEmpty) {
              return 'Please enter supplier phone';
            } else {
              return null;
            }
          },
          decoration: InputDecoration(
              label: const Text("Supplier Phone"),
              hintText: "Supplier Phone",
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

        // Supplier address
        TextFormField(
          maxLines: 3,
          maxLength: 200,
          controller: widget.addressController,
          validator: (value) {
            if (value!.isEmpty) {
              return 'Please enter supplier address';
            } else {
              return null;
            }
          },
          decoration: InputDecoration(
              label: const Text("Supplier Address"),
              hintText: "Supplier Address",
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
      ],
    );
  }
}
