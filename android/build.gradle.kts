allprojects {
    repositories {
        google()
        mavenCentral()
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
subprojects {
    project.evaluationDependsOn(":app")
}

// Silenciar el warning "source value 8 is obsolete" que provocan los
// plugins de terceros (mobile_scanner, hive, dotenv, etc.) que aún declaran
// sourceCompatibility = 1.8. NO podemos cambiar su Java target porque sus
// extensiones se finalizan antes de que podamos reaccionar; en su lugar
// desactivamos solo el lint del compilador Java en todas las tareas.
//
// IMPORTANTE: NO se fija aquí el jvmTarget de Kotlin a 11. Si lo hiciéramos,
// chocaría con el `compileDebugJavaWithJavac` (1.8) de esos plugins y
// rompería con "Inconsistent JVM-target compatibility". Cada subproyecto
// queda internamente consistente con su propio target.
subprojects {
    tasks.withType<JavaCompile>().configureEach {
        options.compilerArgs.add("-Xlint:-options")
    }
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
