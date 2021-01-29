import 'package:cabby/datamodels/address.dart';
import 'package:flutter/cupertino.dart';

class AppData extends ChangeNotifier {
  Address pickupAddress;

  Address destinationAddress;
  void updatePickupAddress(Address pickup) {
    pickupAddress = pickup;
    notifyListeners();
  }

  void updateDestinationAddress(Address destination) {
    destinationAddress = destination;
    notifyListeners();
  }
}