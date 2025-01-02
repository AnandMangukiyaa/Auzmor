import 'dart:io';

import 'package:auzmor_assignment/core/enums/enums.dart';
import 'package:auzmor_assignment/models/models.dart';
import 'package:auzmor_assignment/repositories/training_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';

part 'training_state.dart';

class TrainingBloc extends Cubit<TrainingState> {
  TrainingBloc() : super(const TrainingState());

  TrainingRepository trainingRepository = GetIt.I<TrainingRepository>();

  Future<void> getCategories() async {
    emit(state.update(status: ResultStatus.loading));
    try {
      List<Categories> categories = await trainingRepository.getCategories();
      emit(state.update(status: ResultStatus.success, categories: categories));
    } catch (e) {
      emit(state.update(status: ResultStatus.failure, message: e.toString()));
    }
  }


}
