import 'package:developer_company/shared/resources/colors.dart';
import 'package:flutter/material.dart';

final Map<String, IconData> iconsInDatabase = {
  "rotate_left": Icons.rotate_left,
  "ac_unit": Icons.ac_unit,
  "access_alarm": Icons.access_alarm,
  "access_alarms": Icons.access_alarms,
  "access_time": Icons.access_time,
  "accessibility": Icons.accessibility,
  "accessibility_new": Icons.accessibility_new,
  "accessible": Icons.accessible,
  "accessible_forward": Icons.accessible_forward,
  "account_balance": Icons.account_balance,
  "account_balance_wallet": Icons.account_balance_wallet,
  "account_box": Icons.account_box,
  "account_circle": Icons.account_circle,
  "adb": Icons.adb,
  "add": Icons.add,
  "add_a_photo": Icons.add_a_photo,
  "add_alarm": Icons.add_alarm,
  "add_alert": Icons.add_alert,
  "add_box": Icons.add_box,
  "add_circle": Icons.add_circle,
  "add_circle_outline": Icons.add_circle_outline,
  "add_comment": Icons.add_comment,
  "add_location": Icons.add_location,
  "add_photo_alternate": Icons.add_photo_alternate,
  "add_shopping_cart": Icons.add_shopping_cart,
  "add_to_home_screen": Icons.add_to_home_screen,
  "add_to_photos": Icons.add_to_photos,
  "add_to_queue": Icons.add_to_queue,
  "adjust": Icons.adjust,
  "airline_seat_flat": Icons.airline_seat_flat,
  "airline_seat_flat_angled": Icons.airline_seat_flat_angled,
  "airline_seat_individual_suite": Icons.airline_seat_individual_suite,
  "airline_seat_legroom_extra": Icons.airline_seat_legroom_extra,
  "airline_seat_legroom_normal": Icons.airline_seat_legroom_normal,
  "airline_seat_legroom_reduced": Icons.airline_seat_legroom_reduced,
  "airline_seat_recline_extra": Icons.airline_seat_recline_extra,
  "airline_seat_recline_normal": Icons.airline_seat_recline_normal,
  "airplanemode_active": Icons.airplanemode_active,
  "airplanemode_inactive": Icons.airplanemode_inactive,
  "airplay": Icons.airplay,
  "airport_shuttle": Icons.airport_shuttle,
  "alarm": Icons.alarm,
  "alarm_add": Icons.alarm_add,
  "alarm_off": Icons.alarm_off,
  "alarm_on": Icons.alarm_on,
  "album": Icons.album,
  "all_inbox": Icons.all_inbox,
  "all_inclusive": Icons.all_inclusive,
  "all_out": Icons.all_out,
  "alternate_email": Icons.alternate_email,
  "android": Icons.android,
  "announcement": Icons.announcement,
  "apartment": Icons.apartment,
  "apps": Icons.apps,
  "archive": Icons.archive,
  "arrow_back": Icons.arrow_back,
  "arrow_back_ios": Icons.arrow_back_ios,
  "arrow_downward": Icons.arrow_downward,
  "arrow_drop_down": Icons.arrow_drop_down,
  "arrow_drop_down_circle": Icons.arrow_drop_down_circle,
  "arrow_drop_up": Icons.arrow_drop_up,
  "arrow_forward": Icons.arrow_forward,
  "arrow_forward_ios": Icons.arrow_forward_ios,
  "arrow_left": Icons.arrow_left,
  "arrow_right": Icons.arrow_right,
  "arrow_right_alt": Icons.arrow_right_alt,
  "arrow_upward": Icons.arrow_upward,
  "art_track": Icons.art_track,
  "aspect_ratio": Icons.aspect_ratio,
  "assessment": Icons.assessment,
  "assignment": Icons.assignment,
  "assignment_ind": Icons.assignment_ind,
  "assignment_late": Icons.assignment_late,
  "assignment_return": Icons.assignment_return,
  "assignment_returned": Icons.assignment_returned,
  "assignment_turned_in": Icons.assignment_turned_in,
  "assistant": Icons.assistant,
  "assistant_photo": Icons.assistant_photo,
  "attach_file": Icons.attach_file,
  "attach_money": Icons.attach_money,
  "attachment": Icons.attachment,
  "audiotrack": Icons.audiotrack,
  "autorenew": Icons.autorenew,
  "av_timer": Icons.av_timer,
  "backspace": Icons.backspace,
  "backup": Icons.backup,
  "ballot": Icons.ballot,
  "bar_chart": Icons.bar_chart,
  "battery_alert": Icons.battery_alert,
  "battery_charging_full": Icons.battery_charging_full,
  "battery_full": Icons.battery_full,
  "battery_std": Icons.battery_std,
  "battery_unknown": Icons.battery_unknown,
  "beach_access": Icons.beach_access,
  "beenhere": Icons.beenhere,
  "block": Icons.block,
  "bluetooth": Icons.bluetooth,
  "bluetooth_audio": Icons.bluetooth_audio,
  "bluetooth_connected": Icons.bluetooth_connected,
  "bluetooth_disabled": Icons.bluetooth_disabled,
  "bluetooth_searching": Icons.bluetooth_searching,
  "blur_circular": Icons.blur_circular,
  "blur_linear": Icons.blur_linear,
  "blur_off": Icons.blur_off,
  "blur_on": Icons.blur_on,
  "book": Icons.book,
  "bookmark": Icons.bookmark,
  "bookmark_border": Icons.bookmark_border,
  "bookmarks": Icons.bookmarks,
  "border_all": Icons.border_all,
  "border_bottom": Icons.border_bottom,
  "border_clear": Icons.border_clear,
  "border_color": Icons.border_color,
  "border_horizontal": Icons.border_horizontal,
  "border_inner": Icons.border_inner,
  "border_left": Icons.border_left,
  "border_outer": Icons.border_outer,
  "border_right": Icons.border_right,
  "border_style": Icons.border_style,
  "border_top": Icons.border_top,
  "border_vertical": Icons.border_vertical,
  "branding_watermark": Icons.branding_watermark,
  "brightness_1": Icons.brightness_1,
  "brightness_2": Icons.brightness_2,
  "brightness_3": Icons.brightness_3,
  "brightness_4": Icons.brightness_4,
  "brightness_5": Icons.brightness_5,
  "brightness_6": Icons.brightness_6,
  "brightness_7": Icons.brightness_7,
  "brightness_auto": Icons.brightness_auto,
  "brightness_high": Icons.brightness_high,
  "brightness_low": Icons.brightness_low,
  "brightness_medium": Icons.brightness_medium,
  "broken_image": Icons.broken_image,
  "brush": Icons.brush,
  "bubble_chart": Icons.bubble_chart,
  "bug_report": Icons.bug_report,
  "build": Icons.build,
  "burst_mode": Icons.burst_mode,
  "business": Icons.business,
  "business_center": Icons.business_center,
  "cached": Icons.cached,
  "cake": Icons.cake,
  "calendar_today": Icons.calendar_today,
  "calendar_view_day": Icons.calendar_view_day,
  "call": Icons.call,
  "call_end": Icons.call_end,
  "call_made": Icons.call_made,
  "call_merge": Icons.call_merge,
  "call_missed": Icons.call_missed,
  "call_missed_outgoing": Icons.call_missed_outgoing,
  "call_received": Icons.call_received,
  "call_split": Icons.call_split,
  "call_to_action": Icons.call_to_action,
  "camera": Icons.camera,
  "camera_alt": Icons.camera_alt,
  "camera_enhance": Icons.camera_enhance,
  "camera_front": Icons.camera_front,
  "camera_rear": Icons.camera_rear,
  "camera_roll": Icons.camera_roll,
  "cancel": Icons.cancel,
  "cancel_presentation": Icons.cancel_presentation,
  "card_giftcard": Icons.card_giftcard,
  "card_membership": Icons.card_membership,
  "card_travel": Icons.card_travel,
  "casino": Icons.casino,
  "cast": Icons.cast,
  "cast_connected": Icons.cast_connected,
  "cast_for_education": Icons.cast_for_education,
  "category": Icons.category,
  "center_focus_strong": Icons.center_focus_strong,
  "center_focus_weak": Icons.center_focus_weak,
  "change_history": Icons.change_history,
  "chat": Icons.chat,
  "chat_bubble": Icons.chat_bubble,
  "chat_bubble_outline": Icons.chat_bubble_outline,
  "check": Icons.check,
  "check_box": Icons.check_box,
  "check_box_outline_blank": Icons.check_box_outline_blank,
  "check_circle": Icons.check_circle,
  "check_circle_outline": Icons.check_circle_outline,
  "chevron_left": Icons.chevron_left,
  "chevron_right": Icons.chevron_right,
  "child_care": Icons.child_care,
  "child_friendly": Icons.child_friendly,
  "chrome_reader_mode": Icons.chrome_reader_mode,
  "clear": Icons.clear,
  "clear_all": Icons.clear_all,
  "close": Icons.close,
  "closed_caption": Icons.closed_caption,
  "cloud": Icons.cloud,
  "cloud_circle": Icons.cloud_circle,
  "cloud_done": Icons.cloud_done,
  "cloud_download": Icons.cloud_download,
  "cloud_off": Icons.cloud_off,
  "cloud_queue": Icons.cloud_queue,
  "cloud_upload": Icons.cloud_upload,
  "code": Icons.code,
  "collections": Icons.collections,
  "phone_android": Icons.phone_android,
  "description": Icons.description,
  "person": Icons.person,
  "confirmation_number": Icons.confirmation_number,
  "location_on": Icons.location_on,
  "phone": Icons.phone,
  "person_pin": Icons.person_pin,
  "supervised_user_circle": Icons.supervised_user_circle,
  "person_outline": Icons.person_outline,
  "contact_page": Icons.contact_page,
  "work": Icons.work,
};

IconData selectedIcon(String? icon) {
  final IconData defaultIcon = Icons.app_blocking;
  if (icon == null) return defaultIcon;

  return iconsInDatabase[icon] ?? defaultIcon;
}

Icon selectedIconForImage(String? icon) {
  final Icon defaultIcon = Icon(Icons.upload);
  if (icon == null) return defaultIcon;

  return Icon(iconsInDatabase[icon], color: AppColors.officialWhite);
}
