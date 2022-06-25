import 'package:consultme/components/components.dart';
import 'package:consultme/moduls/login/login_screen.dart';
import 'package:consultme/presentation_layer/user/user_layout/home_user_layout.dart';
import 'package:consultme/shard/network/local/cache_helper.dart';
import 'package:firebase_auth/firebase_auth.dart';

const userLayoutScreen = '/';
const viewAllImportantArtcle = 'ViewAll';
const chatDetails = 'ChatDetails';

const profileImageUri =
    'https://www.phoenixmag.com/wp-content/uploads/2022/03/PHM0422TD07-scaled.jpg';

const serverToken = "AAAA75XQmLE:APA91bFZCWhIxRk1IZUFkx9Ni7UyubXF6bXJHwJlpNvUqyEHa7A2WPUzsxR6qW_xYSlbeSWrXzHmiE1O1cKzTNWQDJt_FPNBRa12huRVBJqBGqKnORZ3duRQkbG82pjtDLclMmMAHv-g";

Future<void> signOut(context) async {
  await FirebaseAuth.instance.signOut();
  CacheHelper.removeData(key: 'uId');
  CacheHelper.removeData(
    key: 'type',
  ).then((value)
  {
    if (value)
    {
      navigateAndFinish(
        context,
        LoginScreen(),
      );
    }
  });
}