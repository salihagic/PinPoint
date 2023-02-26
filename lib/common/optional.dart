class Optional<T> {
  final T? value;

  const Optional.absent() : value = null;

  Optional(this.value);
}
