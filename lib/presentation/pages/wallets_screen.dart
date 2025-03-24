import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import '../../domain/entities/wallet.dart';
import '../../domain/usecases/wallet_usecases.dart';
import '../atoms/app_button.dart';
import '../molecules/empty_state.dart';
import '../molecules/search_field.dart';
import '../molecules/wallet_list_item.dart';
import '../organisms/app_drawer.dart';
import '../routes/navigation_service.dart';
import '../routes/app_routes.dart';

class WalletsScreen extends StatefulWidget {
  const WalletsScreen({Key? key}) : super(key: key);

  @override
  State<WalletsScreen> createState() => _WalletsScreenState();
}

class _WalletsScreenState extends State<WalletsScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  List<Wallet> _wallets = [];
  bool _isLoading = true;
  String? _error;
  
  late final WalletUseCases _walletUseCases;

  @override
  void initState() {
    super.initState();
    _walletUseCases = GetIt.instance<WalletUseCases>();
    _loadWallets();
  }
  
  Future<void> _loadWallets() async {
    try {
      setState(() {
        _isLoading = true;
        _error = null;
      });
      
      final wallets = await _walletUseCases.getAllWallets();
      
      if (mounted) {
        setState(() {
          _wallets = wallets;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _error = e.toString();
          _isLoading = false;
        });
      }
    }
  }

  void _navigateToWalletForm({Wallet? wallet}) async {
    final result = await NavigationService.navigateTo(
      AppRoutes.walletForm,
      arguments: wallet,
    );
    
    if (result != null && result is Wallet) {
      _loadWallets();
    }
  }
  
  Future<void> _deleteWallet(Wallet wallet) async {
    // Mostrar diálogo de confirmación
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Eliminar billetera'),
        content: Text('¿Estás seguro de eliminar la billetera ${wallet.name}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancelar'),
          ),
          TextButton(
            style: TextButton.styleFrom(
              foregroundColor: Theme.of(context).colorScheme.error,
            ),
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Eliminar'),
          ),
        ],
      ),
    );

    if (confirmed == true && mounted) {
      try {
        await _walletUseCases.deleteWallet(wallet.id);
        
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Billetera eliminada con éxito'),
              backgroundColor: Colors.green,
            ),
          );
          
          _loadWallets(); // Recargar billeteras después de eliminar
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error al eliminar billetera: $e'),
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    
    final filteredWallets = _wallets
        .where((wallet) => wallet.name.toLowerCase().contains(_searchQuery.toLowerCase()))
        .toList();
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Billeteras'), // Cambiamos el título
        centerTitle: true,
        elevation: 0,
      ),
      drawer: const AppDrawer(),
      body: RefreshIndicator(
        onRefresh: _loadWallets,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SearchField(
                controller: _searchController,
                hintText: 'Buscar billeteras', // Cambiamos placeholder
                onChanged: (value) {
                  setState(() {
                    _searchQuery = value;
                  });
                },
              ),
            ),
            
            Expanded(
              child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _error != null 
                  ? _buildErrorState()
                  : _buildWalletsList(filteredWallets),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateToWalletForm(),
        backgroundColor: colorScheme.primary,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildErrorState() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.error_outline,
            size: 48,
            color: Theme.of(context).colorScheme.error,
          ),
          const SizedBox(height: 16),
          const Text('Error al cargar las billeteras'), // Cambiamos mensaje
          const SizedBox(height: 8),
          Text(_error ?? 'Error desconocido'),
          const SizedBox(height: 16),
          AppButton(
            text: 'Reintentar',
            onPressed: _loadWallets,
            type: AppButtonType.primary,
          ),
        ],
      ),
    );
  }

  Widget _buildWalletsList(List<Wallet> wallets) {
    if (wallets.isEmpty) {
      return EmptyState(
        icon: Icons.account_balance_wallet_outlined,
        title: 'No tienes billeteras', // Cambiamos mensaje
        message: _searchQuery.isEmpty 
          ? 'Crea una billetera utilizando el botón "+"' // Cambiamos mensaje
          : 'No se encontraron billeteras que coincidan con la búsqueda', // Cambiamos mensaje
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: wallets.length,
      itemBuilder: (context, index) {
        final wallet = wallets[index];
        return WalletListItem(
          wallet: wallet,
          onTap: () => _navigateToWalletForm(wallet: wallet),
          onDelete: () => _deleteWallet(wallet), // Añadir esta línea
        );
      },
    );
  }
}
