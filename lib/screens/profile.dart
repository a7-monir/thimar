import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kiwi/kiwi.dart';
import 'package:thimar/core/design/res/app_input.dart';
import 'package:thimar/core/design/res/app_loading.dart';
import 'package:thimar/screens/edit_password.dart';
import '../core/design/res/app_button.dart';
import '../core/design/res/app_image.dart';
import '../core/design/res/appbar.dart';
import '../core/logic/cache_helper.dart';
import '../core/logic/helper_methods.dart';
import '../features/profile/bloc.dart';
import 'city/view.dart';



class PersonalInfoView extends StatefulWidget {
  const PersonalInfoView({Key? key}) : super(key: key);

  @override
  State<PersonalInfoView> createState() => _PersonalInfoViewState();
}

class _PersonalInfoViewState extends State<PersonalInfoView> {
  final bloc = KiwiContainer().resolve<ProfileBloc>();

  File? selectedImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(50.h),
          child: CustomAppBar(title: 'البيانات الشخصية')),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 33.h,
              ),
              Container(
                height: 85.h,
                width: 85.h,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.r),
                ),
                child: Stack(
                  children: [
                    ColorFiltered(
                        colorFilter: ColorFilter.mode(
                            Colors.black.withOpacity(.32), BlendMode.darken),
                        child: selectedImage != null
                            ? Image.file(
                                selectedImage!,
                                height: 85.h,
                                width: 85.h,
                                fit: BoxFit.fill,
                              )
                            : AppImage(
                                CacheHelper.getImage(),
                                fit: BoxFit.fill,
                              )),
                    Center(
                        child: GestureDetector(
                            onTap: () async {
                              final image = await ImagePicker.platform
                                  .getImageFromSource(
                                      source: ImageSource.gallery);
                              if (image != null) {
                                print(image.path);
                                selectedImage = File(image.path);
                                setState(() {});
                              }
                            },
                            child:
                            AppImage('assets/icons/Camera.png',)
                        )
                    ),
                  ],
                ),
              ),
              Text(
                CacheHelper.getFullName(),
                style: TextStyle(
                  fontSize: 17.sp,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              Text(
                "+${CacheHelper.getPhone()}",
                textDirection: TextDirection.ltr,
                style: TextStyle(
                  fontSize: 17.sp,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              SizedBox(
                height: 18.h,
              ),
              AppInput(
                label: 'اسم المستخدم',
                prefix: 'assets/icons/user.png',
                color: Color(0xFFFAFFF5),
                controller: bloc.nameController,
              ),
              AppInput(
                label: 'رقم الجوال',
                prefix: 'assets/icons/phoneicon.png',
                inputType: InputType.phone,
                color: Color(0xFFFAFFF5),
                controller: bloc.phoneController,
              ),
              AppInput(
               controller: bloc.cityController,
                prefix: 'assets/icons/city.png',
                onPress: () {
                  showModalBottomSheet(
                      context: context,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadiusDirectional.only(
                            topEnd: Radius.circular(15.r),
                            topStart: Radius.circular(15.r)),
                      ),
                      builder: (context) => ChooseCityDialog(
                        selectedCityId: bloc.cityId,
                      )).then((value) {
                    if (value != null) {
                      var city = value;
                      bloc.cityId = city.id;
                      bloc.cityController.text = city.name;
                      setState(() {});
                    }
                  });
                },
                color: Color(0xFFFAFFF5),

              ),
              AppInput(
                label: 'كلمة المرور',
                prefix: 'assets/icons/lock.png',
                onPress: () {
                  navigateTo(EditPasswordView());
                },
                color: Color(0xFFFAFFF5),
                suffix: AppImage("assets/icons/arrow.png"),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.r),
          child: BlocBuilder(
            bloc: bloc,
            builder: (context, state) {
              if(state is ProfileLoadingState){
                return AppLoading();
              }else{
                return AppButton(
                  text: 'تعديل البيانات',
                  onTap: () {
                    bloc.add(ProfileStartEvent(
                      imagePath: selectedImage,
                        name: bloc.nameController.text,
                        phone: bloc.phoneController.text,
                        cityId: bloc.cityId,
                    ));
                  },
                  height: 60.h,
                  width: 343.w,
                );
              }

            },
          ),
        ),
      ),
    );
  }
}
