import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopora_e_commerce/model/location_item_model.dart';
import 'package:shopora_e_commerce/model_views/location_cubit/loaction_cubit.dart';
import 'package:shopora_e_commerce/utils/app_colors.dart';

class LocationItem extends StatelessWidget {
  const LocationItem({super.key, required this.location});
  final LocationItemModel location;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final locationCubit = BlocProvider.of<LoactionCubit>(context);

    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: InkWell(
        onTap: () {
          locationCubit.chosenLocation(location.id);
        },
        child: BlocBuilder<LoactionCubit, LoactionState>(
          bloc: locationCubit,
          buildWhen: (previous, current) =>
              current is ChosenLocation || current is LoactionsLoaded,
          builder: (context, state) {
            if (state is ChosenLocation) {
              return DecoratedBox(
                decoration: BoxDecoration(
                  color: AppColors.white,

                  borderRadius: BorderRadius.circular(20.0),
                  border: Border.all(
                    color: state.id == location.id
                        ? AppColors.primary
                        : AppColors.grey400,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 15.0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            location.city,
                            style: Theme.of(context).textTheme.titleMedium!
                                .copyWith(fontWeight: FontWeight.w700),
                          ),
                          SizedBox(height: size.height * 0.002),
                          Text(
                            " ${location.city},${location.country}",
                            style: Theme.of(context).textTheme.titleMedium!
                                .copyWith(color: Colors.grey),
                          ),
                        ],
                      ),
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          CircleAvatar(
                            backgroundColor: state.id == location.id
                                ? AppColors.primary
                                : AppColors.grey400,
                            radius: size.height * 0.057,
                          ),
                          CircleAvatar(
                            radius: size.height * 0.05,
                            backgroundImage: CachedNetworkImageProvider(
                              location.imgUrl,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }
            return DecoratedBox(
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(20.0),
                border: Border.all(color: AppColors.grey400),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 15.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          location.city,
                          style: Theme.of(context).textTheme.titleMedium!
                              .copyWith(fontWeight: FontWeight.w700),
                        ),
                        SizedBox(height: size.height * 0.002),
                        Text(
                          " ${location.city},${location.country}",
                          style: Theme.of(
                            context,
                          ).textTheme.titleMedium!.copyWith(color: Colors.grey),
                        ),
                      ],
                    ),
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        CircleAvatar(
                          backgroundColor: AppColors.grey400,
                          radius: size.height * 0.057,
                        ),
                        CircleAvatar(
                          radius: size.height * 0.05,
                          backgroundImage: CachedNetworkImageProvider(
                            location.imgUrl,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
