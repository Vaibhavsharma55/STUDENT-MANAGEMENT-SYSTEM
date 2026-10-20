@echo off
setlocal enabledelayedexpansion
title Student Management System - Run Script

echo ================================================================
echo   Student Management System - Tomcat 11 Launcher
echo ================================================================
echo.

:: 1. Check Java
if "%JAVA_HOME%"=="" (
    if exist "C:\Program Files\Java\jdk-24" (
        set "JAVA_HOME=C:\Program Files\Java\jdk-24"
    ) else if exist "C:\Program Files\Java\jdk-21" (
        set "JAVA_HOME=C:\Program Files\Java\jdk-21"
    ) else if exist "C:\Program Files\Java\jdk-17" (
        set "JAVA_HOME=C:\Program Files\Java\jdk-17"
    )
)

if "%JAVA_HOME%"=="" (
    echo [ERROR] JAVA_HOME is not set and could not be detected.
    echo Please install JDK 17+ and set JAVA_HOME.
    pause
    exit /b 1
)
echo [OK] Using Java: %JAVA_HOME%

:: 2. Check Maven
set "MVN_CMD=mvn"
where mvn >nul 2>nul
if %errorlevel% neq 0 (
    if exist "C:\tools\apache-maven-3.9.9\bin\mvn.cmd" (
        set "MVN_CMD=C:\tools\apache-maven-3.9.9\bin\mvn.cmd"
    ) else (
        echo [ERROR] Maven not found. Please install Maven or add it to PATH.
        pause
        exit /b 1
    )
)
echo [OK] Using Maven: %MVN_CMD%

:: 3. Build WAR if not already built or rebuild
echo.
echo [1/3] Building WAR package with Maven...
call "%MVN_CMD%" clean package -DskipTests
if %errorlevel% neq 0 (
    echo [ERROR] Maven build failed!
    pause
    exit /b 1
)

:: 4. Locate Tomcat 11
if "%CATALINA_HOME%"=="" (
    if exist "C:\tools\apache-tomcat-11.0.4" (
        set "CATALINA_HOME=C:\tools\apache-tomcat-11.0.4"
    ) else if exist "C:\Program Files\Apache Software Foundation\Tomcat 11.0" (
        set "CATALINA_HOME=C:\Program Files\Apache Software Foundation\Tomcat 11.0"
    )
)

if "%CATALINA_HOME%"=="" (
    echo [ERROR] Apache Tomcat 11 was not detected.
    echo Please set CATALINA_HOME or deploy target\sms.war manually to your Tomcat webapps folder.
    pause
    exit /b 1
)
echo [OK] Using Tomcat: %CATALINA_HOME%

:: 5. Copy WAR to Tomcat webapps
echo.
echo [2/3] Deploying sms.war to Tomcat webapps directory...
copy /y "target\sms.war" "%CATALINA_HOME%\webapps\sms.war" >nul
if %errorlevel% neq 0 (
    echo [ERROR] Failed to copy WAR file to Tomcat webapps!
    pause
    exit /b 1
)
echo [OK] Deployment complete.

:: 6. Launch Tomcat and open browser
echo.
echo [3/3] Starting Apache Tomcat 11...
echo The application will be accessible at: http://localhost:8080/sms/
echo Default Admin credentials: admin / admin123
echo.

start "Student Management System - Browser" "http://localhost:8080/sms/"
call "%CATALINA_HOME%\bin\catalina.bat" run

pause
