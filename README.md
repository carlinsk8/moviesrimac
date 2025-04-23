# MoviesRimac 🎬

Aplicación iOS desarrollada con **SwiftUI** y arquitectura **Clean Architecture**, que permite visualizar las películas próximas desde la API de TMDB.

## 🧱 Arquitectura

- Clean Architecture (Domain, Data, Presentation)
- Combine
- SwiftUI
- Repository Pattern
- Inyección de dependencias manual
- Configuración externa con `Environment.plist`


## 🛠 Configuración

Crear un archivo `Resources/Environment.plist` con las siguientes claves:

```xml
<key>API_BASE_URL</key>
<string>https://api.themoviedb.org/3/movie/upcoming</string>
<key>API_KEY</key>
<string>AQUI_TU_API_KEY</string>
