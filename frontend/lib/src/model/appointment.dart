class Appointment {
  // constructor
  Appointment(this.id,this.contactCodes, this.name, this.year, this.month, this.day, this.time,
      this.duration, this.location);

  // leeres Appointment
  Appointment.zero();

  factory Appointment.fromJson(Map<String, dynamic> appointment) => Appointment(
      _toInt(appointment['id']),
      appointment['contactCodes'] as List<String>,
      appointment['name'] as String,
      appointment['year'] as int,
      appointment['month'] as int,
      appointment['day'] as int,
      appointment['time'] as String,
      appointment['duration'] as String,
      appointment['location'] as String);

  List<String> contactCodes;
  int id;
  String name;
  int year;
  int month;
  int day;
  String time = "";
  String duration = "";
  String location;

  Map toJson() => {
        'contactCodes': contactCodes,
        'name': name,
        'year': year,
        'month': month,
        "day": day,
        'time': time,
        'duration': duration,
        'location': location
      };

  ///date like 'yyyy-mm-dd'
  set date(String str) {
    final List split = str.split("-");
    year = _toInt(split[0]);
    month = _toInt(split[1]);
    day = _toInt(split[2]);
  }

  String get date {
    return "$year-$month-$day";
  }
}

int _toInt(id) => id is int ? id : int.parse(id as String);
