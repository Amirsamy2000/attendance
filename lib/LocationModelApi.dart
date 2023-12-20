class LocationModelApi {
  double? longitude;
  double? latitude;
  int? id;

  LocationModelApi(double longitude, double latitude, int id) {
    this.longitude = longitude;
    this.latitude = latitude;
    this.id = id;
  }

  // Factory method to create a LocationModelApi object from a map
  factory LocationModelApi.fromMap(Map<String, dynamic> map) {
    return LocationModelApi(
      map['Longitude'] ?? 0.0,
      map['Latitude'] ?? 0.0,
      map['ID'] ?? 0,
    );
  }

  // Convert the object to a map
  Map<String, dynamic> toMap() {
    return {
      'Longitude': longitude,
      'Latitude': latitude,
      'ID': id,
    };
  }
}
