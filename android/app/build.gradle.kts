plugins {
    id("com.android.application")
    id("kotlin-android")
    id("dev.flutter.flutter-gradle-plugin") // Flutter plugin must come after Android and Kotlin
    id("com.google.gms.google-services") // Firebase
}

repositories {
    google()
    mavenCentral()
    flatDir {
        dirs("libs") // For AAR/JAR files
    }
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
        release {
            signingConfig = signingConfigs.getByName("debug") // Replace with actual signing config for production
        }
    }

    lint {
        abortOnError = false // ✅ Safely disable lint build failure
        disable.add("MissingTranslation") // Optional
    }
}

dependencies {
    // Firebase BoM
    implementation(platform("com.google.firebase:firebase-bom:34.0.0"))

    // Local JAR/AARs from libs folder
//    implementation(fileTree(mapOf("dir" to "libs", "include" to listOf("*.jar", "*.aar"))))
//
//    // Explicit file references (only if needed, can remove if already covered by fileTree above)
//    implementation(files("libs/itext5-itextpdf-5.5.12.jar"))
//    implementation(files("libs/icici.aar")) // ✅ Make sure this file actually exists

    // Firebase products
    implementation("com.google.firebase:firebase-analytics")





}

flutter {
    source = "../.."
}
