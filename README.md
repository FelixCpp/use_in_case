<!-- 
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages). 

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages). 
-->

Repository containing several sub-packages to implement highly customizable invocation of usecases (interactors & observers).

## Features

[uic-package](packages/uic-interactor/) provides definitions, default implementations and invocation configuration for interactors.

## Getting started

Add the dependency to your project.

```yaml
dependencies:
    git:
        url: https://github.com/FelixCpp/use_in_case.git
        path: packages/uic-interactor
        ref: main
```