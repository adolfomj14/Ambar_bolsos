# ÁMBAR — Bolsos & Carteras (Catálogo Web + Panel Admin)

Catálogo digital interactivo para **ÁMBAR — Bolsos & Carteras**, con visor de fotos con zoom táctil/clic, soporte para vista 360°, sistema de rebajas/promociones en todos los precios expuestos, y panel de administración con guardado en tiempo real y publicación automática.

---

## 📁 Estructura del Proyecto

| Archivo / Carpeta | Descripción |
|---|---|
| `index.html` | Catálogo público principal. Muestra la portada (Hero), la grilla de productos, el modal de detalle con galería y zoom, y el enlace directo a WhatsApp e Instagram. |
| `admin.html` | Panel de administración (`/admin`). Permite crear, editar, ocultar o eliminar bolsos, gestionar el stock, aplicar rebajas/descuentos a cualquier precio de la página y configurar los textos de la marca. |
| `products.js` | Base de datos del catálogo (`window.CATALOG_DATA`). Contiene la configuración general (`settings`) y la lista de productos (`products`). |
| `assets/` | Carpeta de imágenes optimizadas para web (`assets/logo.jpg` y `assets/bolsos/*.jpg`). |
| `vercel.json` | Configuración de rutas (`/admin` → `/admin.html`), redirecciones y encabezados sin caché para despliegue en Vercel. |
| `_redirects` / `_headers` | Reglas equivalentes de rutas y control de caché para Netlify. |
| `convertir_fotos.bat` | Script auxiliar para convertir fotos `.heic` a `.jpg` y comprimirlas para carga rápida. |

---

## ⚡ Cómo Funciona el Guardado en Tiempo Real

El proyecto mantiene sincronizados el **Panel Admin** (`admin.html`) y el **Catálogo** (`index.html`) siguiendo esta arquitectura:

1. **Sincronización instantánea en el navegador (`localStorage` + `BroadcastChannel`):**
   - Cada vez que guardas un producto, una rebaja o una sección de configuración en `admin.html`, se almacena inmediatamente en `localStorage` (`AMBAR_CATALOG_DATA_V1`) con marca de tiempo (`_savedAt`) y se emite por el canal en vivo `BroadcastChannel('ambar_catalog_sync')`.
   - Si tienes el catálogo (`index.html`) abierto en otra pestaña, **todos los precios, descuentos, textos y productos se actualizan al instante sin necesidad de recargar**.
2. **Publicación automática en la web (GitHub API → Vercel / Netlify):**
   - Al conectar el repositorio de GitHub desde el botón **⚙ Conectar web** en la barra superior de `admin.html`, cada cambio guardado actualiza automáticamente el archivo `products.js` en GitHub (o al pulsar **🚀 Publicar**).
   - También puedes descargar `products.js` manualmente en cualquier momento con el botón **⬇ Descargar products.js**.

---

## 🏷️ Sistema de Rebajas y Promociones (Todos los Precios de la Página)

Todos los precios visibles en el catálogo soportan descuentos con **precio original tachado**, **etiqueta con el porcentaje de descuento (`-X%` / `-X% OFF`)** y **precio total con descuento**:

### Precios contemplados en el catálogo (`index.html`)
1. **Insignia del bolso destacado en la Portada (Hero Badge):**
   - Muestra el precio original tachado, la píldora `-X%` y el precio final rebajado.
   - Si no se configura un descuento independiente en la portada pero el bolso destacado coincide por nombre con un producto del catálogo que tiene rebaja activa, toma automáticamente su descuento.
2. **Tarjetas de productos en la grilla del catálogo:**
   - Muestra arriba el precio original tachado junto a la etiqueta roja `-X%`, y debajo el precio final con descuento en `COP`.
   - Si el producto no tiene otro badge asignado y está disponible, muestra también la insignia `-X% OFF` sobre la foto.
3. **Ventana modal de detalle del producto:**
   - Muestra el precio original tachado, la insignia `-X% OFF` y el precio final en grande.
4. **Mensaje de consulta por WhatsApp:**
   - Al pulsar *Consultar por WhatsApp*, el mensaje automático incluye el precio final rebajado, el porcentaje de descuento y el precio anterior.

### Formas de aplicar o modificar rebajas desde el Admin (`admin.html`)
1. **Gestor rápido de todos los precios (`🏷️ Rebajas` en la barra superior o en cada tarjeta):**
   - Abre una tabla con **el bolso destacado de la portada y todos los productos del catálogo**.
   - Permite modificar el **Precio Original**, el **% de Descuento** o el **Precio Final** (se calculan mutuamente en automático) o aplicar un descuento masivo (`-10%`, `-15%`, `-20%`, `-30%`, `-50%` o quitar todas las rebajas) y guardar todo de una sola vez.
2. **Desde el editor individual de cada producto (`✏ Editar`):**
   - Debajo de *Precio Original (COP)*, activa el interruptor **🏷️ Activar promoción / descuento**.
   - Escribe el **Descuento (%)** o el **Precio final con descuento (COP)** y verás la vista previa en vivo con el ahorro calculado antes de pulsar **Guardar Producto**.
3. **Desde Configuración → Hero (Página Principal):**
   - Debajo de *Bolso destacado (nombre)* y *Precio bolso destacado (COP)*, activa **🏷️ Rebaja en bolso destacado de portada** y pulsa **Guardar Hero**.

---

## 🔐 Acceso al Panel de Administración

- **URL en línea:** `https://tu-dominio.vercel.app/admin` (o abriendo `admin.html`).
- **Contraseña actual:** configurada en `products.js` (`settings.adminPassword`), modificable desde **Configuración → Seguridad**.
