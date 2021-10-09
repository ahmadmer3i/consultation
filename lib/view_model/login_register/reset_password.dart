import 'package:consultation/widgets/dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';

void resetPassword(context, {required String email}) async {
  var auth = FirebaseAuth.instance;
  try {
    await auth.sendPasswordResetEmail(email: email);
    MessageDialog.showSnackBar(
        "تم إرسال رابط إعاده التعيين على بريدك الألكتروني", context);
  } on FirebaseAuthException catch (e) {
    if (e.code == "invalid-email") {
      MessageDialog.showSnackBar("خطأ في البريد المستخدم", context);
    } else if (e.code == "user-not-found") {
      MessageDialog.showSnackBar("ليس لديك حساب ", context);
    }
  }
}
