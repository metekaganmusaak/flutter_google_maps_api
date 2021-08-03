class Coordinates{
  String directionWay;
  double longitude;
  double latitude;

  Coordinates({this.directionWay, this.latitude, this.longitude});


  factory Coordinates.fromJson(Map<String, dynamic> parsedJson){
    return Coordinates(
      directionWay: parsedJson['directionWay'],
      longitude : parsedJson['longitude'],
      latitude : parsedJson ['latitude'],

    );
  }

  Map<String, dynamic> toJson() {
    return {
      'directionWay': directionWay,
      'longitude': longitude,
      'latitude': latitude,
    };
  }
  
}