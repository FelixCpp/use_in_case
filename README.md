# Use-In-Case

A library providing functionality to configure and modify the invocation flow of an interactor/usecase.

The base library is implemented inside the [packages/uic-interactor](https://github.com/FelixCpp/use_in_case/tree/main/packages/uic-interactor) module. During the implementation of this module, I've tried to be extensible for modification modules. Extensions can be implemented using the [uic-interactor-profiler](https://github.com/FelixCpp/use_in_case/tree/main/packages/uic-interactor-profiler) and [uic-interactor-execution-listener](https://github.com/FelixCpp/use_in_case/tree/main/packages/uic-interactor-execution-listener) as reference.

## Libraries

| Library Name                      | Description                                                  |
| --------------------------------- | :----------------------------------------------------------- |
| uic-interactor                    | The base library that provides the base class as well as functions to invoke the interactor. |
| uic-interactor-profiler           | Addon that provides chronological statistics about the interactor's workflow. |
| uic-interactor-execution-listener | Addon to get notified about changes whether the interactor is working or not |

