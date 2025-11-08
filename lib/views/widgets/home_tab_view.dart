import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:shopora_e_commerce/model/home_carosel_item_model.dart';
import 'package:shopora_e_commerce/model/product_item_model.dart';
import 'package:shopora_e_commerce/model_views/home_cubit/home_cubit.dart';
import 'package:shopora_e_commerce/utils/app_routes.dart';
import 'package:shopora_e_commerce/views/widgets/grid_item.dart';

class HomeTabView extends StatelessWidget {
  const HomeTabView({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final homeCubit = BlocProvider.of<HomeCubit>(context);
    return BlocBuilder<HomeCubit, HomeState>(
      bloc: homeCubit,
      builder: (context, state) {
        if (state is HomeLoading) {
          return Center(child: CircularProgressIndicator.adaptive());
        } else if (state is HomeLoaded) {
          final carouselItems = state.carouselItems;
          final products = state.products;
          return SingleChildScrollView(
            child: Column(
              children: [
                FlutterCarousel.builder(
                  options: FlutterCarouselOptions(
                    autoPlay: true,
                    viewportFraction: 1,
                    height: size.height * 0.2,
                    enlargeCenterPage: true,
                    showIndicator: true,
                    slideIndicator: CircularWaveSlideIndicator(),
                  ),
                  itemCount: carouselItems.length,
                  itemBuilder:
                      (BuildContext context, int itemIndex, int pageViewIndex) {
                        final HomeCarouselItemModel banner =
                            carouselItems[itemIndex];
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(12.0),
                          child: CachedNetworkImage(
                            imageUrl: banner.imgUrl,
                            fit: BoxFit.fill,
                            placeholder: (context, url) => Center(
                              child: CircularProgressIndicator.adaptive(),
                            ),
                          ),
                        );
                      },
                ),

                const SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "New Arrivals 🔥",
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "see All",
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20.0),
                GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: size.width * 0.02,
                    mainAxisSpacing: size.height * 0.02,
                    childAspectRatio: 0.86,
                  ),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: products.length,
                  itemBuilder: (context, index) => InkWell(
                    onTap: () =>
                        Navigator.of(context, rootNavigator: true).pushNamed(
                          AppRoutes.productDetailsRoute,
                          arguments: products[index].id,
                        ),
                    child: GridItem(productItem: products[index]),
                  ),
                ),
              ],
            ),
          );
        } else if (state is HomeError) {
          return Center(child: Text(state.message));
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
