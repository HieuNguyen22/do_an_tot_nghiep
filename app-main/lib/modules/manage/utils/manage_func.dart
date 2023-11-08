// import 'package:flutter_datetime_picker/flutter_datetime_picker.dart' as datetime_picker;
import 'package:intl/intl.dart';

class ManageFunc {
  // static Enum switchLang(String lang) {
  //   if (lang == "vi_VN") {
  //     return datetime_picker.LocaleType.vi;
  //   } else if (lang == "jp_JP") {
  //     return datetime_picker.LocaleType.jp;
  //   } else {
  //     return datetime_picker.LocaleType.en;
  //   }
  // }

  static formatTimeToString(date) {
    var inputDate = DateTime.parse(date.toString());
    var outputFormat = DateFormat('yyyy/MM/dd');
    var outputDate = outputFormat.format(inputDate);
    return outputDate;
  }

}
