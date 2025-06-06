import 'package:bloc/bloc.dart';
import 'package:canary_template/data/model/response/burung_tersedia_semua_model.dart';
import 'package:canary_template/data/repository/get_all_burung_tersedia_repository.dart';
import 'package:meta/meta.dart';

part 'get_burung_tersedia_event.dart';
part 'get_burung_tersedia_state.dart';

class GetBurungTersediaBloc extends Bloc<GetBurungTersediaEvent, GetBurungTersediaState> {
  final GetAllBurungTersediaRepository getAllBurungTersediaRepository;

  GetBurungTersediaBloc(this.getAllBurungTersediaRepository) : super(GetBurungTersediaInitial()) {
    on<GetAllBurungTersediaEvent>(_getAllBurungTersedia);
  }

  Future<void> _getAllBurungTersedia(
    GetAllBurungTersediaEvent event, 
    Emitter<GetBurungTersediaState> emit,
  ) async {
    emit(GetBurungTersediaLoading());
    final result = await getAllBurungTersediaRepository.getAllBurungTersedia();
    result.fold(
      (error) => emit(GetBurungTersediaError(error)),
      (burungTersedia) => 
      emit(GetBurungTersediaLoaded(burungTersedia)),
    );
  }
}