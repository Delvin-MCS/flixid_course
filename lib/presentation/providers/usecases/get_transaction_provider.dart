import 'package:flixid_course/domain/usecases/get_transactions/get_transactions.dart';
import 'package:flixid_course/presentation/providers/repositories/transaction_repository/transaction_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'get_transaction_provider.g.dart';

@riverpod
GetTransactions getTransaction(GetTransactionRef ref) => GetTransactions(
    transactionRepository: ref.watch(transactionRepositoryProvider));
