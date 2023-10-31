import 'package:crud_api/screens/add_new_product_screen.dart';
import 'package:crud_api/screens/product_list_screen.dart';
import 'package:flutter/material.dart';




class ProductItem extends StatelessWidget {
  const ProductItem({super.key, required this.product});


  final Product product;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        showDialog(
            context: context,
            builder: (context) {
              return const buildActionDialog();
            });
      },
      leading: Image.network(
        product.image,
        width: 80,
      ),
      title:  Text(product.productName),
      subtitle:  Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(product.productCode),
          SizedBox(width: 24,),
          //Text('Total Price :${product.totalPrice}'),
        ],
      ),
      trailing: Text('${product.unitPrice}'),
    );
  }
}

class buildActionDialog extends StatelessWidget {
  const buildActionDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Select Action'),
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
                      builder: (context) =>
                          const AddNewProductScreen()));
            },
          ),
          const Divider(
            height: 0,
          ),
          ListTile(
              title: Text('Delete'),
              leading: Icon(Icons.delete_forever),
              onTap: () {
                Navigator.pop(context);
              }),
        ],
      ),
    );
  }
}
