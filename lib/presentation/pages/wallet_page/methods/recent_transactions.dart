import 'package:flixid_course/presentation/misc/methods.dart';
import 'package:flixid_course/presentation/providers/transaction_data/transaction_data.dart';
import 'package:flixid_course/presentation/widgets/transaction_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

List<Widget> recentTransactions(WidgetRef ref) => [
      const Text(
        'Recent Transactions',
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
      verticalSpace(24),
      ...ref.watch(transactionDataProvider).when(
          data: (transactions) {
            if (transactions.isNotEmpty) {
              return (transactions
                    ..sort((a, b) =>
                        -a.transactionTime!.compareTo(b.transactionTime!)))
                  .map(
                (transaction) => TransactionCard(transaction: transaction),
              );
            } else {
              return [
                Text(
                  'no data',
                  style: TextStyle(
                      fontStyle: FontStyle.italic,
                      fontSize: 12,
                      color: Colors.white.withOpacity(0.5)),
                )
              ];
            }
          },
          error: (error, stackTrace) => [],
          loading: () => [const CircularProgressIndicator()])
    ];
