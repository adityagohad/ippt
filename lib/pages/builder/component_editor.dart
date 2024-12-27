import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:ippt/bloc/ippt_bloc.dart';
import 'package:ippt/models/component.model.dart';
import 'package:ippt/models/image_widget/image.model.dart';
import 'package:ippt/models/text_widget/text.model.dart';
import 'package:ippt/pages/builder/editors/image_edit_widget.dart';
import 'package:ippt/pages/builder/editors/text_edit_widget.dart';

class ComponentEditor extends StatelessWidget {
  const ComponentEditor({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
        value: GetIt.I<IpptBloc>(),
        child: BlocBuilder<IpptBloc, IpptState>(
          builder: (context, state) {
            switch (state.selectedComponent?.type) {
              case Type.text:
                return TextEditWidget(
                  key: ValueKey(state.selectedComponent?.id),
                  id: state.selectedComponent?.id ?? 0,
                  initialValue:
                      TextModel.fromJson(state.selectedComponent?.data),
                );
              case Type.image:
                return ImageEditWidget(
                    key: ValueKey(state.selectedComponent?.id),
                    componentId: state.selectedComponent?.id ?? 0,
                    initialModel:
                        ImageModel.fromJson(state.selectedComponent?.data));
              default:
                return const Center(
                  child: Text('Select a component to edit'),
                );
            }
          },
        ));
  }
}
