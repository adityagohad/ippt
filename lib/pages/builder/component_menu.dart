import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:ippt/bloc/ippt_bloc.dart';

import 'package:ippt/models/component.model.dart' as type;
import 'package:ippt/utils/constants.dart';

class ComponentMenu extends StatelessWidget {
  const ComponentMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                "Widgets",
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextButton.icon(
                  icon: const Icon(Icons.text_decrease_rounded),
                  label: const Text('Text'),
                  onPressed: () {
                    GetIt.I<IpptBloc>()
                        .add(AddComponent(type: type.Type.text, data: text));
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                TextButton.icon(
                  icon: const Icon(Icons.image_rounded),
                  label: const Text('Image'),
                  onPressed: () {
                    GetIt.I<IpptBloc>()
                        .add(AddComponent(type: type.Type.image, data: image));
                  },
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
