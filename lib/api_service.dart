import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'http://192.168.18.112:3000';

  static Future<List<dynamic>> getBabies(String ibu) async {
    final response = await http.get(
      Uri.parse('$baseUrl/bayi/$ibu'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      print('Failed to fetch babies with status code: ${response.statusCode}');
      print('Response body: ${response.body}');
      throw Exception('Failed to fetch babies');
    }
  }

  // Fetch all baby records
  static Future<List<dynamic>> getAllBabies() async {
    final response = await http.get(
      Uri.parse('$baseUrl/bayi'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      print('Failed to fetch babies with status code: ${response.statusCode}');
      print('Response body: ${response.body}');
      throw Exception('Failed to fetch babies');
    }
  }

  // Add a new baby record
  static Future<List<dynamic>> fetchBabies() async {
    final response = await http.get(Uri.parse('$baseUrl/bayi'));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load babies');
    }
  }

  static Future<void> addBaby(String nama, String jenisKelamin,
      String tanggalLahir, String golonganDarah, String ibu) async {
    final response = await http.post(
      Uri.parse('$baseUrl/bayi'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'nama': nama,
        'jenis_kelamin': jenisKelamin,
        'tanggal_lahir': tanggalLahir,
        'golongan_darah': golonganDarah,
        'ibu': ibu,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to add baby');
    }
  }

  // Register a new user
  static Future<void> registerUser(
      String name, String phoneNumber, String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/register'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'name': name,
        'phone_number': phoneNumber,
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      print('User registered successfully');
    } else {
      throw Exception('Failed to register user');
    }
  }

  // User login
  static Future<int> loginUser(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print('Login successful');
      return data['userId'];
    } else if (response.statusCode == 401) {
      throw Exception('Invalid email or password');
    } else {
      print('Failed to login with status code: ${response.statusCode}');
      print('Response body: ${response.body}');
      throw Exception('Failed to login');
    }
  }

  // Fetch user data
  static Future<Map<String, dynamic>> getUserData(int userId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/user/$userId'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      print(
          'Failed to fetch user data with status code: ${response.statusCode}');
      print('Response body: ${response.body}');
      throw Exception('Failed to fetch user data');
    }
  }

  // Fetch user tickets
  static Future<List<dynamic>> getUserTickets(int userId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/tickets/$userId'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      print('Failed to fetch tickets with status code: ${response.statusCode}');
      print('Response body: ${response.body}');
      throw Exception('Failed to fetch tickets');
    }
  }

  // Submit a new ticket
  static Future<void> submitTicket(
      int userId,
      String name,
      String email,
      String appointmentDate,
      String appointmentTime,
      String jenisImunisasi) async {
    final response = await http.post(
      Uri.parse('$baseUrl/submit-ticket'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'user_id': userId,
        'name': name,
        'email': email,
        'appointment_date': appointmentDate,
        'appointment_time': appointmentTime,
        'jenis_imunisasi': jenisImunisasi,
        'status': 'waiting', // Set initial status to 'waiting'
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to create ticket');
    }
  }

  // Fetch all immunization records
  static Future<List<dynamic>> getAllImmunizationRecords() async {
    final response = await http.get(
      Uri.parse('$baseUrl/imunisasi'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      print(
          'Failed to fetch immunization records with status code: ${response.statusCode}');
      print('Response body: ${response.body}');
      throw Exception('Failed to fetch immunization records');
    }
  }

  static Future<List<dynamic>> fetchTickets() async {
    final response = await http.get(Uri.parse('$baseUrl/tickets'));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load tickets');
    }
  }

  static Future<List<dynamic>> fetchImmunizations() async {
    final response = await http.get(Uri.parse('$baseUrl/imunisasi'));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load immunizations');
    }
  }

  static Future<void> addImmunization(
      String namaBayi,
      String jenisKelamin,
      String tanggalLahir,
      int usia,
      double beratBadan,
      double tinggiBayi) async {
    final response = await http.post(
      Uri.parse('$baseUrl/imunisasi'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'nama_bayi': namaBayi,
        'jenis_kelamin': jenisKelamin,
        'tanggal_lahir': tanggalLahir,
        'usia': usia,
        'berat_badan': beratBadan,
        'tinggi_bayi': tinggiBayi,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to add immunization record');
    }
  }
}
