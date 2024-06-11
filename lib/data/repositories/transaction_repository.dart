import 'package:flixid_course/domain/entities/result.dart';
import 'package:flixid_course/domain/entities/transaction.dart';

abstract interface class TransactionRepository {
  Future<Result<Transaction>> createTransaction(
      {required Transaction transaction});
  Future<Result<List<Transaction>>> getUserTransaction({required String uid});
}
