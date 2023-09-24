import 'package:flutter_animate/flutter_animate.dart';
import 'package:geolocator/geolocator.dart';
import 'package:new_attandance/src/presentation/auth/widget/q_dialog_error.dart';
import 'package:new_attandance/src/presentation/home/bloc/location/location_cubit.dart';
import 'package:new_attandance/src/presentation/home/bloc/user_status/user_status_cubit.dart';
import 'package:new_attandance/src/presentation/home/screen/q_absen.dart';
import 'package:device_info_plus/device_info_plus.dart';

import '../../../shared/util/q_export.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double latitude = 0;
  double longitude = 0;
  bool locationLoaded = false;
  bool inArea = false;
  String deviceName = "";

  @override
  void initState() {
    super.initState();
    getLocation().then((_) {});
    context.read<UserStatusCubit>().cekData();
    deviceInfo();
  }

  Future<void> getLocation() async {
    Position position = await Geolocator.getCurrentPosition();
    latitude = position.latitude;
    longitude = position.longitude;
    locationLoaded = true;
    setState(() {});
    debugPrint("out latitude = $latitude longitude = $longitude");
  }

  deviceInfo() async {
    final deviceInfoPlugin = DeviceInfoPlugin();
    final deviceInfo = await deviceInfoPlugin.androidInfo;
    final anroidInfo = "${deviceInfo.brand} ${deviceInfo.model}";
    setState(() {
      deviceName = anroidInfo;
    });
  }

  onRefrest() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var auth = context.read<AuthBloc>();
    var theme = context.read<ThemeCubit>();
    var location = context.read<LocationCubit>();
    var userStatus = context.read<UserStatusCubit>();
    return MultiBlocListener(
      listeners: [
        BlocListener<AuthBloc, AuthState>(
          bloc: auth,
          listener: (context, state) {
            state.maybeMap(
              orElse: () {},
              unauthenticate: (value) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                );
              },
            );
          },
        ),
        BlocListener<LocationCubit, LocationState>(
          bloc: location,
          listener: (context, state) {
            state.maybeMap(
              orElse: () {},
              inLocation: (value) {
                setState(() {
                  inArea = true;
                });
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => QAbsen(
                          latitude: latitude,
                          longitude: longitude,
                          deviceName: deviceName)),
                );
              },
              outLocation: (value) {
                dialogError(context, "Di luar kawansan kantor");
                setState(() {
                  inArea = false;
                });
              },
              failed: (value) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                );
              },
            );
          },
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Home Screen"),
          actions: [
            IconButton(
              onPressed: () => onRefrest(),
              icon: const Icon(
                Icons.refresh,
                size: 24.0,
              ),
            ),
            BlocBuilder<ThemeCubit, bool>(
              bloc: theme,
              builder: (context, state) {
                return IconButton(
                  icon: Icon(state ? Icons.dark_mode : Icons.light_mode),
                  onPressed: () {
                    context.read<ThemeCubit>().changeTheme();
                  },
                );
              },
            ),
            const SizedBox(
              width: 10.0,
            ),
            InkWell(
              onTap: () async {
                bool confirm = false;
                await showDialog<void>(
                  context: context,
                  barrierDismissible: true,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Center(
                        child: Text('Logout'),
                      ),
                      content: const SingleChildScrollView(
                        child: ListBody(
                          children: <Widget>[
                            Text('Apakah anda yakin ingin logout?'),
                          ],
                        ),
                      ),
                      actions: <Widget>[
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey[600],
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text("No"),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blueGrey,
                          ),
                          onPressed: () {
                            confirm = true;
                            Navigator.pop(context);
                          },
                          child: const Text("Yes"),
                        ),
                      ],
                    ).animate().shake().fadeIn();
                  },
                );

                if (confirm) {
                  auth.add(const AuthEvent.logout());
                }
              },
              child: const Icon(
                Icons.logout,
                size: 24.0,
              ),
            ),
            const SizedBox(
              width: 10.0,
            ),
          ],
        ),
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: MediaQuery.of(context).size.height / 2,
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.symmetric(horizontal: 15.0),
                decoration: const BoxDecoration(),
                child: Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const CircleAvatar(
                        maxRadius: 80,
                        backgroundImage: NetworkImage(
                          "https://i.ibb.co/PGv8ZzG/me.jpg",
                        ),
                      ),
                      const Text(
                        "06:00",
                        style: TextStyle(
                          fontSize: 50.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Text(
                        "Admin@gmail.com",
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      Card(
                        margin: const EdgeInsets.symmetric(horizontal: 10.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        elevation: 2,
                        child: const Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 5.0),
                          child: Text(
                            "Waktu kerja yang tersisa: 03:20",
                            style: TextStyle(
                              fontSize: 18.0,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      BlocBuilder<UserStatusCubit, UserStatusState>(
                        bloc: userStatus,
                        builder: (context, state) {
                          return state.maybeWhen(
                            orElse: () {
                              return Container();
                            },
                            signIn: () {
                              return SizedBox(
                                height: 50,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  onPressed: () {
                                    debugPrint("Nama Device =$deviceName");
                                    location.checkLocation(
                                        latitude: latitude,
                                        longitude: longitude);
                                    setState(() {});
                                    if (inArea = true) {
                                      debugPrint("aman");
                                    } else {
                                      debugPrint("tidak aman");
                                    }
                                  },
                                  child: const Text(
                                    "CHECK IN",
                                    style: TextStyle(
                                      fontSize: 20.0,
                                    ),
                                  ),
                                ),
                              );
                            },
                            signOut: (data) {
                              return SizedBox(
                                height: 50,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  onPressed: () {
                                    location.checkLocation(
                                        latitude: latitude,
                                        longitude: longitude);
                                    setState(() {});
                                    if (inArea = true) {
                                      debugPrint("aman");
                                    } else {
                                      debugPrint("tidak aman");
                                    }
                                  },
                                  child: const Text(
                                    "CHECK OUT",
                                    style: TextStyle(
                                      fontSize: 20.0,
                                    ),
                                  ),
                                ),
                              );
                            },
                            complate: (data) {
                              return SizedBox(
                                height: 50,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  onPressed: null,
                                  child: const Text(
                                    "PEKERJAAN TELAH SELESAI",
                                    style: TextStyle(
                                      fontSize: 20.0,
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
              )
                  .animate()
                  .slideX(delay: const Duration(milliseconds: 2))
                  .fadeIn(),
              const SizedBox(
                height: 20.0,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CardHomePage(
                      title: "Check In",
                      icon: Icons.login,
                      time: "10:20 am",
                      subtitle: "On Time"),
                  CardHomePage(
                      title: "Check Out",
                      icon: Icons.logout,
                      time: "18:20 am",
                      subtitle: "Go Home")
                ],
              ).animate().slideX(delay: 150.ms, begin: 0.5).fadeIn(),
              const SizedBox(
                height: 20.0,
              ),
              const CardHomePage(
                      title: "Working Time",
                      icon: Icons.lock_clock,
                      time: "08:00 am",
                      subtitle: "Your Late to home")
                  .animate()
                  .slideX(delay: 200.ms, begin: -0.5)
                  .fadeIn()
            ],
          ),
        ),
      ),
    );
  }
}
