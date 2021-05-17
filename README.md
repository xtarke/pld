# Quartus/Modelsim install (Debian, Ubuntu (20.04) e OpenSuse)

- Instalar bibliotecas 32-bit (Debian):

```bash
sudo dpkg --add-architecture i386
sudo apt-get update
sudo apt-get install libc6:i386 libncurses5:i386 libstdc++6:i386 libx11-6:i386 libxext6:i386 libxrender1:i386
```

- Instalar bibliotecas 32-bit (Debian)

```bash
sudo apt-get update
sudo apt-get install libc6:i386 libncurses5:i386 libstdc++6:i386 libx11-6:i386 libxext6:i386 libxrender1:i386 libxft2:i386
```

- Instalar bibliotecas 32-bit (OpenSuse):

```bash
sudo zypper install libX11-6-32bit libXext6-32bit libXft2-32bit libXrender1-32bit libncurses5-32bit
```

- Para executar o Modelsim:

```bash
<dir de instalacão>/intelFPGA/20.1/modelsim_ase/bin/vsim
```

- Modelsim (somente se o software não rodar):

Caso o Modelsim reporte o seguinte erro, é necessário alterar algumas bibliotecas:

```bash
Error in startup script:
Initialization problem, exiting.
Initialization problem, exiting.
Initialization problem, exiting.
   while executing
"EnvHistory::Reset"
   (procedure "PropertiesInit" line 3)
   invoked from within
"PropertiesInit"
   invoked from within
"ncFyP12 -+"
   (file "/opt/questasim/linux_x86_64/../tcl/vsim/vsim" line 1)
** Fatal: Read failure in vlm process (0,0)
```

  - Criar um diretório lib32:

    ```bash
    ~/intelFPGA
        +--- 18.1
        +--- lib32
    ```

  - Extrair as bibliotecas seguintes em lib32 (sugiro verificar se há correções de segurança).

    ```bash
    libfontconfig.so.1  libfontconfig.so.1.10.1  libfreetype.so.6  libfreetype.so.6.8.1  libXft.so.2  libXft.so.2.3.2    
    ```

  - Alterar __modelsim_ase/bin/vsim__:

    de:

    ```bash
    dir=`dirname "$arg0"`
    ```

    para:

    ```bash
    dir=`dirname "$arg0"` export LD_LIBRARY_PATH=<dir lib32 criado>/intelFPGA/lib32
    ```

  - Alterar __/modelsim_ase/bin/vco__ (linha 206)

    de:

    ```bash
    vco="linux_rh60" ;;
    ```

    para:

    ```bash
    vco="linux" ;;
    ```

## Permissão para gravação do blaster

Crie o arquivo `51-altera-usb-blaster.rules` em `/etc/udev/rules.d/` contendo:

```bash
SUBSYSTEM=="usb", ATTR{idVendor}=="09fb", ATTR{idProduct}=="6001", MODE="0666"
SUBSYSTEM=="usb", ATTR{idVendor}=="09fb", ATTR{idProduct}=="6002", MODE="0666"
SUBSYSTEM=="usb", ATTR{idVendor}=="09fb", ATTR{idProduct}=="6003", MODE="0666"
SUBSYSTEM=="usb", ATTR{idVendor}=="09fb", ATTR{idProduct}=="6010", MODE="0666"
SUBSYSTEM=="usb", ATTR{idVendor}=="09fb", ATTR{idProduct}=="6810", MODE="0666"
```

Execute `udevadm control --reload` para recarregar as regras de permissão.

## Criação de atalhos

Crie o arquivo `modelsim.desktop` em `~/.local/share/applications` contendo:

```bash
[Desktop Entry]
Version=1.0
Name=ModelSim
Comment=ModelSim
Exec=<     dir de instalação     >/intelFPGA/20.1/modelsim_ase/bin/vsim
Icon=applications-electronics
Terminal=true
Type=Application
Categories=Development
 ```

Crie o arquivo quartus.desktop` em `~/.local/share/applications` contendo:

```
[Desktop Entry]
Type=Application
Version=0.9.4
Name=Quartus (Quartus Prime 20.1) Lite Edition
Comment=Quartus (Quartus Prime 20.1)
Icon=<     dir de instalação     >/intelFPGA/20.1/quartus/adm/quartusii.png
Exec=<     dir de instalação     >/intelFPGA/20.1/quartus/bin/quartus --64bit
Terminal=false
Path=/home/xtarke/Data/Apps/intelFPGA/20.
```

## Referências

- [Arch Linux Wiki](https://wiki.archlinux.org/index.php/Altera_Design_Software)
- [Debian Packages](https://packages.debian.org)
- [Tutorial](https://github.com/arthurmteodoro/install-quartus-linux)
