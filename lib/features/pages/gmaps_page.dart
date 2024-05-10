import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mvvm_playground/features/cubit/maps_cubit.dart';
import 'package:mvvm_playground/features/state/base_state.dart';

class GmapsPage extends StatefulWidget {
  const GmapsPage({super.key});

  @override
  State<GmapsPage> createState() => _GmapsPageState();
}

class _GmapsPageState extends State<GmapsPage> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  LatLng? lat;

  @override
  void initState() {
    super.initState();
    context.read<MapsCubit>().initLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<MapsCubit, BaseState>(builder: (context, state) {
        if (state is GeneralErrorState) {
          return Center(
            child: Text(state.error),
          );
        }
        if (state is SuccessState<LatLng>) {
          return GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition: CameraPosition(
                target: LatLng(state.data.latitude, state.data.longitude),
                zoom: 20),
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      }),
      floatingActionButton: FloatingActionButton.extended(
        label: const Text('Refresh'),
        onPressed: () {
          context.read<MapsCubit>().initLocation();
        },
      ),
    );
  }
}
