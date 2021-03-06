import 'package:angular_router/angular_router.dart';

const String idParam = 'id';
const String conParam = 'number';
const String yParam ="year";
const String mParam ="month";
const String dParam ="day";


class RoutePaths {
  ///Definition der routpaths dazu werden noch mögliche url parameter festgelegt
  static final RoutePath dashboard = RoutePath(path: 'dashboard');
  static final RoutePath appointments = RoutePath(path: 'appointments');
  static final RoutePath appointmentNew = RoutePath(path: 'appointmentNew');
  static final RoutePath appointment = RoutePath(path: '${appointments.path}/:$idParam');
  static final RoutePath calendarMain = RoutePath(path: 'calendar');
  static final RoutePath calendar = RoutePath(path: '${calendarMain.path}/:$yParam/:$mParam');
  static final RoutePath dayview = RoutePath(path: '${calendarMain.path}/:$yParam/:$mParam/:$dParam');
  static final RoutePath register = RoutePath(path: 'register');
  static final RoutePath login = RoutePath(path: 'login');
  static final RoutePath account = RoutePath(path: 'account');
  static final RoutePath contacts = RoutePath(path: 'contacts');
  static final RoutePath contact = RoutePath(path: '${contacts.path}/:$conParam');
}

///Funktionen die aus der Url Parameter lesen
int getYear(Map<String, String> parameters) {
  final id = parameters[yParam];
  return id == null ? null : int.tryParse(id);
}
int getMonth(Map<String, String> parameters) {
  final id = parameters[mParam];
  return id == null ? null : int.tryParse(id);
}
int getDay(Map<String, String> parameters) {
  final id = parameters[dParam];
  return id == null ? null : int.tryParse(id);
}
int getId(Map<String, String> parameters) {
  final id = parameters[idParam];
  return id == null ? null : int.tryParse(id);
}
String getNumber(Map<String, String> parameters) {
  return parameters[conParam];
}
