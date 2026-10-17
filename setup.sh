#!/bin/bash

# Create Directory Structure
mkdir -p android/app/src/main/kotlin/com/kashmir/reels
mkdir -p android/app/src/main/res/values

# 1. android/build.gradle
cat << 'EOF' > android/build.gradle
allprojects {
    repositories {
        google()
        mavenCentral()
    }
}
rootProject.buildDir = '../build'
subprojects {
    project.buildDir = "${rootProject.buildDir}/${project.name}"
}
subprojects {
    project.evaluationDependsOn(':app')
}
tasks.register("clean", Delete) {
    delete rootProject.buildDir
}
EOF

# 2. android/settings.gradle
cat << 'EOF' > android/settings.gradle
pluginManagement {
    def flutterSdkPath = {
        def properties = new Properties()
        def file = new File(rootProject.projectDir, "local.properties")
        if (file.exists()) {
            file.withReader("UTF-8") { reader -> properties.load(reader) }
        }
        return properties.getProperty("flutter.sdk")
    }()

    includeBuild("$flutterSdkPath/packages/flutter_tools/gradle")

    repositories {
        google()
        mavenCentral()
        gradlePluginPortal()
    }
}

plugins {
    id "dev.flutter.flutter-gradle-plugin" version "1.0.0" apply false
}

include ":app"
EOF

# 3. android/app/build.gradle
cat << 'EOF' > android/app/build.gradle
plugins {
    id "com.android.application"
    id "kotlin-android"
    id "dev.flutter.flutter-gradle-plugin"
}

android {
    namespace "com.kashmir.reels"
    compileSdk 34

    defaultConfig {
        applicationId "com.kashmir.reels"
        minSdk 21
        targetSdk 34
        versionCode 1
        versionName "1.0"
    }

    buildTypes {
        release {
            signingConfig signingConfigs.debug
        }
    }
}

flutter {
    source '../..'
}
EOF

# 4. android/app/src/main/AndroidManifest.xml
cat << 'EOF' > android/app/src/main/AndroidManifest.xml
<manifest xmlns:android="http://schemas.android.com/apk/res/android">
    <uses-permission android:name="android.permission.INTERNET"/>
    <uses-permission android:name="android.permission.CAMERA"/>
    <uses-permission android:name="android.permission.RECORD_AUDIO"/>

    <application
        android:label="Kashmir Reels Pro"
        android:name="${applicationName}"
        android:icon="@mipmap/ic_launcher">
        <activity
            android:name=".MainActivity"
            android:exported="true"
            android:launchMode="singleTop"
            android:theme="@style/LaunchTheme"
            android:configChanges="orientation|keyboardHidden|keyboard|screenSize|smallestScreenSize|locale|layoutDirection|fontScale|screenLayout|density|uiMode"
            android:hardwareAccelerated="true"
            android:windowSoftInputMode="adjustResize">
            <meta-data
              android:name="io.flutter.embedding.android.NormalTheme"
              android:resource="@style/NormalTheme"
              />
            <intent-filter>
                <action android:name="android.intent.action.MAIN"/>
                <category android:name="android.intent.category.LAUNCHER"/>
            </intent-filter>
        </activity>
        <meta-data
            android:name="flutterEmbedding"
            android:value="2" />
    </application>
</manifest>
EOF

# 5. android/app/src/main/kotlin/com/kashmir/reels/MainActivity.kt
cat << 'EOF' > android/app/src/main/kotlin/com/kashmir/reels/MainActivity.kt
package com.kashmir.reels

import io.flutter.embedding.android.FlutterActivity

class MainActivity: FlutterActivity() {
}
EOF

echo "Android files generated successfully!"
