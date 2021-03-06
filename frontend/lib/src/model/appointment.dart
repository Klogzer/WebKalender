class Appointment {
  // constructor
  Appointment(this.id, this.name, this.year, this.month, this.day, this.time,
      this.duration, this.location, this.note);

  // leeres Appointment
  Appointment.zero();


  ///Appointment aus einer Json Datei / Respons
  factory Appointment.fromJson(Map<String, dynamic> appointment) => Appointment(
      appointment['id'] as int,
      appointment['name'] as String,
      appointment['year'] as int,
      appointment['month'] as int,
      appointment['day'] as int,
      appointment['time'] as String,
      appointment['duration'] as String,
      appointment['location'] as String,
      appointment['note'] as String);

  List<String> contactCodes = []; //wäre für einladen und geteilte termine
  int id;
  String name;
  int year;
  int month;
  int day;
  String time = "";
  String duration = "";
  String location = "";
  String note = "";

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'year': year,
        'month': month,
        "day": day,
        'time': time,
        'duration': duration,
        'location': location,
        'note': note
      };

  ///date like 'yyyy-mm-dd'
  set date(String str) {
    final List<String> split = str.split("-");
    year = int.parse(split[0]);
    month = int.parse(split[1]);
    day = int.parse(split[2]);
  }

  String get date {
    return "$year-$month-$day";
  }

  bool equals(Appointment app) {
    return id == app.id &&
        year == app.year &&
        month == app.month &&
        day == app.day &&
        name == app.name &&
        time == app.time &&
        duration == app.duration &&
        location == app.location;
  }

  @override
  String toString() {
    return "ID: $id Name: $name Date: $date Time: $time Duration: $duration Location: $location Note: $note";
  }
}
