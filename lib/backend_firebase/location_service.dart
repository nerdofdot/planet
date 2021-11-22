import 'package:geocoding/geocoding.dart';
import 'package:location/location.dart';

class LocationService
{
  Future<Map<String,dynamic>> getAddressFromLatLng(LocationData locationData) async
  {
    late Map<String,dynamic> locationAndAddress;
    try
    {
      List<Placemark> placemarks = await placemarkFromCoordinates(
          locationData.latitude!,
          locationData.longitude!
      );
      Placemark place = placemarks[0];
      locationAndAddress =
      {
        "country":place.country!.toLowerCase(),
        "city":place.locality!.toLowerCase(),
        "location_lat":locationData.latitude,
        "location_long":locationData.longitude,
      };
    }
    catch (e)
    {
      print(e);
    }
    return locationAndAddress;
  }
}