import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pwar_pwar_gyi_app/constants.dart';
import 'package:pwar_pwar_gyi_app/controller/category_controller.dart';
import 'package:pwar_pwar_gyi_app/controller/item_controller.dart';
import 'package:pwar_pwar_gyi_app/controller/purchased_item_controller.dart';
import 'package:pwar_pwar_gyi_app/controller/purchased_order_controller.dart';
import 'package:pwar_pwar_gyi_app/controller/supplier_controller.dart';
import 'package:pwar_pwar_gyi_app/model/supplier.dart';
import 'package:pwar_pwar_gyi_app/view/screens/widgets/supplier_information_widget.dart';
import 'package:pwar_pwar_gyi_app/view/screens/widgets/add_to_purchased_order_widget.dart';

import '../../../model/category.dart';

class AddItemScreen extends ConsumerStatefulWidget {
  const AddItemScreen({super.key});

  @override
  ConsumerState<AddItemScreen> createState() => _AddItemScreenState();
}

class _AddItemScreenState extends ConsumerState<AddItemScreen> {
  ImagePicker imagePicker = ImagePicker();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController supplierNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController totalAmountController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController orderDateController = TextEditingController();
  final ItemController _itemController = ItemController();
  late Future<List<Category>> futureCategories;
  late String itemCode;
  late String brand;
  late String itemName;
  late String description;
  late List<Map<String, dynamic>> warranty;
  bool isLoading = false;
  Category? selectedCategory;
  bool? isChecked = false;
  String deliveryStatus = '';
  List<File> images = [];
  chooseImage() async {
    final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedFile == null) {
      return null;
    } else {
      setState(() {
        images.add(File(pickedFile.path));
      });
    }
  }

  Future<void> uploadToThreeCollections(
      {required String supplierName,
      required String email,
      required String phone,
      required String address,
      required price,
      required context}) async {
    SupplierController supplierController = SupplierController();
    PurchasedItemController purchasedItemController = PurchasedItemController();
    PurchasedOrderController purchasedOrderController =
        PurchasedOrderController();
    try {
      selectedSupplier == null
          ? await supplierController
              .uploadSupplier(
                  id: '',
                  supplierName: supplierName,
                  email: email,
                  phone: phone,
                  address: address,
                  context: context)
              .whenComplete(() async {
              final lastInsertedSupplier =
                  await supplierController.loadLastSupplier();

              await purchasedOrderController
                  .uploadPurchasedOrder(
                      id: '',
                      supplierId: lastInsertedSupplier['_id'],
                      orderDate: orderDateController.text,
                      deliveryStatus: deliveryStatus,
                      totalAmount: int.parse(totalAmountController.text),
                      context: context)
                  .whenComplete(() async {
                final lastInsertedOrder =
                    await purchasedOrderController.loadLastOrders();
                final lastInsertedItems = await _itemController.loadLastItems();
                await purchasedItemController.uploadPurchasedItem(
                    id: '',
                    purchaseOrderId: lastInsertedOrder['_id'],
                    itemId: lastInsertedItems['_id'],
                    quantity: int.parse(quantityController.text),
                    price: price,
                    context: context);
              });
            })
          : await purchasedOrderController
              .uploadPurchasedOrder(
                  id: '',
                  supplierId: selectedSupplier!.id,
                  orderDate: orderDateController.text,
                  deliveryStatus: deliveryStatus,
                  totalAmount: int.parse(totalAmountController.text),
                  context: context)
              .whenComplete(() async {
              final lastInsertedOrder =
                  await purchasedOrderController.loadLastOrders();
              final lastInsertedItems = await _itemController.loadLastItems();
              await purchasedItemController.uploadPurchasedItem(
                  id: '',
                  purchaseOrderId: lastInsertedOrder['_id'],
                  itemId: lastInsertedItems['_id'],
                  quantity: int.parse(quantityController.text),
                  price: price,
                  context: context);
            });
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  void _onDropDownChangedValue(String orderStatus) {
    setState(() {
      deliveryStatus = orderStatus;
    });
  }

  @override
  void initState() {
    super.initState();
    futureCategories = CategoryController().loadCategories();
    futureSuppliers = supplierController.loadSupplier();
  }

  late Future<List<Supplier>> futureSuppliers;
  Supplier? selectedSupplier;
  SupplierController supplierController = SupplierController();

  loadSupplierBySupplierId(String supplierId) async {
    try {
      final supplierData =
          await supplierController.loadSupplierBySupplierId(supplierId);
      supplierNameController.text = supplierData['supplierName'];
      emailController.text = supplierData['email'];
      phoneController.text = supplierData['phone'];
      addressController.text = supplierData['address'];
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Add Products",
          style: GoogleFonts.montserrat(
              fontSize: 20, fontWeight: FontWeight.bold, letterSpacing: 1),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),

                GridView.builder(
                    shrinkWrap: true,
                    itemCount: images.length + 1,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 4,
                            mainAxisSpacing: 4,
                            childAspectRatio: 1),
                    itemBuilder: (context, index) {
                      return index == 0
                          ? Container(
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Center(
                                child: IconButton(
                                    onPressed: () {
                                      chooseImage();
                                    },
                                    icon: const Icon(Icons.camera)),
                              ),
                            )
                          : Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: Image.file(images[index - 1],
                                    width: 50, height: 50, fit: BoxFit.cover),
                              ),
                            );
                    }),

                const SizedBox(
                  height: 20,
                ),

                // CategoryId Drop down menu field

                FutureBuilder(
                    future: futureCategories,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (snapshot.hasError) {
                        return Center(
                          child: Text("Error: ${snapshot.error}"),
                        );
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return const Center(
                          child: Text("Categories not found"),
                        );
                      } else {
                        return DropdownButtonFormField(
                            decoration: InputDecoration(
                                labelText: "Select Category",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10))),
                            items: snapshot.data!.map((Category category) {
                              return DropdownMenuItem(
                                  value: category,
                                  child: Text(category.categoryName));
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                selectedCategory = value;
                              });
                            });
                      }
                    }),

                const SizedBox(
                  height: 10,
                ),
                // Item Code Text form field
                TextFormField(
                  onChanged: (value) {
                    itemCode = value;
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter item code';
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                      label: const Text("Item Code"),
                      hintText: "Item Code",
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

                // Type Text form field
                TextFormField(
                  onChanged: (value) {
                    brand = value;
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter brand';
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                      label: const Text("Brand"),
                      hintText: "Brand",
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

                // Brand Text form field
                TextFormField(
                  onChanged: (value) {
                    itemName = value;
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please Item Name';
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                      label: const Text("Item Name"),
                      hintText: "Item Name",
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

                // Price Text form field
                TextFormField(
                  keyboardType: TextInputType.number,
                  controller: priceController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter price';
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                      label: const Text("Item Price"),
                      hintText: "Item Price",
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

                // components warranty Text form field
                TextFormField(
                  onChanged: (value) {
                    warranty = [
                      {"components": value}
                    ];
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter warranty part';
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                      label: const Text("Warranty Part"),
                      hintText: "Warranty Part",
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

                // warranty duration Text form field
                TextFormField(
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    warranty = [
                      {"durationMonths": value}
                    ];
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter warranty months';
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                      label: const Text("Warranty Months"),
                      hintText: "Warranty Months",
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

                // Description Text form field
                TextFormField(
                  onChanged: (value) {
                    description = value;
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter description';
                    } else {
                      return null;
                    }
                  },
                  maxLines: 3,
                  maxLength: 500,
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

                // Quick Sale

                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Checkbox(
                        value: isChecked,
                        onChanged: (bool? value) {
                          setState(() {
                            isChecked = value;
                          });
                        }),
                    Text(
                      "Add to purchased item",
                      style: GoogleFonts.montserrat(
                        fontSize: 14,
                      ),
                    )
                  ],
                ),

                isChecked!
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          FutureBuilder(
                              future: futureSuppliers,
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else if (snapshot.hasError) {
                                  return Center(
                                    child: Text("Error: ${snapshot.error}"),
                                  );
                                } else if (!snapshot.hasData ||
                                    snapshot.data!.isEmpty) {
                                  return const Center(
                                    child: Text("Suppliers not found"),
                                  );
                                } else {
                                  return snapshot.data!.isEmpty
                                      ? const Text("No Existing Supplier")
                                      : DropdownButtonFormField(
                                          decoration: InputDecoration(
                                              labelText:
                                                  "Select from existing suppliers",
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10))),
                                          items: snapshot.data!
                                              .map((Supplier supplier) {
                                            return DropdownMenuItem(
                                                value: supplier,
                                                child: Text(
                                                    supplier.supplierName));
                                          }).toList(),
                                          onChanged: (value) {
                                            setState(() {
                                              selectedSupplier = value;
                                              loadSupplierBySupplierId(
                                                  selectedSupplier!.id);
                                            });
                                          });
                                }
                              }),
                          SupplierInformationWidget(
                              supplierNameController: supplierNameController,
                              emailController: emailController,
                              phoneController: phoneController,
                              addressController: addressController),
                          AddToPurchasedOrderWidget(
                            onValueChanged: _onDropDownChangedValue,
                            totalAmountController: totalAmountController,
                            quantityController: quantityController,
                            orderDateController: orderDateController,
                          ),
                        ],
                      )
                    : Container(),

                const SizedBox(
                  height: 150,
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
            await _itemController
                .uploadItems(
                    id: '',
                    pickedImages: images,
                    itemCode: itemCode,
                    categoryId: selectedCategory!.id,
                    brand: brand,
                    itemName: itemName,
                    buyPrice: int.parse(priceController.text),
                    warranty: warranty,
                    description: description,
                    context: context)
                .whenComplete(() {
              setState(() {
                isLoading = false;
                images.clear();
              });
            });
            isChecked!
                ? await uploadToThreeCollections(
                    supplierName: supplierNameController.text,
                    email: emailController.text,
                    phone: phoneController.text,
                    address: addressController.text,
                    price: int.parse(priceController.text),
                    context: context)
                : null;
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
