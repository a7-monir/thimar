import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../core/logic/cache_helper.dart';
import '../../core/logic/server_gate.dart';

part 'event.dart';
part 'model.dart';
part 'state.dart';

class ProfileBloc extends Bloc<ProfileEvents,ProfileStates>{

  ProfileBloc(this.serverGate, ):super(ProfileStates()){
    on<ProfileStartEvent>(getData);
  }
  final ServerGate serverGate;
  final phoneController = TextEditingController(text: CacheHelper.getPhone());
  final nameController = TextEditingController(text: CacheHelper.getFullName());
  final cityController = TextEditingController(text: CacheHelper.getCityName());
  String? cityId;
  String cityName = CacheHelper.getCityName();
  File?image;

  void getData(ProfileStartEvent event , Emitter<ProfileStates>emit)async{

    emit(ProfileLoadingState());

    final response = await serverGate.sendToServer(url: 'client/profile',
        body: {
        'image':image==null? null : MultipartFile.fromFileSync(image!.path,filename:image!.path.split("/").last ),
        'fullname': nameController.text.trim(),
        'phone': phoneController.text.trim(),
        'city_id': cityId,

        });

    if(response.success){

      final profileModel =ProfileData.fromJson(response.response!.data);
      CacheHelper.setFullName(profileModel.data.fullname);
      CacheHelper.setImage(profileModel.data.image);
      CacheHelper.setPhone(profileModel.data.phone);
      CacheHelper.setCityId(profileModel.data.city.id.toString());
      CacheHelper.setCityName(profileModel.data.city.name.toString());
    print(CacheHelper.getCityId()+"=-=--=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=");
      emit(ProfileSuccessState(model: profileModel));

    }else{
      emit(ProfileFailedState(
          msg: response.msg,
          statusCode: response.errType!));
    }
  }
}