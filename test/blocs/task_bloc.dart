import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:task_management/common/utils/status.dart';
import 'package:task_management/core/data/models/task.dart';
import 'package:task_management/domain/usecases/add_task.dart';
import 'package:task_management/domain/usecases/delete_task.dart';
import 'package:task_management/domain/usecases/filter_tasks.dart';
import 'package:task_management/domain/usecases/get_tasks.dart';
import 'package:task_management/domain/usecases/update_task.dart';
import 'package:task_management/presentation/task/blocs/task_bloc.dart';

class MockAddTask extends Mock implements AddTask {}

class MockGetTasks extends Mock implements GetTasks {}

class MockUpdateTask extends Mock implements UpdateTask {}

class MockDeleteTask extends Mock implements DeleteTask {}

class MockFilterTasks extends Mock implements FilterTasks {}

void main() {
  late TaskBloc taskBloc;
  late MockAddTask mockAddTask;
  late MockGetTasks mockGetTasks;
  late MockUpdateTask mockUpdateTask;
  late MockDeleteTask mockDeleteTask;
  late MockFilterTasks mockFilterTasks;

  setUp(() {
    mockAddTask = MockAddTask();
    mockGetTasks = MockGetTasks();
    mockUpdateTask = MockUpdateTask();
    mockDeleteTask = MockDeleteTask();
    mockFilterTasks = MockFilterTasks();
    taskBloc = TaskBloc(
        addTask: mockAddTask,
        getTasks: mockGetTasks,
        updateTask: mockUpdateTask,
        deleteTask: mockDeleteTask,
        filterTasks: mockFilterTasks);
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

    blocTest<TaskBloc, TaskState>(
      'emits [loading, success] when update task is successful',
      build: () {
        when(() => mockUpdateTask.execute(const Task(
            id: 1,
            title: 'Test Task',
            dueDate: '2 Feb 2024',
            status: TaskStatus.pending))).thenAnswer((_) async => 1);
        return taskBloc;
      },
      act: (bloc) => bloc.add(const UpdateTaskEvent(
          task: Task(
              id: 1,
              title: 'Test Task',
              dueDate: '2 Feb 2024',
              status: TaskStatus.pending))),
      expect: () => [
        const TaskState(status: Status.loading),
        const TaskState(status: Status.success),
      ],
    );
    blocTest<TaskBloc, TaskState>(
      'emits [loading, success] when delete task is successful',
      build: () {
        when(() => mockDeleteTask.execute(1)).thenAnswer((_) async => 1);
        return taskBloc;
      },
      act: (bloc) => bloc.add(const DeleteTaskEvent(id: 1)),
      expect: () => [
        const TaskState(status: Status.loading),
        const TaskState(
          status: Status.success,
        )
      ],
    );
    blocTest<TaskBloc, TaskState>(
      'emits [loading, success] when filter tasks is successful',
      build: () {
        when(() => mockFilterTasks.execute(TaskStatus.pending))
            .thenAnswer((_) async => [
                  const Task(
                      id: 1,
                      title: 'Test Task',
                      dueDate: '2 Feb 2024',
                      status: TaskStatus.pending)
                ]);
        return taskBloc;
      },
      act: (bloc) =>
          bloc.add(const FilterTasksEvent(status: TaskStatus.pending)),
      expect: () => [
        const TaskState(status: Status.loading, tasks: []),
        const TaskState(status: Status.success, tasks: [
          Task(
              id: 1,
              title: 'Test Task',
              dueDate: '2 Feb 2024',
              status: TaskStatus.pending)
        ]),
      ],
    );
  });
}
