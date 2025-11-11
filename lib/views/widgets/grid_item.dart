import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopora_e_commerce/model/product_item_model.dart';
import 'package:shopora_e_commerce/model_views/home_cubit/home_cubit.dart';
import 'package:shopora_e_commerce/utils/app_colors.dart';

class GridItem extends StatelessWidget {
  const GridItem({super.key, required this.productItem});
  final ProductItemModel productItem;

  @override
  Widget build(BuildContext context) {
    final homeCubit = BlocProvider.of<HomeCubit>(context);
    final Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        Container(
          height: size.height * 0.15,
          width: size.width * 0.45,

          decoration: BoxDecoration(
            color: AppColors.grey200,
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
                  child: BlocBuilder<HomeCubit, HomeState>(
                    bloc: homeCubit,
                    buildWhen: (previous, current) =>
                        (current is FavoritesLoading &&
                            current.productId == productItem.id) ||
                        (current is FvaoritesLoaded &&
                            current.productId == productItem.id) ||
                        (current is FavoritesError &&
                            current.productId == productItem.id),
                    builder: (context, state) {
                      if (state is FavoritesLoading) {
                        return Center(
                          child: CircularProgressIndicator.adaptive(),
                        );
                      } else if (state is FvaoritesLoaded) {
                        final isFavorite = state.isFavorite;

                        return InkWell(
                          onTap: () async =>
                              await homeCubit.setFavorites(productItem),
                          child: isFavorite
                              ? Icon(
                                  Icons.favorite,
                                  color: AppColors.red,
                                  size: size.height * 0.03,
                                )
                              : Icon(
                                  Icons.favorite_border,
                                  color: Colors.white,
                                  size: size.height * 0.03,
                                ),
                        );
                      }
                      return InkWell(
                        onTap: () async =>
                            await homeCubit.setFavorites(productItem),
                        child: productItem.isFavorite
                            ? Icon(
                                Icons.favorite,
                                color: AppColors.red,
                                size: size.height * 0.03,
                              )
                            : Icon(
                                Icons.favorite_border,
                                color: AppColors.white,
                                size: size.height * 0.03,
                              ),
                      );
                    },
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
