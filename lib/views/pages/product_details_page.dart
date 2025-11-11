import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopora_e_commerce/model_views/product_details_cubit/product_details_cubit.dart';
import 'package:shopora_e_commerce/utils/app_colors.dart';
import 'package:shopora_e_commerce/views/widgets/add_to_cart_row_widget.dart';
import 'package:shopora_e_commerce/views/widgets/counter_widget.dart';
import 'package:shopora_e_commerce/views/widgets/size_widget.dart';

class ProductDetailsPage extends StatelessWidget {
  const ProductDetailsPage({super.key, required this.productId});
  final String productId;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final productDetailsCubit = BlocProvider.of<ProductDetailsCubit>(context);

    return BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
      bloc: productDetailsCubit,
      buildWhen: (previous, current) =>
          current is ProductDetailsLoaded ||
          current is ProductDetailsError ||
          current is ProductDetailsLoading,
      builder: (context, state) {
        if (state is ProductDetailsLoading) {
          return Scaffold(
            body: const Center(child: CircularProgressIndicator()),
          );
        } else if (state is ProductDetailsError) {
          return Scaffold(body: Center(child: Text(state.message)));
        } else if (state is ProductDetailsLoaded) {
          final selectedItem = state.product;
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
                    BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
                      bloc: productDetailsCubit,
                      buildWhen: (previous, current) =>
                          current is FvaoritesLoaded ||
                          current is ProductDetailsLoaded ||
                          current is FavoritesLoading,
                      builder: (context, state) {
                        if (state is FavoritesLoading) {
                          return Center(
                            child: Transform.scale(
                              scale: 0.5,
                              child: CircularProgressIndicator.adaptive(),
                            ),
                          );
                        } else if (state is FvaoritesLoaded) {
                          final isFavorite = state.isFavorite;
                          return InkWell(
                            onTap: () async => await productDetailsCubit
                                .setFavorites(selectedItem),
                            child: isFavorite
                                ? Icon(Icons.favorite, color: AppColors.red)
                                : Icon(Icons.favorite_border_outlined),
                          );
                        }

                        return InkWell(
                          onTap: () async => await productDetailsCubit
                              .setFavorites(selectedItem),
                          child: selectedItem.isFavorite
                              ? Icon(Icons.favorite, color: AppColors.red)
                              : Icon(Icons.favorite_border_outlined),
                        );
                      },
                    ),
                  ],
                  expandedHeight: size.height * 0.55,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Container(
                      decoration: BoxDecoration(color: AppColors.grey200),
                      child: Column(
                        children: [
                          SizedBox(height: size.height * 0.1),
                          CachedNetworkImage(
                            imageUrl: selectedItem.imgUrl,
                            fit: BoxFit.fill,
                            height: size.height * 0.47,
                            placeholder: (context, url) => const Center(
                              child: CircularProgressIndicator(),
                            ),
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
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge!
                                          .copyWith(
                                            fontWeight: FontWeight.bold,
                                          ),
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
                                BlocBuilder<
                                  ProductDetailsCubit,
                                  ProductDetailsState
                                >(
                                  bloc: BlocProvider.of<ProductDetailsCubit>(
                                    context,
                                  ),
                                  buildWhen: (previous, current) =>
                                      current is CounterUpdated ||
                                      current is ProductDetailsLoaded,
                                  builder: (context, state) {
                                    if (state is CounterUpdated) {
                                      return CounterWidget(
                                        value: state.value,
                                        productId: selectedItem.id,
                                        cubit:
                                            BlocProvider.of<
                                              ProductDetailsCubit
                                            >(context),
                                      );
                                    } else if (state is ProductDetailsLoaded) {
                                      return CounterWidget(
                                        productId: selectedItem.id,
                                        cubit:
                                            BlocProvider.of<
                                              ProductDetailsCubit
                                            >(context),
                                        value: 1,
                                      );
                                    } else {
                                      return SizedBox.shrink();
                                    }
                                  },
                                ),
                              ],
                            ),
                            SizedBox(height: size.height * 0.015),
                            Text(
                              "Size",
                              style: Theme.of(context).textTheme.titleLarge!
                                  .copyWith(fontWeight: FontWeight.w600),
                            ),
                            SizedBox(height: size.height * 0.01),
                            SizeWidget(),
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
                  ]),
                ),
              ],
            ),
            bottomNavigationBar: AddToCartRowWidget(selectedItem: selectedItem),
          );
        } else {
          return Scaffold(body: Center(child: Text("something went wrong")));
        }
      },
    );
  }
}
