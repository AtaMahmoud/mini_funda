import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_funda/views/common_ui/error_screen.dart';
import 'package:mini_funda/views/common_ui/spacer.dart';
import 'package:mini_funda/views/house_overview/bloc/house_overview_bloc.dart';
import 'package:mini_funda/views/house_overview/bloc/house_overview_event.dart';

import '../../data_providers/funda_homes_repository.dart';
import '../../models/house.dart';
import '../common_ui/loading_indicator.dart';
import 'bloc/house_overview_state.dart';
import 'widget/house_info_entry.dart';

class HouseOverview extends StatelessWidget {
  const HouseOverview({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HouseOverviewBloc(
        fundaHomesRepository: context.read<FundaHomesRepository>(),
      ),
      child: const HouseOverviewScreen(),
    );
  }
}

class HouseOverviewScreen extends StatefulWidget {
  const HouseOverviewScreen({super.key});

  @override
  State<HouseOverviewScreen> createState() => _HouseOverviewScreenState();
}

class _HouseOverviewScreenState extends State<HouseOverviewScreen> {
  String _selectedCity = "";

  @override
  void initState() {
    context.read<HouseOverviewBloc>().add(const DutchCitiesRequested());

    super.initState();
  }

  void _requestSelectedCityHomes() {
    if (_selectedCity.isNotEmpty) {
      context
          .read<HouseOverviewBloc>()
          .add(HousesByCityRequested(_selectedCity));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mini Funda"),
      ),
      body: BlocBuilder<HouseOverviewBloc, HouseOverviewState>(
        builder: (BuildContext context, HouseOverviewState state) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SearchAnchor.bar(
                  barHintText: "City name",
                  suggestionsBuilder: (context, controller) {
                    return state.cities
                        .where((city) => city.name
                            .toLowerCase()
                            .contains(controller.text.toLowerCase()))
                        .map(
                          (city) => ListTile(
                            title: Text(city.name),
                            subtitle: Text(city.adminName),
                            onTap: () {
                              controller.closeView(city.name);
                              if (city.name != _selectedCity) {
                                _selectedCity = city.name;
                                _requestSelectedCityHomes();
                              }
                            },
                          ),
                        )
                        .toList();
                  },
                ),
              ),
              HorizontalSpacer.l(),
              switch (state.status) {
                HouseOverviewStatus.initial => const SizedBox.shrink(),
                HouseOverviewStatus.loading => const LoadingIndicator(),
                HouseOverviewStatus.loaded =>
                  Expanded(child: HousesList(houses: state.houses)),
                HouseOverviewStatus.failure =>
                  ErrorScreen(onTryAgain: _requestSelectedCityHomes),
              }
            ],
          );
        },
      ),
    );
  }
}

class HousesList extends StatelessWidget {
  const HousesList({required this.houses, super.key});
  final List<House> houses;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: houses.length,
      itemBuilder: (context, index) => HouseInfo(
        houses[index],
      ),
    );
  }
}
