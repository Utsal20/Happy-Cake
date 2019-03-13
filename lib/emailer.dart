// https://pub.dartlang.org/packages/mailer#-readme-tab-
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';

class Emailer {
  static email(String clientName, String clientEmail, String text) async {
    String username = 'happycaketest@gmail.com';
    String password = 'P!rates88';

    final smtpServer = gmail(username, password);
    
    // Create our message.
    final dateTime = new DateTime.now();
    final message = new Message()
      ..from = new Address(username, clientName)
      ..recipients.add('happycaketest@gmail.com')
      ..ccRecipients.add(clientEmail)
      ..subject = 'Order ${dateTime.month}-${dateTime.day}-${dateTime.year}'
      ..html = text;
    
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
