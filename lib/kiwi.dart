import 'package:kiwi/kiwi.dart';
import 'core/logic/server_gate.dart';
import 'features/about_order/bloc.dart';
import 'features/about_us/bloc.dart';
import 'features/add_to_cart/bloc.dart';
import 'features/address/bloc.dart';
import 'features/cart/bloc.dart';
import 'features/categories/bloc.dart';
import 'features/change_password/bloc.dart';
import 'features/confirm_order/bloc.dart';
import 'features/contact/bloc.dart';
import 'features/edit_password/bloc.dart';
import 'features/faqs/bloc.dart';
import 'features/favorites/bloc.dart';
import 'features/forget_password/bloc.dart';
import 'features/get_products/bloc.dart';
import 'features/login/bloc.dart';
import 'features/logout_bloc/bloc.dart';
import 'features/my_order/bloc.dart';
import 'features/notifications/bloc.dart';
import 'features/policy/bloc.dart';
import 'features/profile/bloc.dart';
import 'features/rate_order/bloc.dart';
import 'features/register/bloc.dart';
import 'features/search/bloc.dart';
import 'features/sections/bloc.dart';
import 'features/show_product/bloc.dart';
import 'features/slider/bloc.dart';
import 'features/verification/bloc.dart';




void initKiwi() {
  KiwiContainer container = KiwiContainer();
  container.registerSingleton((c) => ServerGate());
  container.registerFactory((c) => LoginBloc(c.resolve<ServerGate>()));
  container.registerFactory((c) => RegisterBloc(c.resolve<ServerGate>()));
  container.registerFactory((c) => VerificationBloc(c.resolve<ServerGate>()));
  container.registerFactory((c) => ForgetPasswordBloc(c.resolve<ServerGate>()));
  container.registerFactory((c) => ChangePasswordBloc(c.resolve<ServerGate>()));
  container.registerFactory((c) => SliderBloc(c.resolve<ServerGate>()));
  container.registerFactory((c) => CategoriesProductBloc(c.resolve<ServerGate>()));
  container.registerFactory((c) => ProductBloc(c.resolve<ServerGate>()));
  container.registerFactory((c) => ShowCartBloc(c.resolve<ServerGate>()));
  container.registerFactory((c) => AddToCartBloc(c.resolve<ServerGate>()));
  container.registerFactory((c) => GetProductsBloc(c.resolve<ServerGate>()));
  container.registerFactory((c) => CategoriesBloc(c.resolve<ServerGate>()));
  container.registerFactory((c) => OrderBloc(c.resolve<ServerGate>()));
  container.registerFactory((c) => AddRateBloc(c.resolve<ServerGate>()));
  container.registerFactory((c) => FaqsBloc(c.resolve<ServerGate>()));
  container.registerFactory((c) => PolicyBloc(c.resolve<ServerGate>()));
  container.registerFactory((c) => FavoritesBloc(c.resolve<ServerGate>()));
  container.registerFactory((c) => ContactBloc(c.resolve<ServerGate>()));
  container.registerFactory((c) => AddressBloc(c.resolve<ServerGate>()));
  container.registerFactory((c) => AboutOrderBloc(c.resolve<ServerGate>()));
  container.registerFactory((c) => AboutBloc(c.resolve<ServerGate>()));
  container.registerFactory((c) => ProfileBloc(c.resolve<ServerGate>()));
  container.registerFactory((c) => EditPasswordBloc(c.resolve<ServerGate>()));
  container.registerFactory((c) => ConfirmOrderBloc(c.resolve<ServerGate>()));
  container.registerFactory((c) => LogoutBloc(c.resolve<ServerGate>()));
  container.registerFactory((c) => SearchBloc(c.resolve<ServerGate>()));
  container.registerFactory((c) => NotificationsBloc(c.resolve<ServerGate>()));



}