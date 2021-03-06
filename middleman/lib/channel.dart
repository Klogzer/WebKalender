import 'package:aqueduct/managed_auth.dart';
import 'package:middleman/controller/appointment_controller.dart';
import 'package:middleman/controller/contact_controller.dart';
import 'package:middleman/controller/register_controller.dart';
import 'package:middleman/controller/user_controller.dart';
import 'package:middleman/model/person.dart';

import 'middleman.dart';

/// This type initializes an application.
///
/// Override methods in this class to set up routes and initialize services like
/// database connections. See http://aqueduct.io/docs/http/channel/.
class CalenderChannel extends ApplicationChannel {
  ManagedContext context;
  AuthServer authServer;

  /// Initialize services in this method.
  ///
  /// Implement this method to initialize services, read values from [options]
  /// and any other initialization required before constructing [entryPoint].
  ///
  /// This method is invoked prior to [entryPoint] being accessed.
  @override
  Future prepare() async {


    logger.onRecord.listen(
        (rec) => print("$rec ${rec.error ?? ""} ${rec.stackTrace ?? ""}"));

    final config = CalenderConfig(options.configurationFilePath);
    final dataModel = ManagedDataModel.fromCurrentMirrorSystem();
    final persistentStore = PostgreSQLPersistentStore.fromConnectionInfo(
        config.database.username,
        config.database.password,
        config.database.host,
        config.database.port,
        config.database.databaseName);

    context = ManagedContext(dataModel, persistentStore);

    // AuthStorage
    final authStorage = ManagedAuthDelegate<User>(context);
    authServer = AuthServer(authStorage);
  }

  /// Construct the request channel.
  ///
  /// Return an instance of some [Controller] that will be the initial receiver
  /// of all [Request]s.
  ///
  /// This method is invoked after [prepare].
  @override
  Controller get entryPoint {
    final router = Router();
    // registerStuff
    router
        .route('/register')
        .link(() => RegisterController(context, authServer));
    // add this route
    router
        .route('/auth/token')
        .link(() => AuthController(authServer));
    router
        .route('/appointments/[:id]')
        .link(() => Authorizer.bearer(authServer))
        .link(() => AppointmentController(context));
    router
        .route('/appointments/lookup/[:year/[:month/[:day]]]')
        .link(() => Authorizer.bearer(authServer))
        .link(() => AppointmentController(context));
    router
        .route('/user/[:number]')
        .link(() => UserController(context));
    router
        .route('/user/lookup/[:id]')
        .link(() => UserController(context));
    router
        .route('/user/look/[:username]')
        .link(() => UserController(context));
    router
        .route('/contacts/[:number]')
        .link(() => ContactController(context));

    return router;
  }
}

class CalenderConfig extends Configuration {
  CalenderConfig(String path) : super.fromFile(File(path));

  DatabaseConfiguration database;
}
