@echo off
set JAVA_HOME=D:\JAV101\eclipse-jee-2026-03-R-win32-x86_64\eclipse\plugins\org.eclipse.justj.openjdk.hotspot.jre.full.win32.x86_64_21.0.10.v20260205-0638\jre

echo Building project with Maven...
call "D:\idea-2026.1.1.win\plugins\maven\lib\maven3\bin\mvn.cmd" package -f "C:\Users\ADMIN\Desktop\SportShop\pom.xml"

echo Copying WAR file to Tomcat...
copy /Y "C:\Users\ADMIN\Desktop\SportShop\target\SportShop-0.0.1-SNAPSHOT.war" "D:\JAV101\apache-tomcat-11.0.21-windows-x64\apache-tomcat-11.0.21\webapps\SportShop.war"

echo Starting Tomcat Server...
set CATALINA_HOME=D:\JAV101\apache-tomcat-11.0.21-windows-x64\apache-tomcat-11.0.21
call "%CATALINA_HOME%\bin\startup.bat"

echo.
echo ========================================================
echo Tomcat has been started in a new window!
echo You can view the app at: http://localhost:8080/SportShop/home
echo ========================================================
pause
