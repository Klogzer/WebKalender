import 'package:aqueduct/managed_auth.dart';
import 'package:middleman/middleman.dart';

class Person extends ManagedObject<_Person> implements _Person {}

class User extends ManagedObject<_User> implements _User,ManagedAuthResourceOwner<_User> {
  @Serialize(input: true, output: false)
  String password;
}

class Contact extends ManagedObject<_Contact> implements _Contact {}

abstract class _Person  {
  @primaryKey
  int id;

  @Column(unique: true, nullable: true)
  String contactCode;

  @Column(unique: true)
  String username;

  @Column(unique: false)
  String surname;

  @Column(unique: false)
  String name;

  @Column(unique: true)
  String email;
}

class _Contact extends _Person{
  @Column(unique: false,nullable: true)
  String note;

}


class _User extends ResourceOwnerTableDefinition implements _Person {

  @Column(omitByDefault: true)
  String hashedPassword;

  @Column(omitByDefault: true)
  String salt;

  ManagedSet<ManagedAuthToken> tokens;

  @Column(unique: false, nullable: true)
  String mobileNo;

  @Column(unique: true, nullable: true)
  String contactCode;

  @Column(unique: false)
  String surname;

  @Column(unique: false)
  String name;

  @Column(unique: true)
  String email;
}
