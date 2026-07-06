plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
    // Google Services plugin (FCM): reads android/app/google-services.json.
    id("com.google.gms.google-services")
}

import java.io.File
import java.util.Base64

/**
 * Loads `config/dart-defines/android.local.json` (or legacy path) for debug builds
 * pass `--dart-define-from-file` (e.g. Android Studio Run without launch config).
 */
fun encodeDartDefinesFromJson(file: File): String? {
    if (!file.isFile) {
        return null
    }

    val pattern = """"([^"]+)"\s*:\s*"((?:\\.|[^"\\])*)"""".toRegex()
    val pairs = pattern.findAll(file.readText(Charsets.UTF_8)).map { match ->
        val key = match.groupValues[1]
        val value = match.groupValues[2]
            .replace("\\\"", "\"")
            .replace("\\\\", "\\")
        Base64.getEncoder().encodeToString("$key=$value".toByteArray(Charsets.UTF_8))
    }.toList()

    return pairs.takeIf { it.isNotEmpty() }?.joinToString(",")
}

fun decodeDartDefineKeys(encoded: String): Set<String> {
    if (encoded.isBlank()) {
        return emptySet()
    }

    return encoded.split(',').mapNotNull { segment ->
        val trimmed = segment.trim()
        if (trimmed.isEmpty()) {
            return@mapNotNull null
        }

        try {
            // Format: base64("KEY=value") — used by --dart-define-from-file.
            val decodedPair = String(Base64.getDecoder().decode(trimmed), Charsets.UTF_8)
            val key = decodedPair.substringBefore('=')
            if (key.isNotEmpty() && decodedPair.contains('=')) {
                return@mapNotNull key
            }
        } catch (_: IllegalArgumentException) {
            // Fall through to legacy format.
        }

        try {
            // Legacy format: base64(KEY)=base64(value).
            val keyPart = trimmed.substringBefore('=')
            String(Base64.getDecoder().decode(keyPart), Charsets.UTF_8)
        } catch (_: IllegalArgumentException) {
            null
        }
    }.toSet()
}

/**
 * Loads local android dart-defines when Flutter CLI did not pass Supabase keys
 * (CLI always includes FLUTTER_* defines, so blank-check alone is not enough).
 */
fun mergeLocalDartDefines(project: org.gradle.api.Project) {
    val cliDartDefines = (project.findProperty("dart-defines") as String?).orEmpty()
    val cliKeys = decodeDartDefineKeys(cliDartDefines)
    if (cliKeys.contains("SUPABASE_URL") && cliKeys.contains("SUPABASE_ANON_KEY")) {
        return
    }

    val definesFile = project.rootProject.projectDir.parentFile
        .resolve("config/dart-defines/android.local.json")
        .takeIf { it.isFile }
        ?: project.rootProject.projectDir.parentFile
            .resolve("dart_defines.android.local.json")
    val fileDefines = encodeDartDefinesFromJson(definesFile) ?: return

    val merged = if (cliDartDefines.isBlank()) {
        fileDefines
    } else {
        "$cliDartDefines,$fileDefines"
    }
    project.extensions.extraProperties.set("dart-defines", merged)
}

mergeLocalDartDefines(project)

android {
    namespace = "com.example.rafiq_alhajj"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        // Required by flutter_local_notifications (uses java.time APIs).
        isCoreLibraryDesugaringEnabled = true
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_17.toString()
    }

    defaultConfig {
        // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
        applicationId = "com.example.rafiq_alhajj"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    buildTypes {
        release {
            // TODO: Add your own signing config for the release build.
            // Signing with the debug keys for now, so `flutter run --release` works.
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

flutter {
    source = "../.."
}

dependencies {
    // Backports java.time for flutter_local_notifications on older Android.
    coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.1.4")
}

// FCM is enabled: android/app/google-services.json is present and the
// com.google.gms.google-services plugin is applied in the plugins {} block above.
