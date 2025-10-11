import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../data/models/edition_model.dart';
import '../../../data/models/password_complexity_model.dart';
import '../../../data/repositories/edition_repository.dart';
import '../../../core/network/api_result.dart';

part 'edition_event.dart';
part 'edition_state.dart';

class EditionBloc extends Bloc<EditionEvent, EditionState> {
  final EditionRepository _editionRepository;

  EditionBloc({required EditionRepository editionRepository})
      : _editionRepository = editionRepository,
        super(const EditionState()) {
    on<LoadEditions>(_onLoadEditions);
    on<SelectEdition>(_onSelectEdition);
  }

  Future<void> _onLoadEditions(
    LoadEditions event,
    Emitter<EditionState> emit,
  ) async {
    emit(state.copyWith(status: EditionStatus.loading));

    final result = await _editionRepository.getEditionsForSelect();
    
    result.when(
      success: (editionsData) {
        emit(state.copyWith(
          status: EditionStatus.loaded,
          editionsData: editionsData,
          selectedEdition: (editionsData.result?.editionsWithFeatures.isNotEmpty ?? false)
              ? editionsData.result!.editionsWithFeatures.first.edition
              : null,
        ));
      },
      failure: (error) {
        emit(state.copyWith(
          status: EditionStatus.error,
          error: error,
        ));
      },
    );
  }

  void _onSelectEdition(
    SelectEdition event,
    Emitter<EditionState> emit,
  ) {
    emit(state.copyWith(selectedEdition: event.edition));
  }
}
