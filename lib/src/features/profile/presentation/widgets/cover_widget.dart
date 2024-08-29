import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:you_app/src/core/constant/app_assets.dart';
import 'package:you_app/src/core/extensions/theme_extension.dart';
import 'package:you_app/src/shared/dummy_widgets/app_card.dart';

class CoverWidget extends StatelessWidget {
  const CoverWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return
        // AppCard(
        //     height: 190.h,
        //     width: double.infinity,
        //     borderColor: Colors.transparent,
        //     image: AppAsset.imageCover,
        //     borderWidth: 0,
        //     color: const Color(0xFF162329).withOpacity(0.6),
        ImageCover(
            height: 190.h,
            image: AppAsset.imageCover,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: GestureDetector(
                      onTap: () {},
                      child: SvgPicture.asset(
                        AppAsset.editIcon,
                        height: 24,
                      )),
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    '@johndoe,',
                    style:
                        context.textTheme.displayMedium?.copyWith(fontSize: 16),
                  ),
                ),
              ],
            ));
  }
}
