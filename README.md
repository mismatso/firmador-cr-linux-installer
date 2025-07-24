# Instalador de Firma Digital de Costa Rica para Debian 12 y Ubuntu 22.04

![Debian](https://img.shields.io/badge/debian-12+-red)
![Ubuntu](https://img.shields.io/badge/ubuntu-22.04-orange)
![License](https://img.shields.io/github/license/mismatso/firmador-cr-linux-installer)

Este proyecto contiene un script para automatizar la instalación de los componentes necesarios para la Firma Digital de Costa Rica en sistemas operativos Debian 12 (Bookworm) y Ubuntu 22.04 LTS.

## Descripción

El script `install.sh` automatiza la instalación de los siguientes componentes:
- **Dependencias del sistema**: `pcscd`, `pcsc-tools`, `libccid`, `libasedrive-usb`, `libarchive-tools`.
- **Idopte**: Middleware para Firma Digital.
- **GAUDI**: Agente del Banco Central para autenticación y firma en portales soportados.
- **Certificados**: Certificados de autoridades certificadoras de Costa Rica.
- **Librerías**: Librerías requeridas por algunos programas para el funcionamiento de la firma.
- **Firmador Libre**: Herramienta para firmar documentos conforme a la política nacional de firma digital en Costa Rica.

## Requisitos generales

- Sistema operativo: Debian 12 (Bookworm) o Ubuntu 22.04 LTS.
- Acceso administrativo (sudo).
- Conexión a internet para descargar dependencias.
- Archivo `sfd_ClientesLinux_DEB64_Ubuntu22_Rev27.zip` (ver instrucciones de descarga).

## Descarga del archivo requerido

Antes de utilizar este asistente, debe descargar el archivo `sfd_ClientesLinux_DEB64_Ubuntu22_Rev27.zip` desde el sitio web de «Soporte Firma Digital». Este archivo contiene los instaladores de **Idopte**, el **Agente Gaudi**, y otros componentes que no pueden incluirse directamente en este repositorio por limitaciones de licenciamiento.

Para descargar este paquete se le solicitará el número de serie de su tarjeta de firma digital, a fin de validar que es un usuario autorizado por la plataforma de soporte.

- **URL de descarga:** https://soportefirmadigital.com/sfdj/dl.aspx?lang=es
- **Paquete a descargar:** Usuarios Linux - Ubuntu 22.04 LTS (DEB 64bits)

## Uso del asistente de instalación

### 1. Instalación de prerrequisitos

Antes de clonar el repositorio y ejecutar el script, asegúrese de tener instalados los siguientes paquetes:

```bash
sudo apt-get install git libarchive-tools tree
```

### 2. Clonar el repositorio

Abra una terminal y clone el repositorio en su directorio personal:

```bash
git clone https://github.com/mismatso/firmador-cr-linux-installer.git $HOME/FirmadorCR-LI
```

### 3. Copiar el archivo descargado

Mueva el archivo `.zip` descargado desde la plataforma de Firma Digital a la carpeta del repositorio:

```bash
mv "$(xdg-user-dir DOWNLOAD)/sfd_ClientesLinux_DEB64_Ubuntu22_Rev27.zip" "$HOME/FirmadorCR-LI"
```

### 4. Ingresar al directorio del proyecto

```bash
cd $HOME/FirmadorCR-LI
```

### 5. Verificar los archivos

Ejecute el siguiente comando para confirmar que todos los archivos necesarios están presentes:

```bash
tree .
```

Debería ver algo similar a lo siguiente:

```
.
├── install.sh
├── README.md
└── sfd_ClientesLinux_DEB64_Ubuntu22_Rev27.zip
```

### 6. Dar permisos de ejecución

```bash
chmod +x install.sh
```

### 7. Ejecutar el asistente de instalación

```bash
./install.sh
```

## Autor

Este asistente de instalación ha sido desarrollado por [Misael Matamoros](https://t.me/mismatso).

- YouTube: [MizaqScreencasts](https://www.youtube.com/MizaqScreencasts)
- Twitter: [@mismatso](https://twitter.com/mismatso)
- Telegram: [@mismatso](https://t.me/mismatso)

## Licencia

[Firmador CR Linux Installer](https://github.com/mismatso/firmador-cr-linux-installer) © 2024 por [Misael Matamoros](https://t.me/mismatso) está licenciado bajo los términos de la **GNU General Public License, version 3 (GPLv3)**. Para más detalles, consulte el archivo [LICENSE](/LICENSE).

[![GPLv3](https://www.gnu.org/graphics/gplv3-with-text-136x68.png)](https://www.gnu.org/licenses/gpl-3.0.html)
