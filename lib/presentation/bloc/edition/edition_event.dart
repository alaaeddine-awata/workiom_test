part of 'edition_bloc.dart';

abstract class EditionEvent extends Equatable {
  const EditionEvent();

  @override
  List<Object?> get props => [];
}

class LoadEditions extends EditionEvent {
  const LoadEditions();
}

class SelectEdition extends EditionEvent {
  final EditionModel edition;

  const SelectEdition({required this.edition});

  @override
  List<Object> get props => [edition];
}
