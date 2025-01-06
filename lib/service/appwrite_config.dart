import 'package:appwrite/appwrite.dart';

class AppwriteConfig {
  static final Client client = Client()
    ..setEndpoint('https://cloud.appwrite.io/v1') // Endpoint Appwrite
    ..setProject('677b8aa6000d4b609c1b'); // Project ID Appwrite

  // Tambahkan layanan Appwrite
  static final Account account = Account(client);
  static final Databases database = Databases(client);
}
