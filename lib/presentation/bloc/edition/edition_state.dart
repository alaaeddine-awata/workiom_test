part of 'edition_bloc.dart';

enum EditionStatus {
  initial,
  loading,
  loaded,
  error,
}

class EditionState extends Equatable {
  final EditionStatus status;
  final EditionModelApiResponse? editionsData;
  final EditionModel? selectedEdition;
  final PasswordComplexityModel? passwordComplexity;
  final String? error;

  const EditionState({
    this.status = EditionStatus.initial,
    this.editionsData,
    this.selectedEdition,
    this.passwordComplexity,
    this.error,
  });

  EditionState copyWith({
    EditionStatus? status,
    EditionModelApiResponse? editionsData,
    EditionModel? selectedEdition,
    PasswordComplexityModel? passwordComplexity,
    String? error,
  }) {
    return EditionState(
      status: status ?? this.status,
      editionsData: editionsData ?? this.editionsData,
      selectedEdition: selectedEdition ?? this.selectedEdition,
      passwordComplexity: passwordComplexity ?? this.passwordComplexity,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [
        status,
        editionsData,
        selectedEdition,
        passwordComplexity,
        error,
      ];
}
