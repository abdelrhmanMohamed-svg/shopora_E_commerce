import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopora_e_commerce/model_views/favorites_cubit/favorites_cubit.dart';
import 'package:shopora_e_commerce/utils/app_colors.dart';
import 'package:shopora_e_commerce/views/widgets/custom_snack_bar.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    final favoriteCubit = BlocProvider.of<FavoritesCubit>(context);
    final Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: BlocConsumer<FavoritesCubit, FavoritesState>(
          bloc: favoriteCubit,
          listenWhen: (previous, current) => current is FavoritesError,

          listener: (context, state) {
            if (state is FavoritesError) {
              showCustomSnackBar(context, state.message);
            }
          },
          buildWhen: (previous, current) =>
              current is FavoritesLoaded ||
              current is FavoritesLoading ||
              current is FavoritesError,
          builder: (context, state) {
            if (state is FavoritesLoading) {
              return const Center(child: CircularProgressIndicator.adaptive());
            } else if (state is FavoritesLoaded) {
              final products = state.products;
              if (products.isEmpty) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Favorites is empty"),
                    SizedBox(height: size.height * 0.02),
                    InkWell(
                      onTap: () async => await favoriteCubit.fetchFavorites(),
                      child: Icon(Icons.refresh_outlined),
                    ),
                  ],
                );
              }

              return RefreshIndicator(
                onRefresh: () async {
                  await favoriteCubit.fetchFavorites();
                },
                child: ListView.separated(
                  separatorBuilder: (context, index) => Divider(
                    color: AppColors.grey200,
                    indent: 20,
                    endIndent: 20,
                  ),
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final product = products[index];

                    return ListTile(
                      leading: DecoratedBox(
                        decoration: BoxDecoration(
                          color: AppColors.grey200,
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: CachedNetworkImage(
                          imageUrl: product.imgUrl,
                          height: size.height * 0.8,
                          width: size.width * 0.33,
                        ),
                      ),
                      title: Text(
                        product.name,
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      subtitle: Text(
                        product.category,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      trailing: BlocConsumer<FavoritesCubit, FavoritesState>(
                        bloc: favoriteCubit,
                        listenWhen: (previous, current) =>
                            (current is RemoveFavoriteSucsess &&
                            current.productId == product.id),
                        listener: (context, state) {
                          if (state is RemoveFavoriteSucsess) {
                            showCustomSnackBar(
                              context,
                              "remove Item Successfully",
                            );
                          }
                        },
                        buildWhen: (previous, current) =>
                            (current is RemoveFavoriteLoading &&
                            current.productId == product.id),
                        builder: (context, state) {
                          if (state is RemoveFavoriteLoading) {
                            return Transform.scale(
                              scale: 0.5,
                              child: const CircularProgressIndicator.adaptive(),
                            );
                          }
                          return InkWell(
                            onTap: () async =>
                                await favoriteCubit.removeFavorite(product.id),
                            child: Icon(Icons.delete, color: AppColors.red),
                          );
                        },
                      ),
                    );
                  },
                ),
              );
            }
            return const Center(child: Text("something went wrong"));
          },
        ),
      ),
    );
  }
}
