import 'dart:convert';

import 'package:expensive_app/model/category_mode.dart';
import 'package:expensive_app/model/expense_model.dart';
import 'package:expensive_app/model/income_model.dart';
import 'package:expensive_app/model/loan_model.dart';
import 'package:expensive_app/model/sub_category_mode.dart';
import 'package:expensive_app/model/todo_model.dart';
import 'package:expensive_app/model/total_expanses_model.dart';
import 'package:expensive_app/model/total_income_model.dart';
import 'package:expensive_app/model/transaction_model.dart';
import 'package:expensive_app/view/home.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class RemoteService {
  static var client = http.Client();
  static var baseURL = "http://192.168.0.101:8000/api";
  //Register User
  static Future register(Map data) async {
    try {
      var response = await client.post(Uri.parse("$baseURL/register"), headers: {'Content-Type': 'application/json'}, body: jsonEncode(data));

      if (response.statusCode == 200) {
        var jsonString = jsonDecode(response.body);
        Get.snackbar("Success", jsonString['message'], snackPosition: SnackPosition.BOTTOM);
      } else {
        Get.snackbar("Error", "User Already Exist", snackPosition: SnackPosition.BOTTOM);
      }
    } catch (e) {
      Get.snackbar("Error", e.toString(), snackPosition: SnackPosition.BOTTOM);
    }
  }

  //Register User
  static Future login(Map data) async {
    try {
      var response = await client.post(Uri.parse("$baseURL/login"), headers: {'Content-Type': 'application/json'}, body: jsonEncode(data));
      var jsonString = jsonDecode(response.body);
      if (jsonString['message'] != "Unauthorized") {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        preferences.setString("token", jsonString['token']);
        preferences.setString("email", data['email']);
        preferences.setString("password", data['password']);
        Get.off(() => const HomeView());
      } else {
        Get.snackbar("Error", "Invalid Username or Password", snackPosition: SnackPosition.BOTTOM);
      }
    } catch (e) {
      Get.snackbar("Error", e.toString(), snackPosition: SnackPosition.BOTTOM);
    }
  }

  //Fetch Category
  static Future<CategoryModel?> fetchCategory() async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      var token = preferences.getString("token");
      var response = await client.get(Uri.parse("$baseURL/categories"), headers: {'Authorization': 'Bearer $token'});
      if (response.statusCode == 200) {
        var jsonString = response.body;
        return categoryModelFromJson(jsonString);
      } else {
        return null;
      }
    } catch (e) {
      Get.snackbar("Error", 'No Internet Connection');
    }
  }

  //Fetch Category
  static Future<List<SubCategoryModel>?> fetchSubCategory(int id) async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      var token = preferences.getString("token");
      var response = await client.get(Uri.parse("$baseURL/categories/$id"), headers: {'Authorization': 'Bearer $token'});
      if (response.statusCode == 200) {
        var jsonString = response.body;
        return subCategoryModelFromJson(jsonString);
      } else {
        return null;
      }
    } catch (e) {
      Get.snackbar("Error", 'No Internet Connection');
    }
  }

  //Post Transaction
  static Future postTransaction(Map data) async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      var token = preferences.getString("token");
      var response = await client.post(Uri.parse("$baseURL/transaction"),
          headers: {'Content-type': 'application/json', 'Authorization': 'Bearer $token'}, body: jsonEncode(data));
      if (response.statusCode == 200) {
        Get.snackbar("Success", "Record Saved Successfully");
      }
    } catch (e) {
      Get.snackbar("Error", "No Internet Connection");
    }
  }

  //Add Loan
  static Future addLoan(Map data) async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      var token = preferences.getString("token");
      var response = await client.post(Uri.parse("$baseURL/loan"),
          headers: {'Content-type': 'application/json', 'Authorization': 'Bearer $token'}, body: jsonEncode(data));
      print(response.body);
      if (response.statusCode == 200) {
        Get.snackbar("Success", "Record Saved Successfully");
      }
    } catch (e) {
      Get.snackbar("Error", "No Internet Connection");
    }
  }

  static Future<List<LoanModel>?> fetchLoan() async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      var token = preferences.getString("token");
      var response = await client.get(Uri.parse("$baseURL/loan"), headers: {'Authorization': 'Bearer $token'});
      if (response.statusCode == 200) {
        var jsonString = response.body;
        return loanModelFromJson(jsonString);
      } else {
        return null;
      }
    } catch (e) {
      Get.snackbar("Error", 'No Internet Connection');
    }
  }

  //Post Todo
  static Future postTodo(Map data) async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      var token = preferences.getString("token");
      var response = await client.post(Uri.parse("$baseURL/todo"),
          headers: {'Content-type': 'application/json', 'Authorization': 'Bearer $token'}, body: jsonEncode(data));
      print(response.statusCode);
      if (response.statusCode == 200) {
        Get.snackbar("Success", "Record Saved Successfully");
      }
    } catch (e) {
      Get.snackbar("Error", "No Internet Connection");
    }
  }

  //Fetch Category
  static Future<TransactionModel?> fetchTransaction() async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      var token = preferences.getString("token");
      var response = await client.get(Uri.parse("$baseURL/transaction"), headers: {'Authorization': 'Bearer $token'});
      if (response.statusCode == 200) {
        var jsonString = response.body;
        return transactionModelFromJson(jsonString);
      } else {
        return null;
      }
    } catch (e) {
      Get.snackbar("Error", 'No Internet Connection');
    }
  }

  //Fetch Income
  static Future<IncomeModel?> fetchIncome() async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      var token = preferences.getString("token");
      var response = await client.get(Uri.parse("$baseURL/income"), headers: {'Authorization': 'Bearer $token'});
      if (response.statusCode == 200) {
        var jsonString = response.body;
        return incomeModelFromJson(jsonString);
      } else {
        return null;
      }
    } catch (e) {
      Get.snackbar("Error", 'No Internet Connection');
    }
  }

  //Fetch Total Income
  static Future<TotalIncomeModel?> fetchTotalIncome() async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      var token = preferences.getString("token");
      var response = await client.get(Uri.parse("$baseURL/totalIncome"), headers: {'Authorization': 'Bearer $token'});
      if (response.statusCode == 200) {
        var jsonString = response.body;
        return totalIncomeModelFromJson(jsonString);
      } else {
        return null;
      }
    } catch (e) {
      Get.snackbar("Error", 'No Internet Connection');
    }
  }

  //Fetch Expenses
  static Future<ExpensesModel?> fetchExpenses() async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      var token = preferences.getString("token");
      var response = await client.get(Uri.parse("$baseURL/expense"), headers: {'Authorization': 'Bearer $token'});
      if (response.statusCode == 200) {
        var jsonString = response.body;
        return expensesModelFromJson(jsonString);
      } else {
        return null;
      }
    } catch (e) {
      Get.snackbar("Error", 'No Internet Connection');
    }
  }

  //Fetch Total Expanses
  static Future<TotalExpensesModel?> fetchTotalExpanses() async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      var token = preferences.getString("token");
      var response = await client.get(Uri.parse("$baseURL/totalExpanses"), headers: {'Authorization': 'Bearer $token'});
      if (response.statusCode == 200) {
        var jsonString = response.body;
        return totalExpensesModelFromJson(jsonString);
      } else {
        return null;
      }
    } catch (e) {
      Get.snackbar("Error", 'No Internet Connection');
    }
  }

  //Fetch Todos
  static Future<TodoModel?> fetchTodos() async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      var token = preferences.getString("token");
      var response = await client.get(Uri.parse("$baseURL/todo"), headers: {'Authorization': 'Bearer $token'});
      if (response.statusCode == 200) {
        var jsonString = response.body;
        return todoModelFromJson(jsonString);
      } else {
        return null;
      }
    } catch (e) {
      Get.snackbar("Error", 'No Internet Connection');
    }
  }
}
