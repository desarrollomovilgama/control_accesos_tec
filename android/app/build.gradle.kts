<<<<<<< HEAD
import org.jetbrains.kotlin.gradle.dsl.JvmTarget

=======
>>>>>>> 358d57ba1357f30f64afa2c4e1ad017fde59e106
plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

android {
<<<<<<< HEAD
    namespace = "mx.com.gama.control_aulas"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    // Java 11 para nuestra app. Los plugins de terceros pueden seguir en su
    // propia versión (1.8) sin afectarnos: el warning de obsolete options se
    // silencia desde el build.gradle.kts raíz con -Xlint:-options.
    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
=======
    namespace = "com.tuempresa.pr_c"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_17.toString()
>>>>>>> 358d57ba1357f30f64afa2c4e1ad017fde59e106
    }

    defaultConfig {
        // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
<<<<<<< HEAD
        applicationId = "mx.com.gama.control_aulas"
=======
        applicationId = "com.tuempresa.pr_c"
>>>>>>> 358d57ba1357f30f64afa2c4e1ad017fde59e106
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

<<<<<<< HEAD
// Kotlin alineado a Java 11 usando el DSL nuevo `compilerOptions`
// (el viejo `kotlinOptions { jvmTarget = ... }` está deprecated en
// Kotlin Gradle Plugin 2.x).
kotlin {
    compilerOptions {
        jvmTarget.set(JvmTarget.JVM_11)
    }
}

=======
>>>>>>> 358d57ba1357f30f64afa2c4e1ad017fde59e106
flutter {
    source = "../.."
}
