import 'package:auzmor_assignment/core/constants/constants.dart';
import 'package:auzmor_assignment/core/helpers/helpers.dart';
import 'package:auzmor_assignment/core/utils/utils.dart';
import 'package:auzmor_assignment/models/models.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

part 'app_bars.dart';
part 'loader.dart';
part 'image_view.dart';
part 'primary_text.dart';
part 'category_card.dart';
part 'training_card.dart';

class EmptyWidget extends StatelessWidget {
  final String message;
  const EmptyWidget(this.message, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        message,
        style: TextStyle(
          fontSize: Sizes.s16.h,
          color: AppColors.darkGrey,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
