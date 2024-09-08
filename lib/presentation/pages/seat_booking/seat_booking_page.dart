import 'dart:math';

import 'package:flixid_course/domain/entities/movie_detail.dart';
import 'package:flixid_course/domain/entities/transaction.dart';
import 'package:flixid_course/presentation/extensions/build_context_extensions.dart';
import 'package:flixid_course/presentation/misc/constants.dart';
import 'package:flixid_course/presentation/misc/methods.dart';
import 'package:flixid_course/presentation/pages/seat_booking/methods/legend.dart';
import 'package:flixid_course/presentation/pages/seat_booking/methods/movie_screen.dart';
import 'package:flixid_course/presentation/pages/seat_booking/methods/seat_section.dart';
import 'package:flixid_course/presentation/providers/router/router_provider.dart';
import 'package:flixid_course/presentation/widgets/back_navigation_bar.dart';
import 'package:flixid_course/presentation/widgets/seat.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SeatBookingPage extends ConsumerStatefulWidget {
  final (MovieDetail, Transaction) transactionDetail;
  const SeatBookingPage({super.key, required this.transactionDetail});

  @override
  ConsumerState<SeatBookingPage> createState() => _MyWidgetState();
}

class _MyWidgetState extends ConsumerState<SeatBookingPage> {
  List<int> selectedSeats = [];
  List<int> reservedSeats = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Random random = Random();
    int reservedNumber = random.nextInt(36) + 1;

    while (reservedSeats.length < 8) {
      if (!reservedSeats.contains(reservedNumber)) {
        reservedSeats.add(reservedNumber);
      }
      reservedNumber = random.nextInt(36) + 1;
    }
  }

  @override
  Widget build(BuildContext context) {
    final (movieDetail, transaction) = widget.transactionDetail;

    return Scaffold(
        body: ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              BackNavigationBar(
                movieDetail.title,
                onTap: () => ref.read(routerProvider).pop(),
              ),
              movieScreen(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  seatSection(
                    seatNumbers: List.generate(
                      18,
                      (index) => index + 1,
                    ),
                    onTap: onSeatTap,
                    seatStatusChecker: seatStatusChecker,
                  ),
                  horizontalSpace(30),
                  seatSection(
                    seatNumbers: List.generate(
                      18,
                      (index) => index + 19,
                    ),
                    onTap: onSeatTap,
                    seatStatusChecker: seatStatusChecker,
                  ),
                ],
              ),
              verticalSpace(20),
              legend(),
              verticalSpace(20),
              Text(
                '${selectedSeats.length} seats selected',
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              verticalSpace(40),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () {
                      if (selectedSeats.isEmpty) {
                        context.showSnackBar('Please select at least one seat');
                      } else {
                        var updatedTransaction = transaction.copyWith(
                            seats: (selectedSeats..sort())
                                .map((e) => '$e')
                                .toList(),
                            ticketAmount: selectedSeats.length,
                            ticketPrice: 25000);

                        ref.read(routerProvider).pushNamed(
                            'booking-confirmation',
                            extra: (movieDetail, updatedTransaction));
                      }
                      // Navigator.of(context).push
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: backgroundColor,
                      backgroundColor: saffron,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text('Next')),
              )
              // number of selected seats
              // button
            ],
          ),
        )
      ],
    ));
  }

  void onSeatTap(seatNumber) {
    if (!selectedSeats.contains(seatNumber) &&
        !reservedSeats.contains(seatNumber)) {
      setState(() {
        selectedSeats.add(seatNumber);
      });
    } else {
      setState(() {
        selectedSeats.remove(seatNumber);
      });
    }
  }

  SeatStatus seatStatusChecker(seatNumber) => reservedSeats.contains(seatNumber)
      ? SeatStatus.reserved
      : selectedSeats.contains(seatNumber)
          ? SeatStatus.selected
          : SeatStatus.available;
}
