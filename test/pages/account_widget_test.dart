import 'package:capitalontap_coding_test/account/create/bloc/create_account_bloc.dart';
import 'package:capitalontap_coding_test/account/detail/bloc/account_bloc.dart';
import 'package:capitalontap_coding_test/account/detail/ui/account.dart';
import 'package:capitalontap_coding_test/models/user.dart';
import 'package:capitalontap_coding_test/services/repository_interface.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';

class MockRepository extends Mock implements RepositoryInterface {}

void main() {
  var mockRepository = MockRepository();
  setUpAll(() {
    // initialise service provider for mock repo
    GetIt.instance.registerSingleton<RepositoryInterface>(mockRepository);
  });

  Widget makeTestableWidget({Widget? child}) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AccountBloc()),
        BlocProvider(create: (context) => CreateAccountBloc())
      ],
      child: MaterialApp(
        home: child,
      ),
    );
  }

  group('Test AccountPage widget', () {
    testWidgets('A basic widget actually builds', (WidgetTester tester) async {
      await tester.pumpWidget(makeTestableWidget(child: AccountPage(User())));
      expect(find.text('Account'), findsOneWidget);
    });
  });
}
