import 'dart:convert';
import 'package:crud_api/screens/product_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class AddNewProductScreen extends StatefulWidget {
  final Product? product;

  const AddNewProductScreen({
    super.key,
    this.product,
  });

  @override
  State<AddNewProductScreen> createState() => _AddNewProductScreenState();
}

class _AddNewProductScreenState extends State<AddNewProductScreen> {
  final TextEditingController _titleTEController = TextEditingController();
  final TextEditingController _productCodeTEController =
      TextEditingController();
  final TextEditingController _quantityTEController = TextEditingController();
  final TextEditingController _priceTEController = TextEditingController();
  final TextEditingController _totalPriceTEController = TextEditingController();
  final TextEditingController _imageUrlTEController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool addInProgress = false;

  Future<void> addNewProduct() async {
    addInProgress = true;
    setState(() {});
    final Map<String, String> inputMap = {
      "ProductName": _titleTEController.text.trim(),
      "ProductCode": _productCodeTEController.text.trim(),
      "Img": _imageUrlTEController.text.trim(),
      "UnitPrice": _priceTEController.text.trim(),
      "Qty": _quantityTEController.text.trim(),
      "TotalPrice": _totalPriceTEController.text.trim(),
    };

    final Response response = await post(
        Uri.parse('https://crud.teamrabbil.com/api/v1/CreateProduct'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(inputMap));
    if (response.statusCode == 200) {
      _titleTEController.clear();
      _productCodeTEController.clear();
      _imageUrlTEController.clear();
      _priceTEController.clear();
      _quantityTEController.clear();
      _totalPriceTEController.clear();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Produtc has been added'),
        ),
      );
    } else if (response.statusCode == 400) {}
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Produtc Code Should be Unique'),
      ),
    );

    addInProgress = false;
    setState(() {});
  }

  Future<void> updateProduct() async {
    addInProgress = true;
    setState(() {});
    final Map<String, String> inputMap = {
      "ProductName": _titleTEController.text.trim(),
      "ProductCode": _productCodeTEController.text.trim(),
      "Img": _imageUrlTEController.text.trim(),
      "UnitPrice": _priceTEController.text.trim(),
      "Qty": _quantityTEController.text.trim(),
      "TotalPrice": _totalPriceTEController.text.trim(),
    };

    final Response response = await post(
        Uri.parse('https://crud.teamrabbil.com/api/v1/UpdateProduct/${widget.product!.id}'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(inputMap));
    if (response.statusCode == 200) {
      _titleTEController.clear();
      _productCodeTEController.clear();
      _imageUrlTEController.clear();
      _priceTEController.clear();
      _quantityTEController.clear();
      _totalPriceTEController.clear();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Produtc has been Updated'),
        ),
      );
    } else if (response.statusCode == 400) {}
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Produtc Code Should be Unique'),
      ),
    );

    addInProgress = false;
    setState(() {});
  }

  @override
  void initState() {
    if (widget.product != null) {
      _titleTEController.text = widget.product!.productName;
      _productCodeTEController.text = widget.product!.productCode;
      _imageUrlTEController.text = widget.product!.image;
      _quantityTEController.text = widget.product!.quantity;
      _totalPriceTEController.text = widget.product!.totalPrice;
      _priceTEController.text = widget.product!.unitPrice;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add new product'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _titleTEController,
                  decoration: const InputDecoration(
                      label: Text('Title'), hintText: 'Enter product title'),
                  validator: isValidate,
                ),
                TextFormField(
                  controller: _productCodeTEController,
                  decoration: const InputDecoration(
                      label: Text('Product code'),
                      hintText: 'Enter product code'),
                  validator: isValidate,
                ),
                TextFormField(
                  keyboardType: TextInputType.text,
                  controller: _imageUrlTEController,
                  decoration: const InputDecoration(
                      label: Text('Product Image'),
                      hintText: 'Enter Image Url'),
                  validator: isValidate,
                ),
                TextFormField(
                  controller: _quantityTEController,
                  decoration: const InputDecoration(
                      label: Text('Quantity'),
                      hintText: 'Enter product Quantity'),
                  validator: isValidate,
                ),
                TextFormField(
                  controller: _priceTEController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      label: Text('Price'), hintText: 'Enter product Price'),
                  validator: isValidate,
                ),
                TextFormField(
                  controller: _totalPriceTEController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      label: Text('Total Price'),
                      hintText: 'Enter product Total Price'),
                  validator: isValidate,
                ),
                const SizedBox(
                  height: 25,
                ),
                SizedBox(
                    width: double.infinity,
                    child: addInProgress
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 14),
                                textStyle: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                )),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                if(widget.product ==null){
                                  addNewProduct();
                                }
                                else {updateProduct();}
                              }
                            },
                            child: widget.product != null
                                ? const Text('Update')
                                : const Text('Add'))),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String? isValidate(String? value) {
    if (value?.trim().isNotEmpty ?? false) {
      return null;
    }
    return 'Enter valid value';
  }

  void dispose() {
    _titleTEController.dispose();
    _productCodeTEController.dispose();
    _quantityTEController.dispose();
    _priceTEController.dispose();
    _totalPriceTEController.dispose();
    _imageUrlTEController.dispose();
  }
}
