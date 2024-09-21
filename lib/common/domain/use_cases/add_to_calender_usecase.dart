import 'package:add_2_calendar/add_2_calendar.dart';
import 'package:starter/common/utils/permissions.dart';

class AddEventToCalenderUseCase{

  AddEventToCalenderUseCase();

  Future<void> call({
    required String title,
    required String description,
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    try{
      if(await AppPermissions.instance.requestCalendarPermission()){
        await Add2Calendar.addEvent2Cal(Event(
            title: title,
            description: description,
            startDate: startDate,
            endDate: startDate));
      }
    }catch(e){
    }

  }

}




