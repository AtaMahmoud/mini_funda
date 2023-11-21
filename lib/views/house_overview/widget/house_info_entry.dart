import 'package:flutter/material.dart';

import '../../../models/house.dart';
import '../../common_ui/text_style.dart';
import '../../house_details.dart/house_details.dart';

class HouseInfo extends StatelessWidget {
  final House house;

  const HouseInfo(this.house, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () => Navigator.of(context).push(
          HouseDetailsPage.route(id: house.id),
        ),
        child: Card(
          clipBehavior: Clip.hardEdge,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                house.coverImageUrl,
                fit: BoxFit.cover,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      house.address,
                      style: MiniFundaTextTheme.h1,
                      overflow: TextOverflow.fade,
                      maxLines: 1,
                      softWrap: false,
                    ),
                    Text(
                      house.postCode,
                    ),
                    Text(
                      house.formattedPrice,
                      style: MiniFundaTextTheme.h2,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
