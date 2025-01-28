import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pwar_pwar_gyi_app/constants.dart';
import 'package:pwar_pwar_gyi_app/controller/category_controller.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController categoryNameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  bool isLoading = false;
  CategoryController categoryController = CategoryController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        centerTitle: true,
        title: Text(
          "Add Category",
          style:
              GoogleFonts.montserrat(fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // const SizedBox(
                //   height: 10,
                // ),

                // Category Name Text form field
                TextFormField(
                  controller: categoryNameController,

                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter category name';
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                      label: const Text("Category Name"),
                      hintText: "Category Name",
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

                // Description Text Form field
                TextFormField(
                  controller: descriptionController,
                  // validator: (value) {
                  //   if (value!.isEmpty) {
                  //     return 'Please enter description';
                  //   } else {
                  //     return null;
                  //   }
                  // },
                  maxLines: 5,
                  maxLength: 1000,
                  decoration: InputDecoration(
                      label: const Text("Description"),
                      hintText: "Description",
                      hintStyle: const TextStyle(
                        color: Colors.grey,
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: MyColor.color1,
                          ))),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomSheet: // Login Button
          InkWell(
        onTap: () async {
          if (_formKey.currentState!.validate()) {
            setState(() {
              isLoading = true;
            });
            await categoryController
                .uploadCategory(
                    id: '',
                    categoryName: categoryNameController.text.trim(),
                    description: descriptionController.text.trim(),
                    context: context)
                .whenComplete(() {
              setState(() {
                isLoading = false;
                categoryNameController.text = '';
                descriptionController.text = '';

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
                    "Add Item",
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
