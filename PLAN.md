# PLAN.md · Revisión integral de Esplora (5 sesiones)

Estado: marca cada casilla al terminar. Una sesión = una rama = un merge solo si cumple su "Hecho cuando".
Dentro de cada sesión se trabaja por **bloques**: Claude termina un bloque, me lo enseña y espera mi OK antes del siguiente.

---

## Sesión 0 · Preparación · rama `sesion-0-base` (30-45 min)
- [x] Añadir a CLAUDE.md la sección de skills de diseño
  > Nota: CLAUDE-revision.md fusionado entero en CLAUDE.md sin quitar nada (dos choques resueltos por el autor: afines «más adelante» y público «secundaria con foco en FP»). CLAUDE-revision.md borrado.
- [x] Inspeccionar el repo: stack, estructura, cómo se genera el catálogo y dónde se guarda el progreso
  > Nota: HTML estático; el catálogo se pinta en el navegador desde `data/estructura.json`; el progreso va en `localStorage`. Detalle en `docs/inventario.md`, apartado 1.
- [x] Medir Lighthouse base (home) y guardar en `docs/lighthouse-base.md`
  > Nota: medido con PageSpeed Insights sobre esplora.es (sin instalar nada). Móvil 96/96/100/100, ordenador 100/96/100/100. Fallan el contraste de `.session-t` y `.step-when`, y `fuentes/fuentes.css` bloquea la carga en móvil.
- [x] Inventario de páginas, rutas y dependencias en `docs/inventario.md`
  > Nota: 24 herramientas, todas en el catálogo; sin peticiones externas en lo publicado. Hay 3 claves de guardado fuera de la regla `esplora…` y una lista de archivos que parecen sobrar (no se ha borrado nada).
- [x] Resolver las "Decisiones pendientes" de CLAUDE.md
  > Nota: las 6 resueltas y anotadas en CLAUDE.md. Para la Sesión 1: Cloudflare Web Analytics por script (no hay proxy activo) y exportar/importar progreso en todas las herramientas; archivar pruebas y branding/ con OK previo.
**Hecho cuando:** base medida, inventario hecho y decisiones anotadas.

## Sesión 1 · Cimientos: rutas + legal · rama `sesion-1-cimientos` (2-3 h)
**Bloque A · Rutas y SEO**
- [ ] URLs reales por materia (`/ipe-1`, `/ipe-2`) y por recurso (`/recursos/<slug>`), sin anclas
- [ ] Prerender del catálogo; fallback `<noscript>` y estado de carga útil
- [ ] `sitemap.xml`, `robots.txt`, canonical
- [ ] Open Graph y Twitter cards
- [ ] Favicon y página 404 propia

**Bloque B · Legal y privacidad**
- [ ] Aviso legal, privacidad, cookies, licencia, accesibilidad, atribuciones
- [ ] Enlaces desde el pie de todas las páginas
- [ ] Banner de cookies solo si hace falta
- [ ] Texto claro sobre dónde se guarda el progreso y tratamiento de menores
- [ ] Textos marcados como BORRADOR pendiente de revisión jurídica
**Hecho cuando:** cada recurso tiene URL, el sitemap los lista y todas las páginas legales existen y enlazan entre sí.

## Sesión 2 · Diseño y home · rama `sesion-2-diseno` (2-3 h)
**Bloque A · Sistema de diseño** (skills: `/apple-design`, `/estetica-rapida`)
- [ ] Tokens (color, tipografía, espaciado, radios, sombras) en un único archivo
- [ ] Componentes base: botón, tarjeta de recurso, etiquetas, filtros, cabecera, pie
- [ ] Iconografía y color por tipo de recurso y materia; contraste revisado

**Bloque B · Home y navegación** (skills: `/animate`, `/emil-design-eng`, `/estetica-rapida`)
- [ ] Hero con una herramienta real en acción
- [ ] Menú reordenado (fusionar Recursos y Catálogo; añadir Cómo se usa, Proyecto, Novedades)
- [ ] Buscador y filtros: materia, unidad, duración, individual/grupal
- [ ] Microinteracciones y gamificación ligera, respetando `prefers-reduced-motion`
**Hecho cuando:** la web usa solo tokens y componentes, y un docente llega a un recurso en menos de 3 clics.

## Sesión 3 · Contenido y confianza · rama `sesion-3-contenido` (2-3 h)
**Bloque A · Fichas y mapa curricular** (skill: `/emil-design-eng` solo sobre la plantilla)
- [ ] Plantilla de ficha de recurso (objetivo, duración, nivel, RA, requisitos, capturas, guía docente, informe PDF de ejemplo, licencia)
- [ ] JSON único de metadatos que alimente catálogo, filtros, fichas y datos estructurados `LearningResource`
- [ ] Página de programación: recurso ↔ unidad ↔ RA de IPE 1 y 2

**Bloque B · Confianza y comunidad** (skill: `/estetica-rapida`)
- [ ] Página Proyecto (con huecos para mis datos)
- [ ] FAQ y "Cómo usarlo en 50 minutos"
- [ ] Formulario de reportar error / sugerir recurso
- [ ] Eliminar placeholders ("Próximamente", "Provisional"); sin testimonios ni cifras inventados
**Hecho cuando:** añadir un recurso es rellenar un JSON y no queda ningún placeholder visible.

## Sesión 4 · QA final · rama `sesion-4-qa` (1-2 h)
- [ ] Listar archivos principales y elegir cuáles auditar
- [ ] `/web-design-guidelines` sobre cada archivo clave
- [ ] Corregir fallos críticos y de accesibilidad
- [ ] Lighthouse + teclado + móvil real a 360 px
- [ ] Simulación de una sesión de 50 min con una herramienta
- [ ] (Solo si lo pido yo) `/review-animations`
**Hecho cuando:** Lighthouse ≥ 90 en las cuatro categorías y cero errores críticos de accesibilidad.

## Sesión 5 (opcional) · Vida del proyecto · rama `sesion-5-vida`
- [ ] Blog/novedades y changelog público
- [ ] Boletín con doble opt-in
- [ ] Asistente de orientación alimentado solo con el catálogo (aviso de IA, sin datos personales)
- [ ] Hoja de ruta pública
