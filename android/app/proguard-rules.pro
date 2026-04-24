# Flutter
-keep class io.flutter.** { *; }
-keep class io.flutter.plugins.** { *; }

# TikTok Events SDK
-keep class com.tiktok.** { *; }
-dontwarn com.tiktok.**

# Superwall
-keep class com.superwall.** { *; }
-dontwarn com.superwall.**

# PostHog
-keep class com.posthog.** { *; }
-dontwarn com.posthog.**

# Kotlin
-keep class kotlin.** { *; }
-dontwarn kotlin.**

# Facebook SDK
-keep class com.facebook.** { *; }
-dontwarn com.facebook.**

# Flutter Play Core (deferred components — not used in this app)
-dontwarn com.google.android.play.core.splitcompat.SplitCompatApplication
-dontwarn com.google.android.play.core.splitinstall.SplitInstallException
-dontwarn com.google.android.play.core.splitinstall.SplitInstallManager
-dontwarn com.google.android.play.core.splitinstall.SplitInstallManagerFactory
-dontwarn com.google.android.play.core.splitinstall.SplitInstallRequest$Builder
-dontwarn com.google.android.play.core.splitinstall.SplitInstallRequest
-dontwarn com.google.android.play.core.splitinstall.SplitInstallSessionState
-dontwarn com.google.android.play.core.splitinstall.SplitInstallStateUpdatedListener
-dontwarn com.google.android.play.core.tasks.OnFailureListener
-dontwarn com.google.android.play.core.tasks.OnSuccessListener
-dontwarn com.google.android.play.core.tasks.Task
