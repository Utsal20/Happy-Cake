// https://pub.dartlang.org/packages/mailer#-readme-tab-
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';
import 'secret.dart';
import 'dart:io';

class Emailer {
  static email(String clientName, String clientEmail, String text, String attachment) async {
    //Credentials accessed through secret.dart via Secret class

    final smtpServer = gmail(Secrets.email, Secrets.password); // Create smpt server
    
    // Create our message.
    final dateTime = new DateTime.now();
    final message = new Message()
      ..from = new Address(Secrets.email, clientName)
      ..recipients.add('happycaketest@gmail.com')
      ..ccRecipients.add(clientEmail)
      ..subject = 'Order Inquiry ${dateTime.month}-${dateTime.day}-${dateTime.year} $clientName'
      ..html = text
      ..attachments.add(FileAttachment(File(attachment)));
    
    final sendReports = await send(message, smtpServer); // Send the email

    sendReports.forEach((sr) {
      if (sr.sent)
        print('Email sent');
      else {
        print('Email not sent.');
        for (var p in sr.validationProblems) { // Go through errors and print them out to the debug console
          print('Problem: ${p.code}: ${p.msg}');
        }
      }
    });
  }
}
