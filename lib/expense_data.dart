import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

final formatter = DateFormat.yMd();
const uuid = Uuid();

enum Category { food, travel, leisure, work, personal }

const categoryText = {
  Category.food: 'Food',
  Category.leisure: 'Leisure',
  Category.personal: 'Personal',
  Category.travel: 'Travel',
  Category.work: 'Work'
};

class ExpenseModel {
  final String title;
  final double amount;
  final String id;
  final DateTime date;
  final Category category;

  ExpenseModel(
      {required this.amount,
      required this.category,
      required this.date,
      required this.title})
      : id = uuid.v4();

  String get formattedDate {
    return formatter.format(date);
  }
}
