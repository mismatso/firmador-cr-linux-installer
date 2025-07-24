#!/bin/bash

# Dectectar el directorio del script
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Limpiando archivos de ejecución anteriores
echo "🔄 Limpiando archivos de ejecución anteriores..."
rm -rf "$SCRIPT_DIR/Installers"
if [ $? -ne 0 ]; then
    echo "❌ Error al limpiar archivos de ejecución anteriores."
    exit 1
else
    echo "✔️ Archivos de ejecución anteriores limpiados."
fi

rm -rf "$SCRIPT_DIR/FirmadorLibreCR"
if [ $? -ne 0 ]; then
    echo "❌ Error eliminar instalador anterior del FirmadorLibreCR."
    exit 1
else
    echo "✔️ Archivos de instalador anterior del FirmadorLibreCR eliminado."
fi

# Verificar que exista el archivo sfd_ClientesLinux_DEB64_Ubuntu22_Rev27.zip
if [ -f "$SCRIPT_DIR/sfd_ClientesLinux_DEB64_Ubuntu22_Rev27.zip" ]; then
    echo "✔️ El archivo sfd_ClientesLinux_DEB64_Ubuntu22_Rev27.zip existe."
else
    echo "❌ El archivo sfd_ClientesLinux_DEB64_Ubuntu22_Rev27.zip no existe."
    echo
    echo "Por favor, descárguelo desde el sitio web de «Soporte de Firma Digital»"
    echo "en la URL https://soportefirmadigital.com/sfdj/dl.aspx?lang=es"
    echo
    echo "Colóquelo en este directorio $SCRIPT_DIR"
    echo "Una vez descargado, ejecute nuevamente este script."
    exit 1
fi

# Instalando dependencias y librerías necesarias
echo "🔄 Instalando dependencias y librerías necesarias..."
sudo apt-get update
sudo apt-get install -y pcscd pcsc-tools libccid libasedrive-usb libarchive-tools
if [ $? -ne 0 ]; then
    echo "❌ Error al instalar las dependencias."
    exit 1
else
    echo "✔️ Dependencias instaladas correctamente."
fi

# Descomprimir el archivo ZIP
# en modo silencioso y sobrescribir archivos existentes
echo "🔄 Descomprimiendo el archivo sfd_ClientesLinux_DEB64_Ubuntu22_Rev27.zip..."
if ! command -v bsdtar &> /dev/null; then
    echo "❌ El comando 'bsdtar' no está instalado. Por favor, instálelo con:"
    echo "sudo apt install libarchive-tools"
    exit 1
else
    cd "$SCRIPT_DIR"
    mkdir -p Installers
    bsdtar -xf sfd_ClientesLinux_DEB64_Ubuntu22_Rev27.zip --strip-components=2 -C Installers/

    if [ $? -ne 0 ]; then
        echo "❌ Error al descomprimir el archivo ZIP."
        exit 1
    fi
    echo "✔️ Archivo descomprimido correctamente."
fi

echo "🔄 Organizando carpeta de instaladores..."
mv Installers/'Agente GAUDI' Installers/GAUDI
if [ $? -ne 0 ]; then
    echo "❌ Error al renombrar la carpeta 'Agente GAUDI'."
    exit 1
else
    echo "✔️ Carpeta 'Agente GAUDI' renombrada a 'GAUDI'."    
fi

rm Installers/lib.sh
if [ $? -ne 0 ]; then
    echo "❌ Error al eliminar 'lib.sh'."
    exit 1
else
    echo "✔️ Archivo 'lib.sh' eliminado."
fi

# Instalando Idopte
echo "🔄 Instalando Idopte..."
sudo dpkg -i Installers/Idopte/*idopte*amd64.deb
if [ $? -ne 0 ]; then
    echo "❌ Error al instalar Idopte."
    echo "Por favor, asegúrese de que el archivo 'Idopte_1.0.0-1_amd64.deb' esté presente en la carpeta 'Installers'."
    exit 1
else
    sudo apt-get install -f -y
    echo "✔️ Idopte instalado correctamente."
fi

# Instalando GAUDI
echo "🔄 Instalando GAUDI..."
sudo dpkg -i Installers/GAUDI/*gaudi*amd64*.deb
if [ $? -ne 0 ]; then
    echo "❌ Error al instalar GAUDI."
    echo "Por favor, asegúrese de que el archivo 'GAUDI_1.0.0-1_amd64.deb' esté presente en la carpeta 'Installers'."
    exit 1
else
    sudo apt-get install -f -y
    echo "✔️ GAUDI instalado correctamente."
fi

# Descargando el firmador
echo "🔄 Descargando el firmador..."
mkdir -p "$SCRIPT_DIR/FirmadorLibreCR"
wget -O "$SCRIPT_DIR/FirmadorLibreCR/firmador.jar" https://firmador.libre.cr/firmador.jar
if [ $? -eq 0 ]; then
    echo "✔️ Descarga completada correctamente."
else
    echo "❌ Error al descargar el archivo."
    exit 1
fi

# Extrayendo el icono del firmador
echo "🔄 Extrayendo el icono del firmador..."
unzip -o "$SCRIPT_DIR/FirmadorLibreCR/firmador.jar" firmador.png -d "$SCRIPT_DIR/FirmadorLibreCR"
if [ $? -eq 0 ]; then
    echo "✔️ Icono extraído correctamente."
else
    echo "❌ Error al extraer el icono del firmador."
    exit 1
fi

# Verificando si alguna versión de Java está instalada
echo "🔄 Verificando la versión de Java instalada..."
if command -v java &> /dev/null; then
    JAVA_VERSION=$(java -version 2>&1 | awk -F '"' '/version/ {print $2}')
    echo "✔️ Java está instalado. Versión: $JAVA_VERSION"
else
    # Instalar Java si no está presente
    echo "⚠️ Java no está instalado. Instalando OpenJDK..."
    sudo apt-get install -y openjdk-11-jre
    if [ $? -eq 0 ]; then
        echo "✔️ OpenJDK instalado correctamente."
    else
        echo "❌ Error al instalar OpenJDK. Por favor, instálelo manualmente."
        exit 1
    fi
fi

# Variables para instalar el firmador
echo "🔄 Instalando el firmador..."
APP_DIR="$HOME/.firmador"
DESKTOP_FILE_NAME="librefirma.desktop"
MENU_ENTRY="$HOME/.local/share/applications/$DESKTOP_FILE_NAME"
DESKTOP_ENTRY="$(xdg-user-dir DESKTOP)/$DESKTOP_FILE_NAME"

# Copiando el firmador al directorio de aplicaciones
mkdir -p "$APP_DIR"
cp "$SCRIPT_DIR/FirmadorLibreCR/firmador.png" "$APP_DIR/firmador.png"
cp "$SCRIPT_DIR/FirmadorLibreCR/firmador.jar" "$APP_DIR/firmador.jar"
if [ $? -ne 0 ]; then
    echo "❌ Error al copiar el firmador."
    exit 1
else
    echo "✔️ Firmador copiado a $APP_DIR."
fi

# Contenido del archivo .desktop
DESKTOP_CONTENT="[Desktop Entry]
Version=1.0
Type=Application
Name=LibreFirma
Comment=Aplicación para firma digital compatible con JCOP4 en Costa Rica
Exec=java -jar $APP_DIR/firmador.jar
Icon=$APP_DIR/firmador.png
Terminal=false
Categories=Office;
StartupNotify=true
MimeType=application/x-java-archive;
"

# Crear el archivo en el menú de aplicaciones
mkdir -p "$(dirname "$MENU_ENTRY")"
echo "$DESKTOP_CONTENT" > "$MENU_ENTRY"
chmod +x "$MENU_ENTRY"
echo "✔️ Archivo .desktop creado en: $MENU_ENTRY"

# Crear el archivo en el escritorio si existe la carpeta
if [ -d "$HOME/Desktop" ]; then
    echo "$DESKTOP_CONTENT" > "$DESKTOP_ENTRY"
    chmod +x "$DESKTOP_ENTRY"
    echo "✔️ Acceso directo también creado en: $DESKTOP_ENTRY"
else
    echo "❌ La carpeta ~/Desktop no existe, se omitió la creación del acceso directo."
fi

# Mensaje final
echo
echo "🎉 Instalación completada con éxito."
echo "Puede iniciar LibreFirma desde el menú de aplicaciones, desde la"
echo "sección de aplicaciones de oficina o desde el acceso directo en"
echo "el escritorio."
echo
echo "Si encuentra algún problema, por favor, escríbame."
echo "https://t.me/mismatso"
echo
exit 0