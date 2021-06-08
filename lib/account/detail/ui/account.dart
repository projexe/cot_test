import 'package:capitalontap_coding_test/account/card/bloc/card_bloc.dart';
import 'package:capitalontap_coding_test/account/card/ui/card_page.dart';
import 'package:capitalontap_coding_test/account/create/bloc/create_account_bloc.dart';
import 'package:capitalontap_coding_test/account/detail/bloc/account_bloc.dart';
import 'package:capitalontap_coding_test/account/detail/ui/account_data_row.dart';
import 'package:capitalontap_coding_test/config/config.dart';
import 'package:capitalontap_coding_test/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:intl/intl.dart';

class AccountPage extends StatefulWidget {
  final User user;

  AccountPage(this.user);

  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  late User _user;

  @override
  void initState() {
    super.initState();
    _user = widget.user;
  }

  _AccountPageState();

  @override
  Widget build(BuildContext context) {
    return BlocListener<AccountBloc, AccountState>(
      listener: (context, accountState) {
        // AccountBloc listener
        if (accountState is CardsDisplay) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BlocProvider(
                create: (context) => CardBloc(cardList: accountState.cardList),
                child: CardPage(),
              ),
            ),
          );
        } else if (accountState is NoDataConnection) {
          _showErrorSnackbar(CreateAccountError.connection);
        }
      },
      child: BlocListener<CreateAccountBloc, CreateAccountState>(
        listener: (context, createState) {
          // CreateAccountBloc listener
          if (createState.error != CreateAccountError.none) {
            _showErrorSnackbar(createState.error);
          }
          if (createState.complete) {
            _user = createState.toUser();
            ScaffoldMessenger.of(context)
              ..removeCurrentSnackBar()
              ..showSnackBar(SnackBar(
                  content: Text('Your account initialisation is complete!')));
          }
        },
        child: BlocBuilder<CreateAccountBloc, CreateAccountState>(
          builder: (context, createState) {
            return BlocBuilder<AccountBloc, AccountState>(
                builder: (context, detailsState) {
              return Scaffold(
                appBar: AppBar(
                  title: Text('Account'),
                ),
                body: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Card(
                      elevation: 4.0,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text('${_user.firstName} ${_user.lastName}',
                                style: TextStyle(
                                  fontSize: Config.fontsize_details_name,
                                ),
                                overflow: TextOverflow.clip),
                            AccountDataRow(
                                label: 'Account number',
                                value: (createState.complete)
                                    ? AccountValueText(_user.id.toString())
                                    : Center(
                                        child:
                                            PlatformCircularProgressIndicator())),
                            AccountDataRow(
                                label: 'Company',
                                value: AccountValueText(_user.companyName)),
                            AccountDataRow(
                                label: 'Mobile',
                                value: AccountValueText(_user.mobileNumber)),
                            AccountDataRow(
                                label: 'Annual Turnover',
                                value: AccountValueText(
                                    NumberFormat('£#,###,###,###')
                                        .format(_user.annualTurnover))),
                            if (createState.complete)
                              ShowCardsButton(_user.id!),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            });
          },
        ),
      ),
    );
  }

  void _showErrorSnackbar(CreateAccountError error) {
    switch (error) {
      case CreateAccountError.api:
        {
          ScaffoldMessenger.of(context)
            ..removeCurrentSnackBar()
            ..showSnackBar(SnackBar(
                content: Text('There was a problem creating your account')));
        }
        break;
      case CreateAccountError.connection:
        {
          ScaffoldMessenger.of(context)
            ..removeCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                  content: Text(
                      'You are not connected to the internet. Please connect and retry')),
            );
        }
        break;
      case CreateAccountError.none:
        {}
        break;
    }
  }
}

class ShowCardsButton extends StatelessWidget {
  const ShowCardsButton(this.id);

  final int id;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AccountBloc, AccountState>(
      builder: (context, state) {
        return OutlinedButton(
          style: OutlinedButton.styleFrom(
            side: BorderSide(width: 2, color: Colors.blue),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            padding: EdgeInsets.all(10),
          ),
          onPressed: () async {
            context.read<AccountBloc>().add(ShowCards(id));
          },
          child: Text('My cards'),
        );
      },
    );
  }
}
