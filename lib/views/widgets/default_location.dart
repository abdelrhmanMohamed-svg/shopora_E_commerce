import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shopora_e_commerce/model/location_item_model.dart';
import 'package:shopora_e_commerce/utils/app_colors.dart';

class SelectedLocation extends StatelessWidget {
  const SelectedLocation({super.key, required this.location});
  final LocationItemModel location;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20.0),
        border: Border.all(color: AppColors.grey300),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: size.height * 0.055,
              backgroundImage: CachedNetworkImageProvider(location.imgUrl),
            ),
            SizedBox(width: size.width * 0.05),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  location.city,
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: size.height * 0.002),
                Text(
                  "${location.city},${location.country}",
                  style: Theme.of(
                    context,
                  ).textTheme.titleMedium!.copyWith(color: Colors.grey),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
