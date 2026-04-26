import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('es'),
  ];

  /// Nombre de la aplicación
  ///
  /// In es, this message translates to:
  /// **'Control de Aulas'**
  String get appTitle;

  /// No description provided for @loginTitleTecnm.
  ///
  /// In es, this message translates to:
  /// **'TECNOLÓGICO NACIONAL DE MÉXICO'**
  String get loginTitleTecnm;

  /// No description provided for @loginSubtitleItt.
  ///
  /// In es, this message translates to:
  /// **'INSTITUTO TECNOLÓGICO DE TOLUCA'**
  String get loginSubtitleItt;

  /// No description provided for @loginUserLabel.
  ///
  /// In es, this message translates to:
  /// **'Usuario'**
  String get loginUserLabel;

  /// No description provided for @loginUserHint.
  ///
  /// In es, this message translates to:
  /// **'Usuario'**
  String get loginUserHint;

  /// No description provided for @loginPasswordLabel.
  ///
  /// In es, this message translates to:
  /// **'Contraseña'**
  String get loginPasswordLabel;

  /// No description provided for @loginPasswordHint.
  ///
  /// In es, this message translates to:
  /// **'Contraseña'**
  String get loginPasswordHint;

  /// No description provided for @loginButton.
  ///
  /// In es, this message translates to:
  /// **'Ingresar'**
  String get loginButton;

  /// No description provided for @loginFooterCopyright.
  ///
  /// In es, this message translates to:
  /// **'Instituto Tecnológico de Toluca - Algunos derechos reservados © 2016'**
  String get loginFooterCopyright;

  /// No description provided for @loginFooterWebsiteLabel.
  ///
  /// In es, this message translates to:
  /// **'Instituto Tecnológico de Toluca |'**
  String get loginFooterWebsiteLabel;

  /// No description provided for @loginFooterWebsite.
  ///
  /// In es, this message translates to:
  /// **'www.tolucatecnm.mx/'**
  String get loginFooterWebsite;

  /// No description provided for @loginFooterAddress.
  ///
  /// In es, this message translates to:
  /// **'Av. Tecnológico s/n. Colonia Agrícola Bellavista\nMetepec, Edo. de México, México C. P. 52149\nTel. (52) (722) 2 08 72 00'**
  String get loginFooterAddress;

  /// No description provided for @navHome.
  ///
  /// In es, this message translates to:
  /// **'Inicio'**
  String get navHome;

  /// No description provided for @navScan.
  ///
  /// In es, this message translates to:
  /// **'Escanear'**
  String get navScan;

  /// No description provided for @navSearch.
  ///
  /// In es, this message translates to:
  /// **'Buscar'**
  String get navSearch;

  /// No description provided for @navProfile.
  ///
  /// In es, this message translates to:
  /// **'Perfil'**
  String get navProfile;

  /// No description provided for @homeTitle.
  ///
  /// In es, this message translates to:
  /// **'Inicio'**
  String get homeTitle;

  /// No description provided for @homeWelcome.
  ///
  /// In es, this message translates to:
  /// **'Bienvenido(a)'**
  String get homeWelcome;

  /// No description provided for @homeNextClass.
  ///
  /// In es, this message translates to:
  /// **'Tu próxima clase'**
  String get homeNextClass;

  /// No description provided for @homeNoClasses.
  ///
  /// In es, this message translates to:
  /// **'No tienes clases programadas hoy.'**
  String get homeNoClasses;

  /// No description provided for @scanTitle.
  ///
  /// In es, this message translates to:
  /// **'Escanear código QR'**
  String get scanTitle;

  /// No description provided for @scanInstructions.
  ///
  /// In es, this message translates to:
  /// **'Coloca el código QR de la puerta del aula dentro del recuadro.'**
  String get scanInstructions;

  /// No description provided for @scanManualSearch.
  ///
  /// In es, this message translates to:
  /// **'Búsqueda manual'**
  String get scanManualSearch;

  /// No description provided for @scanError.
  ///
  /// In es, this message translates to:
  /// **'No se pudo leer el código. Usa la búsqueda manual.'**
  String get scanError;

  /// No description provided for @aulaInfoTitle.
  ///
  /// In es, this message translates to:
  /// **'Información del aula'**
  String get aulaInfoTitle;

  /// No description provided for @aulaInfoSubject.
  ///
  /// In es, this message translates to:
  /// **'Materia'**
  String get aulaInfoSubject;

  /// No description provided for @aulaInfoTeacher.
  ///
  /// In es, this message translates to:
  /// **'Docente'**
  String get aulaInfoTeacher;

  /// No description provided for @aulaInfoGroup.
  ///
  /// In es, this message translates to:
  /// **'Grupo'**
  String get aulaInfoGroup;

  /// No description provided for @aulaInfoSchedule.
  ///
  /// In es, this message translates to:
  /// **'Horario'**
  String get aulaInfoSchedule;

  /// No description provided for @aulaInfoStatus.
  ///
  /// In es, this message translates to:
  /// **'Estatus'**
  String get aulaInfoStatus;

  /// No description provided for @aulaInfoRequestOpening.
  ///
  /// In es, this message translates to:
  /// **'Solicitar apertura'**
  String get aulaInfoRequestOpening;

  /// No description provided for @offlineTitle.
  ///
  /// In es, this message translates to:
  /// **'Sin conexión'**
  String get offlineTitle;

  /// No description provided for @offlineMessage.
  ///
  /// In es, this message translates to:
  /// **'Verifica tu conexión a internet e inténtalo de nuevo.'**
  String get offlineMessage;

  /// No description provided for @offlineRetry.
  ///
  /// In es, this message translates to:
  /// **'Reintentar'**
  String get offlineRetry;

  /// No description provided for @searchTitle.
  ///
  /// In es, this message translates to:
  /// **'Búsqueda'**
  String get searchTitle;

  /// No description provided for @searchHint.
  ///
  /// In es, this message translates to:
  /// **'Buscar aula, docente o materia'**
  String get searchHint;

  /// No description provided for @searchTabsAulas.
  ///
  /// In es, this message translates to:
  /// **'Aulas'**
  String get searchTabsAulas;

  /// No description provided for @searchTabsDocentes.
  ///
  /// In es, this message translates to:
  /// **'Docentes'**
  String get searchTabsDocentes;

  /// No description provided for @searchTabsMaterias.
  ///
  /// In es, this message translates to:
  /// **'Materias'**
  String get searchTabsMaterias;

  /// No description provided for @searchEmpty.
  ///
  /// In es, this message translates to:
  /// **'Sin resultados'**
  String get searchEmpty;

  /// No description provided for @searchTeacherNoClass.
  ///
  /// In es, this message translates to:
  /// **'Sin información de clase disponible'**
  String get searchTeacherNoClass;

  /// No description provided for @consultaAulasTitle.
  ///
  /// In es, this message translates to:
  /// **'Consulta de aulas'**
  String get consultaAulasTitle;

  /// No description provided for @consultaAulasFilterBuilding.
  ///
  /// In es, this message translates to:
  /// **'Edificio'**
  String get consultaAulasFilterBuilding;

  /// No description provided for @consultaAulasOccupied.
  ///
  /// In es, this message translates to:
  /// **'Ocupada'**
  String get consultaAulasOccupied;

  /// No description provided for @consultaAulasAvailable.
  ///
  /// In es, this message translates to:
  /// **'Disponible'**
  String get consultaAulasAvailable;

  /// No description provided for @estatusTitle.
  ///
  /// In es, this message translates to:
  /// **'Estatus del docente'**
  String get estatusTitle;

  /// No description provided for @estatusOptionClase.
  ///
  /// In es, this message translates to:
  /// **'Clase'**
  String get estatusOptionClase;

  /// No description provided for @estatusOptionComision.
  ///
  /// In es, this message translates to:
  /// **'Comisión'**
  String get estatusOptionComision;

  /// No description provided for @estatusOptionJunta.
  ///
  /// In es, this message translates to:
  /// **'Junta'**
  String get estatusOptionJunta;

  /// No description provided for @estatusOptionIncapacidad.
  ///
  /// In es, this message translates to:
  /// **'Incapacidad'**
  String get estatusOptionIncapacidad;

  /// No description provided for @estatusOptionPermiso.
  ///
  /// In es, this message translates to:
  /// **'Permiso económico'**
  String get estatusOptionPermiso;

  /// No description provided for @estatusOptionOtro.
  ///
  /// In es, this message translates to:
  /// **'Otro'**
  String get estatusOptionOtro;

  /// No description provided for @estatusStartDate.
  ///
  /// In es, this message translates to:
  /// **'Fecha de inicio'**
  String get estatusStartDate;

  /// No description provided for @estatusEndDate.
  ///
  /// In es, this message translates to:
  /// **'Fecha de fin'**
  String get estatusEndDate;

  /// No description provided for @estatusSubmit.
  ///
  /// In es, this message translates to:
  /// **'Registrar estatus'**
  String get estatusSubmit;

  /// No description provided for @estatusRegistered.
  ///
  /// In es, this message translates to:
  /// **'Estatus registrado correctamente.'**
  String get estatusRegistered;

  /// No description provided for @solicitudTitle.
  ///
  /// In es, this message translates to:
  /// **'Solicitud de apertura'**
  String get solicitudTitle;

  /// No description provided for @solicitudConfirm.
  ///
  /// In es, this message translates to:
  /// **'Confirmar solicitud'**
  String get solicitudConfirm;

  /// No description provided for @solicitudSent.
  ///
  /// In es, this message translates to:
  /// **'Solicitud enviada correctamente.'**
  String get solicitudSent;

  /// No description provided for @solicitudClose.
  ///
  /// In es, this message translates to:
  /// **'Cerrar'**
  String get solicitudClose;

  /// No description provided for @profileTitle.
  ///
  /// In es, this message translates to:
  /// **'Mi perfil'**
  String get profileTitle;

  /// No description provided for @profileLogout.
  ///
  /// In es, this message translates to:
  /// **'Cerrar sesión'**
  String get profileLogout;

  /// No description provided for @profileMyStatus.
  ///
  /// In es, this message translates to:
  /// **'Mi estatus'**
  String get profileMyStatus;

  /// No description provided for @profileMyHistory.
  ///
  /// In es, this message translates to:
  /// **'Mi historial'**
  String get profileMyHistory;

  /// No description provided for @commonRetry.
  ///
  /// In es, this message translates to:
  /// **'Reintentar'**
  String get commonRetry;

  /// No description provided for @commonCancel.
  ///
  /// In es, this message translates to:
  /// **'Cancelar'**
  String get commonCancel;

  /// No description provided for @commonAccept.
  ///
  /// In es, this message translates to:
  /// **'Aceptar'**
  String get commonAccept;

  /// No description provided for @commonClose.
  ///
  /// In es, this message translates to:
  /// **'Cerrar'**
  String get commonClose;

  /// No description provided for @commonLoading.
  ///
  /// In es, this message translates to:
  /// **'Cargando...'**
  String get commonLoading;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'es'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
