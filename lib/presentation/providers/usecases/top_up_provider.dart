import 'package:flixid_course/domain/usecases/top_up/top_up.dart';
import 'package:flixid_course/presentation/providers/repositories/transaction_repository/transaction_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'top_up_provider.g.dart';

@riverpod
TopUp topUp(TopUpRef ref) =>
    TopUp(transactionRepository: ref.watch(transactionRepositoryProvider));
