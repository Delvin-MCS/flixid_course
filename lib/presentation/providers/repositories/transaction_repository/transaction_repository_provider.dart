import 'package:flixid_course/data/firebase/firebase_transaction.dart';
import 'package:flixid_course/data/repositories/transaction_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'transaction_repository_provider.g.dart';

@riverpod
TransactionRepository transactionRepository(TransactionRepositoryRef ref) =>
    FirebaseTransaction();
