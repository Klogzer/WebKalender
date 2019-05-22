import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';
import 'package:demo/src/view/routes/route_paths.dart';
import 'package:demo/src/view/services/appointment_service.dart';
import 'package:demo/src/model/appointment.dart';

import 'mock_appointments.dart';


@Component(
  selector: 'dayview',
  templateUrl: 'dayview_component.html',
  styleUrls: ['dayview_component.css'],
  directives: [coreDirectives, routerDirectives],
)
class DayviewComponent implements OnActivate {
  final Router _router;
  var appointments = List();

  /// Folgender Code wird immer bei der Aktivierung der Klasse aufgerufen
  @override
  void onActivate(_, RouterState current) async {
    final int year = getYear(current.parameters);
    final int month = getMonth(current.parameters);
    final int day = getDay(current.parameters);
    if (year != null && month != null && day !=null) {
      appointments = await _appointmentService.getAll();
      appointments.sort((a, b) => a.time.compareTo(b.time) as int);

    }
  }

  // service Klasse für ORM
  DayviewComponent(this._appointmentService,this._router);

  final AppointmentService _appointmentService;


  ///Methode die die URL von dem Termin mit gegebener id als String zurückgibt
  String _appointmentUrl(int id) =>
      RoutePaths.appointment.toUrl(parameters: {idParam: '$id'});

  ///Methode die den ausgewählten Termin aufruft
  Future<NavigationResult> gotoDetail(Appointment appointment) =>
      _router.navigate(_appointmentUrl(appointment.id));

}