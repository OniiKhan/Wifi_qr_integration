import 'package:flutter/material.dart';
import 'package:wifi_iot/wifi_iot.dart';

void main() => runApp(MaterialApp(
      darkTheme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      home: const FlutterWifiConnect(),
    ));

class FlutterWifiConnect extends StatefulWidget {
  const FlutterWifiConnect({super.key});

  @override
  _FlutterWifiConnectState createState() => _FlutterWifiConnectState();
}

class _FlutterWifiConnectState extends State<FlutterWifiConnect> {
  TextEditingController ssidController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String connectionStatus = "";

  void _connectToWifi() async {
    String ssid = ssidController.text;
    String password = passwordController.text;

    if (ssid.isNotEmpty && password.isNotEmpty) {
      try {
        bool isConnected = await WiFiForIoTPlugin.connect(ssid,
            security: NetworkSecurity.WPA, password: password);

        if (isConnected) {
          setState(() {
            connectionStatus = "Connected to $ssid";
          });
        } else {
          setState(() {
            connectionStatus = "Failed to connect to $ssid";
          });
        }
      } catch (e) {
        setState(() {
          connectionStatus = "Error: $e";
        });
      }
    } else {
      setState(() {
        connectionStatus = "SSID and Password are required";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Wi-Fi Connect"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: ssidController,
              decoration: const InputDecoration(
                labelText: "SSID",
              ),
            ),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: "Password",
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _connectToWifi,
              child: const Text("Connect"),
            ),
            const SizedBox(height: 16.0),
            Text(
              connectionStatus,
              style: const TextStyle(
                fontSize: 16.0,
                color: Colors.green,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
