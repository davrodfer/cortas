# cortas

Monta un servicio de generación de url's cortas.


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

