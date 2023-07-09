import 'package:kiwi/kiwi.dart';
import 'package:thimar/screens/auth/change_password/bloc/bloc.dart';
import 'package:thimar/screens/auth/forget_password/bloc/bloc.dart';
import 'package:thimar/screens/auth/login/bloc/bloc.dart';
import 'package:thimar/screens/auth/register/bloc/bloc.dart';
import 'package:thimar/screens/auth/verification/bloc/bloc.dart';
import 'package:thimar/screens/home/cart/bloc/bloc.dart';
import 'package:thimar/mutual_bloc/bloc_slider/bloc.dart';
import 'package:thimar/screens/home/sections/bloc/bloc.dart';
import 'package:thimar/screens/home/show_product/bloc/bloc.dart';
import 'mutual_bloc/bloc_add_to_cart/bloc.dart';
import 'mutual_bloc/bloc_categories/bloc.dart';
import 'mutual_bloc/bloc_get_products/bloc.dart';





void initKiwi() {
  KiwiContainer container = KiwiContainer();
  container.registerFactory((c) => LoginBloc());
  container.registerFactory((c) => RegisterBloc());
  container.registerFactory((c) => VerificationBloc());
  container.registerFactory((c) => ForgetPasswordBloc());
  container.registerFactory((c) => ChangePasswordBloc());
  container.registerFactory((c) => SliderBloc());
  container.registerFactory((c) => CategoriesProductBloc());
  container.registerFactory((c) => ShowProductBloc());
  container.registerFactory((c) => ShowCartBloc());
  container.registerFactory((c) => AddToCartBloc());
  container.registerFactory((c) => GetProductsBloc());
  container.registerFactory((c) => CategoriesBloc());



}