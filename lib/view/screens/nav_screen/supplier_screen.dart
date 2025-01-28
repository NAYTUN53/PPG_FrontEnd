import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pwar_pwar_gyi_app/controller/supplier_controller.dart';
import 'package:pwar_pwar_gyi_app/view/screens/widgets/supplier_information_widget.dart';

class SupplierScreen extends StatefulWidget {
  const SupplierScreen({super.key});

  @override
  State<SupplierScreen> createState() => _SupplierScreenState();
}

class _SupplierScreenState extends State<SupplierScreen> {
  SupplierController supplierController = SupplierController();
  bool isLoading = false;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController supplierNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Supplier Information",
        style: GoogleFonts.montserrat(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          letterSpacing: 1,
        ),
        ),
        actions: [
          IconButton(onPressed: (){}, icon: const Icon(Icons.edit))
        ],
      ),
      body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
              key: formKey,
              child: SupplierInformationWidget(
                  supplierNameController: supplierNameController,
                  emailController: emailController,
                  phoneController: phoneController,
                  addressController: addressController))),
      bottomSheet: // Login Button
          InkWell(
        onTap: () async {
          if (formKey.currentState!.validate()) {
            setState(() {
              isLoading = true;
            });
            await supplierController
                .uploadSupplier(
                    id: '',
                    supplierName: supplierNameController.text,
                    email: emailController.text,
                    phone: phoneController.text,
                    address: addressController.text,
                    context: context)
                .whenComplete(() {
              setState(() {
                isLoading = false;
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
