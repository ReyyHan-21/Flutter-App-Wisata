import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_app/data/datasources/product_remote_datasource.dart';
import 'package:flutter_app/data/models/response/product_response_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:http/http.dart';

part 'product_event.dart';
part 'product_state.dart';
part 'product_bloc.freezed.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRemoteDatasource productRemoteDatasource;
  ProductBloc(
    this.productRemoteDatasource,
  ) : super(_Initial()) {
    on<_GetProducts>((event, emit) async {
      emit(_Loading());
      final response = await productRemoteDatasource.getProducts();

      response.fold(
        (error) => emit(_Error(error)),
        (data) => emit(_Success(data.data ?? [])),
      );
    });
  }
}
