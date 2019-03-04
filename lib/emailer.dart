// https://pub.dartlang.org/packages/mailer#-readme-tab-
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';

class Emailer {
  static email() async {
    String username = 'happycaketest@gmail.com';
    String password = 'P!rates88';

    final smtpServer = gmail(username, password);
    
    // Create our message.
    final dateTime = new DateTime.now();
    final message = new Message()
      ..from = new Address(username, 'Put name of the client')
      ..recipients.add('happycaketest@gmail.com')
      ..subject = 'Order ${dateTime.month}-${dateTime.day}-${dateTime.year}'
      ..text = 'This is the plain text.\nThis is line 2 of the text part.';
    
    final sendReports = await send(message, smtpServer);

    sendReports.forEach((sr) {
      if (sr.sent)
        print('Email sent');
      else {
        print('Email not sent.');
        for (var p in sr.validationProblems) {
          print('Problem: ${p.code}: ${p.msg}');
        }
      }
    });
  }
}
