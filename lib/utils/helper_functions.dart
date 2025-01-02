import 'package:ippt/models/component.model.dart';

int generateUniqueId(List<Component> components) {
  if (components.isEmpty) return 1;

  int maxId =
      components.map((c) => c.id).reduce((max, id) => id > max ? id : max);

  return maxId + 1;
}
