import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:social_book/data/services/media/media_services.dart';

part 'media_picker_event.dart';
part 'media_picker_state.dart';

class MediaPickerBloc extends Bloc<MediaPickerEvent, MediaPickerState> {
  List<AssetEntity> selectedAssetList = [];
  MediaPickerBloc() : super(MediaPickerInitial()) {
    on<LoadAlbumsAndAssetsEvent>(_loadAlbumsAndAssetsEvent);
    on<LoadSelectedAssetEvent>(loadSelectedAssetEvent);
    on<SelectAssetEvent>(selectAssetEvent);
    on<UnselectAssetEvent>(unselectAssetEvent);
  }
  Future<void> _loadAlbumsAndAssetsEvent(
      LoadAlbumsAndAssetsEvent event, Emitter<MediaPickerState> emit) async {
    emit(MediaLoadingState());
    List<AssetPathEntity> albumList =
        await MediaServices().loadAlbums(event.requestType);
    List<AssetEntity> assetList = [];
    if (albumList.isNotEmpty) {
      debugPrint('Album list: ${albumList.length}');
      assetList = await MediaServices().loadAssets(albumList[0]);
    }
    if (assetList.isNotEmpty) {
      emit(MediaSuccessState(
        albumList: albumList,
        assetList: assetList,
        selectedAlbum: albumList[0],
        selectedAssetList: const [],
      ));
    } else {
      emit(MediaLoadingState());
    }
  }

  Future<void> loadSelectedAssetEvent(
      LoadSelectedAssetEvent event, Emitter<MediaPickerState> emit) async {
    emit(MediaLoadingState());
    List<AssetEntity> assetList =
        await MediaServices().loadAssets(event.selectedAlbum!);
    if (assetList.isNotEmpty) {
      emit(MediaSuccessState(
        assetList: assetList,
        albumList: event.albumList,
        selectedAlbum: event.selectedAlbum,
        selectedAssetList: const [],
      ));
    } else {
      emit(MediaErrorState());
    }
  }

  Future<void> selectAssetEvent(
      SelectAssetEvent event, Emitter<MediaPickerState> emit) async {
    selectedAssetList.add(event.assetEntity);
    emit(MediaSuccessState(
      assetList: event.assetList,
      albumList: event.albumList,
      selectedAssetList: selectedAssetList,
      selectedAlbum: event.selectedAlbum,
    ));
  }

  Future<void> unselectAssetEvent(
      UnselectAssetEvent event, Emitter<MediaPickerState> emit) async {
    selectedAssetList.remove(event.assetEntity);
    emit(MediaSuccessState(
      assetList: event.assetList,
      albumList: event.albumList,
      selectedAssetList: selectedAssetList,
      selectedAlbum: event.selectedAlbum,
    ));
  }
}
