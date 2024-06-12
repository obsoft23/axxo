// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, unused_element, unused_field

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:vixo/theme/constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vixo/view/pages/chats_page.dart';

class PartnerLocationMap extends StatefulWidget {
  const PartnerLocationMap({super.key});

  @override
  State<PartnerLocationMap> createState() => _PartnerLocationMapState();
}

class _PartnerLocationMapState extends State<PartnerLocationMap> {
  String ACCESS_TOKEN = String.fromEnvironment("ACCESS_TOKEN");

  MapboxMapController? _controller;

  void _onMapCreated(MapboxMapController controller) {
    _controller = controller;
  }

  @override
  void initState() {
    //_onMapCreated(mapBoxController!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: null,
        backgroundColor: Colors.transparent,
        elevation: 0, // Removes the shadow below the AppBar
        actions: [
          Container(
            margin: EdgeInsets.only(right: 16.0), // Margin for spacing
            child: IconButton(
              icon: Icon(Icons.notifications),
              color: kDefaultIconDarkColor,
              iconSize: 30.0,
              onPressed: () {
                // Add your onPressed code here!
                showCupertinoModalBottomSheet(
                  context: context,
                  builder: (context) => Container(),
                );
              },
            ),
          ),
        ],
      ),
      extendBodyBehindAppBar: true,
      body: Obx(
        () {
          if (mapController.isLoading.value) {
            return Center(child: CircularProgressIndicator());
          } else {
            return Stack(
              children: [
                Container(
                  color: Colors.yellow,
                ),
                // Map background
                Container(
                  margin: EdgeInsets.only(bottom: 30),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            ClipRRect(
                              borderRadius:
                                  BorderRadius.circular(25.0), // Rounded edges
                              child: Column(
                                children: [
                                  Image.asset(
                                    'assets/images/map.jpg', // Local asset image
                                    fit: BoxFit.cover,
                                    width: MediaQuery.of(context).size.width *
                                        0.9, // Fill most of the width
                                    height: MediaQuery.of(context).size.height *
                                        0.72, // Fill most of the height
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                // Floating containers
                Positioned(
                  bottom: 45,
                  left: 20,
                  child: Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      //  icon: Icon(Icons.accessibility_new_rounded),
                      icon: FaIcon(FontAwesomeIcons.solidMessage),
                      color: kDefaultIconDarkColor,
                      iconSize: 30.0,
                      onPressed: () {
                        // Add your onPressed code here!
                        Get.to(() => ChatPage());
                      },
                    ),
                  ),
                ),
                Positioned(
                  bottom: 45,
                  right: 20,
                  child: Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      icon: Icon(Icons.favorite),
                      color: kDefaultIconDarkColor,
                      iconSize: 30.0,
                      onPressed: () {
                        // Add your onPressed code here!
                      },
                    ),
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}

  /* MapboxMap(
            accessToken:
                "pk.eyJ1Ijoib2xvZ3NiYWJhIiwiYSI6ImNseDd6cjIxYTFyOGcya3F1NmxjY3hzMzgifQ.Ii_Hu6mk0pXM7uG_MOrhrQ",
            scrollGesturesEnabled: true,
            initialCameraPosition:
                const CameraPosition(target: LatLng(37.785834, -122.406417)),
          );
          
         AssetImage(
                          'assets/images/map.jpg'), // Replace with your map image URL
                      fit: BoxFit.fi,
                    ),  
          
          
          */
/*MapWidget(
            //onMapCreated: _onMapCreated,
            cameraOptions: CameraOptions(
                center:
                    Point(coordinates: Position(-80.1263, 25.7845)).toJson(),
                zoom: 13.0),
          ); 
          

          MapWidget(
            styleUri:
                "https://api.mapbox.com/styles/v1/ologsbaba/clwnypxtm010401qse2if04v0/wmts?access_token=pk.eyJ1Ijoib2xvZ3NiYWJhIiwiYSI6ImNscm9leWF6NzEzaTMyanFqejIzNjY2M3EifQ.ohEV3fbSJ9MrnPWuoYZoCw",
            key: ValueKey("mapWidget"),
            //  onMapCreated: _onMapCreated,
          );


          MapboxMap? mapboxMap;

  _onMapCreated(MapboxMap mapboxMap) {
    this.mapboxMap = mapboxMap;
  }
          
          
          
          
          MapboxMap(
            accessToken: const String.fromEnvironment("ACCESS_TOKEN"),
            styleString:
                "https://api.mapbox.com/styles/v1/ologsbaba/clwnypxtm010401qse2if04v0/wmts?access_token=pk.eyJ1Ijoib2xvZ3NiYWJhIiwiYSI6ImNscm9leWF6NzEzaTMyanFqejIzNjY2M3EifQ.ohEV3fbSJ9MrnPWuoYZoCw",
            scrollGesturesEnabled: true,
            initialCameraPosition:
                const CameraPosition(target: LatLng(37.785834, -122.406417)),
          );
          
          
          
       PlatformException (PlatformException(unregistered_view_type, A UIKitView widget is trying to create a PlatformView with an unregistered type: < plugins.flutter.io/mapbox_maps >, If you are the author of the PlatformView, make sure `registerViewFactory` is invoked.
   
          
          
         appBar: AppBar(
        title: null,
        backgroundColor: Colors.transparent,
        elevation: 0, // Removes the shadow below the AppBar
        actions: [
          Container(
            margin: EdgeInsets.only(right: 16.0), // Margin for spacing
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: kDarkGreyColor, width: 2.0),
            ),
            child: IconButton(
              icon: Icon(Icons.person),
              color: kPrimaryColor2,
              iconSize: 30.0,
              onPressed: () {
                // Add your onPressed code here!
              },
            ),
          ),
        ],
      ),   
          */