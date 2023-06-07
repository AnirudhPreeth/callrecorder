import 'package:flutter/material.dart';
import 'package:location/location.dart';

class PermissionStatusWidget extends StatefulWidget {
  const PermissionStatusWidget({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _PermissionStatusState createState() => _PermissionStatusState();
}

class _PermissionStatusState extends State<PermissionStatusWidget> {
  final Location location = Location();

  late PermissionStatus _permissionGranted;

  // ignore: prefer_typing_uninitialized_variables
  var child;

  Future<void> _checkPermissions() async {
    final PermissionStatus permissionGrantedResult =
    await location.hasPermission();
    setState(() {
      _permissionGranted = permissionGrantedResult;
    });
  }

  Future<void> _requestPermission() async {
    if (_permissionGranted != PermissionStatus.granted) {
      final PermissionStatus permissionRequestedResult =
      await location.requestPermission();
      setState(() {
        _permissionGranted = permissionRequestedResult;
      });
    }
  }

  @override
  // ignore: avoid_types_as_parameter_names, non_constant_identifier_names
  Widget build(BuildContext) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Permission Status: $_permissionGranted',
          style: const TextStyle(
            fontSize: 20.0,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 30),
        const Divider(
          color: Colors.redAccent,
          thickness: 1.0,
        ),
        Row(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(right: 42),
              child: ElevatedButton(
                onPressed: _checkPermissions,
                child: const Text("Check"),
              ),
            ),
            ElevatedButton(
              onPressed: _permissionGranted == PermissionStatus.granted
                  ? null
                  : _requestPermission,
              child: const Text('Request'),
            )
          ],
        )
      ],
    );
  }
}

