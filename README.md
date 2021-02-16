# goodmeal_developer_test

# WeatherEveryWhere

WeatherEveryWhere es una aplicación que te permite conocer el pronostico del tiempo en cada parte del mundo!

Aplicación desarrollada por Marcelo Villablanca para el proceso para Desarrollador Flutter.

### Arquitectura
-------------
- **View**: Archivos relacionados a la UI de nuestro componente.
- **Bloc**: Archivos relacionados al manejo de estado de cada componente.
- **Repository**: Almacenamiento y distribución de datos en la aplicación en tiempo de ejecución.
- **Models**: Definición de la estructura de datos de cada componente en la aplicación.
- **Services**: Implementación de API's para la comunicación con servicios externos e internos.
- 
## Componentes
- **Home Component**: Página principal de la aplicación, muestra el pronostico presente en el lugar donde se utilice la aplicación.
- **Search Component**: Componente de búsqueda, Se encarga de procesar y presentar la información de las búsquedas realizadas a cualquier ciudad del mundo.

## Servicios
- **Local**: Se dispone dentro de la aplicación 2 diccionarios con información sobre todas las ciudades y paises del mundo.
- **Externa**: Se utiliza OpenWeather, la API recomendada para esta tarea, en especifico su endpoint OneCall que entrega pronosticos climaticos de 5 días desde la petición.

## Diagrama
![alt text](https://github.com/Mvillablancae/goodmeal_test/blob/development/assets/design/diagramaArq.png?raw=true)

### Release Pipeline
-------------

Instrucciónes para el release

1 - Clonar este repositorio 
```sh
$ git clone https://github.com/Mvillablancae/goodmeal_test.git
```
2 - Navegar hasta la carpeta de la app.
```sh
$ cd route_to/cloned_repo
```
3 - Ejecutar comando de compilación de la aplicación.
    Para este paso existen 2 opciones:
        - *APK*: Crea sólo un archivo de gran tamaño que contiene el instalable de la aplicación.
        ```
        $ flutter build apk
        ```
        - *Split ABI*: Crea 3 archivos, cada uno para la arquitectura de hardware del dispositivo a ocupar.
        ```
        $ flutter build apk --split-per-abi
        ```
    Si no se conoce la arquitectura de un dispositivo la primera opción es recomendada.

También existe la opción de compilar un Bundle, pero dado que esta app no se subira a la PlayStore no se desarrollará este paso.
3.2 - Para compilar para iOS se requiere de un dispositivo Mac y seguir las instrucciones en: https://flutter.dev/docs/deployment/ios

4 - Basta con mover el archivo generado (route_to/cloned_repo/build/app/outputs/apk/release/) en nuestro proyecto a nuestro teléfono, proveer permisos y abrir el Archivo.
5 - Disfrutar de la Aplicación :)



