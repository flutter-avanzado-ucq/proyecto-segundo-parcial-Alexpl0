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

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
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
    Locale('es')
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Task Manager'**
  String get appTitle;

  /// No description provided for @addTask.
  ///
  /// In en, this message translates to:
  /// **'Add task'**
  String get addTask;

  /// No description provided for @editTask.
  ///
  /// In en, this message translates to:
  /// **'Edit task'**
  String get editTask;

  /// No description provided for @deleteTask.
  ///
  /// In en, this message translates to:
  /// **'Delete task'**
  String get deleteTask;

  /// No description provided for @changeTheme.
  ///
  /// In en, this message translates to:
  /// **'Change theme'**
  String get changeTheme;

  /// No description provided for @addNewTask.
  ///
  /// In en, this message translates to:
  /// **'Add new task'**
  String get addNewTask;

  /// No description provided for @description.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get description;

  /// No description provided for @selectDate.
  ///
  /// In en, this message translates to:
  /// **'Select date'**
  String get selectDate;

  /// No description provided for @selectTime.
  ///
  /// In en, this message translates to:
  /// **'Select time'**
  String get selectTime;

  /// No description provided for @timeLabel.
  ///
  /// In en, this message translates to:
  /// **'Time:'**
  String get timeLabel;

  /// No description provided for @hourLabel.
  ///
  /// In en, this message translates to:
  /// **'Time:'**
  String get hourLabel;

  /// No description provided for @titleLabel.
  ///
  /// In en, this message translates to:
  /// **'Title'**
  String get titleLabel;

  /// No description provided for @saveChanges.
  ///
  /// In en, this message translates to:
  /// **'Save changes'**
  String get saveChanges;

  /// No description provided for @name.
  ///
  /// In en, this message translates to:
  /// **'name'**
  String get name;

  /// No description provided for @changeDate.
  ///
  /// In en, this message translates to:
  /// **'Change date'**
  String get changeDate;

  /// No description provided for @changeTime.
  ///
  /// In en, this message translates to:
  /// **'Change time'**
  String get changeTime;

  /// No description provided for @editTaskTitle.
  ///
  /// In en, this message translates to:
  /// **'Edit Task'**
  String get editTaskTitle;

  /// No description provided for @selectDateButton.
  ///
  /// In en, this message translates to:
  /// **'Select a date'**
  String get selectDateButton;

  /// No description provided for @appBarTitle.
  ///
  /// In en, this message translates to:
  /// **'My Tasks'**
  String get appBarTitle;

  /// No description provided for @notificationTaskUpdatedTitle.
  ///
  /// In en, this message translates to:
  /// **'Task Updated'**
  String get notificationTaskUpdatedTitle;

  /// No description provided for @notificationTaskUpdatedBody.
  ///
  /// In en, this message translates to:
  /// **'You have updated the task: {taskName}'**
  String notificationTaskUpdatedBody(Object taskName);

  /// No description provided for @notificationReminderTaskUpdatedTitle.
  ///
  /// In en, this message translates to:
  /// **'Updated Task Reminder'**
  String get notificationReminderTaskUpdatedTitle;

  /// No description provided for @notificationReminderTaskUpdatedBody.
  ///
  /// In en, this message translates to:
  /// **'Don\'t forget: {taskName}'**
  String notificationReminderTaskUpdatedBody(Object taskName);

  /// No description provided for @notificationNewTaskTitle.
  ///
  /// In en, this message translates to:
  /// **'New Task'**
  String get notificationNewTaskTitle;

  /// No description provided for @notificationNewTaskBody.
  ///
  /// In en, this message translates to:
  /// **'You have added the task: {taskName}'**
  String notificationNewTaskBody(Object taskName);

  /// No description provided for @notificationReminderTaskTitle.
  ///
  /// In en, this message translates to:
  /// **'Task Reminder'**
  String get notificationReminderTaskTitle;

  /// No description provided for @notificationReminderTaskBody.
  ///
  /// In en, this message translates to:
  /// **'Don\'t forget: {taskName}'**
  String notificationReminderTaskBody(Object taskName);

  /// Text for the language change option
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// Shows the due date of the task, using a formatted date as a placeholder.
  ///
  /// In en, this message translates to:
  /// **'Due on {date}'**
  String dueDate(String date);

  /// A message showing how many tasks are pending, with pluralization support.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{You have no pending tasks} =1{You have 1 pending task} other{You have {count} pending tasks}}'**
  String pendingTasks(int count);

  /// No description provided for @todayIsHoliday.
  ///
  /// In en, this message translates to:
  /// **'Today is a holiday'**
  String get todayIsHoliday;

  /// No description provided for @holidayTag.
  ///
  /// In en, this message translates to:
  /// **'Holiday'**
  String get holidayTag;

  /// A greeting message that includes the user's name.
  ///
  /// In en, this message translates to:
  /// **'Hi, {userName} 👋'**
  String greeting(String userName);

  /// No description provided for @todayTasksHeader.
  ///
  /// In en, this message translates to:
  /// **'These are your tasks for today'**
  String get todayTasksHeader;

  /// No description provided for @weatherError.
  ///
  /// In en, this message translates to:
  /// **'Could not load weather data'**
  String get weatherError;

  /// No description provided for @weatherLoading.
  ///
  /// In en, this message translates to:
  /// **'Loading weather...'**
  String get weatherLoading;

  /// No description provided for @holidayError.
  ///
  /// In en, this message translates to:
  /// **'Could not load holiday data'**
  String get holidayError;

  /// No description provided for @settingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTitle;

  /// No description provided for @spanish.
  ///
  /// In en, this message translates to:
  /// **'Spanish'**
  String get spanish;

  /// No description provided for @english.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// No description provided for @systemLanguage.
  ///
  /// In en, this message translates to:
  /// **'Use system language'**
  String get systemLanguage;
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
      'that was used.');
}
