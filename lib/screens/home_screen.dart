import 'package:flutter/material.dart';
import '../constants/app_constants.dart';
import '../routes/app_routes.dart';
import '../widgets/app_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void _go(BuildContext c, {bool register = false, bool driver = false}) =>
      Navigator.pushNamed(c, AppRoutes.login,
          arguments: {'register': register, 'driver': driver});

  @override
  Widget build(BuildContext context) {
    const queue = ['Ben Cruz', 'Lito Ramos'];
    return Scaffold(
      appBar: AppBar(
        title: const Row(children: [
          Icon(Icons.local_taxi, color: kGreen),
          SizedBox(width: 8),
          Text('Park Keys', style: TextStyle(fontWeight: FontWeight.w700)),
        ]),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 480),
          child: ListView(padding: const EdgeInsets.all(16), children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                gradient: const LinearGradient(
                    colors: [Color(0xFF1E7B4A), Color(0xFF3FA55E)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight),
              ),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                const Chip(label: Text('● 5 driver(s) in queue right now', style: TextStyle(fontSize: 12))),
                const SizedBox(height: 8),
                const Text('Fair, fast and organized rides for your community',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.w800, height: 1.1)),
                const SizedBox(height: 8),
                const Text('A live tricycle queue for passengers and a fair turn for drivers.'),
                const SizedBox(height: 16),
                AppButton(label: 'Log in', color: Colors.white, onPressed: () => _go(context)),
                const SizedBox(height: 10),
                AppButton(label: 'Register as Passenger', color: Colors.white,
                    onPressed: () => _go(context, register: true)),
                const SizedBox(height: 10),
                AppButton(label: 'Register as Driver', color: kOrange, textColor: Colors.white,
                    onPressed: () => _go(context, register: true, driver: true)),
              ]),
            ),
            const SizedBox(height: 16),
            Card(
              color: kCard,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(children: [
                  const ListTile(
                    title: Text('Live queue', style: TextStyle(fontWeight: FontWeight.w700)),
                    trailing: Chip(label: Text('Mabini · 3 in queue')),
                  ),
                  for (var i = 0; i < queue.length; i++)
                    ListTile(
                      title: Text('#${i + 1} ${queue[i]}', style: const TextStyle(fontWeight: FontWeight.w600)),
                      subtitle: Text(i == 0 ? 'Ready now' : 'Waiting'),
                      trailing: Chip(
                        label: Text(i == 0 ? 'On deck' : 'Waiting'),
                        backgroundColor: i == 0 ? kGreen.withOpacity(.2) : Colors.amber.withOpacity(.2),
                      ),
                    ),
                ]),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}