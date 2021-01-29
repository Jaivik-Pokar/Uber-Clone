import 'dart:math';
import 'package:cab_driver/datamodels/history.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:cab_driver/datamodels/directiondetails.dart';
import 'package:cab_driver/dataprovider.dart';
import 'package:cab_driver/globalvaribles.dart';
import 'package:cab_driver/helpers/requesthelper.dart';
import 'package:cab_driver/widgets/ProgressDialog.dart';
import 'package:connectivity/connectivity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_geofire/flutter_geofire.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

// class HelperMethods {
//   static Future<DirectionDetails> getDirectionDetails(
//       LatLng startPosition, LatLng endPosition) async {
//     String url =
//         'https://maps.googleapis.com/maps/api/directions/json?origin=${startPosition.latitude},${startPosition.longitude}&destination=${endPosition.latitude},${endPosition.longitude}&mode=driving&key=AIzaSyAXhk1498g3ORPHcP6Wytkouh0Mn28obVo';
//     print('URL: ${url}');
//     var response = await RequestHelper.getRequest(url);
//
//     if (response == 'failed') {
//       return null;
//     }
//
//     DirectionDetails directionDetails = DirectionDetails();
//
//     directionDetails.durationText =
//         response['routes'][0]['legs'][0]['duration']['text'];
//     directionDetails.durationValue =
//         response['routes'][0]['legs'][0]['duration']['value'];
//
//     directionDetails.distanceText =
//         response['routes'][0]['legs'][0]['distance']['text'];
//
//     directionDetails.distanceValue =
//         response['routes'][0]['legs'][0]['distance']['value'];
//
//     directionDetails.encodedPoints =
//         response['routes'][0]['overview_polyline']['points'];
//
//     return directionDetails;
//   }
//
//   static int estimateFares(DirectionDetails details, int durationValue) {
//     //per km = 6 rupees
//     //per minute = 5 rupees
//     // base fare = 20 rupees
//
//     double baseFare = 20;
//     double distanceFare = (details.distanceValue / 1000) * 6;
//     double timeFare = (durationValue / 60) * 5;
//
//     double totalFare = baseFare + distanceFare + timeFare;
//
//     return totalFare.truncate();
//   }
//
//   static double generateRandomNumber(int max) {
//     var randomGenerator = Random();
//     int randInt = randomGenerator.nextInt(max);
//
//     return randInt.toDouble();
//   }
//
//   static void disableHomeTabLocationUpdates() {
//     homeTabPositionStream.pause();
//     Geofire.removeLocation(currentFirebaseUser.uid);
//   }
//
//   static void enableHomeTabLocationUpadate() {
//     homeTabPositionStream.resume();
//     Geofire.setLocation(currentFirebaseUser.uid, currentPosition.latitude,
//         currentPosition.longitude);
//   }
//
//   static void showProgressDialog(context) {
//     //show please wait dialog
//     showDialog(
//       barrierDismissible: false,
//       context: context,
//       builder: (BuildContext context) => ProgressDialog(
//         status: 'Please wait',
//       ),
//     );
//   }
//
//
//   static void getHistoryInfo(context){
//
//     DatabaseReference earninRef = FirebaseDatabase.instance.reference().child('drivers/${currentFirebaseUser.uid}/earnings');
//
//     earninRef.once().then((DataSnapshot snapshot)=>{
//     if(snapshot.value != null){
//         String earnings = snapshot.value.toString();
//     Provider.of<AppData>(context, listen: false).updateEarnings(earnings);
//   }
//
//
//     });
//
//   }

class HelperMethods {
  static Future<DirectionDetails> getDirectionDetails(
      LatLng startPosition, LatLng endPosition) async {
    String url =
        'https://maps.googleapis.com/maps/api/directions/json?origin=${startPosition.latitude},${startPosition.longitude}&destination=${endPosition.latitude},${endPosition.longitude}&mode=driving&key=AIzaSyAXhk1498g3ORPHcP6Wytkouh0Mn28obVo';

    var response = await RequestHelper.getRequest(url);

    if (response == 'failed') {
      return null;
    }

    DirectionDetails directionDetails = DirectionDetails();

    directionDetails.durationText =
        response['routes'][0]['legs'][0]['duration']['text'];
    directionDetails.durationValue =
        response['routes'][0]['legs'][0]['duration']['value'];

    directionDetails.distanceText =
        response['routes'][0]['legs'][0]['distance']['text'];
    directionDetails.distanceValue =
        response['routes'][0]['legs'][0]['distance']['value'];

    directionDetails.encodedPoints =
        response['routes'][0]['overview_polyline']['points'];

    return directionDetails;
  }

  static int estimateFares(DirectionDetails details, int durationValue) {
    //per km = 6 rupees
//     //per minute = 5 rupees
//     // base fare = 20 rupees

    double baseFare = 20;
    double distanceFare = (details.distanceValue / 1000) * 6;
    double timeFare = (durationValue / 60) * 5;

    double totalFare = baseFare + distanceFare + timeFare;

    return totalFare.truncate();
  }

  static double generateRandomNumber(int max) {
    var randomGenerator = Random();
    int randInt = randomGenerator.nextInt(max);

    return randInt.toDouble();
  }

  static void disableHomTabLocationUpdates() {
    homeTabPositionStream.pause();
    Geofire.removeLocation(currentFirebaseUser.uid);
  }

  // static void enableHomTabLocationUpdates(){
  //   homeTabPositionStream.resume();
  //   Geofire.setLocation(currentFirebaseUser.uid, currentPosition.latitude, currentPosition.longitude);
  // }

  static void enableHomeTabLocationUpadate() {
    homeTabPositionStream.resume();
    Geofire.setLocation(currentFirebaseUser.uid, currentPosition.latitude,
        currentPosition.longitude);
  }

  static void showProgressDialog(context) {
    //show please wait dialog
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) => ProgressDialog(
        status: 'Please wait',
      ),
    );
  }

  static void getHistoryInfo(context) {
    DatabaseReference earningRef = FirebaseDatabase.instance
        .reference()
        .child('drivers/${currentFirebaseUser.uid}/earnings');

    earningRef.once().then((DataSnapshot snapshot) {
      if (snapshot.value != null) {
        String earnings = snapshot.value.toString();
        Provider.of<AppData>(context, listen: false).updateEarnings(earnings);

        List<String> tripHistoryKeys = [];
      }
    });

    DatabaseReference historyRef = FirebaseDatabase.instance
        .reference()
        .child('drivers/${currentFirebaseUser.uid}/history');
    historyRef.once().then((DataSnapshot snapshot) {
      if (snapshot.value != null) {
        Map<dynamic, dynamic> values = snapshot.value;
        int tripCount = values.length;

        //update trip count  to data provider
        Provider.of<AppData>(context, listen: false).updateTripCount(tripCount);

        List<String> tripHistoryKeys = [];

        values.forEach((key, value) {
          tripHistoryKeys.add(key);

          // update trip keys to data provider
          Provider.of<AppData>(context, listen: false)
              .updateTripKeys(tripHistoryKeys);

          getHistoryData(context);
        });
      }
    });
  }

  static void getHistoryData(context) {
    var keys = Provider.of<AppData>(context, listen: false).tripHistoryKeys;

    for (String key in keys) {
      DatabaseReference historyRef =
          FirebaseDatabase.instance.reference().child('rideRequest/$key');

      historyRef.once().then((DataSnapshot snapshot) {
        if (snapshot.value != null) {
          var history = History.fromSnapshot(snapshot);
          Provider.of<AppData>(context, listen: false)
              .updateTripHistory(history);
          print(history.destination);
        }
      });
    }
  }

  static String formatMyDate(String datestring) {
    DateTime thisDate = DateTime.parse(datestring);

    String formattedDate =
        '${DateFormat.MMMd().format(thisDate)},${DateFormat.y().format(thisDate)} -${DateFormat.jm().format(thisDate)}';

    return formattedDate;
  }
}
