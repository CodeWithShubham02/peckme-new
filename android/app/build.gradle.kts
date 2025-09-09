plugins {
    id("com.android.application")
    id("kotlin-android")
    id("dev.flutter.flutter-gradle-plugin") // Flutter plugin must come after Android and Kotlin
    id("com.google.gms.google-services") // Firebase
    id("org.jetbrains.kotlin.plugin.compose") // ✅ this is required
}

repositories {
    google()
    mavenCentral()
  flatDir { dirs("libs") }
}

android {
    namespace = "com.example.peckme"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = "27.0.12077973"

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    defaultConfig {
        applicationId = "com.example.peckme"
        minSdk = 24
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    buildTypes {
        getByName("release") {
            signingConfig = signingConfigs.getByName("debug") // 👈 important
            isMinifyEnabled = false
            isShrinkResources = false
        }
        getByName("debug") {
            signingConfig = signingConfigs.getByName("debug")
            isMinifyEnabled = false
            isShrinkResources = false
        }
    }

    lint {
        abortOnError = false // ✅ Safely disable lint build failure
        disable.add("MissingTranslation") // Optional
    }
//    repositories {
//        flatDir { dirs("libs") }
//    }
    buildFeatures {
        compose = true
    }
    configurations.all {
        resolutionStrategy {
            force("com.squareup.okhttp3:okhttp:3.12.13")
        }
    }

}

dependencies {
    // Firebase BoM
    implementation(platform("com.google.firebase:firebase-bom:34.0.0"))
    implementation(files("libs/icici.aar"))
    implementation(files("libs/itext5-itextpdf-5.5.12.jar"))

    // Jetpack Compose runtime + UI
    implementation("androidx.core:core-ktx:1.16.0")
    implementation("androidx.activity:activity-compose:1.9.0")
    implementation("androidx.constraintlayout:constraintlayout:2.1.4")
// Or the latest stable version

    // Jetpack Compose BOM keeps versions aligned
    implementation(platform("androidx.compose:compose-bom:2024.06.00"))
    implementation("androidx.compose.ui:ui")
    implementation("androidx.compose.material:material")
    implementation("androidx.compose.ui:ui-tooling-preview")
    implementation("com.squareup.okhttp3:okhttp:3.12.13") // stable 3.x version
    debugImplementation("androidx.compose.ui:ui-tooling")

//    implementation(files("libs/icici.aar"))
//
//    // common deps AAR चाहते हों तो
//    implementation("androidx.appcompat:appcompat:1.6.1")
//    implementation("com.google.android.material:material:1.9.0")
    // Firebase products
    implementation("com.google.firebase:firebase-analytics")





}

flutter {
    source = "../.."
}
