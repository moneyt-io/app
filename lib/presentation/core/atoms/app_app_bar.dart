import 'package:flutter/material.dart';
import 'dart:ui';

/// Tipos de AppBar basados en las maquetas HTML
enum AppAppBarType {
  standard,  // contact_list.html: bg-white shadow-sm
  blur,      // contact_form.html, contact_detail.html: bg-slate-50/80 backdrop-blur-md
}

/// Tipos de botón leading basados en las maquetas HTML
enum AppAppBarLeading {
  none,
  back,      // arrow_back_ios_new - contact_detail.html
  close,     // close - contact_form.html
  drawer,    // arrow_back_ios_new (pero para drawer) - contact_list.html
  custom,
}

/// Tipos de acciones basados en las maquetas HTML
enum AppAppBarAction {
  none,
  search,    // search - contact_list.html
  edit,      // edit - contact_detail.html
  menu,      // more_vert
  custom,
}

/// AppBar reutilizable que sigue exactamente el diseño de las maquetas HTML
/// 
/// Basado en:
/// - contact_list.html: AppBar standard con shadow y search
/// - contact_form.html: AppBar blur con close button
/// - contact_detail.html: AppBar blur con back y edit buttons
/// 
/// Ejemplo de uso:
/// ```dart
/// AppAppBar(
///   title: 'Contacts',
///   type: AppAppBarType.standard,
///   leading: AppAppBarLeading.drawer,
///   actions: [AppAppBarAction.search],
///   onLeadingPressed: () => Scaffold.of(context).openDrawer(),
///   onActionsPressed: [_handleSearch],
/// )
/// ```
class AppAppBar extends StatelessWidget implements PreferredSizeWidget {
  const AppAppBar({
    Key? key,
    this.title,
    this.type = AppAppBarType.standard,
    this.leading = AppAppBarLeading.back,
    this.actions = const [],
    this.onLeadingPressed,
    this.onActionsPressed,
    this.customLeading,
    this.customActions,
    this.centerTitle = true,
  }) : super(key: key);

  final String? title;
  final AppAppBarType type;
  final AppAppBarLeading leading;
  final List<AppAppBarAction> actions;
  final VoidCallback? onLeadingPressed;
  final List<VoidCallback>? onActionsPressed;
  final Widget? customLeading;
  final List<Widget>? customActions;
  final bool centerTitle;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: _getBackgroundDecoration(),
      child: type == AppAppBarType.blur
          ? ClipRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12), // HTML: backdrop-blur-md
                child: _buildAppBarContent(context),
              ),
            )
          : _buildAppBarContent(context),
    );
  }

  /// Decoración de fondo según el tipo basado en HTML
  BoxDecoration _getBackgroundDecoration() {
    switch (type) {
      case AppAppBarType.standard:
        // HTML: bg-white shadow-sm
        return const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Color(0x0F000000), // shadow-sm del HTML
              blurRadius: 2,
              offset: Offset(0, 1),
            ),
          ],
        );
      case AppAppBarType.blur:
        // HTML: bg-slate-50/80
        return BoxDecoration(
          color: const Color(0xFFF8FAFC).withOpacity(0.8), // bg-slate-50/80
        );
    }
  }

  /// Contenido principal del AppBar siguiendo estructura HTML
  Widget _buildAppBarContent(BuildContext context) {
    return SafeArea(
      child: Container(
        height: kToolbarHeight,
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 12), // HTML: p-4 pb-3
        child: Row(
          children: [
            // Botón leading
            _buildLeadingButton(context),
            
            // Título (con flex para centrado)
            Expanded(
              child: _buildTitle(),
            ),
            
            // Botones de acción
            ..._buildActionButtons(),
          ],
        ),
      ),
    );
  }

  /// Construye el botón leading basado en los diseños HTML
  Widget _buildLeadingButton(BuildContext context) {
    if (leading == AppAppBarLeading.none) {
      return const SizedBox(width: 40);
    }

    if (customLeading != null) {
      return SizedBox(
        width: 40,
        height: 40,
        child: customLeading!,
      );
    }

    IconData iconData;
    VoidCallback? defaultCallback;

    switch (leading) {
      case AppAppBarLeading.back:
        iconData = Icons.arrow_back_ios_new; // HTML: arrow_back_ios_new
        defaultCallback = () => Navigator.of(context).pop();
        break;
      case AppAppBarLeading.close:
        iconData = Icons.close; // HTML: close
        defaultCallback = () => Navigator.of(context).pop();
        break;
      case AppAppBarLeading.drawer:
        iconData = Icons.arrow_back_ios_new; // HTML: arrow_back_ios_new (para drawer)
        defaultCallback = () => Scaffold.of(context).openDrawer();
        break;
      case AppAppBarLeading.custom:
      case AppAppBarLeading.none:
        return const SizedBox(width: 40);
    }

    return SizedBox(
      width: 40, // HTML: h-10 w-10
      height: 40,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onLeadingPressed ?? defaultCallback,
          borderRadius: BorderRadius.circular(20),
          child: Center(
            child: Icon(
              iconData,
              color: const Color(0xFF475569), // HTML: text-slate-600
              size: leading == AppAppBarLeading.close ? 24 : 20, // HTML: text-2xl para close
            ),
          ),
        ),
      ),
    );
  }

  /// Construye el título basado en el HTML
  Widget _buildTitle() {
    if (title == null) return const SizedBox.shrink();

    return Text(
      title!,
      style: const TextStyle(
        fontSize: 20, // HTML: text-xl
        fontWeight: FontWeight.w600, // HTML: font-semibold
        color: Color(0xFF0F172A), // HTML: text-slate-900
        letterSpacing: -0.3, // HTML: tracking-tight
        height: 1.2, // HTML: leading-tight
      ),
      textAlign: centerTitle ? TextAlign.center : TextAlign.start,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }

  /// Construye los botones de acción basados en los diseños HTML
  List<Widget> _buildActionButtons() {
    if (actions.isEmpty && customActions == null) {
      return [const SizedBox(width: 40)]; // Spacer para balance visual
    }

    if (customActions != null) {
      return customActions!;
    }

    List<Widget> actionWidgets = [];

    for (int i = 0; i < actions.length; i++) {
      final action = actions[i];
      if (action == AppAppBarAction.none) continue;

      IconData iconData;
      VoidCallback? callback;

      switch (action) {
        case AppAppBarAction.search:
          iconData = Icons.search; // HTML: search
          break;
        case AppAppBarAction.edit:
          iconData = Icons.edit; // HTML: edit
          break;
        case AppAppBarAction.menu:
          iconData = Icons.more_vert; // HTML: more_vert
          break;
        case AppAppBarAction.custom:
        case AppAppBarAction.none:
          continue;
      }

      if (onActionsPressed != null && i < onActionsPressed!.length) {
        callback = onActionsPressed![i];
      }

      actionWidgets.add(
        SizedBox(
          width: 40, // HTML: h-10 w-10
          height: 40,
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: callback,
              borderRadius: BorderRadius.circular(20),
              child: Center(
                child: Icon(
                  iconData,
                  color: const Color(0xFF475569), // HTML: text-slate-600
                  size: 24,
                ),
              ),
            ),
          ),
        ),
      );
    }

    // Si no hay acciones, agregar spacer para balance
    if (actionWidgets.isEmpty) {
      actionWidgets.add(const SizedBox(width: 40));
    }

    return actionWidgets;
  }
}
