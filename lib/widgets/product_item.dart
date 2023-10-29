import 'package:crud_api/screens/add_new_product_screen.dart';
import 'package:flutter/material.dart';

class ProductItem extends StatefulWidget {
  const ProductItem({super.key});

  @override
  State<ProductItem> createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
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
        'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?auto=format&fit=crop&q=80&w=1000&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8M3x8cHJvZHVjdHxlbnwwfHwwfHx8MA%3D%3D',
        width: 80,
      ),
      title: const Text('Product name'),
      subtitle: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text('Product code'),
              SizedBox(width: 24,),
              Text('Product price'),
            ],
          ),
          Text('Product Description'),
        ],
      ),
      trailing: const Text('\$120'),
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
