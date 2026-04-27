import org.jetbrains.kotlin.gradle.dsl.JvmTarget

plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "mx.com.gama.control_aulas"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    // Java 11 para nuestra app. Los plugins de terceros pueden seguir en su
    // propia versión (1.8) sin afectarnos: el warning de obsolete options se
    // silencia desde el build.gradle.kts raíz con -Xlint:-options.
    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    defaultConfig {
        // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
        applicationId = "mx.com.gama.control_aulas"
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

// Kotlin alineado a Java 11 usando el DSL nuevo `compilerOptions`
// (el viejo `kotlinOptions { jvmTarget = ... }` está deprecated en
// Kotlin Gradle Plugin 2.x).
kotlin {
    compilerOptions {
        jvmTarget.set(JvmTarget.JVM_11)
    }
}

flutter {
    source = "../.."
}
