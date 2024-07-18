import 'package:flutter/material.dart';
// import 'package:flutter_app/data/models/response/product_response_model.dart';
import 'package:flutter_app/presentation/home/bloc/product/product_bloc.dart';
import 'package:flutter_app/presentation/home/widgets/order_card.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/core.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  @override
  void initState() {
    context.read<ProductBloc>().add(const ProductEvent.getProducts());
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Penjualan Ticket'),
      ),
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          final products = state.maybeWhen(
            success: (products) => products,
            orElse: () => [],
          );
          print(products);
          if (products.isEmpty) {
            return const Center(
              child: Text('Belum ada data'),
            );
          }
          return ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            itemCount: products.length,
            separatorBuilder: (context, index) => const SpaceHeight(20),
            itemBuilder: (context, index) => OrderCard(
              item: products[index],
            ),
          );
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(26.0), //Jarak Item pada sisi pojok bawah
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Total Harga'),
                  Text(
                    40000.currencyFormatRp,
                    style: const TextStyle(
                      color: Color.fromARGB(190, 114, 114, 114),
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Button.filled(
                width: 120.0,
                height: 50,
                onPressed: () {},
                label: 'Process',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
