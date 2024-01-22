# Use-In-Case

A library providing functionality to configure and modify the invocation flow of an interactor/usecase.

The base library is implemented inside the [packages/uic-interactor](https://github.com/FelixCpp/use_in_case/tree/main/packages/uic-interactor) module. During the implementation of this module, I've tried to be extensible for modification modules.
At this point there are some extensions already implemented using the written API. If you're interested take a look at the modules listed below.

1. [uic-interactor-busy-state-listener](https://github.com/FelixCpp/use_in_case/tree/main/packags/uic-interactor-busy-state-listener)
2. [uic-interactor-profiler](https://github.com/FelixCpp/use_in_case/tree/main/packags/uic-interactor-profiler)
3. [uic-interactor-timeout](https://github.com/FelixCpp/use_in_case/tree/main/packags/uic-interactor-timeout)

## Libraries

| Library Name                       | Description                                                  |
| ---------------------------------- | :----------------------------------------------------------- |
| uic-interactor                     | The base library that provides the base class as well as functions to invoke the interactor. |
| uic-interactor-busy-state-listener | Addon to get notified about changes whether the interactor is working or not. |
| uic-interactor-profiler            | Addon that provides chronological statistics about the interactor's workflow. |
| uic-interactor-timeout             | Addon that allows the caller to define a time limit before failing. |
