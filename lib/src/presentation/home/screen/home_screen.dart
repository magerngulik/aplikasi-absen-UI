import 'package:flutter_animate/flutter_animate.dart';

import '../../../shared/util/q_export.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var auth = context.read<AuthBloc>();
    var theme = context.read<ThemeCubit>();
    return BlocListener<AuthBloc, AuthState>(
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
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Home Screen"),
          actions: [
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
                          padding: EdgeInsets.symmetric(horizontal: 10.0),
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
                      SizedBox(
                        height: 50,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: () {},
                          child: const Text(
                            "CHECK OUT",
                            style: TextStyle(
                              fontSize: 20.0,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
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
              ),
              const SizedBox(
                height: 20.0,
              ),
              const CardHomePage(
                  title: "Working Time",
                  icon: Icons.lock_clock,
                  time: "08:00 am",
                  subtitle: "Your Late to home")
            ],
          ),
        ),
      ),
    );
  }
}
