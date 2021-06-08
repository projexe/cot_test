import 'package:capitalontap_coding_test/account/create/bloc/create_account_bloc.dart';
import 'package:capitalontap_coding_test/account/create/models/companyname.dart';
import 'package:capitalontap_coding_test/account/create/models/firstname.dart';
import 'package:capitalontap_coding_test/account/create/models/lastname.dart';
import 'package:capitalontap_coding_test/account/create/models/mobile.dart';
import 'package:capitalontap_coding_test/account/create/models/models.dart';
import 'package:capitalontap_coding_test/account/create/ui/create-account.dart';
import 'package:capitalontap_coding_test/services/repository_interface.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:formz/formz.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';

CreateAccountState dummyState = CreateAccountState(
    firstname: Firstname.pure(),
    lastname: Lastname.pure(),
    companyname: Companyname.pure(),
    mobile: Mobile.pure(),
    turnover: Turnover.pure(),
    status: FormzStatus.valid);

class MockRepository extends Mock implements RepositoryInterface {}

void main() {
  var mockRepository = MockRepository();
  setUpAll(() {
    // initialise service provider for mock repo
    GetIt.instance.registerSingleton<RepositoryInterface>(mockRepository);
  });

  Widget makeTestableWidget({Widget? child}) {
    return BlocProvider(
      create: (context) => CreateAccountBloc(),
      child: MaterialApp(
        home: child,
      ),
    );
  }

  group('Test CreateAccount widget', () {
    testWidgets('A basic widget actually builds with all input labels visible', (WidgetTester tester) async {
      await tester.pumpWidget(makeTestableWidget(child: CreateAccountPage()));
      expect(find.text('Create Account'), findsOneWidget);
      expect(find.text('Last name'), findsOneWidget);
      expect(find.text('First name'), findsOneWidget);
      expect(find.text('Company name'), findsOneWidget);
      expect(find.text('Annual Turnover'), findsOneWidget);
      expect(find.text('Mobile phone'), findsOneWidget);
      expect(find.text('SAVE'), findsOneWidget);
    });
  });
}
