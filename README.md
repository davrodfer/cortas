# cortas

Monta un servicio de generación de url's cortas. Las url's se guardan en una estructura de directorios en la que los nombres de los archivos coinciden con la url que se pasa por parámetro, formando un directorio por letra. 

Hay una traslación numérica de la etiqueta de la url al nombre del archivo. La precedencia de los caracteres se definen en un fichero "alfabeto".


## Instalacion

```
cd /opt
git clone https://github.com/davrodfer/cortas.git
```

#### Instalación del modulo de cgi

```
sudo apt-get install nginx fcgiwrap
```
## Configuracion

Añadir configuracion a nginx

```
  location ~ /- {
     fastcgi_param SCRIPT_FILENAME  /opt/cortas/cortas.sh;
     include fastcgi_params;
     fastcgi_pass unix:/var/run/fcgiwrap.socket;
  }
```

Añadir urlbase

```
cd /opt/cortas
echo "https://www.example.com/-" > urlbase
```

## Añadir url a la BBDD

```
$ /opt/cortas/nuevaUrl.sh https://github.com/davrodfer/cortas
https://www.example.com/-9212
$
```

## Reconstruir el alfabeto

```
cad="qwertyuioplkjhgfdsazxcvbnmMNBVCXZLKJHGFDSAPOIUYTREWQ1234567890"; n=${#cad} ; for i in `seq 1 $n`; do echo ${cad} | cut -c$i-$i; done | shuf > alfabeto
```