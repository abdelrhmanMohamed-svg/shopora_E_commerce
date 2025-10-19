import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shopora_e_commerce/model/product_item_model.dart';

class GridItem extends StatelessWidget {
  const GridItem({super.key, required this.productItem});
  final ProductItemModel productItem;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        Container(
          height: size.height * 0.15,
          width: size.width * 0.45,

          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: CachedNetworkImage(
                  imageUrl: productItem.imgUrl,
                  fit: BoxFit.fill,
                  placeholder: (context, url) =>
                      Center(child: CircularProgressIndicator.adaptive()),
                ),
              ),
              Positioned(
                top: 8,
                right: 8,
                child: Container(
                  height: size.height * 0.035,
                  width: size.height * 0.035,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.black12,
                  ),
                  child: Icon(
                    Icons.favorite_border,
                    color: Colors.white,
                    size: size.height * 0.03,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 7.0),
        Text(
          productItem.name,
          style: Theme.of(
            context,
          ).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w600),
        ),

        Text(
          productItem.category,
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
            fontWeight: FontWeight.w600,
            color: Colors.grey,
          ),
        ),

        Text(
          "\$${productItem.price}",
          style: Theme.of(
            context,
          ).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}
