/// The outcome of an interactor invocation, either success or failure.
sealed class InteractorOutcome<Output> {
  const InteractorOutcome();
}

/// A successful interactor invocation.
final class InteractorSuccess<Output> extends InteractorOutcome<Output> {
  final Output value;

  const InteractorSuccess(this.value);
}

/// A failed interactor invocation.
final class InteractorFailure<Output> extends InteractorOutcome<Output> {
  final Exception exception;

  const InteractorFailure(this.exception);
}
