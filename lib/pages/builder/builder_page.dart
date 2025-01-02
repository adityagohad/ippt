import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:ippt/bloc/ippt_bloc.dart';
import 'package:ippt/pages/builder/component_editor.dart';
import 'package:ippt/pages/builder/component_menu.dart';
import 'package:ippt/pages/builder/work_canvas.dart';
import 'package:ippt/utils/canvas_aspect_ratio.dart';

class BuilderPage extends StatelessWidget {
  const BuilderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: GetIt.I<IpptBloc>(),
      child: BlocBuilder<IpptBloc, IpptState>(
        builder: (context, state) {
          return Scaffold(
              appBar: AppBar(
                actions: [
                  IconButton(
                      onPressed: () {
                        _showDialog(context);
                      },
                      icon: const Icon(Icons.save_as_rounded))
                ],
              ),
              //bottomNavigationBar: const BottomAppBar(),
              body: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                      flex: 2,
                      child: Container(
                          height: MediaQuery.of(context).size.height,
                          decoration: BoxDecoration(
                            color: Theme.of(context).splashColor,
                          ),
                          child: const ComponentMenu())),
                  Expanded(
                      flex: 7,
                      child: GestureDetector(
                        onTap: () {
                          GetIt.I<IpptBloc>().add(UpdateComponentSelection(
                              id: null, isSelected: false));
                        },
                        child: Container(
                          color: Theme.of(context).canvasColor,
                          child: Center(
                              child: Padding(
                            padding: const EdgeInsets.all(32),
                            child: AspectRatio(
                              aspectRatio: state.aspectRatio.value,
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Theme.of(context).cardColor,
                                    boxShadow: [
                                      BoxShadow(
                                          offset: const Offset(0, 10),
                                          blurRadius: 30,
                                          spreadRadius: 10,
                                          color: Theme.of(context).shadowColor)
                                    ]),
                                child: const WorkCanvas(),
                              ),
                            ),
                          )),
                        ),
                      )),
                  Expanded(
                      flex: 3,
                      child: Container(
                          height: MediaQuery.of(context).size.height,
                          decoration: BoxDecoration(
                            color: Theme.of(context).splashColor,
                            // boxShadow: [
                            //   BoxShadow(
                            //       offset: const Offset(10, 0),
                            //       blurRadius: 30,
                            //       spreadRadius: 10,
                            //       color: Theme.of(context).shadowColor)
                            // ]
                          ),
                          child: const ComponentEditor()))
                ],
              ));
        },
      ),
    );
  }

  void _showDialog(BuildContext context) {
    final TextEditingController fileNameController = TextEditingController();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: const EdgeInsets.all(16.0),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Close button at top right
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.of(context).pop(),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ),

              const Text(
                'Enter File Name',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 16),

              // Text field for file name
              TextField(
                controller: fileNameController,
                decoration: const InputDecoration(
                  hintText: 'Enter file name',
                  border: OutlineInputBorder(),
                ),
                autofocus: true,
              ),

              const SizedBox(height: 16),

              // Save button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // Handle save action here
                    final fileName = fileNameController.text;
                    if (fileName.isNotEmpty) {
                      GetIt.I<IpptBloc>().add(SavePresentation());
                      Navigator.of(context).pop();
                      fileNameController.clear();
                    }
                  },
                  child: const Text('Save'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
