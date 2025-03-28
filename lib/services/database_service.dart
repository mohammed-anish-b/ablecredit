import 'package:ablecredit/models/car.dart';
import 'package:firebase_database/firebase_database.dart';

class DatabaseService {
  final DatabaseReference _dbRef = FirebaseDatabase.instance.ref("cars");

  Future<void> addCar(Car car) async {
    await _dbRef.push().set(car.toJson());
  }

  Stream<Car?> getLastInsertedCar() {
    return _dbRef.orderByKey().limitToLast(1).onValue.map((event) {
      if (event.snapshot.value != null) {
        final Map<dynamic, dynamic> data = event.snapshot.value as Map<dynamic, dynamic>;
        final String lastKey = data.keys.first;
        return Car.fromJson(Map<String, dynamic>.from(data[lastKey]));
      }
      return null;
    });
  }
}
