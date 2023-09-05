import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../../../../helper/cache_helper.dart';
import '../../../../../helper/server_gate.dart';
part 'event.dart';
part 'model.dart';
part 'state.dart';

class ProfileBloc extends Bloc<ProfileEvents,ProfileState>{

  ProfileBloc(this.serverGate, ):super(ProfileState()){
    on<ProfileStartEvent>(GetProfileInfo);
  }
  ProfileModel? model;
  final ServerGate serverGate;
  final phoneController = TextEditingController(text: CacheHelper.getPhone());
  final nameController = TextEditingController(text: CacheHelper.getFullName());
  final cityController = TextEditingController(text: CacheHelper.getCityName());
  String? cityId;
  String cityName = CacheHelper.getCityName();
  File?image;

  void GetProfileInfo(ProfileStartEvent event , Emitter<ProfileState>emit)async{

    emit(ProfileLoadingState());

    final response = await serverGate.sendToServer(url: 'client/profile',
        body: {
        'image':image==null? null : MultipartFile.fromFileSync(image!.path,filename:image!.path.split("/").last ),
        'fullname': nameController.text.trim(),
        'phone': phoneController.text.trim(),
        'city_id': cityId,

        });

    if(response.success){

      model =ProfileModel.fromJson(response.response!.data);
      CacheHelper.setFullName(model!.list.fullname);
      CacheHelper.setImage(model!.list.image);
      CacheHelper.setPhone(model!.list.phone);
      CacheHelper.setCityId(model!.list.city.id.toString());
      CacheHelper.setCityName(model!.list.city.name.toString());
    print(CacheHelper.getCityId()+"=-=--=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=");
      emit(ProfileSuccessState());

    }else{
      emit(ProfileFailedState(
          error: response.msg,
          errType: response.errType!));
    }
  }
}