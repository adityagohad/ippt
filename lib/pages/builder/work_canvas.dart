import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:ippt/bloc/ippt_bloc.dart';
import 'package:ippt/pages/builder/builder_item.dart';

class WorkCanvas extends StatelessWidget {
  const WorkCanvas({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: GetIt.I<IpptBloc>(),
      child: BlocBuilder<IpptBloc, IpptState>(
        builder: (context, state) {
          if (state.canvasWidth == 0 && state.canvasHeight == 0) {
            return LayoutBuilder(builder: (context, constraints) {
              GetIt.I<IpptBloc>().add(UpdateCanvasSize(
                  width: constraints.maxWidth, height: constraints.maxHeight));
              return const Center(
                child: CircularProgressIndicator(),
              );
            });
          } else {
            return SizedBox(
              width: state.canvasWidth,
              height: state.canvasHeight,
              child: Stack(
                children: (List.from(state.components)
                      ..sort((a, b) => a.geometry.z.compareTo(b.geometry.z)))
                    .map((component) => BuilderItem(component: component))
                    .toList(),
              ),
            );
          }
        },
      ),
    );
  }
}
