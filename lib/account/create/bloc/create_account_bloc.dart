import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:capitalontap_coding_test/account/create/models/firstname.dart';
import 'package:capitalontap_coding_test/account/create/models/models.dart';
import 'package:capitalontap_coding_test/config/di_registration.dart';
import 'package:capitalontap_coding_test/core/exceptions.dart';
import 'package:capitalontap_coding_test/models/user.dart';
import 'package:capitalontap_coding_test/services/repository_interface.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:formz/formz.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

part 'create_account_event.dart';
part 'create_account_state.dart';

class CreateAccountBloc extends Bloc<CreateAccountEvent, CreateAccountState> {
  CreateAccountBloc() : super(const CreateAccountState());

  final RepositoryInterface repo = getIt<RepositoryInterface>();

  @override
  Stream<CreateAccountState> mapEventToState(CreateAccountEvent event) async* {
    if (event is FirstnameChanged) {
      final firstname = Firstname.dirty(event.firstname);
      yield state.copyWith(
        firstname:
            firstname.valid ? firstname : Firstname.pure(event.firstname),
        status: Formz.validate([
          firstname,
          state.lastname,
          state.companyname,
          state.turnover,
          state.mobile
        ]),
      );
    } else if (event is LastnameChanged) {
      final lastname = Lastname.dirty(event.lastname);
      yield state.copyWith(
        lastname: lastname.valid ? lastname : Lastname.pure(event.lastname),
        status: Formz.validate([
          lastname,
          state.firstname,
          state.companyname,
          state.turnover,
          state.mobile
        ]),
      );
    } else if (event is CompanynameChanged) {
      final companyname = Companyname.dirty(event.companyname);
      yield state.copyWith(
        companyname: companyname.valid
            ? companyname
            : Companyname.pure(event.companyname),
        status: Formz.validate([
          companyname,
          state.firstname,
          state.lastname,
          state.turnover,
          state.mobile
        ]),
      );
    } else if (event is TurnoverChanged) {
      final turnover = Turnover.dirty(event.turnover);
      yield state.copyWith(
        turnover: turnover.valid ? turnover : Turnover.pure(event.turnover),
        status: Formz.validate([
          turnover,
          state.firstname,
          state.lastname,
          state.companyname,
          state.mobile
        ]),
      );
    } else if (event is MobileChanged) {
      final mobile = Mobile.dirty(event.mobile);
      yield state.copyWith(
        mobile: mobile.valid ? mobile : Mobile.pure(event.mobile),
        status: Formz.validate(<FormzInput>[
          mobile,
          state.lastname,
          state.companyname,
          state.turnover,
          state.lastname
        ]),
      );
    } else if (event is FirstnameUnfocused) {
      final firstname = Firstname.dirty(state.firstname.value);
      yield state.copyWith(
        firstname: firstname,
        status: Formz.validate(<FormzInput>[
          firstname,
          state.lastname,
          state.companyname,
          state.turnover,
          state.mobile
        ]),
      );
    } else if (event is LastnameUnfocused) {
      final lastname = Lastname.dirty(state.lastname.value);
      yield state.copyWith(
        lastname: lastname,
        status: Formz.validate([
          lastname,
          state.firstname,
          state.companyname,
          state.turnover,
          state.mobile
        ]),
      );
    } else if (event is CompanynameUnfocused) {
      final companyname = Companyname.dirty(state.companyname.value);
      yield state.copyWith(
        companyname: companyname,
        status: Formz.validate([
          companyname,
          state.firstname,
          state.lastname,
          state.turnover,
          state.mobile
        ]),
      );
    } else if (event is TurnoverUnfocused) {
      final turnover = Turnover.dirty(state.turnover.value);
      yield state.copyWith(
        turnover: turnover,
        status: Formz.validate([
          turnover,
          state.firstname,
          state.lastname,
          state.companyname,
          state.mobile
        ]),
      );
    } else if (event is MobileUnfocused) {
      final mobile = Mobile.dirty(state.mobile.value);
      yield state.copyWith(
        mobile: mobile,
        status: Formz.validate([
          mobile,
          state.firstname,
          state.lastname,
          state.companyname,
          state.turnover
        ]),
      );
    } else if (event is FormSubmitted) {
      if (!await InternetConnectionChecker().hasConnection) {
        yield state.copyWith(
            error: CreateAccountError.connection, complete: false);
      } else {
        final firstname = Firstname.dirty(state.firstname.value);
        final lastname = Lastname.dirty(state.lastname.value);
        final companyname = Companyname.dirty(state.companyname.value);
        final turnover = Turnover.dirty(state.turnover.value);
        final mobile = Mobile.dirty(state.mobile.value);

        yield state.copyWith(
          firstname: firstname,
          lastname: lastname,
          companyname: companyname,
          turnover: turnover,
          mobile: mobile,
          status: Formz.validate(
              [firstname, lastname, companyname, turnover, mobile]),
        );

        if (state.status.isValidated) {
          yield state.copyWith(status: FormzStatus.submissionInProgress);
          User? _customer;

          try {
            _customer = await repo.createUser(state.toUser());
          } on ApiException {
            yield state.copyWith(
                error: CreateAccountError.api, complete: false);
          } on ConnectionException {
            yield state.copyWith(
                error: CreateAccountError.connection, complete: false);
          }

          if (_customer != null) {
            debugPrint('Account creation complete');
            yield state.copyWith(
              id: _customer.id,
              complete: true,
            );
          }
        }
      }
    }
  }
}
