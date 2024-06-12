import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:vixo/theme/constants.dart';

class CalendarController extends GetxController {
  var calendarFormat = CalendarFormat.month.obs;
  var focusedDay = DateTime.now().obs;
  var selectedDay = DateTime.now().obs;

  void onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    this.selectedDay.value = selectedDay;
    this.focusedDay.value = focusedDay;
  }

  void onFormatChanged(CalendarFormat format) {
    if (calendarFormat.value != format) {
      calendarFormat.value = format;
    }
  }

  void onPageChanged(DateTime focusedDay) {
    this.focusedDay.value = focusedDay;
  }

  void addEventToFirebase(
      String title, String location, String type, DateTime alertTime) {
    String userId = auth.currentUser!.uid;
    firestore.collection('events').doc(userId).set({
      'title': title,
      'location': location,
      'type': type,
      'alertTime': alertTime.toIso8601String(),
    });
  }
}
