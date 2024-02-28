# Use-In-Case: Observer

This module provides a base class for observers.

## Getting started

Before writing your interactors/usecases you need to depend on this library.

```Yaml
dependencies:
  uic_observer:
    git:
      url: https://github.com/FelixCpp/use_in_case.git
      path: packages/uic-observer
```

## Writing observers

There are four different types of interactors.

| Type                          | Parameterzed  | Produces Output  |
| :---------------------------- | ------------: | ---------------: |
| Observer                      | No            | Yes              |
| ParameterizedObserver         | Yes           | Yes              |

### Implementation of an Observer

```Dart
class UsersObserver extends Observer<List<User>> {
    final UserDao _dao;
    UsersObserver(this._dao);

    @override
    Stream<List<User>> transform(Nothing _) async {
        return _dao.observeUsers();
    }
}
```

### Implementation of an ParameterizedObserver

```Dart
class UsersWithNameObserver extends ParameterizedObserver<String, List<User>> {
    final UserDao _dao;
    UsersObserver(this._dao);

    @override
    Stream<List<User>> transform(String username) async {
        return _dao.observeUsersWithName(username);
    }
}
```

## Triggering an Observer/ParameterizedObserver

```Dart
// - Observer
final myObserver = UsersObserver();
myObsrever.emit(nothing);

// - ParameterizedObserver
final myObserver = UsersWithNameObserver();
myObserver.emit('John');
```

## Receiving values from observer stream

```Dart
// Initialization
final myObserver = UsersObserver();

// Receiving data
myObserver.listen((user) {
    print('User received: $user');
});

// Triggering
myObserver.emit(nothing);

// Cleanup
myObserver.closeStream();
```
