## 1.0.0

## 0.1.0

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

## 2.0.0

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

#### Note
* Some design decisions may not be final and may change completely in future releases.
* README's may contain content that isn't present yet but will be published quiet soon.