import 'package:hive/hive.dart';

class LocalHelper {
  static late Box<dynamic> userBox;

  static const String kName = 'name';
  static const String kImage = 'image';
  static const String kIsUploaded = 'isUploaded';
  static const String kTasks = 'tasks';

  static Future<void> init() async {
    userBox = await Hive.openBox('userBox');
  }

  static void putData(String key, dynamic value) {
    userBox.put(key, value);
  }

  static dynamic getData(String key) {
    return userBox.get(key);
  }

  static void putUserData(String name, String image) {
    putData(kName, name);
    putData(kImage, image);
    putData(kIsUploaded, true);
  }

  static void addTask(String title, String desc) {
    final List current = List.from(userBox.get(kTasks, defaultValue: []));
    current.add({'title': title, 'desc': desc});
    userBox.put(kTasks, current);
  }

  static List<dynamic> getTasks() {
    return List.from(userBox.get(kTasks, defaultValue: []));
  }
}
