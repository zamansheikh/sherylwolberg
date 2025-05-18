import 'dart:convert';
import 'dart:io'; // For HttpHeaders

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:workflowx/features/projects/project_model.dart';
import '../../../core/utils/loading_controller.dart'; 

class ProjectController extends GetxController {
  // --- State Variables ---

  // Make the project list reactive
  final RxList<Project> projectList = <Project>[].obs;

  // Reactive variable to store potential error messages
  final RxString errorMessage = ''.obs;

  // --- Constants ---
  static const String _apiBaseUrl = "http://192.168.0.125:3500/api/";
  static const String _projectsEndpoint = "/projects/";

  // --- Lifecycle Methods ---
  @override
  void onInit() {
    super.onInit();
    fetchProjects(); // Fetch projects when the controller initializes
  }

  // --- API Call Method ---
  Future<void> fetchProjects() async {
    // 1. Show Loading Indicator & Clear Previous Errors/Data
    LoadingController.to.showLoading();
    errorMessage.value = ''; // Clear previous error message
    projectList.clear(); // Clear previous project list (optional, depends on desired behavior on refresh)

    // --- !!! IMPORTANT: Token Management !!! ---
    // Replace this with your actual token retrieval logic.
    // This token should come from a secure storage (like flutter_secure_storage)
    // or your authentication service after login.
    // **NEVER hardcode tokens directly in your source code for production apps.**
    const String? authToken = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyRW1haWwiOiJ6YW1hbjAxQGdtYWlsLmNvbSIsInVzZXJJZCI6IjY4MDQ1MTZjYzc3NzA5NTI1N2QzYzM1NCIsInVzZXJSb2xlIjoiTEVBREVSIiwiaWF0IjoxNzQ1NTAxMDUwLCJleHAiOjE3NDU1MDE5NTB9.YbvoyVRSfRF3v0iODnumVg-vVZuNvwcPr7Z-NRfWSgo";

    if (authToken == null || authToken.isEmpty || authToken == "YOUR_ACTUAL_BEARER_TOKEN") {
       debugPrint("Auth token is missing or placeholder! Cannot fetch projects.");
       errorMessage.value = "Authentication token not found.";
       LoadingController.to.hideLoading();
       return; // Stop execution if no token
    }
    // --- End Token Management ---

    final Uri url = Uri.parse(_apiBaseUrl + _projectsEndpoint);
    final Map<String, String> headers = {
      HttpHeaders.authorizationHeader: 'Bearer $authToken',
      HttpHeaders.contentTypeHeader: 'application/json', // Often needed
      HttpHeaders.acceptHeader: 'application/json',
    };

    try {
      // 2. Make the HTTP GET request
      final response = await http.get(url, headers: headers);

      // 3. Process the Response
      if (response.statusCode == 200) {
        // Decode the response body
        final decodedBody = jsonDecode(response.body);

        // Check if the response structure is as expected
        if (decodedBody is Map<String, dynamic> && decodedBody['success'] == true && decodedBody['data'] is List) {
          // Extract the list of project data
          final List<dynamic> dataList = decodedBody['data'];

          // Parse each item in the list using Project.fromJson
          final List<Project> parsedProjects = dataList
              .map((projectJson) => Project.fromJson(projectJson as Map<String, dynamic>))
              .toList();

          // Update the reactive list - assignAll replaces the list content
          projectList.assignAll(parsedProjects);
          debugPrint('Successfully fetched ${projectList.length} projects.');

        } else {
          // Handle unexpected success response structure
          debugPrint('Error: Unexpected API response format. Body: ${response.body}');
          errorMessage.value = decodedBody['message'] as String? ?? 'Failed to parse project data.';
        }
      } else {
        // Handle non-200 status codes (errors)
        debugPrint('Error: API request failed with status code ${response.statusCode}');
        debugPrint('Error Body: ${response.body}');
        String errorMsg = 'Error ${response.statusCode}: Failed to load projects.';
        // Try to parse error message from response body if available
         try {
           final errorBody = jsonDecode(response.body);
           if (errorBody is Map<String, dynamic> && errorBody.containsKey('message')) {
             errorMsg = 'Error ${response.statusCode}: ${errorBody['message']}';
           }
         } catch (_) {
           // Ignore if error body is not JSON or doesn't contain 'message'
           errorMsg = 'Error ${response.statusCode}: ${response.reasonPhrase ?? 'Unknown error'}';
         }
        errorMessage.value = errorMsg;
      }
    } catch (e, stackTrace) {
      // Handle network errors or JSON parsing errors
      debugPrint('Error fetching projects: $e');
      debugPrint('Stack Trace: $stackTrace');
      errorMessage.value = 'An error occurred: ${e.toString()}';
    } finally {
      // 4. Hide Loading Indicator (always runs)
      LoadingController.to.hideLoading();
    }
  }

  // Example method (you can remove if not needed)
  final count = 0.obs;
  void increment() {
    LoadingController.to.showLoading();
    Future.delayed(const Duration(seconds: 1), () { // Shorter delay for example
      count.value++;
      LoadingController.to.hideLoading();
    });
  }

  // Optional: Add a refresh method
  Future<void> refreshProjects() async {
    debugPrint("Refreshing projects...");
    await fetchProjects();
  }
}