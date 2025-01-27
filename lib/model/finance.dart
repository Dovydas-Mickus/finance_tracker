import 'package:objectbox/objectbox.dart';
import 'package:intl/intl.dart';



@Entity()
class Finance {
  int id;
  String title;
  double amount;
  String type;
  String category;
  DateTime date;


  Finance({
    this.id = 0,
    required this.title,
    required this.amount,
    required this.type,
    required this.category,
    required this.date,
  });

  String formatDate() {
    DateFormat dateFormat = DateFormat("yyyy-MM-dd");
    return dateFormat.format(date);
  }
}