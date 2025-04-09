import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class StripeService {
  static Future<void> init() async {
    await dotenv.load();
    Stripe.publishableKey = dotenv.env['STRIPE_PUBLISHABLE_KEY'] ?? '';
  }

  static Future<Map<String, dynamic>> createPaymentIntent({
    required double amount,
    required String currency,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        headers: {
          'Authorization': 'Bearer ${dotenv.env['STRIPE_SECRET_KEY']}',
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: {
          'amount': (amount).toInt().toString(), // Convert to cents
          'currency': currency,
        },
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to create payment intent');
      }
    } catch (e) {
      throw Exception('Error creating payment intent: $e');
    }
  }

  static Future<void> makePayment({
    required double amount,
    required String currency,
    required String customerEmail,
  }) async {
    try {
      final paymentIntent = await createPaymentIntent(
        amount: amount,
        currency: currency,
      );

      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: paymentIntent['client_secret'],
          merchantDisplayName: 'ITC Food',
          customerId: customerEmail,
        ),
      );

      await Stripe.instance.presentPaymentSheet();
    } catch (e) {
      throw Exception('Payment failed: $e');
    }
  }
} 