allprojects {
    repositories {
        google()
        mavenCentral()
        maven(url = uri("https://maven.aliyun.com/repository/google"))
        maven(url = uri("https://maven.aliyun.com/repository/central"))
    }
}

// Legacy Flutter plugins may pin removed AGP versions; align with the app.
subprojects {
    buildscript {
        repositories {
            google()
            mavenCentral()
            maven(url = uri("https://maven.aliyun.com/repository/google"))
            maven(url = uri("https://maven.aliyun.com/repository/central"))
        }
        configurations.matching { it.name == "classpath" }.configureEach {
            resolutionStrategy {
                force("com.android.tools.build:gradle:8.11.1")
            }
        }
    }
}

val newBuildDir: Directory =
    rootProject.layout.buildDirectory
        .dir("../../build")
        .get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
