import 'package:cabby/datamodels/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

String serverKey =
    'key=AAAA0QwbZwM:APA91bHRoBwfBfNToVzCP2qPBv_ek8bLMuqrurh_xMSxt0rBk1SBRjquzx0EfxfAMtKkYVgtHuM2XeQFEPIRzle_8uZnhkiKiWj79oiHDyhwTvIiBWF7lsSAgiPnq6IAqIKJiwxOBG8r';

String mapKey = 'AIzaSyDluzsfhiaAFwPkk25k3ofUGUoISc1Pglo';

final CameraPosition GooglePlex = CameraPosition(
  target: LatLng(37.42796133580664, -122.085749655962),
  zoom: 14.4746,
);

User currentFirebaseUser;

UserProfile currentUserInfo;
