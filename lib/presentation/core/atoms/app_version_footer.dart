import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

/// Footer de versión de la aplicación basado en settings.html
/// 
/// HTML Reference:
/// ```html
/// <div class="mt-6 px-4 text-center">
///   <p class="text-slate-400 text-sm">MoneyT v1.0.0</p>
///   <p class="text-slate-400 text-xs mt-1">© 2024 MoneyT. All rights reserved.</p>
/// </div>
/// ```
class AppVersionFooter extends StatefulWidget {
  const AppVersionFooter({
    Key? key,
    this.margin = const EdgeInsets.fromLTRB(16, 24, 16, 24), // HTML: mt-6 px-4
    this.textAlign = TextAlign.center,
    this.showCopyright = true,
    this.showBuildNumber = false, // ✅ AGREGADO: Control para mostrar build number
  }) : super(key: key);

  final EdgeInsets margin;
  final TextAlign textAlign;
  final bool showCopyright;
  final bool showBuildNumber; // ✅ AGREGADO: Nueva propiedad

  @override
  State<AppVersionFooter> createState() => _AppVersionFooterState();
}

class _AppVersionFooterState extends State<AppVersionFooter> {
  String _appName = 'MoneyT';
  String _version = '1.0.0';
  String _buildNumber = '';
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadPackageInfo();
  }

  Future<void> _loadPackageInfo() async {
    try {
      final packageInfo = await PackageInfo.fromPlatform();
      
      if (mounted) {
        setState(() {
          _appName = packageInfo.appName.isNotEmpty ? packageInfo.appName : 'MoneyT';
          _version = packageInfo.version.isNotEmpty ? packageInfo.version : '1.0.0';
          _buildNumber = packageInfo.buildNumber;
          _isLoading = false;
        });
      }
    } catch (e) {
      // En caso de error, usar valores por defecto
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  String get _versionText {
    // ✅ CORREGIDO: Solo mostrar build number si está habilitado
    if (widget.showBuildNumber && _buildNumber.isNotEmpty) {
      return '$_appName v$_version+$_buildNumber';
    }
    return '$_appName v$_version'; // Versión simple como en app_drawer.html
  }

  String get _copyrightText {
    final currentYear = DateTime.now().year;
    return '© $currentYear MONEYT, LLC. All rights reserved.';
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Container(
        margin: widget.margin,
        child: Column(
          children: [
            Container(
              height: 16, // Altura aproximada del texto de versión
              width: 120,
              decoration: BoxDecoration(
                color: const Color(0xFFF1F5F9), // HTML: bg-slate-100 (shimmer)
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            if (widget.showCopyright) ...[
              const SizedBox(height: 4),
              Container(
                height: 12, // Altura aproximada del texto de copyright
                width: 200,
                decoration: BoxDecoration(
                  color: const Color(0xFFF1F5F9), // HTML: bg-slate-100 (shimmer)
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ],
          ],
        ),
      );
    }

    return Container(
      margin: widget.margin,
      child: Column(
        children: [
          // Version text
          Text(
            _versionText,
            style: const TextStyle(
              fontSize: 14, // HTML: text-sm
              color: Color(0xFF9CA3AF), // HTML: text-slate-400
            ),
            textAlign: widget.textAlign,
          ),
          
          // Copyright text
          if (widget.showCopyright) ...[
            const SizedBox(height: 4), // HTML: mt-1
            Text(
              _copyrightText,
              style: const TextStyle(
                fontSize: 12, // HTML: text-xs
                color: Color(0xFF9CA3AF), // HTML: text-slate-400
              ),
              textAlign: widget.textAlign,
            ),
          ],
        ],
      ),
    );
  }
}
