# 0.1.0

### Core Classes
- Base Class "[Interactor](lib/src/interactor.dart)" added
- Base Class "[Modifier](lib/src/modifier.dart)" added
- Class "[Invocator](lib/src/invocator.dart)" added
- Class "[Event](lib/src/event.dart)" added
- Class "[Timeout Modifier](lib/src/timeout_modifier.dart)" added
- Class "[Busy-State Modifier](lib/src/busy_state_modifier.dart)" added

#### Examples
- Example "[simple example](example/simple_example.dart)" added
- Example "[predefined modifier example](example/predefined_modifier_example.dart)" added
- Example "[custom modifier](example/custom_modifier_example.dart)" added

#### Tests
- Test "[timeout test](test/modifiers/timeout_test.dart)" added
- Test "[busy-state test](test/modifiers/busy_state_test.dart)" added
- Test "[default configuration test](test/default_configuration_test.dart)" added
- Test "[on event test](test/modifiers/on_event_test.dart)" added

# 1.0.0

I'm glad to announce that Versin 2 has reached its initial state that can be published!

### Core Classes
- Interface [Interactor](lib/src/interactor.dart) added
- Interface [ResultInteractor](lib/src/interactor.dart) added
- Interface [ParameterizedInteractor](lib/src/interactor.dart) added
- Interface [ParameterizedResultInteractor](lib/src/interactor.dart) added
- Modifier [after](lib/src/after.dart) added
- Modifier [before](lib/src/before.dart) added
- Modifier [watchBusyState](lib/src/busy_state.dart) added
- Modifier [eventually](lib/src/eventually.dart) added
- Modifier [intercept](lib/src/intercept.dart) added
- Invocations [runUnsafe](lib/src/invoke.dart) added
- Invocations [run](lib/src/invoke.dart) added
- Invocations [getOrThrow](lib/src/invoke.dart) added
- Invocations [getOrNull](lib/src/invoke.dart) added
- Invocations [getOrElse](lib/src/invoke.dart) added
- Modifier [typedIntercept](lib/src/intercept.dart) added
- Modifier [logEvents](lib/src/log.dart) added
- Modifier [log](lib/src/log.dart) added
- Modifier [map](lib/src/map.dart) added
- Base class [ProgressInteractor](lib/src/progress.dart) added
- Base class [ResultProgressInteractor](lib/src/progress.dart) added
- Base class [ParameterizedProgressInteractor](lib/src/progress.dart) added
- Base class [ParameterizedResultProgressInteractor](lib/src/progress.dart) added
- Modifier [recover](lib/src/recover.dart) added
- Modifier [typedRecover](lib/src/recover.dart) added
- Modifier [timeout](lib/src/timeout.dart) added

### Examples
- Example for [after](examples/after.dart) added
- Example for [before](examples/before.dart) added
- Example for [busy_state](examples/busy_state.dart) added
- Example for [eventually](examples/eventually.dart) added
- Example for [interactor](examples/interactor.dart) added
- Example for [intercept](examples/intercept.dart) added
- Example for [log](examples/log.dart) added
- Example for [parameterized_interactor](examples/parameterized_interactor.dart) added
- Example for [parameterized_result_interactor](examples/parameterized_result_interactor.dart) added
- Example for [parameterized_result_progress_interactor](examples/parameterized_result_progress_interactor.dart) added
- Example for [result_interactor](examples/result_interactor.dart) added
- Example for [use_in_case](examples/use_in_case.dart) added

### Documentation
- Documentation for [after](docs/after.drawio.svg) added
- Documentation for [before](docs/before.drawio.svg) added
- Documentation for [busyState](docs/busyState.drawio.svg) added
- Documentation for [eventually](docs/eventually.drawio.svg) added
- Documentation for [intercept](docs/intercept.drawio.svg) added
- Documentation for [log](docs/log.drawio.svg) added
- Documentation for [map](docs/map.drawio.svg) added
- Documentation for [recover](docs/recover.drawio.svg) added
- Documentation for [timeout](docs/timeout.drawio.svg) added

### Cleanup
Removed pretty much all dependencies from the [pubspec](./pubspec.yaml) except darz for the unit type.
Removed use_in_case2.0 branch from git-workflow filter.

# 1.1.0

### Documentation
- Code Documentation added in [after.dart](lib/src/after.dart)
- Code Documentation added in [before.dart](lib/src/before.dart)
- Code Documentation added in [busy_state.dart](lib/src/busy_state.dart)
- Code Documentation added in [eventually.dart](lib/src/eventually.dart)
- Code Documentation added in [interactor.dart](lib/src/interactor.dart)
- Code Documentation added in [intercept.dart](lib/src/intercept.dart)
- Code Documentation added in [invoke.dart](lib/src/invoke.dart)
- Code Documentation added in [log.dart](lib/src/log.dart)
- Code Documentation added in [map.dart](lib/src/map.dart)
- Code Documentation added in [progress.dart](lib/src/progress.dart)
- Code Documentation added in [recover.dart](lib/src/recover.dart)
- Code Documentation added in [timeout.dart](lib/src/timeout.dart)

### Breaking Changes

`errorMessage` parameter in [`timeout`](./lib/src/timeout.dart) modifier has been migrated to be a lazily-invoked callback due to unnecessary evaluation.

# 1.2.0

- Removed documentation of deprecated method `debounceBusyState` in README.md
- Updated [example](./example/use_in_case.dart) to call getOrThrow instead of execute.
- Renamed execute interactor to runUnsafe
- Edited documentation to match the new interactor signature.

# 1.2.1

- Added [map](lib/src/map.dart) to library export

# 1.3.0

- Modifier [measure](./lib/src/measure.dart) added
- Modifier [runAtLeast](./lib/src/run_at_least.dart) added
- Modifier [measuredValue](./lib/src/measure.dart) added
- Example [measure](./example/measure.dart) added
- Example [measureTimedValue](./example/measure_timed_value.dart) added
- Example [runAtLeast](./example/run_at_least.dart) added

# 1.4.0

- Modifier [busyStateChange](./lib/src/busy_state.dart) added
- Deprecation of [watchBusyState](./lib/src/busy_state.dart) introduced
- Modifier [emitBusyStateChange](./lib/src/busy_state.dart) added
- Examples of [watchBusyState](./example/busy_state.dart) updated
- Example [emitBusyStateChange](./example/emit_busy_state_change.dart) added
- Documentation for [emitBusyStateChange](./lib/src/busy_state.dart) added
- Modifier [ensureMinExecutionTime](./lib/src/ensure_min_execution_time.dart) added
- Modifier [ensureMinExecutionTimeOnSuccess](./lib/src/ensure_min_execution_time.dart) added
- Added `onDelay` callback to [ensureMinExecutionTime](./lib/src/ensure_min_execution_time.dart)
- Added `onDelay` callback to [ensureMinExecutionTimeOnSuccess](./lib/src/ensure_min_execution_time.dart)
- Renamed `runUnsafe` to `getOrThrow` in [ParameterizedResultInteractor](./lib/src/interactor.dart)
- Renamed `runUnsafe` to `getOrThrow` in [ParameterizedResultProgressInteractor](./lib/src/progress.dart)
- Modifier [measureTimeOnSuccess](./lib/src/measure.dart) added
- Modifier [cast](./lib/src/map.dart) added

# 1.4.1

## Bugfixes

Re-invocation of `callback` provided as parameter in [checkedIntercept](./lib/src/intercept.dart) is now awaited when called.

## Examples

- Example of [after](./lib/src/after.dart) updated
- Example of [before](./lib/src/before.dart) updated
- Example for [timeout](./lib/src/timeout.dart) added
- Example [intercept](./example/intercept_handled.dart) added

## Features

New parameter `allowMultiCatch` added to the following function signatures:

* [checkedIntercept](./lib/src/intercept.dart)
* [typedIntercept](./lib/src/intercept.dart)
* [intercept](./lib/src/intercept.dart)

## Branding

Shortened package description

# 1.4.2

## Features

### Intercept

`allowMultiCatch` has been renamed to `consume`. By default, all intercept-functions will
consume exceptions and rethrow a `HandledException` in order to filter out previously caught exception types. Note that this behavior can be customized by providing `false` as parameter.

# 1.4.3

## Bugfixes

There was a bug in 'logEvents' that consumed exceptions event though they should've forwarded to the interception call.

# 1.4.4

## Features

### continue-with
`continueWith` has been added to the library. Its purpose is to continue the execution flow of an interactor regardless of the result.
It's callback produces an output having the outcome passed as parameter in order for you to decide what to continue with.

Function: [here](./lib/src/map.dart)<br/>
Example: [here](./example/continue_with.dart)<br/>
Test: [here](./test/map_test.dart)<br/>
