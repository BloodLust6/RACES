import 'package:get/get.dart';
import 'package:races/features/appointment/screens/appointment/appointment.dart';
import 'package:races/features/appointment/screens/appointment_doctor/appointment_doctor.dart';
import 'package:races/features/appointment/screens/appointment_nurse/appointment_nurse.dart';
import 'package:races/features/appointment/screens/create_appointment/create_appointment.dart';
import 'package:races/features/authentication/screens/login/login.dart';
import 'package:races/features/authentication/screens/password_configuration/forget_password.dart';
import 'package:races/features/authentication/screens/signup/signup.dart';
import 'package:races/features/clinic/screens/home/home.dart';
import 'package:races/features/dependent/screens/create_dependent/create_dependent.dart';
import 'package:races/features/dependent/screens/dependent/dependent.dart';
import 'package:races/features/information/screens/create_information/create_information.dart';
import 'package:races/features/information/screens/information/information.dart';
import 'package:races/features/information/screens/information_nurse/information_nurse.dart';
import 'package:races/features/medication/screens/create_medication/create_medication.dart';
import 'package:races/features/medication/screens/medication/medication.dart';
import 'package:races/features/medication/screens/create_medication_doctor/create_medication_doctor.dart';
import 'package:races/features/medication/screens/medication_nurse/medication_nurse.dart';
import 'package:races/features/personalization/screens/profile/widgets/re_authenticate_user_login_form.dart';
import 'package:races/features/personalization/screens/update_details/change_dob.dart';
import 'package:races/features/personalization/screens/update_details/change_gender.dart';
import 'package:races/features/personalization/screens/update_details/change_name.dart';
import 'package:races/features/personalization/screens/update_details/change_phonenumber.dart';
import 'package:races/features/personalization/screens/update_details/change_username.dart';
import 'package:races/features/personalization/screens/update_details_doctor/change_dob_doctor.dart';
import 'package:races/features/personalization/screens/update_details_doctor/change_gender_doctor.dart';
import 'package:races/features/personalization/screens/update_details_doctor/change_name_doctor.dart';
import 'package:races/features/personalization/screens/update_details_doctor/change_phonenumber_doctor.dart';
import 'package:races/features/personalization/screens/update_details_doctor/change_username_doctor.dart';
import 'package:races/features/personalization/screens/update_details_nurse/change_dob_nurse.dart';
import 'package:races/features/personalization/screens/update_details_nurse/change_gender_nurse.dart';
import 'package:races/features/personalization/screens/update_details_nurse/change_name_nurse.dart';
import 'package:races/features/personalization/screens/update_details_nurse/change_phonenumber_nurse.dart';
import 'package:races/features/personalization/screens/update_details_nurse/change_username_nurse.dart';
import 'package:races/navigation_menu/navigation_menu.dart';
import 'package:races/navigation_menu/navigation_menu_doctor.dart';
import 'package:races/navigation_menu/navigation_menu_nurse.dart';
import 'package:races/routes/routes.dart';

class AppRoutes {
  static final pages = [
    GetPage(name: SRoutes.home, page: () => const HomeScreen()),
    GetPage(name: SRoutes.information, page: () => const InformationScreen()),
    GetPage(
        name: SRoutes.infonurse, page: () => const InformationNurseScreen()),
    GetPage(name: SRoutes.chgname, page: () => const ChangeName()),
    GetPage(name: SRoutes.chgusername, page: () => const ChangeUsername()),
    GetPage(name: SRoutes.chgphoneno, page: () => const ChangePhoneNumber()),
    GetPage(name: SRoutes.chggender, page: () => const ChangeGender()),
    GetPage(name: SRoutes.chgdob, page: () => const ChangeDateOfBirth()),
    GetPage(name: SRoutes.chgnameN, page: () => const ChangeNameNurse()),
    GetPage(
        name: SRoutes.chgusernameN, page: () => const ChangeUsernameNurse()),
    GetPage(
        name: SRoutes.chgphonenoN, page: () => const ChangePhoneNumberNurse()),
    GetPage(name: SRoutes.chggenderN, page: () => const ChangeGenderNurse()),
    GetPage(name: SRoutes.chgdobN, page: () => const ChangeDateOfBirthNurse()),
    GetPage(name: SRoutes.chgnameD, page: () => const ChangeNameDoctor()),
    GetPage(
        name: SRoutes.chgusernameD, page: () => const ChangeUsernameDoctor()),
    GetPage(
        name: SRoutes.chgphonenoD, page: () => const ChangePhoneNumberDoctor()),
    GetPage(name: SRoutes.chggenderD, page: () => const ChangeGenderDoctor()),
    GetPage(name: SRoutes.chgdobD, page: () => const ChangeDateOfBirthDoctor()),
    GetPage(name: SRoutes.crtinfo, page: () => const CreateInformationScreen()),
    GetPage(name: SRoutes.navmenu, page: () => const NavigationMenu()),
    GetPage(name: SRoutes.navdoctor, page: () => const NavigationMenuDoctor()),
    GetPage(name: SRoutes.navnurse, page: () => const NavigationMenuNurse()),
    GetPage(name: SRoutes.navmenu, page: () => const NavigationMenu()),
    GetPage(name: SRoutes.signup, page: () => const SignupScreen()),
    GetPage(name: SRoutes.frgetpass, page: () => const ForgetPassword()),
    GetPage(name: SRoutes.reauthlogin, page: () => const ReAuthLoginForm()),
    GetPage(name: SRoutes.login, page: () => const LoginScreen()),
    GetPage(name: SRoutes.dependent, page: () => const DependentScreen()),
    GetPage(name: SRoutes.crtdpndnt, page: () => const CreateDependentScreen()),
    GetPage(name: SRoutes.medication, page: () => const MedicationScreen()),
    GetPage(name: SRoutes.crtmedic, page: () => const CreateMedicationScreen()),
    GetPage(
        name: SRoutes.medicnurse, page: () => const MedicationScreenNurse()),
    GetPage(
        name: SRoutes.medicdoctor, page: () => const MedicationScreenDoctor()),
    GetPage(name: SRoutes.appointment, page: () => const AppointmentScreen()),
    GetPage(
        name: SRoutes.crtappntmnt, page: () => const CreateAppointmentScreen()),
    GetPage(
        name: SRoutes.appntmntnurse,
        page: () => const AppointmentScreenNurse()),
    GetPage(
        name: SRoutes.appntmntdoctor,
        page: () => const AppointmentScreenDoctor()),
  ];
}
