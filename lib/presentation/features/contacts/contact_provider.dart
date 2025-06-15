import 'package:flutter/material.dart';
import '../../../domain/entities/contact.dart';
import '../../../domain/usecases/contact_usecases.dart';

class ContactProvider extends ChangeNotifier {
  final ContactUseCases _contactUseCases;

  ContactProvider(this._contactUseCases);

  // Estado
  List<Contact> _allContacts = [];
  List<Contact> _filteredContacts = [];
  bool _isLoading = false;
  String? _error;
  String _searchQuery = '';

  // Getters
  List<Contact> get contacts => _filteredContacts;
  bool get isLoading => _isLoading;
  String? get error => _error;
  String get searchQuery => _searchQuery;
  bool get hasContacts => _allContacts.isNotEmpty;

  /// Cargar todos los contactos
  Future<void> loadContacts() async {
    _setLoading(true);
    _setError(null);

    try {
      _allContacts = await _contactUseCases.getAllContacts();
      _applySearch();
      notifyListeners();
    } catch (e) {
      _setError(e.toString());
    } finally {
      _setLoading(false);
    }
  }

  /// Buscar contactos en tiempo real
  void searchContacts(String query) {
    _searchQuery = query.trim().toLowerCase();
    _applySearch();
    notifyListeners();
  }

  /// Limpiar búsqueda
  void clearSearch() {
    _searchQuery = '';
    _applySearch();
    notifyListeners();
  }

  /// Crear nuevo contacto
  Future<bool> createContact(Contact contact) async {
    try {
      final createdContact = await _contactUseCases.createContact(contact);
      _allContacts.add(createdContact);
      _applySearch();
      notifyListeners();
      return true;
    } catch (e) {
      _setError(e.toString());
      return false;
    }
  }

  /// Actualizar contacto existente
  Future<bool> updateContact(Contact contact) async {
    try {
      await _contactUseCases.updateContact(contact);
      
      final index = _allContacts.indexWhere((c) => c.id == contact.id);
      if (index != -1) {
        _allContacts[index] = contact;
        _applySearch();
        notifyListeners();
      }
      return true;
    } catch (e) {
      _setError(e.toString());
      return false;
    }
  }

  /// Eliminar contacto
  Future<bool> deleteContact(int contactId) async {
    try {
      await _contactUseCases.deleteContact(contactId);
      
      _allContacts.removeWhere((c) => c.id == contactId);
      _applySearch();
      notifyListeners();
      return true;
    } catch (e) {
      _setError(e.toString());
      return false;
    }
  }

  /// Obtener contacto por ID
  Contact? getContactById(int id) {
    try {
      return _allContacts.firstWhere((c) => c.id == id);
    } catch (e) {
      return null;
    }
  }

  // Métodos privados
  void _applySearch() {
    if (_searchQuery.isEmpty) {
      _filteredContacts = List.from(_allContacts);
    } else {
      _filteredContacts = _allContacts.where((contact) {
        return contact.name.toLowerCase().contains(_searchQuery) ||
               (contact.email?.toLowerCase().contains(_searchQuery) ?? false) ||
               (contact.phone?.toLowerCase().contains(_searchQuery) ?? false);
      }).toList();
    }
  }

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void _setError(String? error) {
    _error = error;
    notifyListeners();
  }

  /// Limpiar estado de error
  void clearError() {
    _error = null;
    notifyListeners();
  }
}
