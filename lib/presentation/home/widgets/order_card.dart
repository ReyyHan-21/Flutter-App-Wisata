import 'package:flutter/material.dart';
import 'package:flutter_app/data/models/response/product_response_model.dart';

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
              InkWell(
                onTap: () {
                  if (quantityNotifier.value > 0) {
                    quantityNotifier.value--;
                  }
                },
                child: Assets.icons.reduceQuantity.svg(),
              ),
              ValueListenableBuilder(
                valueListenable: quantityNotifier,
                builder: (context, value, _) => Text(
                  '$value',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              InkWell(
                onTap: () => quantityNotifier.value++,
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
              ValueListenableBuilder(
                valueListenable: quantityNotifier,
                builder: (context, value, _) => Text(
                  (widget.item.price! * value).currencyFormatRp,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
  }