import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_funda/views/common_ui/error_screen.dart';

import '../../data_providers/funda_homes_repository.dart';
import '../../models/house_details.dart';
import '../common_ui/loading_indicator.dart';
import '../common_ui/spacer.dart';
import '../common_ui/text_style.dart';
import 'bloc/house_details_bloc.dart';
import 'bloc/house_details_event.dart';
import 'bloc/house_details_state.dart';
import 'widgets/description_section.dart';
import 'widgets/feature_entry.dart';

class HouseDetailsPage extends StatelessWidget {
  const HouseDetailsPage({
    required this.houseId,
    required this.houseAddress,
    super.key,
  });

  final String houseId;
  final String houseAddress;

  static Route<void> route({
    required String id,
    required String address,
  }) =>
      MaterialPageRoute<void>(
        builder: (context) => HouseDetailsPage(
          houseId: id,
          houseAddress: address,
        ),
      );

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HouseDetailsBloc(
        houseId: houseId,
        fundaHomesRepository: context.read<FundaHomesRepository>(),
      )..add(const HouseDetailsRequested()),
      child: HouseDetailsScreen(
        address: houseAddress,
      ),
    );
  }
}

class HouseDetailsScreen extends StatelessWidget {
  const HouseDetailsScreen({required this.address, super.key});

  final String address;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          address,
          softWrap: true,
        ),
      ),
      body: BlocBuilder<HouseDetailsBloc, HouseDetailsState>(
          builder: (BuildContext context, HouseDetailsState state) {
        return switch (state.status) {
          HouseDetailsStatus.initial => const SizedBox.shrink(),
          HouseDetailsStatus.loading => const LoadingIndicator(),
          HouseDetailsStatus.loaded =>
            FetchedHouseDetails(houseDetails: state.houseDetails!),
          HouseDetailsStatus.failure => ErrorScreen.houseCouldBeSold(
              () => context
                  .read<HouseDetailsBloc>()
                  .add(const HouseDetailsRequested()),
            ),
        };
      }),
    );
  }
}

class FetchedHouseDetails extends StatefulWidget {
  const FetchedHouseDetails({required this.houseDetails, super.key});

  final HouseDetails houseDetails;

  @override
  State<FetchedHouseDetails> createState() => _FetchedHouseDetailsState();
}

class _FetchedHouseDetailsState extends State<FetchedHouseDetails> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(widget.houseDetails.mainImageUrl),
          HorizontalSpacer.l(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.houseDetails.address,
                  style: MiniFundaTextTheme.h1,
                ),
                HorizontalSpacer.xs(),
                Text(widget.houseDetails.postalCodeWithCity),
                HorizontalSpacer.xs(),
                Text(
                  widget.houseDetails.price.formattedPrice,
                  style: MiniFundaTextTheme.h2,
                ),
                HorizontalSpacer.l(),
                DescriptionSection(
                  description: widget.houseDetails.fullDescription,
                ),
                HorizontalSpacer.l(),
                const Text(
                  "Features",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                FeatureEntry(
                  title: "Offered Since",
                  subtitle: widget.houseDetails.formattedDate,
                ),
                FeatureEntry(
                  title: "Acceptance",
                  subtitle: widget.houseDetails.acceptance,
                ),
                if (widget.houseDetails.bathrooms != null)
                  FeatureEntry(
                    title: "Number of bathrooms",
                    subtitle: widget.houseDetails.bathrooms.toString(),
                  ),
                if (widget.houseDetails.bedrooms != null)
                  FeatureEntry(
                    title: "Number of bedrooms",
                    subtitle: widget.houseDetails.bedrooms.toString(),
                  ),
                FeatureEntry(
                  title: "Floors",
                  subtitle: widget.houseDetails.floors,
                ),
                FeatureEntry(
                  title: "Energy Label",
                  subtitle: widget.houseDetails.energyLabel,
                ),
                if (widget.houseDetails.cv != null)
                  FeatureEntry(
                    title: "CV",
                    subtitle: widget.houseDetails.cv!,
                  ),
                FeatureEntry(
                  title: "Construction Year",
                  subtitle: widget.houseDetails.constructionYear,
                ),
                FeatureEntry(
                  title: "Construction Type",
                  subtitle: widget.houseDetails.constructionType,
                ),
                FeatureEntry(
                  title: "Construction Type",
                  subtitle: widget.houseDetails.constructionType,
                ),
                FeatureEntry(
                  title: "House Type",
                  subtitle: widget.houseDetails.houseType,
                ),
                FeatureEntry(
                  title: "Insulation",
                  subtitle: widget.houseDetails.insulation,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
