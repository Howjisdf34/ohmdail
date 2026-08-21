# Ohmdail

Sitio web de un solo archivo (`index.html`, HTML+CSS+JS en línea, sin build)
para José Ángel Hernández Amaya — servicios de mantenimiento del hogar en
Ciudad Lázaro Cárdenas, Michoacán.

## Deploy en Coolify

Este repo incluye un `Dockerfile` (nginx:alpine sirviendo `index.html` y
`pictures/web/`). En Coolify:

1. New Resource → Public Repository → pega la URL de este repo.
2. Build Pack: **Dockerfile** (se detecta solo).
3. Puerto expuesto: **80**.
4. Configura el dominio `ohmdail.com` / `www.ohmdail.com` y el DNS apuntando
   al servidor de Coolify.
5. Deploy.

## Editar contenido

Todo el contenido (textos, teléfono, correo) vive en el objeto `CONFIG` al
final del `<script>` en `index.html`. Ver `Claude.md` para el resto del
contexto del proyecto.
