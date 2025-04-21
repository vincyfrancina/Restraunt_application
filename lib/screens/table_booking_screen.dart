import 'package:flutter/material.dart';
import '../widgets/booking_form.dart';

/*class TableBookingScreen extends StatelessWidget {
  const TableBookingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Table Booking')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: BookingForm(),
      ),
    );
  }
}*/
//import 'package:flutter/material.dart';

class TableBookingScreen extends StatefulWidget {
  @override
  _TableBookingScreenState createState() => _TableBookingScreenState();
}

class _TableBookingScreenState extends State<TableBookingScreen> {
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  int guests = 2;
  final TextEditingController _specialRequestController = TextEditingController();

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
    );
    if (picked != null) {
      setState(() => selectedDate = picked);
    }
  }

  Future<void> _selectTime() async {
    final TimeOfDay? picked =
        await showTimePicker(context: context, initialTime: selectedTime);
    if (picked != null) {
      setState(() => selectedTime = picked);
    }
  }

  void _confirmBooking() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text("Booking Confirmed"),
        content: Text(
            "Your table is booked for ${selectedDate.toLocal().toString().split(' ')[0]} at ${selectedTime.format(context)} for $guests guests."),
        actions: [
          TextButton(
              onPressed: () => Navigator.of(ctx).pop(), child: Text("OK")),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Book a Table"),
        backgroundColor: Colors.orangeAccent,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: ListTile(
                leading: Icon(Icons.calendar_today),
                title: Text("Select Date"),
                subtitle: Text("${selectedDate.toLocal()}".split(' ')[0]),
                onTap: _selectDate,
              ),
            ),
            SizedBox(height: 12),
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: ListTile(
                leading: Icon(Icons.access_time),
                title: Text("Select Time"),
                subtitle: Text(selectedTime.format(context)),
                onTap: _selectTime,
              ),
            ),
            SizedBox(height: 12),
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: DropdownButtonFormField<int>(
                  decoration: InputDecoration(
                    labelText: "Number of Guests",
                    border: InputBorder.none,
                  ),
                  value: guests,
                  items: List.generate(10, (index) => index + 1)
                      .map((e) => DropdownMenuItem<int>(
                            value: e,
                            child: Text('$e'),
                          ))
                      .toList(),
                  onChanged: (value) => setState(() => guests = value!),
                ),
              ),
            ),
            SizedBox(height: 12),
            TextField(
              controller: _specialRequestController,
              maxLines: 3,
              decoration: InputDecoration(
                labelText: "Special Requests",
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 16),
                backgroundColor: Colors.orangeAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              icon: Icon(Icons.check_circle_outline),
              label: Text("Confirm Booking", style: TextStyle(fontSize: 16)),
              onPressed: _confirmBooking,
            ),
          ],
        ),
      ),
    );
  }
}
