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
        isCoreLibraryDesugaringEnabled = true
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
        multiDexEnabled = true
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
    coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.1.4")
    // Jetpack Compose BOM keeps versions aligned
    implementation(platform("androidx.compose:compose-bom:2024.06.00"))
    implementation("androidx.compose.ui:ui")
    implementation("androidx.compose.material:material")
    implementation("androidx.compose.ui:ui-tooling-preview")

    implementation("com.squareup.okhttp3:okhttp:4.9.0") // stable 3.x version
    implementation("com.squareup.okio:okio:1.17.5")

    debugImplementation("androidx.compose.ui:ui-tooling")
    implementation("com.google.firebase:firebase-analytics")
    implementation("androidx.multidex:multidex:2.0.1")

}
configurations.all {
    resolutionStrategy {
        force("com.squareup.okhttp3:okhttp:4.9.0")
    }
}

flutter {
    source = "../.."
}
