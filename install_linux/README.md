# Quartus/Modelsim install (Debian)

- Instalar bibliotecas 32-bit:

```bash
sudo dpkg --add-architecture i386
sudo apt-get update
sudo apt-get install libc6:i386 libncurses5:i386 libstdc++6:i386 libx11-6:i386 libxext6:i386 libXft2:i386
```

- Instalar [libpng12-0 xyz amd64.deb](https://packages.debian.org/pt-br/jessie/amd64/libpng12-0/download)

- Modelsim:

  - Criar um diretório lib32:

    ```bash
    ~/intelFPGA
        +--- 18.1
        +--- lib32
    ```

    - Extrair as bibliotecas freetype6 em lib32 (sugiro verificar se há correções de segurança).
  
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

## Referências

- [Arch Linux Wiki](https://wiki.archlinux.org/index.php/Altera_Design_Software)
- [Debian Packages](https://packages.debian.org)
