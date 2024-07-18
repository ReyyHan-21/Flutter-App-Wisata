import 'package:flutter/material.dart';
import 'package:flutter_app/data/models/response/product_response_model.dart';
import 'package:flutter_app/presentation/home/bloc/checkout/checkout_bloc.dart';
import 'package:flutter_app/presentation/home/bloc/checkout/models/order_item.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/core.dart';

class OrderCard extends StatefulWidget {
  final Product item;
  const OrderCard({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  State<OrderCard> createState() => _OrderCardState();
}

class _OrderCardState extends State<OrderCard> {
  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    final quantityNotifier = ValueNotifier(0);
    return Container(
      padding: const EdgeInsets.all(24.0),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.stroke),
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  widget.item.name ?? '',
                  style: const TextStyle(fontSize: 15.0),
                ),
              ),
              //------------------------Minus-------------------------
              InkWell(
                onTap: () {
                  // print(widget.item.name);
                  context
                      .read<CheckoutBloc>()
                      .add(CheckoutEvent.removeCheckout(widget.item));
                },
                child: Assets.icons.reduceQuantity.svg(),
              ),
              //------------------------Value-------------------------
              BlocBuilder<CheckoutBloc, CheckoutState>(
                  builder: (context, state) {
                final quantity = state.maybeWhen(
                  initial: () => 0,
                  success: (checkout) => checkout
                      .firstWhere(
                        (element) => element.product.id == widget.item.id,
                        orElse: () =>
                            OrderItem(product: widget.item, quantity: 0),
                      )
                      .quantity,
                  orElse: () {
                    0;
                  },
                );
                return Text(
                  quantity.toString(),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                );
              }),
              //------------------------Plus-------------------------
              InkWell(
                onTap: () {
                  // print(widget.item.name);
                  context
                      .read<CheckoutBloc>()
                      .add(CheckoutEvent.addCheckout(widget.item));
                },
                child: Assets.icons.addQuantity.svg(),
              ),
            ],
          ),
          Text(
            widget.item.category?.name ?? '',
            style: const TextStyle(fontSize: 11.0),
          ),
          const SpaceHeight(8.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.item.price!.currencyFormatRp,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              // ValueListenableBuilder(
              //   valueListenable: quantityNotifier,
              //   builder: (context, value, _) => Text(
              //     (widget.item.price! * value).currencyFormatRp,
              //     style: const TextStyle(fontWeight: FontWeight.bold),
              //   ),
              // ),
            ],
          )
        ],
      ),
    );
  }
}
