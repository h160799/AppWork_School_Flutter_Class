import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_programe_johnny/data/map_data.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class MapSample extends StatefulWidget {
  const MapSample({Key? key}) : super(key: key);

  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  final position = Geolocator.getCurrentPosition(
    desiredAccuracy: LocationAccuracy.high,
  );

  String? _locationMessage;

  bool _isLoading = true;

//地圖初始化狀態控制
  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
    setState(() {
      _isLoading = false;
    });
  }

//初始位置變數
  CameraPosition _kGooglePlex = const CameraPosition(
    target: LatLng(
      25.033110135034015,
      121.56276292037668,
    ),
    zoom: 14.4746,
  );

  @override
  void initState() {
    super.initState();
    _requestPermission();
    _getCurrentLocation();
  }

  // Request location permission
  void _requestPermission() async {
    final permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      setState(() {
        _locationMessage = 'Location permission denied';
        _isLoading = false;
      });
    } else {
      _getCurrentLocation();
    }
  }

  // 取得當前位置
  void _getCurrentLocation() async {
    final position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    final GoogleMapController controller = await _controller.future;

    setState(() {
      _locationMessage =
          'Latitude: ${position.latitude}, Longitude: ${position.longitude}';

      _kGooglePlex = CameraPosition(
        target: LatLng(position.latitude, position.longitude),
        zoom: 14.4746,
      );

      _isLoading = false;

      // 將 _kGooglePlex 傳遞給 initialCameraPosition
      controller.animateCamera(CameraUpdate.newCameraPosition(_kGooglePlex));

      // 新增 Marker 顯示當前位置
      _markers.add(Marker(
        markerId: const MarkerId('current_location'),
        position: LatLng(position.latitude, position.longitude),
        infoWindow: const InfoWindow(title: 'Current Location'),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
      ));
    });
  }

  //按鈕位置
  static const CameraPosition _specifiedLocation = CameraPosition(
    bearing: 192.8334901395799,
    target: LatLng(25.045663018103355, 121.53132942478894),
    tilt: 69.440717697143555,
    zoom: 12.700026040649414,
  );

  // 定義標記
  late final List<Marker> _markers = <Marker>[];

  Future<void> _goToSpecifiedLocation() async {
    final GoogleMapController controller = await _controller.future;
    controller
        .animateCamera(CameraUpdate.newCameraPosition(_specifiedLocation));

    setState(() {
      _markers.add(const Marker(
        markerId: MarkerId("marker_1"),
        position: LatLng(25.045663018103355, 121.53132942478894),
        infoWindow: InfoWindow(
          title: 'STYLiSH 三創店',
          snippet: '服飾選品專賣',
        ),
        icon: BitmapDescriptor.defaultMarker,
      ));
      _markers.add(const Marker(
        markerId: MarkerId("marker_2"),
        position: LatLng(25.038977850216206, 121.53242079010171),
        infoWindow: InfoWindow(
          title: 'STYLiSH 忠孝新生店',
          snippet: '服飾選品專賣',
        ),
        icon: BitmapDescriptor.defaultMarker,
      ));
      _markers.add(const Marker(
        markerId: MarkerId("marker_3"),
        position: LatLng(25.04504690719513, 121.52330417247282),
        infoWindow: InfoWindow(
          title: 'STYLiSH 善導寺店',
          snippet: '服飾選品專賣',
        ),
        icon: BitmapDescriptor.defaultMarker,
      ));
      _markers.add(const Marker(
        markerId: MarkerId("marker_4"),
        position: LatLng(25.046408805745273, 121.51751751777037),
        infoWindow: InfoWindow(
          title: 'STYLiSH 北車店',
          snippet: '服飾選品專賣',
        ),
        icon: BitmapDescriptor.defaultMarker,
      ));
      _markers.add(const Marker(
        markerId: MarkerId("marker_5"),
        position: LatLng(
          25.033110135034015,
          121.56276292037668,
        ),
        infoWindow: InfoWindow(
          title: 'STYLiSH 台北101店',
          snippet: '服飾選品專賣',
        ),
        icon: BitmapDescriptor.defaultMarker,
      ));
      _markers.add(const Marker(
        markerId: MarkerId("marker_6"),
        position: LatLng(
          25.053122352395405,
          121.5486009657437,
        ),
        infoWindow: InfoWindow(
          title: 'STYLiSH 小巨蛋店',
          snippet: '服飾選品專賣',
        ),
        icon: BitmapDescriptor.defaultMarker,
      ));
    });
  }

  final List<MyLocation> _locations = [
    MyLocation(
      name: 'STYLiSH 三創店',
      latitude: 25.045663018103355,
      longitude: 121.53132942478894,
      mainImage: 'assets/images/flowers_3.png',
    ),
    MyLocation(
      name: 'STYLiSH 忠孝新生店',
      latitude: 25.038977850216206,
      longitude: 121.53242079010171,
      mainImage: 'assets/images/flowers_4.png',
    ),
    MyLocation(
      name: 'STYLiSH 善導寺店',
      latitude: 25.04504690719513,
      longitude: 121.52330417247282,
      mainImage: 'assets/images/flowers_5.png',
    ),
    MyLocation(
      name: 'STYLiSH 北車店',
      latitude: 25.046408805745273,
      longitude: 121.51751751777037,
      mainImage: 'assets/images/flowers_6.png',
    ),
    MyLocation(
      name: 'STYLiSH 台北101店',
      latitude: 25.033110135034015,
      longitude: 121.56276292037668,
      mainImage: 'assets/images/flowers_7.png',
    ),
    MyLocation(
      name: 'STYLiSH 小巨蛋店',
      latitude: 25.053122352395405,
      longitude: 121.5486009657437,
      mainImage: 'assets/images/flowers_2.png',
    ),
  ];

  // 追蹤選定的位置
  Future<void> _goToTapLocation(CameraPosition _selectedLocation) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_selectedLocation));
  }

  //導航功能
  void launchGoogleMapsNavigation(double lat, double lng) async {
    final String googleMapsUrl =
        'https://www.google.com/maps/search/?api=1&query=$lat,$lng';
    if (await canLaunch(googleMapsUrl)) {
      await launch(googleMapsUrl);
    } else {
      throw 'Could not open the map.';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition: _kGooglePlex,
            onMapCreated: _onMapCreated,
            markers: Set<Marker>.of(_markers), // 在地圖上顯示標記

            // 更新地圖位置
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            compassEnabled: true,
            mapToolbarEnabled: false,
          ),
          if (_isLoading)
            const Center(
              child: CircularProgressIndicator(),
            ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 80,
            child: SizedBox(
              height: 250.0,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _locations.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          CameraPosition selectedLocation = CameraPosition(
                            bearing: 192.8334901395799,
                            target: LatLng(_locations[index].latitude,
                                _locations[index].longitude),
                            tilt: 69.440717697143555,
                            zoom: 19.151926040649414,
                          );
                          _goToTapLocation(selectedLocation);
                          _markers.add(
                            Marker(
                              markerId: MarkerId(_locations[index].name),
                              position: LatLng(_locations[index].latitude,
                                  _locations[index].longitude),
                              infoWindow: InfoWindow(
                                title: _locations[index].name,
                                snippet: '服飾選品專賣',
                              ),
                              icon: BitmapDescriptor.defaultMarker,
                            ),
                          );
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          shape: BoxShape.rectangle,
                        ),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(8),
                                  topRight: Radius.circular(8),
                                ),
                                child: Image(
                                  width: 200,
                                  height: 100,
                                  image:
                                      AssetImage(_locations[index].mainImage),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const SizedBox(
                                height: 10.0,
                              ),
                              Container(
                                margin: const EdgeInsets.only(left: 10.0),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        _locations[index].name,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16.0),
                                      ),
                                      const SizedBox(
                                        height: 10.0,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          launchGoogleMapsNavigation(
                                            _locations[index].latitude,
                                            _locations[index].longitude,
                                          );
                                        },
                                        child: Container(
                                            width: 90.0,
                                            height: 40.0,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              color: Colors.grey[200],
                                              shape: BoxShape.rectangle,
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: const [
                                                Icon(Icons.directions),
                                                SizedBox(
                                                  width: 10.0,
                                                ),
                                                Text('路線'),
                                              ],
                                            )),
                                      ),
                                    ]),
                              )
                            ]),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _goToSpecifiedLocation,
        label: const Text(
          '所有分店',
          style: TextStyle(fontSize: 16.0),
        ),
        icon: const Icon(Icons.my_location),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
    );
  }
}
