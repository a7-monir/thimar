import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiwi/kiwi.dart';

import '../constant/app_button.dart';
import '../constant/app_input.dart';
import '../constant/appbar.dart';
import '../features/contact/bloc.dart';

class ComplaintView extends StatefulWidget {
  const ComplaintView({Key? key}) : super(key: key);

  @override
  State<ComplaintView> createState() => _ComplaintViewState();
}

class _ComplaintViewState extends State<ComplaintView> {

  final bloc = KiwiContainer().resolve<ContactBloc>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.h),
        child: CustomAppBar(title: 'الأقتراحات والشكاوي'),),
      body: BlocBuilder(
        bloc: bloc,
        builder: (context, state) {
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                children: [
                  SizedBox(height: 40.h,),
                  AppInput(
                    label: 'الإسم',
                    controller: bloc.nameController,
                  ),
                  AppInput(
                      label: 'رقم الموبايل',
                      textInputType: TextInputType.phone,
                  inputType: InputType.phone,
                  controller: bloc.phoneController,
                  ),
                  AppInput(
                    label: 'عنوان الموضوع',
                    color: Colors.white,
                    controller: bloc.titleController,),

                  AppInput(
                    label: 'الموضوع',
                    controller: bloc.contentController,
                    minLine: 5,
                  ),
                  AppButton(
                    text: 'إرسال',
                    onTap: () {
                      print(bloc.nameController.text);
                      print(bloc.phoneController.text);
                      print(bloc.titleController.text);
                      print(bloc.contentController.text);

                      bloc.add(CreateContactStartEvent(
                          fullname:bloc.nameController.text,
                          phone: bloc.phoneController.text,
                          title: bloc.titleController.text,
                          content: bloc.contentController.text));
                    },
                    height: 60.h,
                    width: 343.w,
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
