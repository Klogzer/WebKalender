import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:angular_router/angular_router.dart';


import 'package:demo/src/model/person.dart';
import 'package:demo/src/view/components/login_component.dart';
import 'package:demo/src/view/routes/route_paths.dart';
import 'package:demo/src/view/services/contact_service.dart';




@Component(
  selector: 'contact',
  templateUrl: 'contact_component.html',
  styleUrls: ['contact_component.css'],
  directives: [coreDirectives, routerDirectives, formDirectives],
)
/// Klasse zur verwaltung der Kontakte
class ContactComponent implements OnActivate {

  ContactComponent(this._contactService, this._location, this._router);

  Contact contact;
  final Location _location;
  final Router _router;
  String note;
  bool deleteControl = false;
  final ContactService _contactService;

  /// Folgender Code wird immer bei der Aktivierung der Klasse aufgerufen
  @override
  void onActivate(_, RouterState current) async {
    if (!LoginComponent.loggedIn) {
      await _router.navigate('/login');
    } else {
      final con = getNumber(current.parameters);
      if (getNumber != null) {
        // ignore: unnecessary_parenthesis
        contact = await (_contactService.get(con));
        note = contact.note;
      }
    }
  }

  /// Methode zum speichern, der änderungen die man im Kontakt vorgenommen hat
  Future<void> save() async {
    await _contactService.update(contact);
    goBack();
  }

  ///Methode zum löschen von einem Kontakt
  Future<void> delete() async {
    if (deleteControl==true) {
      await _contactService.delete(contact.contactCode);
      goBack();
    } else {
      deleteControl = true;
    }
  }

  ///Methode, die die übergeordnete ansicht anzeigt
  void goBack() => _location.back();

}
