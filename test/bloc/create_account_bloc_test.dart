import 'package:capitalontap_coding_test/account/create/bloc/create_account_bloc.dart';
import 'package:capitalontap_coding_test/services/repository_interface.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';


class MockRepository extends Mock implements RepositoryInterface {}

void main() {
  setUpAll(() {
    // initialise service provider for mock repo
    GetIt.instance
        .registerSingleton<RepositoryInterface>(MockRepository());

  });

  group('Create Account bloc test group', () {
    test('[FirstnameChanged] event emits [Submitted] state when successful', () {
      final bloc = CreateAccountBloc();

      bloc.add(FirstnameChanged(firstname: 'Simon'));

      expectLater(
          bloc.stream,
          emitsInOrder([
            // todo need to test contents of this state
          isA<CreateAccountState>(),
          ]));
    });
  });
}
