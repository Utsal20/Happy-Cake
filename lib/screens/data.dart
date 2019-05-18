///Jacob Brook, Alex Gonzalez, Utsal Shrestha
///Happy Cake Company App
///Last edited May 17th, 2019

///this is where we declare all of the strings that will be stored and emailed

class DataStore{

  ///this section of strings are all included in the order_info.dart page
  ///it includes the date for the cake to be finished, how many people it feeds, the occasion (and other occasion if necessary)
  ///decoration notes, and the image name

  static String date = '';
  static String feeds = '';
  static String occasion = 'Select'; //Select is the initial value for the drop down menu
  static String otherOccasion = '';
  static String decorationNotes = '';
  static String attachment = '';

  ///this section of strings are all included in the user_info.dart page
  ///it includes the name of the client, the email, and the phone number. There is also a string to save the
  ///type of referral (other if necessary)

  static String name = '';
  static String email = '';
  static String phone = '';
  static String referral = 'Select'; //Select is the initial value for the drop down menu
  static String otherReferral = '';
}