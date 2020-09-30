# Quartus/Modelsim install (Debian e OpenSuse)

- Instalar bibliotecas 32-bit (Debian):

```bash
sudo dpkg --add-architecture i386
sudo apt-get update
sudo apt-get install libc6:i386 libncurses5:i386 libstdc++6:i386 libx11-6:i386 libxext6:i386 libxrender1:i386
```

- Instalar bibliotecas 32-bit (OpenSuse):

```bash
sudo zypper install libX11-6-32bit libXext6-32bit libXft2-32bit libXrender1-32bit libncurses5-32bit
```

- Modelsim:

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

https://github.com/arthurmteodoro/install-quartus-linux
    
    

## Referências

- [Arch Linux Wiki](https://wiki.archlinux.org/index.php/Altera_Design_Software)
- [Debian Packages](https://packages.debian.org)
