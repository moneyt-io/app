import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../features/dashboard/home_screen.dart';
import '../theme/v2_theme.dart';
import 'new_home_screen.dart';

class DashboardWrapper extends StatefulWidget {
  final bool hasJustSeenPaywall;

  const DashboardWrapper({super.key, this.hasJustSeenPaywall = false});

  @override
  State<DashboardWrapper> createState() => _DashboardWrapperState();
}

class _DashboardWrapperState extends State<DashboardWrapper> {
  bool _useLegacyDashboard = false;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadPreference();
  }

  Future<void> _loadPreference() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      // Default to new dashboard, or whichever was saved.
      _useLegacyDashboard = prefs.getBool('use_legacy_dashboard') ?? false;
      _isLoading = false;
    });
  }

  Future<void> _toggleDashboard() async {
    final prefs = await SharedPreferences.getInstance();
    final newValue = !_useLegacyDashboard;
    await prefs.setBool('use_legacy_dashboard', newValue);
    setState(() {
      _useLegacyDashboard = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator(color: Color(0xFF0c7ff2))),
      );
    }

    if (_useLegacyDashboard) {
      // We pass a callback to the legacy screen or use a provider/global event, 
      // but to keep it simple without modifying too much of HomeScreen internals deeply,
      // we can wrap HomeScreen in a Scaffold-like container or pass a floating button over it.
      // Since HomeScreen already has a Scaffold, we will pass a callback down if we modify HomeScreen,
      // or we can just overlay a subtle button here.
      return Stack(
        children: [
          HomeScreen(hasJustSeenPaywall: widget.hasJustSeenPaywall),
          Positioned(
            top: MediaQuery.of(context).padding.top + 10,
            right: 16,
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: _toggleDashboard,
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.grey.shade300),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 4,
                        offset: Offset(0, 2),
                      )
                    ],
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.new_releases, size: 16, color: Color(0xFF0c7ff2)),
                      SizedBox(width: 4),
                      Text("New UI", style: TextStyle(fontSize: 12, color: Color(0xFF0c7ff2), fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    } else {
      return Theme(
        data: V2Theme.lightTheme,
        child: NewHomeScreen(
          hasJustSeenPaywall: widget.hasJustSeenPaywall,
          onToggleLegacy: _toggleDashboard,
        ),
      );
    }
  }
}
