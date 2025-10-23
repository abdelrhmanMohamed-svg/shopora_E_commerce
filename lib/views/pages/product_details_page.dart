import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shopora_e_commerce/model/product_item_model.dart';
import 'package:shopora_e_commerce/utils/app_colors.dart';
import 'package:shopora_e_commerce/views/widgets/counter_widget.dart';

class ProductDetailsPage extends StatelessWidget {
  const ProductDetailsPage({super.key, required this.productId});
  final String productId;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final selectedItem = dummyProducts.firstWhere(
      (element) => element.id == productId,
    );
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text("Detail Product"),
        centerTitle: true,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.favorite_border)),
        ],
      ),

      body: Stack(
        children: [
          Container(
            width: size.width,
            height: size.height * 0.6,
            decoration: BoxDecoration(color: AppColors.grey200),
            child: Column(
              children: [
                SizedBox(height: size.height * 0.1),
                CachedNetworkImage(
                  imageUrl: selectedItem.imgUrl,
                  fit: BoxFit.fill,
                  height: size.height * 0.47,
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: size.width,
              height: size.height * 0.5,
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50.0),
                  topRight: Radius.circular(50.0),
                ),
              ),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                selectedItem.name,
                                style: Theme.of(context).textTheme.titleLarge!
                                    .copyWith(fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 8),

                              Row(
                                children: [
                                  Icon(
                                    Icons.star,
                                    color: AppColors.yellow,
                                    size: 25,
                                  ),
                                  const SizedBox(width: 5),
                                  Text(
                                    selectedItem.averageRate.toString(),
                                    style: Theme.of(
                                      context,
                                    ).textTheme.titleMedium!,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          CounterWidget(value: 10),
                        ],
                      ),

                      const SizedBox(height: 12.0),
                      Text(
                        "Size",
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Row(
                        children: ProductSize.values
                            .map(
                              (size) => Padding(
                                padding: const EdgeInsets.only(right: 18.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: AppColors.grey200,

                                    shape: BoxShape.circle,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      size.name,
                                      style: Theme.of(
                                        context,
                                      ).textTheme.bodyLarge,
                                    ),
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                      const SizedBox(height: 12.0),
                      Text(
                        "Description",
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        selectedItem.description,
                        maxLines: 5,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 15.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text.rich(
                            TextSpan(
                              text: "\$",
                              style: Theme.of(context).textTheme.titleLarge!
                                  .copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.primary,
                                  ),
                              children: [
                                TextSpan(
                                  text: selectedItem.price.toString(),
                                  style: Theme.of(context).textTheme.titleLarge!
                                      .copyWith(
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.black,
                                      ),
                                ),
                              ],
                            ),
                          ),
                          ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                            ),
                            onPressed: () {},
                            label: Text(
                              "Add to cart",
                              style: Theme.of(context).textTheme.titleLarge!
                                  .copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.white,
                                  ),
                            ),
                            icon: Icon(
                              Icons.shopping_cart,
                              color: AppColors.white,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
