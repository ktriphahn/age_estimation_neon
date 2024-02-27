import 'package:age_estimation_neon/bloc/estimation_bloc.dart';
import 'package:age_estimation_neon/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../model/user.dart';

class HomeScreen extends StatefulWidget {
  final User? user;

  const HomeScreen({this.user, super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // textfield controller
  final TextEditingController _nameController = TextEditingController();

  void _submitEstimate(context) {
    print('--------------Sende Daten an API------------');
    print(_nameController.text.trim());
    BlocProvider.of<EstimationBloc>(context)
        .add(GetUserData(_nameController.text.trim()));
  }

  void _reset(context) {
    BlocProvider.of<EstimationBloc>(context).add(Reset());
  }

  @override
  Widget build(BuildContext context) {
    String? userAge;

    if (widget.user?.age != null && widget.user?.age != null) {
      _nameController.text = widget.user!.name;
      userAge = widget.user?.age.toString();
    } else {
      _nameController.text = '';
      userAge = '';
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Altersschätzung'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _nameController,
              maxLength: 50,
              style: TextStyle(color: kDarkColorScheme.onBackground),
              decoration: const InputDecoration(
                hintText: 'z.B. Kevin',
                label: Text('Name'),
              ),
              onTapOutside: (event) {
                // close keyboard on tapping anywhere outside the textformfield
                FocusManager.instance.primaryFocus?.unfocus();
              },
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    _reset(context);
                  },
                  child: const Text('Zurücksetzen'),
                ),
                ElevatedButton(
                  child: const Text('Alter schätzen'),
                  onPressed: () {
                    if (_nameController.text.trim().length > 2 &&
                        _nameController.text.trim().length <= 50) {
                      _submitEstimate(context);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                              'Bitte Nutzernamen mit mindestens 3 Buchstaben eingeben.'),
                          duration: Duration(seconds: 1),
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                const Text('Geschätztes Alter:'),
                const SizedBox(
                  width: 20,
                ),
                Text(
                  '$userAge',
                  style: TextStyle(
                      color: kDarkColorScheme.onBackground, fontSize: 18),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
