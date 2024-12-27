import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:ippt/bloc/ippt_bloc.dart';
import 'package:ippt/utils/canvas_aspect_ratio.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late CanvasAspectRatio _selectedRatio;
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    if (!GetIt.I.isRegistered<IpptBloc>()) {
      GetIt.I.registerSingleton<IpptBloc>(IpptBloc());
    }
    _selectedRatio = CanvasAspectRatio.mobile1;
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home page"),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width / 2,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: DropdownButtonFormField<CanvasAspectRatio>(
                          focusNode: _focusNode,
                          value: _selectedRatio,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                          ),
                          items: CanvasAspectRatio.values.map((ratio) {
                            return DropdownMenuItem(
                              value: ratio,
                              child: Row(
                                children: [
                                  _buildRatioPreview(ratio),
                                  const SizedBox(width: 12),
                                  Text(ratio.display),
                                ],
                              ),
                            );
                          }).toList(),
                          onChanged: (ratio) {
                            if (ratio != null) {
                              setState(() => _selectedRatio = ratio);
                              _focusNode.unfocus();
                            }
                          },
                        ),
                      ),
                      const SizedBox(width: 16),
                      ElevatedButton(
                        onPressed: () {
                          GetIt.I<IpptBloc>().add(
                              SetAspectRation(aspectRatio: _selectedRatio));
                          Navigator.of(context).pushNamed("/builder");
                        },
                        child: const Text("Create Presentation"),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRatioPreview(CanvasAspectRatio ratio, {double baseSize = 24}) {
    final value = ratio.value;
    final size = value < 1
        ? Size(baseSize * value, baseSize)
        : Size(baseSize, baseSize / value);

    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Container(
        width: size.width,
        height: size.height,
        decoration: BoxDecoration(
          color: Colors.grey.shade400,
          borderRadius: BorderRadius.circular(2),
        ),
      ),
    );
  }
}
