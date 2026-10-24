import 'package:flutter/material.dart';
import '../constants/app_constants.dart';
import '../widgets/app_button.dart';
import '../widgets/app_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _register = false, _driver = false, _init = false, _codeSent = false;
  final _name = TextEditingController(),
      _user = TextEditingController(),
      _pass = TextEditingController(),
      _phone = TextEditingController(),
      _code = TextEditingController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_init) return;
    _init = true;
    final a = ModalRoute.of(context)?.settings.arguments as Map?;
    _register = a?['register'] ?? false;
    _driver = a?['driver'] ?? false;
  }

  void _msg(String t) =>
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(t)));

  Widget _tabs(String a, String b, bool second, ValueChanged<bool> on) => Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: SizedBox(
          width: double.infinity,
          child: SegmentedButton<bool>(
            segments: [
              ButtonSegment(value: false, label: Text(a)),
              ButtonSegment(value: true, label: Text(b)),
            ],
            selected: {second},
            onSelectionChanged: (s) => setState(() => on(s.first)),
          ),
        ),
      );

  void _submit() {
    if (!_register) {
      const demo = ['admin', 'pedro', 'maria'];
      if (!demo.contains(_user.text.trim().toLowerCase())) {
        return _msg('Demo accounts: admin, pedro, maria');
      }
      return _msg('Welcome, ${_user.text}! (Next screens coming soon)');
    }
    if (_name.text.isEmpty || _user.text.isEmpty) return _msg('Fill in your name and username');
    if (_code.text != kDemoCode) return _msg('Wrong code. Tap Send Code first.');
    _msg(_driver ? 'Application sent. Wait for admin approval.' : 'Account created!');
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(leading: const BackButton()),
        body: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 480),
            child: ListView(padding: const EdgeInsets.all(16), children: [
              const Icon(Icons.local_taxi, size: 72, color: kGreen),
              const SizedBox(height: 8),
              const Center(
                  child: Text('Welcome back',
                      style: TextStyle(fontSize: 26, fontWeight: FontWeight.w800))),
              const Center(child: Text('Fair. Simple. Organized.')),
              const SizedBox(height: 16),
              _tabs('Log in', 'Register', _register, (v) => _register = v),
              if (_register) _tabs('Passenger', 'Driver', _driver, (v) => _driver = v),
              if (_register) AppTextField(label: 'Full name', controller: _name),
              AppTextField(label: 'Username', controller: _user),
              AppTextField(label: 'Password', controller: _pass, obscure: true),
              if (_register) ...[
                AppTextField(label: 'Phone number', controller: _phone, type: TextInputType.phone),
                AppButton(
                    label: 'Send Code',
                    outline: true,
                    onPressed: () => setState(() => _codeSent = true)),
                if (_codeSent)
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: Text('Demo mode: your code is $kDemoCode',
                        style: TextStyle(color: Colors.amber)),
                  ),
                AppTextField(label: 'Verification code', controller: _code, type: TextInputType.number),
              ],
              AppButton(label: _register ? (_driver ? 'Apply' : 'Done') : 'Log in', onPressed: _submit),
              if (!_register)
                const Padding(
                  padding: EdgeInsets.only(top: 12),
                  child: Text('Demo accounts: admin, pedro, maria',
                      style: TextStyle(color: Colors.amber)),
                ),
            ]),
          ),
        ),
      );
}