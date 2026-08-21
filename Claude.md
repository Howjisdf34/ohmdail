# Ohmdail — Sitio web de trabajos independientes

Contexto del proyecto para continuar el desarrollo. Deja este archivo en la raíz
de la carpeta del proyecto; Claude Code lo lee automáticamente.

## Qué es

Página web de una persona (José Ángel Hernández Amaya, marca **Ohmdail**) que
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
  nombre:   "...",           // nombre o negocio
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
  sombras y desenfoques, para celulares de gama baja. Se **enciende solo** si
  detecta equipo limitado (`navigator.connection.saveData`, `effectiveType` 2g,
  `deviceMemory <= 2`, `hardwareConcurrency <= 2`). También persiste en
  `localStorage`. La clase que lo activa es `body.eco`.
- Respeta `prefers-reduced-motion` de forma independiente (media query que anula
  animaciones).
- Focus visible en teclado, `aria-label`s en botones, responsive con breakpoints
  a 900px y 640px.

## Animaciones

- Entrada del hero: líneas con reveal (clip) + `fade-up`, con la clase `loaded`
  que se agrega en `requestAnimationFrame`.
- Cinta ("marquee") de servicios en movimiento continuo.
- Reveal al hacer scroll vía `IntersectionObserver`: elementos con clase `.obs`
  reciben `.in`.
- Tarjetas de servicio: al pasar el cursor se "pintan" de azul (pseudo-elemento
  `::after` que sube con `translateY`).

Todas las animaciones se apagan bajo `body.eco` y bajo `prefers-reduced-motion`.
Si agregas animaciones nuevas, respeta esos dos apagados.

## Galería de trabajos

6 recuadros `.shot` con placeholder (`.ph`, malla + ícono). **Para poner fotos
reales:** dentro de cada `.shot`, reemplaza el `<div class="ph">...</div>` por
`<img src="foto.jpg" alt="descripción">`. Relación de aspecto 4/5. Hay un
comentario `PARA PONER TUS FOTOS` en el HTML que lo indica.

## Pendientes / próximos pasos sugeridos

- Sustituir los placeholders de la galería por fotos reales de trabajos.
- Confirmar que `CONFIG` tenga nombre, ciudad, teléfono (con lada 52) y correo.
- Publicar en `ohmdail.com` / `www.ohmdail.com` (hosting estático; solo suben
  `index.html` y las fotos). Configurar DNS con el proveedor del dominio.
- Opcional: nota visible tipo "La visita y el presupuesto son gratis, sin
  compromiso" junto al botón principal.
- Opcional: sección de reseñas/testimonios de clientes.

## Convenciones al editar

- Mantén todo en un solo archivo autónomo salvo que se pida separar.
- Español mexicano, claro y directo. Los botones dicen exactamente qué pasa
  ("Agendar visita", no "Enviar").
- Cuida la especificidad de los selectores CSS (evita que se cancelen paddings
  entre secciones).
- No introduzcas dependencias ni pasos de build sin necesidad; el sitio debe
  seguir abriéndose con doble clic.