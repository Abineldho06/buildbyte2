import 'package:build_byte/ui/screens/component_selection/component_selectionviewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class ComponentSelectionview extends StatelessWidget {
  const ComponentSelectionview({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ComponentSelectionviewmodel>.reactive(
      viewModelBuilder: () {
        return ComponentSelectionviewmodel();
      },
      builder:
          (
            BuildContext context,
            ComponentSelectionviewmodel viewModel,
            Widget? child,
          ) {
            return Scaffold();
          },
    );
  }
}
