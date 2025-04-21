import 'package:flutter/material.dart';
import '../models/booking_model.dart';
import '../scoped_models/app_model.dart';
import 'package:scoped_model/scoped_model.dart';

class BookingForm extends StatefulWidget {
  const BookingForm({super.key});

  @override
  _BookingFormState createState() => _BookingFormState();
}

class _BookingFormState extends State<BookingForm> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  int _people = 1;
  DateTime _dateTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<AppModel>(
      builder: (context, child, model) => Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(labelText: 'Your Name'),
              onSaved: (value) => _name = value!,
              validator: (value) => value!.isEmpty ? 'Enter a name' : null,
            ),
            DropdownButtonFormField<int>(
              value: _people,
              decoration: InputDecoration(labelText: 'Number of People'),
              items: List.generate(10, (i) => i + 1)
                  .map((e) => DropdownMenuItem(value: e, child: Text('$e')))
                  .toList(),
              onChanged: (val) => setState(() => _people = val!),
            ),
            ElevatedButton(
              onPressed: () async {
                DateTime? picked = await showDatePicker(
                  context: context,
                  initialDate: _dateTime,
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2101),
                );
                if (picked != null) {
                  setState(() {
                    _dateTime = picked;
                  });
                }
              },
              child: Text('Pick Date'),
            ),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  model.addBooking(Booking(name: _name, people: _people, dateTime: _dateTime));
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Booking Confirmed!')));
                }
              },
              child: Text('Book Table'),
            ),
          ],
        ),
      ),
    );
  }
}
