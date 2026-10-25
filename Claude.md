# Trabajos independientes (ohmdail.com) — Sitio web

Contexto del proyecto para continuar el desarrollo. Deja este archivo en la raíz
de la carpeta del proyecto; Claude Code lo lee automáticamente.

## Qué es

Página web de una persona (José Ángel Hernández Amaya). El nombre que se muestra es
**Trabajos independientes** (así dicen sus tarjetas de presentación); **Ohmdail
es solo el dominio**, no lo uses como nombre o marca en la página) que
ofrece servicios de mantenimiento del hogar por su cuenta en **Ciudad Lázaro
Cárdenas, Michoacán, México**. El sitio muestra sus servicios y sus trabajos, y
sirve para que los clientes lo contacten. Público: dueños de casa que llegan
sobre todo de boca en boca, muchos desde el celular.

Servicios: pintura, resane de grietas, impermeabilización, mosquiteros a medida,
ventanas y puertas de acero (herrería), y mantenimiento general.

Dominio: **ohmdail.com** (se recomienda publicar en `ohmdail.com` / `www.ohmdail.com`,
sin subdominio).

## Regla de negocio importante (no romper)

**El precio NO se da al instante.** José necesita ver el lugar antes de cotizar.
Toda la comunicación del sitio está enfocada en **agendar una visita gratuita
para cotizar**, no en dar un presupuesto automático. No agregues calculadoras de
precio ni tabuladores de costo salvo que él lo pida.

## Stack y estructura

- **Un solo archivo:** `index.html`. Autónomo: HTML + CSS + JS en línea.
- **Sin build, sin dependencias, sin framework.** Se abre directo en el navegador.
- Única dependencia externa: Google Fonts (Archivo, IBM Plex Sans, IBM Plex Mono).
- No hay backend. El formulario de contacto arma un mensaje y abre **WhatsApp**
  (`https://wa.me/...` con el texto pre-llenado). También hay enlaces directos a
  WhatsApp, teléfono (`tel:`) y correo (`mailto:`).

Secciones (anclas): `#inicio` (hero), `#servicios`, `#trabajos` (galería),
franja de promesa, `#contacto`, footer.

## Configuración de datos

Al final del `<script>` hay un objeto **`CONFIG`** con los datos editables:

```js
const CONFIG = {
  marca:    "Trabajos independientes", // nombre que se ve en el header
  nombre:   "...",           // nombre o negocio (footer)
  ciudad:   "...",           // zona de servicio
  telefono: "521234567890",  // WhatsApp CON lada país. México = 52
  correo:   "..."            // correo (opcional)
};
```

Datos reales del dueño: José Ángel Hernández Amaya · Lázaro Cárdenas ·
tel visible `753 181 2346` · `joseangelhernandezamaya2@gmail.com`. El teléfono
en `CONFIG.telefono` debe ir en formato internacional sin símbolos
(ej. `52753...`) porque se usa para el enlace de WhatsApp.

> Nota: el `index.html` que está en esta carpeta es la fuente de verdad. Si hay
> una copia con datos ya cargados, úsala como base y confirma que `CONFIG` tenga
> los valores correctos antes de editar.

## Sistema de diseño

Estilo minimalista, industrial-artesanal. El azul es un guiño al pigmento del
pintor; la **malla tipo mosquitero** (rejilla fina de fondo) es el elemento
distintivo (aparece en el hero y en los placeholders de la galería).

Colores por variables CSS en `:root` (claro) y `[data-theme="dark"]` (oscuro):

- Acento (azul): `#182bc4` claro / `#4a5cff` oscuro
- Fondo: `#e9e7e1` claro / `#131418` oscuro
- Superficie de tarjetas: `#f5f3ee` / `#1b1d23`
- Tinta/texto: `#16171b` / `#eceae3`

Tipografías: **Archivo** (display, 600–900), **IBM Plex Sans** (cuerpo),
**IBM Plex Mono** (etiquetas, códigos, datos). Deriva cualquier color o tamaño
nuevo de estas variables; no metas hex sueltos.

## Modos y accesibilidad (funcionalidad clave, conservar)

- **Tema claro/oscuro:** botón sol/luna. Respeta `prefers-color-scheme` y
  recuerda la elección con `localStorage` envuelto en `try/catch` (no truena si
  el navegador lo bloquea).
- **Modo ahorro ("Ahorro"):** botón que desactiva animaciones, la malla animada,
  sombras y desenfoques, para celulares de gama baja. **Por decisión de José
  viene apagado por defecto** (antes se encendía solo al detectar equipo
  limitado; ya no). Solo se activa si el usuario lo toca, y la elección persiste
  en `localStorage` (`ahorro`). La clase que lo activa es `body.eco`.
- Respeta `prefers-reduced-motion` de forma independiente (media query que anula
  animaciones).
- Focus visible en teclado, `aria-label`s en botones, responsive con breakpoints
  a 900px y 640px.

## Animaciones (rediseño oct 2026)

- **Intro de carga (`#intro`, ~3 s):** tres rodillos (`<symbol id="roller">`)
  pintan la pantalla de azul en franjas, aparece "Trabajos independientes" y la cortina sube
  escurriendo pintura (`.in-drips`). Es CSS puro; el JS solo la salta (clic,
  tecla, scroll) y la quita del DOM. Se muestra en cada carga. No sale con
  `body.eco` ni `prefers-reduced-motion`: el `<script>` del `<head>` pone
  `html.no-intro` antes de pintar.
- **Hero:** líneas con reveal + `fade-up` y un brochazo azul detrás de "abajo."
  (`.swash`). Arranca con `body.loaded` cuando sube la cortina.
- **Casa animada (`#house`):** SVG que se arregla de arriba abajo:
  trazos → impermeabilización (`s1`) → resane (`s2`) → pintura con rodillo
  (`s3`) → mosquitero (`s4`) → herrería (`s5`) → `done` (sale el sol). Tiempos
  en `STEPS` del JS. Botón "Ver otra vez". En modo calma salta a `finishHouse()`.
- Cintas de pintor (`.tapes`) cruzadas en movimiento continuo.
- Scroll reveal vía `IntersectionObserver` (`.obs` → `.in`, con escalonado `--d`).
- Tarjetas de servicio: al pasar el cursor se pintan de arriba abajo con escurridos
  y el ícono se redibuja.
- Proceso: la línea entre pasos se pinta conforme haces scroll (`--p`).
- Footer: "Trabajos independientes" en contorno que se rellena de azul al aparecer.
- Cambio de tema con View Transitions (círculo desde el botón) si el navegador
  lo soporta.

Todas las animaciones se apagan bajo `body.eco` y bajo `prefers-reduced-motion`.
Si agregas animaciones nuevas, respeta esos dos apagados.

## Galería de trabajos

Fotos optimizadas en `pictures/web/` (las originales en `pictures/` no se suben;
ver `.gitignore`). Dos tipos de bloque, con un comentario `PARA PONER TUS FOTOS`
en el HTML:

- **Comparador antes/después (`.ba`):** dos `<img>` (antes, luego `.ba-after`).
  Se arrastra con el dedo/mouse o con teclado (range oculto). Solo sirve con
  pares tomados desde el mismo ángulo.
- **Galería (`.shot`):** `<figure>` con botón que abre el visor (`<dialog id="lb">`).
  `class="shot wide"` para fotos horizontales.

## Pendientes / próximos pasos sugeridos

- Agregar más fotos de trabajos (idealmente pares antes/después del mismo ángulo).
- Publicar en `ohmdail.com` / `www.ohmdail.com` (Dockerfile para Coolify incluido).
- Opcional: sección de reseñas/testimonios de clientes (solo reales).

## Convenciones al editar

- Mantén todo en un solo archivo autónomo salvo que se pida separar.
- Español mexicano, claro y directo. Los botones dicen exactamente qué pasa
  ("Agendar visita", no "Enviar").
- Cuida la especificidad de los selectores CSS (evita que se cancelen paddings
  entre secciones).
- No introduzcas dependencias ni pasos de build sin necesidad; el sitio debe
  seguir abriéndose con doble clic.