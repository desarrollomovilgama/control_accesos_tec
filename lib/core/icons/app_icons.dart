/// =============================================================================
/// app_icons.dart
/// -----------------------------------------------------------------------------
/// Catálogo único de íconos. Apartado 4.2 (Iconografía) y Tabla 10 del MPF.
/// Todos los íconos se consumen como AppIcons.<nombre>.
/// =============================================================================
library;

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AppIcons {
  AppIcons._();

  // Navegación principal
  static const IconData home = Icons.home_rounded;
  static const IconData search = Icons.search_rounded;
  static const IconData profile = Icons.person_rounded;
  static const IconData qrScan = Icons.qr_code_scanner_rounded;

  // Autenticación
  static const IconData user = Icons.person_outline_rounded;
  static const IconData password = Icons.lock_outline_rounded;
  static const IconData visibility = Icons.visibility_outlined;
  static const IconData visibilityOff = Icons.visibility_off_outlined;
  static const IconData logout = Icons.logout_rounded;

  // Acciones
  static const IconData back = Icons.arrow_back_rounded;
  static const IconData close = Icons.close_rounded;
  static const IconData refresh = Icons.refresh_rounded;
  static const IconData filter = Icons.filter_list_rounded;
  static const IconData add = Icons.add_rounded;
  static const IconData edit = Icons.edit_outlined;
  static const IconData delete = Icons.delete_outline_rounded;
  static const IconData save = Icons.save_outlined;
  static const IconData info = Icons.info_outline_rounded;

  // Estados / feedback
  static const IconData success = Icons.check_circle_outline_rounded;
  static const IconData warning = Icons.warning_amber_rounded;
  static const IconData error = Icons.error_outline_rounded;
  static const IconData empty = Icons.inbox_outlined;
  static const IconData offline = Icons.wifi_off_rounded;

  // Dominio
  static const IconData classroom = Icons.meeting_room_outlined;
  static const IconData laboratory = Icons.science_outlined;
  static const IconData teacher = Icons.school_outlined;
  static const IconData subject = Icons.menu_book_outlined;
  static const IconData schedule = Icons.schedule_rounded;
  static const IconData calendar = Icons.calendar_today_outlined;
  static const IconData building = Icons.location_city_outlined;

  // Font Awesome para casos específicos
  static const IconData chalkboardTeacher = FontAwesomeIcons.chalkboardUser;
  static const IconData doorOpen = FontAwesomeIcons.doorOpen;
  static const IconData doorClosed = FontAwesomeIcons.doorClosed;
  static const IconData clipboardList = FontAwesomeIcons.clipboardList;
}
