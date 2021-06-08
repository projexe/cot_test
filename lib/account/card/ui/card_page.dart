import 'package:capitalontap_coding_test/account/card/bloc/card_bloc.dart';
import 'package:capitalontap_coding_test/models/credit_card.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CardPage extends StatefulWidget {
  const CardPage();

  @override
  _CardPageState createState() => _CardPageState();
}

class _CardPageState extends State<CardPage> {
  List<CreditCard> cardList = <CreditCard>[];
  @override
  Widget build(BuildContext context) {
    return BlocListener<CardBloc, CardState>(
  listener: (context, state) {
    if (state is NoConnection) {
      ScaffoldMessenger.of(context)
        ..removeCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
              content: Text(
                  'You are not connected to the internet. Please connect and retry')),
        );
    }
  },
  child: BlocBuilder<CardBloc, CardState>(
      builder: (context, state) {
        if (state is CardInitial) {
          cardList = state.cardList;
        }
        if (state is CardFrozen) {
          cardList
              .singleWhere(
                  (card) => card.cardNumber == state.creditCard.cardNumber)
              .isFrozen = state.isFrozen;
        }
        return Scaffold(
          appBar: AppBar(
            title: Text('My Cards'),
          ),
          body: cardList.isNotEmpty
              ? ListView.builder(
                  itemCount: cardList.length,
                  padding: EdgeInsets.only(top: 5.0),
                  itemBuilder: (context, index) => CardView(cardList[index]))
              : Center(
                  child: Text('You don''t have any cards'),
                ),
        );
      },
    ),
);
  }
}

class CardView extends StatefulWidget {
  const CardView(this.card);
  final CreditCard card;

  @override
  _CardViewState createState() => _CardViewState();
}

class _CardViewState extends State<CardView> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CardBloc, CardState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(32.0),
          child: Card(
            elevation: 6,
            color: (widget.card.isFrozen) ? Colors.red[100] : Colors.green[50],
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Text(
                    _formatCardString(widget.card.cardNumber),
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
                  ),
                ),
                Text('expiry : ${_formatDate(widget.card.expiryDate)}'),
                Switch(
                    value: widget.card.isFrozen,
                    onChanged: (value) => BlocProvider.of<CardBloc>(context)
                        .add(FreezeIt(card: widget.card, isFrozen: value))),
              ],
            ),
          ),
        );
      },
    );
  }

  String _formatCardString(String cardNo) => '${cardNo.substring(0, 4)}'
      '  ${cardNo.substring(4, 8)}'
      '  ${cardNo.substring(8, 12)}'
      '  ${cardNo.substring(12, 16)}';

  String _formatDate(DateTime? date) {
    if (date == null) {
      return '';
    }
    return formatDate(date, [dd, '/', mm, '/', yyyy]);
  }
}
