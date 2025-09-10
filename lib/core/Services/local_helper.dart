import 'package:hive/hive.dart';

class LocalHelper {
  static late Box userBox;

  static String kName = 'name';
  static String kImage = 'image';
  static String kIsUploaded = 'isUploaded';
  static String kTasks = 'tasks'; 

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
    List tasks = userBox.get(kTasks, defaultValue: []);
    tasks.add({"title": title, "desc": desc});
    userBox.put(kTasks, tasks);
  }

  static List getTasks() {
    return userBox.get(kTasks, defaultValue: []);
  }
}
