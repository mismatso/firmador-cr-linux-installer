# Instalador de Firma Digital para Debian 12

Este proyecto contiene un script para automatizar la instalación los componentes necesarios de Firma Digital en sistemas Debian 12 (Bookworm), en en Ubuntu 22.

## Descripción

El script `install.sh` automatiza la instalación de los siguientes componentes:
- **Dependencias del sistema**: `pcscd`, `pcsc-tools`, `libccid`, `libasedrive-usb`, `libarchive-tools`.
- **Idopte**: Middleware para firma digital.
- **GAUDI**: Agente del Banco Central para autenticación y firma en portales soportados.
- **Certificados**: Certificados de autoridades certificadoras de Costa Rica.
- **Librerías**: Librerías necesarias para el funcionamiento.
- **Firmador Libre:** Herramienta para firmar documentos cumpliendo con la «Política de Formatos Oficiales de los
Documentos Electrónicos Firmados Digitalmente» de Costa Rica.

## Requisitos generales

- Sistema operativo: Debian 12 (Bookworm) o Ubuntu 22 LTS.
- Acceso administrativo (sudo).
- Conexión a internet para descargar dependencias.
- Archivo `sfd_ClientesLinux_DEB64_Ubuntu22_Rev27.zip` (ver instrucciones de descarga).

## Descarga del archivo requerido

Antes de utilizar este repositorio, debe descargar el archivo `sfd_ClientesLinux_DEB64_Ubuntu22_Rev27.zip` desde la web se «Soporte Firma Digital», este archivo contiene los instaladores de **Idopte** y el **Agente Gaudi**, entre otros archivos que no pueden ser directamente incluidos en este repositorio por limitaciones de licenciamiento. Para descargar estos paquetes se le solicitará el número de serie de la tarjeta, esto es para validar que usted un cliente cubierto por esta la plataforma de «Soporte Firma Digital».

- **URL de descarga:** https://soportefirmadigital.com/sfdj/dl.aspx?lang=es
- **Paquete a descargar:** Usuarios Linux - Ubuntu 22.04 LTS (DEB 64bits)

## Uso de este asistente de instalación

### Instalación de prerequisites

Antes de clonar este repositorio y ejecutar el script de instalación de Firma Digital, usted deberá instalar los siguientes programas.

```bash
sudo apt-get install git libarchive-tools tree
```

### Instalación de controladores, agente y firmador

Para utilizar este asistente de instalación, abra una terminal y siga los siguientes pasos.

1. Clone este repositorio a su equipo:

```bash
git clone https://github.com/mismatso/firmador-cr-linux-installer.git $HOME/FirmadorCR-LI
``` 

2. Copie el archivo descargado de «Soporte de Firma Digital» en folder donde clonó este repositorio:

```bash
mv "$(xdg-user-dir DOWNLOAD)/sfd_ClientesLinux_DEB64_Ubuntu22_Rev27.zip" "$HOME/FirmadorCR-LI"
```

3. Muévase al directorio del asistente de instalación:

```bash
cd $HOME/FirmadorCR-LI
```

4. Puede verificar que tiene lo necesario para iniciar la instalación, lazando el comando `tree .`, debería ver algo así:

```
.
├── install.sh
├── README.md
└── sfd_ClientesLinux_DEB64_Ubuntu22_Rev27.zip
```

5. Otorgue permisos de ejecución al script:

```bash
chmod +x install.sh
```

5. Ejecute el script de instalación:

```bash
./install.sh
```

## **Self-Promotion**

Si lo desea, puede:

- Visitar mi canal de YouTube [MizaqScreencasts](https://www.youtube.com/MizaqScreencasts)
- Seguirme en [Twitter](https://twitter.com/mismatso)
- Contactarme por [Telegram](https://t.me/mismatso)

## **Licencia**

[Firmador CR Linux Installer](https://github.com/mismatso/firmador-cr-linux-installer) © 2024 by [Misael Matamoros](https://t.me/mismatso) está licenciado bajo la **GNU General Public License, version 3 (GPLv3)**. Para más detalles, consulta el archivo [LICENSE](/LICENSE).

!["GPLv3"](https://www.gnu.org/graphics/gplv3-with-text-136x68.png)