// lib/controllers/user_controller.dart
import 'package:get/get.dart';
import 'package:ui/models/users.dart';
import 'package:ui/services/user_services.dart';

class UserController extends GetxController {
  var users = <User>[].obs;
  var selectedUser = User(
    id: '',
    nama: '',
    email: '',
    role: '',
    nomorTelepon: '',
    status: '',
  ).obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchUsers();
  }

  // Fetch all users
  Future<void> fetchUsers() async {
    try {
      isLoading(true);
      final fetchedUsers = await UserService.getAllUsers();
      users.assignAll(fetchedUsers);
    } catch (e) {
      Get.snackbar(
        'Error',
        'Tidak dapat memuat data pengguna: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading(false);
    }
  }

  // Fetch a user by ID
  Future<void> fetchUserById(String id) async {
    try {
      isLoading(true);
      final user = await UserService.getUserById(id);
      selectedUser.value = user;
    } catch (e) {
      Get.snackbar(
        'Error',
        'Tidak dapat memuat detail pengguna: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading(false);
    }
  }

  // Create a new user
  Future<void> createUser(User user) async {
    try {
      isLoading(true);
      await UserService.createUser(user);
      await fetchUsers(); // Refresh the list
    } catch (e) {
      rethrow; // Re-throw to handle in the UI
    } finally {
      isLoading(false);
    }
  }

  // Update an existing user
  Future<void> updateUser(User user) async {
    try {
      isLoading(true);
      await UserService.updateUser(user.id!, user);
      await fetchUsers(); // Refresh the list
    } catch (e) {
      rethrow; // Re-throw to handle in the UI
    } finally {
      isLoading(false);
    }
  }

  // Delete a user
  Future<void> deleteUser(String id) async {
    try {
      isLoading(true);
      await UserService.deleteUser(id);
      await fetchUsers(); // Refresh the list
      Get.snackbar(
        'Sukses',
        'Pengguna berhasil dihapus',
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Tidak dapat menghapus pengguna: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading(false);
    }
  }
}
