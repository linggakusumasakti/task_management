import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:task_management/common/utils/status.dart';
import 'package:task_management/domain/usecases/login_user.dart';
import 'package:task_management/presentation/auth/blocs/auth_bloc.dart';

class MockLoginUser extends Mock implements LoginUser {}

void main() {
  group('auth bloc', () {
    late AuthBloc authBloc;
    late MockLoginUser mockLoginUser;

    setUp(() {
      mockLoginUser = MockLoginUser();
      authBloc = AuthBloc(loginUser: mockLoginUser);
    });

    test('Initial state should be AuthState.initial()', () {
      expect(authBloc.state, AuthState.initial());
    });

    blocTest<AuthBloc, AuthState>(
      'emits [loading, success] when login is successful',
      build: () {
        when(() => mockLoginUser.execute('eve.holt@reqres.in', 'cityslicka'))
            .thenAnswer((_) async => 'mock_token');
        return authBloc;
      },
      act: (bloc) => bloc.add(const LoginEvent(email: 'eve.holt@reqres.in', password: 'cityslicka')),
      expect: () => [
        const AuthState(status: Status.loading),
        const AuthState(status: Status.success, token: 'mock_token'),
      ],
    );
  });
}
