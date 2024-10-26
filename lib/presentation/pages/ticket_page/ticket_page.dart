import 'package:flixid_course/presentation/providers/transaction_data/transaction_data.dart';
import 'package:flixid_course/presentation/widgets/ticket.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TicketPage extends ConsumerWidget {
  const TicketPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(24, 24, 24, 100),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: ref.watch(transactionDataProvider).when(
                  data: (transactions) {
                    if (transactions.isNotEmpty) {
                      return (transactions
                              .where((element) =>
                                  element.title != 'Top Up' &&
                                  element.watchingTime! >=
                                      DateTime.now().millisecondsSinceEpoch)
                              .toList()
                            ..sort(
                              (a, b) =>
                                  a.watchingTime!.compareTo(b.watchingTime!),
                            ))
                          .map(
                            (transaction) => Padding(
                              padding: const EdgeInsets.only(bottom: 20),
                              child: Ticket(
                                transaction: transaction,
                              ),
                            ),
                          )
                          .toList();
                    } else {
                      return [
                        Center(
                          child: Text(
                            'no data',
                            style: TextStyle(
                                fontStyle: FontStyle.italic,
                                fontSize: 12,
                                color: Colors.white.withOpacity(0.5)),
                          ),
                        )
                      ];
                    }
                  },
                  error: (error, stackTrace) => [],
                  loading: () =>
                      const [Center(child: CircularProgressIndicator())],
                ),
          ),
        )
      ],
    );
  }
}
