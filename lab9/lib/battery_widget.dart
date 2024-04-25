import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lab9/bloc/battery_bloc.dart';

class BatteryWidget extends StatelessWidget {
  const BatteryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<BatteryBloc>();
    return BlocBuilder<BatteryBloc, String>(
      bloc: bloc,
      builder: (context, state) =>
        InkWell(
          child: Text(bloc.state),
          onTap: () => bloc.add(BatteryGetStateEvent()),
        )
    );
  }
}