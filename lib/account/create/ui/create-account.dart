import 'dart:io';

import 'package:capitalontap_coding_test/account/create/bloc/create_account_bloc.dart';
import 'package:capitalontap_coding_test/account/create/models/models.dart';
import 'package:capitalontap_coding_test/account/detail/bloc/account_bloc.dart';
import 'package:capitalontap_coding_test/account/detail/ui/account.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

class CreateAccountPage extends StatefulWidget {
  @override
  _CreateAccountPageState createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {
  final _firstnameFocus = FocusNode();
  final _lastnameFocus = FocusNode();
  final _companynameFocus = FocusNode();
  final _turnoverFocus = FocusNode();
  final _mobileFocusNode = FocusNode();
  late CreateAccountBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = BlocProvider.of<CreateAccountBloc>(context);
    _firstnameFocus.addListener(() {
      if (!_firstnameFocus.hasFocus) {
        context.read<CreateAccountBloc>().add(FirstnameUnfocused());
      }
    });
    _lastnameFocus.addListener(() {
      if (!_lastnameFocus.hasFocus) {
        context.read<CreateAccountBloc>().add(LastnameUnfocused());
      }
    });
    _companynameFocus.addListener(() {
      if (!_companynameFocus.hasFocus) {
        context.read<CreateAccountBloc>().add(CompanynameUnfocused());
      }
    });
    _turnoverFocus.addListener(() {
      if (!_turnoverFocus.hasFocus) {
        context.read<CreateAccountBloc>().add(TurnoverUnfocused());
      }
    });
    _mobileFocusNode.addListener(() {
      if (!_mobileFocusNode.hasFocus) {
        context.read<CreateAccountBloc>().add(MobileUnfocused());
      }
    });
  }

  @override
  void dispose() {
    _firstnameFocus.dispose();
    _lastnameFocus.dispose();
    _mobileFocusNode.dispose();
    _companynameFocus.dispose();
    _turnoverFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CreateAccountBloc, CreateAccountState>(
      listener: (context, state) {
        if (state.status.isSubmissionInProgress) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => BlocProvider.value(
                value: bloc,
                child: BlocProvider(
                  create: (context) => AccountBloc(),
                  child: AccountPage(state.toUser()),
                ),
              ),
            ),
          );
        } else if (state.error == CreateAccountError.connection) {
          ScaffoldMessenger.of(context)
            ..removeCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                  content: Text(
                      'You are not connected to the internet. Please connect and retry')),
            );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Create Account'),
          actions: [SubmitButton()],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
                FirstnameInput(focusNode: _firstnameFocus),
                LastnameInput(focusNode: _lastnameFocus),
                CompanynameInput(focusNode: _companynameFocus),
                TurnoverInput(focusNode: _turnoverFocus),
                MobileInput(focusNode: _mobileFocusNode),
                SizedBox(height: 16.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class FirstnameInput extends StatelessWidget {
  const FirstnameInput({Key? key, required this.focusNode}) : super(key: key);

  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateAccountBloc, CreateAccountState>(
      builder: (context, state) {
        return TextFormField(
          initialValue: state.firstname.value,
          focusNode: focusNode,
          decoration: InputDecoration(
            icon: const Icon(
              Icons.person_outline,
            ),
            labelText: 'First name',
            errorText:
                state.firstname.invalid ? 'Please enter your first name' : null,
          ),
          keyboardType: TextInputType.name,
          onChanged: (value) {
            context
                .read<CreateAccountBloc>()
                .add(FirstnameChanged(firstname: value));
          },
          textInputAction: TextInputAction.next,
        );
      },
    );
  }
}

class CompanynameInput extends StatelessWidget {
  const CompanynameInput({Key? key, required this.focusNode}) : super(key: key);

  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateAccountBloc, CreateAccountState>(
      builder: (context, state) {
        return TextFormField(
          initialValue: state.companyname.value,
          focusNode: focusNode,
          decoration: InputDecoration(
            icon: const Icon(Icons.business),
            labelText: 'Company name',
            errorText: state.companyname.invalid
                ? 'Please enter your Company name'
                : null,
          ),
          keyboardType: TextInputType.name,
          onChanged: (value) {
            context
                .read<CreateAccountBloc>()
                .add(CompanynameChanged(companyname: value));
          },
          textInputAction: TextInputAction.next,
        );
      },
    );
  }
}

class LastnameInput extends StatelessWidget {
  const LastnameInput({Key? key, required this.focusNode}) : super(key: key);

  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateAccountBloc, CreateAccountState>(
      builder: (context, state) {
        return TextFormField(
          initialValue: state.lastname.value,
          focusNode: focusNode,
          decoration: InputDecoration(
            labelText: 'Last name',
            icon: Icon(Icons.person_outline,
                color: Theme.of(context).canvasColor),
            errorText:
                state.lastname.invalid ? 'Please enter your last name' : null,
          ),
          keyboardType: TextInputType.name,
          onChanged: (value) {
            context
                .read<CreateAccountBloc>()
                .add(LastnameChanged(lastname: value));
          },
          textInputAction: TextInputAction.next,
        );
      },
    );
  }
}

class TurnoverInput extends StatelessWidget {
  const TurnoverInput({Key? key, required this.focusNode}) : super(key: key);

  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateAccountBloc, CreateAccountState>(
      builder: (context, state) {
        return TextFormField(
          //controller: ,
          initialValue: state.turnover.value,
          focusNode: focusNode,
          decoration: InputDecoration(
            icon: Icon(Icons.money),
            labelText: 'Annual Turnover',
            helperText: 'Your Company annual turnover in £',
            errorText: state.turnover.invalid
                ? _turnoverErrorText(state.turnover.error)
                : null,
          ),
          keyboardType:
              TextInputType.numberWithOptions(decimal: false, signed: false),
          onChanged: (value) {
            context
                .read<CreateAccountBloc>()
                .add(TurnoverChanged(turnover: value));
          },
          textInputAction: TextInputAction.next,
        );
      },
    );
  }

  String? _turnoverErrorText(TurnoverValidationError? error) {
    if (error == TurnoverValidationError.negative) {
      return 'Turnover must be a positive value';
    }
    if (error == TurnoverValidationError.invalid) {
      return 'Turnover value is invalid';
    }
    if (error == TurnoverValidationError.empty) {
      return 'Please input a turnover value';
    }
    if (error == TurnoverValidationError.zero) {
      return 'Please input a turnover value greater than zero';
    }
    return null;
  }
}

class MobileInput extends StatelessWidget {
  const MobileInput({Key? key, required this.focusNode}) : super(key: key);

  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateAccountBloc, CreateAccountState>(
      builder: (context, state) {
        return TextFormField(
          initialValue: state.mobile.value,
          focusNode: focusNode,
          decoration: InputDecoration(
            icon: Platform.isAndroid
                ? Icon(Icons.phone_android)
                : Icon(Icons.phone_iphone),
            labelText: 'Mobile phone',
            helperText: 'A valid UK mobile phone number',
            errorText: state.mobile.invalid
                ? 'Please ensure you enter a valid UK mobile number'
                : null,
          ),
          keyboardType: TextInputType.phone,
          onChanged: (value) {
            context.read<CreateAccountBloc>().add(MobileChanged(mobile: value));
          },
          textInputAction: TextInputAction.next,
        );
      },
    );
  }
}

class SubmitButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateAccountBloc, CreateAccountState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return TextButton(
          onPressed: () =>
              context.read<CreateAccountBloc>().add(FormSubmitted()),

          child: const Text('SAVE', style: TextStyle(color: Colors.white),),
        );
      },
    );
  }
}
