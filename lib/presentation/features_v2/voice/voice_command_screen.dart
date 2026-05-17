import 'dart:ui';
import 'package:flutter/material.dart';

class VoiceCommandScreen extends StatelessWidget {
  const VoiceCommandScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.network(
              'https://lh3.googleusercontent.com/aida/ADBb0uiDxjZ6MHOXH3DQxF0xx4bhPcbgSllJ3SeMWdWmLLnHGDN0PGgL4ZU9KHrAgu9vZdYMG2FXBd-PDCei58o_JFb35Ic4-NK_eUxcC6I4CNPiBcb_V8HRinKeCkOXvHoYTcey352vnBBKTuIPKfi_IQPqLsMkX_lAibqwq7IuFmFlMsW92pIDOgCT6Jm98G3GTcT2ScLB6HsJZnG3fbaOgKKh0gQJE5A9wlXhaE3MkMtz2y8Y229y35eSOiJw',
              fit: BoxFit.cover,
            ),
          ),
          
          // Gradient Overlay
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withValues(alpha: 0.2),
                    Colors.transparent,
                    Colors.black.withValues(alpha: 0.4),
                  ],
                ),
              ),
            ),
          ),
          
          // Floating Icons (Simulated)
          Positioned(
            top: MediaQuery.of(context).size.height * 0.25,
            left: 40,
            child: _buildFloatingIcon(Icons.devices, "Tech"),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.35,
            right: 40,
            child: _buildFloatingIcon(Icons.restaurant, "Food"),
          ),
          Positioned(
            bottom: MediaQuery.of(context).size.height * 0.35,
            left: 60,
            child: _buildFloatingIcon(Icons.checkroom, "Clothing"),
          ),
          
          // Main Content
          SafeArea(
            child: Column(
              children: [
                // Top App Bar
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white.withValues(alpha: 0.5), width: 2),
                              image: const DecorationImage(
                                image: NetworkImage('https://lh3.googleusercontent.com/aida-public/AB6AXuAR6IKbpWwz2GSgKvvCpGE_t5xaHCLpNuzjTryRBYW1Ah8w1IbhauKhsDdsL40NkRp4H8z4PVp7ggmMrIPSuXWBRv4jU3ckimZYxv97NDW5HZOKuwwqEWL7F1pLi7x4ZF6bJ_sanxqJi09gBpW3k49IhfveWCTUHTEkB04D5a23SgRxqsitQkTJRmN-E9DN0wEYwqEkfrKnlZk9s6OC1izsCdSa7F50iMunXfNe5SagJyMcnCMJiT9MwtYc5ui8BUdUTs-B1LjBpFhV'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Text(
                            "Wealth AI",
                            style: theme.textTheme.headlineMedium?.copyWith(
                              color: Colors.white,
                              shadows: [
                                const Shadow(color: Colors.black45, blurRadius: 4, offset: Offset(0, 2)),
                              ],
                            ),
                          ),
                        ],
                      ),
                      IconButton(
                        icon: const Icon(Icons.settings, color: Colors.white),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
                
                // Center Text
                Expanded(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: Text(
                        "Gaste 50 USD en Starbucks",
                        textAlign: TextAlign.center,
                        style: theme.textTheme.displayLarge?.copyWith(
                          color: Colors.white,
                          fontSize: 40, // or 48 for larger screens
                          height: 1.1,
                          shadows: [
                            const Shadow(color: Colors.black54, blurRadius: 10, offset: Offset(0, 2)),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                
                // Bottom Contextual Control Area
                Padding(
                  padding: const EdgeInsets.only(left: 24, right: 24, bottom: 40),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(24),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 24, sigmaY: 24),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _buildBottomActionButton(Icons.close, "Cancelar", () => Navigator.pop(context)),
                            
                            // Large Integrated Voice Button
                            Transform.translate(
                              offset: const Offset(0, -24),
                              child: Container(
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: theme.colorScheme.primary,
                                  shape: BoxShape.circle,
                                  border: Border.all(color: Colors.white.withValues(alpha: 0.2), width: 4),
                                  boxShadow: [
                                    BoxShadow(
                                      color: theme.colorScheme.primary.withValues(alpha: 0.4),
                                      blurRadius: 20,
                                      spreadRadius: 4,
                                    ),
                                  ],
                                ),
                                child: const Icon(Icons.mic, color: Colors.white, size: 36),
                              ),
                            ),
                            
                            _buildBottomActionButton(Icons.history, "Recientes", () {}),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFloatingIcon(IconData icon, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.15),
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
              ),
              child: Icon(icon, color: Colors.white, size: 24),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.w500,
            fontFamily: 'Manrope',
          ),
        ),
      ],
    );
  }

  Widget _buildBottomActionButton(IconData icon, String label, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: Colors.white.withValues(alpha: 0.7)),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.7),
                fontSize: 12,
                fontWeight: FontWeight.w500,
                fontFamily: 'Manrope',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
