import 'package:crud_api/screens/add_new_product_screen.dart';

import 'package:flutter/material.dart';
import '../screens/product_list_screen.dart';

class ProductItem extends StatelessWidget {
  const ProductItem(
      {super.key, required this.product, required this.onPressDelete, });

  final Product product;
  final Function(String) onPressDelete;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        showDialog(
            context: context,
            builder: (context) {
              return productActionDialog(context);
            });
      },
      leading: Image.network(
        product.image,
        width: 80,
      ),
      title: Text(product.productName),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(product.productCode),
          Text('Total price : ${product.totalPrice}'),
          Text('Quantity : ${product.quantity}'),
        ],
      ),
      trailing: Text('\$${product.unitPrice}'),
    );
  }

  AlertDialog productActionDialog(BuildContext context) {
    return AlertDialog(
      title: const Text('Select action'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            title: const Text('Edit'),
            leading: const Icon(Icons.edit),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddNewProductScreen(
                    product: product,
                  ),
                ),
              );
            },
          ),
          const Divider(
            height: 0,
          ),
          ListTile(
            title: const Text('Delete'),
            leading: const Icon(Icons.delete_outline),
            onTap: () {
              Navigator.pop(context);
              onPressDelete(product.id);
            },
          ),
        ],
      ),
    );
  }
}