import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:task_management/common/utils/status.dart';
import 'package:task_management/core/data/models/task.dart';
import 'package:task_management/domain/usecases/add_task.dart';
import 'package:task_management/domain/usecases/delete_task.dart';
import 'package:task_management/domain/usecases/get_tasks.dart';
import 'package:task_management/domain/usecases/update_task.dart';
import 'package:task_management/presentation/task/blocs/task_bloc.dart';

class MockAddTask extends Mock implements AddTask {}

class MockGetTasks extends Mock implements GetTasks {}

class MockUpdateTask extends Mock implements UpdateTask {}

class MockDeleteTask extends Mock implements DeleteTask {}

void main() {
  late TaskBloc taskBloc;
  late MockAddTask mockAddTask;
  late MockGetTasks mockGetTasks;
  late MockUpdateTask mockUpdateTask;
  late MockDeleteTask mockDeleteTask;

  setUp(() {
    mockAddTask = MockAddTask();
    mockGetTasks = MockGetTasks();
    mockUpdateTask = MockUpdateTask();
    mockDeleteTask = MockDeleteTask();
    taskBloc = TaskBloc(
        addTask: mockAddTask,
        getTasks: mockGetTasks,
        updateTask: mockUpdateTask,
        deleteTask: mockDeleteTask);
  });

  tearDown(() {
    taskBloc.close();
  });

  group('TaskBloc Test', () {
    const testTask = Task(
        title: 'Test Task',
        dueDate: '01 February 2025',
        status: TaskStatus.pending);

    blocTest<TaskBloc, TaskState>(
      'emits [loading, success] when AddTaskEvent is added successfully',
      build: () {
        when(() => mockAddTask.execute(testTask)).thenAnswer((_) async => 1);
        return taskBloc;
      },
      act: (bloc) => bloc.add(const AddTaskEvent(task: testTask)),
      expect: () => [
        TaskState.initial().copyWith(status: Status.loading),
        TaskState.initial().copyWith(status: Status.success),
      ],
    );

    blocTest<TaskBloc, TaskState>(
      'emits [loading, success with tasks] when GetTasksEvent retrieves tasks',
      build: () {
        when(() => mockGetTasks.execute()).thenAnswer((_) async => [testTask]);
        return taskBloc;
      },
      act: (bloc) => bloc.add(GetTasksEvent()),
      expect: () => [
        TaskState.initial().copyWith(status: Status.loading),
        TaskState.initial().copyWith(status: Status.success, tasks: [testTask]),
      ],
    );

    blocTest<TaskBloc, TaskState>(
      'emits [loading, empty] when GetTasksEvent retrieves no tasks',
      build: () {
        when(() => mockGetTasks.execute()).thenAnswer((_) async => []);
        return taskBloc;
      },
      act: (bloc) => bloc.add(GetTasksEvent()),
      expect: () => [
        TaskState.initial().copyWith(status: Status.loading),
        TaskState.initial().copyWith(status: Status.empty),
      ],
    );

    blocTest<TaskBloc, TaskState>(
      'emits [loading, error] when GetTasksEvent throws FormatException',
      build: () {
        when(() => mockGetTasks.execute())
            .thenThrow(const FormatException('Failed to load tasks'));
        return taskBloc;
      },
      act: (bloc) => bloc.add(GetTasksEvent()),
      expect: () => [
        TaskState.initial().copyWith(status: Status.loading),
        TaskState.initial()
            .copyWith(status: Status.error, error: 'Failed to load tasks'),
      ],
    );
  });
}
