import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shopora_e_commerce/utils/app_colors.dart';

class SocialMediaRow extends StatelessWidget {
  const SocialMediaRow({
    super.key,
    required this.imgUrl,
    required this.title,
    this.isProfile = false,
  });
  final String imgUrl;
  final String title;
  final bool isProfile;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.grey300),
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Row(
          mainAxisAlignment: isProfile
              ? MainAxisAlignment.start
              : MainAxisAlignment.center,

          children: [
            CachedNetworkImage(
              imageUrl: imgUrl,
              height: size.height * 0.08,
              width: size.width * 0.08,
            ),
            SizedBox(width: size.width * 0.03),
            Text(
              title,
              style: Theme.of(
                context,
              ).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w600),
            ),
            if (isProfile) ...[
              const Spacer(),
              Transform.rotate(
                angle: -50 * 3.14 / 180,
                child: Icon(Icons.link_outlined, color: AppColors.grey500),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
