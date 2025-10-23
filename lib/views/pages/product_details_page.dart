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
      backgroundColor: AppColors.grey200,

      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            pinned: true,

            title: Text("Product Details"),
            centerTitle: true,
            actions: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.favorite_border),
              ),
            ],
            expandedHeight: size.height * 0.6,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(color: AppColors.grey200),
                child: Column(
                  children: [
                    SizedBox(height: size.height * 0.14),
                    CachedNetworkImage(
                      imageUrl: selectedItem.imgUrl,
                      fit: BoxFit.fill,
                      height: size.height * 0.47,
                      placeholder: (context, url) =>
                          const Center(child: CircularProgressIndicator()),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              Container(
                width: size.width,

                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: const BorderRadius.only(
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
                                SizedBox(height: size.height * 0.01),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.star,
                                      color: AppColors.yellow,
                                      size: size.height * 0.03,
                                    ),
                                    SizedBox(width: size.width * 0.01),
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
                            const CounterWidget(value: 10),
                          ],
                        ),
                        SizedBox(height: size.height * 0.015),
                        Text(
                          "Size",
                          style: Theme.of(context).textTheme.titleLarge!
                              .copyWith(fontWeight: FontWeight.w600),
                        ),
                        SizedBox(height: size.height * 0.01),
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
                        SizedBox(height: size.height * 0.015),
                        Text(
                          "Description",
                          style: Theme.of(context).textTheme.titleLarge!
                              .copyWith(fontWeight: FontWeight.w600),
                        ),
                        SizedBox(height: size.height * 0.01),
                        Text(selectedItem.description),
                        SizedBox(height: size.height * 0.017),
                      ],
                    ),
                  ),
                ),
              ),
            ]),
          ),
        ],
      ),
      bottomNavigationBar: DecoratedBox(
        decoration: BoxDecoration(color: AppColors.white),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text.rich(
                TextSpan(
                  text: "\$",
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppColors.primary,
                  ),
                  children: [
                    TextSpan(
                      text: selectedItem.price.toString(),
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
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
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppColors.white,
                  ),
                ),
                icon: Icon(Icons.shopping_cart, color: AppColors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
