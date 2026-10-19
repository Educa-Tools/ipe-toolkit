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
**Bloque A · Rutas y SEO** (skills: `/seo-audit`, `/ai-seo`, `/site-architecture`)
- [ ] URLs reales por materia (`/ipe-1`, `/ipe-2`) y por recurso (`/recursos/<slug>`), sin anclas
- [ ] Prerender del catálogo; fallback `<noscript>` y estado de carga útil. Prioritario: hoy Google y los buscadores de IA que no ejecutan JavaScript solo ven «Cargando el catálogo…»
- [ ] `sitemap.xml`, `robots.txt`, canonical
  > Nota: `robots.txt` hecho (todo abierto, incluidos los asistentes de IA; solo se excluyen `docs/` y los .md internos). Al crear el sitemap hay que añadir su línea `Sitemap:`.
- [ ] `llms.txt`: lista sencilla de las herramientas, una línea cada una, para los buscadores de IA
- [x] Nombres de las herramientas con un único patrón (fuera anglicismos como «Wizard» o «Creator», sin mayúsculas sueltas como «PORTER») y título de pestaña «Nombre claro · Esplora» en las 24
  > Nota: títulos de pestaña con la palabra que busca un docente y la norma cuando la hay (p. ej. «Guía del ruido en el trabajo (RD 286/2006) · Esplora»). En el catálogo, «Análisis de Porter» y «Asistente de determinación de contingencias».
- [x] Descripción propia en las 24 herramientas (hoy 17 no tienen)
  > Nota: 19 descripciones nuevas o reescritas (unos 150 caracteres, dicen que es gratis); se mantienen las 5 que ya estaban bien (ficha de la idea, pirámide, mapa UE, prestaciones y nóminas).
- [ ] Open Graph y Twitter cards
  > Nota: la portada ya los tiene; faltan las 24 herramientas y la imagen para compartir (pendiente de la marca).
- [x] Favicon y página 404 propia
  > Nota: hechos fuera del plan con el logotipo nuevo (commits 3212ed2, ec39eb8 y adee401).
- [ ] Dar de alta esplora.es en Google Search Console (lo hace el autor; si se verifica por DNS, se toca Cloudflare con confirmación)

**Bloque B · Legal y privacidad**
- [ ] Aviso legal, privacidad, cookies, licencia, accesibilidad, atribuciones
- [ ] Enlaces desde el pie de todas las páginas
- [ ] Banner de cookies solo si hace falta
- [ ] Texto claro sobre dónde se guarda el progreso y tratamiento de menores
- [ ] Textos marcados como BORRADOR pendiente de revisión jurídica
**Hecho cuando:** cada recurso tiene URL, título y descripción propios, el sitemap los lista y todas las páginas legales existen y enlazan entre sí.

## Sesión 2 · Diseño y home · rama `sesion-2-diseno` (2-3 h)
**Bloque A · Sistema de diseño** (skills: `/apple-design`, `/estetica-rapida`)
- [ ] Tokens (color, tipografía, espaciado, radios, sombras) en un único archivo
- [ ] Componentes base: botón, tarjeta de recurso, etiquetas, filtros, cabecera, pie
- [ ] Iconografía y color por tipo de recurso y materia; contraste revisado

**Bloque B · Home y navegación** (skills: `/animate`, `/emil-design-eng`, `/estetica-rapida`, `/copywriting`, `/site-architecture`)
- [ ] Hero con una herramienta real en acción
- [ ] Texto de la portada: decir que es gratis, para quién es y qué se lleva el alumnado (se abre en el navegador, guarda el progreso, genera un informe)
- [ ] Concretar frases abstractas: «segunda visión» con un ejemplo real de una herramienta y la cifra exacta de herramientas con informe en lugar de «muchas»
- [ ] Menú reordenado (fusionar Recursos y Catálogo; añadir Cómo se usa, Proyecto, Novedades) y pie sin enlaces duplicados («Explorar el catálogo» / «Explorar»)
- [ ] Tarjetas: sin el nombre repetido dos veces («Guía del ruido / Guía del ruido»), titular en forma de pregunta en todas y «Bloque 1» en lugar de «B1»
- [ ] Tipos de recurso según lo que hace el alumnado (p. ej. «Construye tu proyecto», «Aprende y practica», «Repasa jugando») en lugar de atarlos a IPE 1 / IPE 2. Decide el autor antes: cambia lo que dice CLAUDE.md
- [ ] Buscador y filtros: materia, unidad, duración, individual/grupal
- [ ] Microinteracciones y gamificación ligera, respetando `prefers-reduced-motion`
**Hecho cuando:** la web usa solo tokens y componentes, y un docente llega a un recurso en menos de 3 clics.

## Sesión 3 · Contenido y confianza · rama `sesion-3-contenido` (2-3 h)
**Bloque A · Fichas y mapa curricular** (skills: `/emil-design-eng` solo sobre la plantilla, `/schema`, `/ai-seo`)
- [ ] Plantilla de ficha de recurso (objetivo, duración, nivel, RA, requisitos, capturas, guía docente, informe PDF de ejemplo, licencia), con su apartado «Cómo usarlo en 50 minutos»
- [ ] JSON único de metadatos que alimente catálogo, filtros, fichas y datos estructurados `LearningResource`
- [ ] Datos estructurados escritos en la propia página (no generados con JavaScript): `LearningResource` en cada recurso (gratuito, FP, duración, licencia, español) y `WebSite` + `Organization` en la portada
- [ ] Página de programación: recurso ↔ unidad ↔ RA de IPE 1 y 2
- [ ] Materias de secundaria del documento «Asignaturas y modulos target» (IAEE, FAG, FOPP de 4.º ESO, Economía y Emprendimiento): etiquetar cada herramienta con las materias donde encaja y que «Doy otra materia» muestre esa lista. Decide el autor antes: CLAUDE.md dice «sin materias afines por ahora»

**Bloque B · Confianza y comunidad** (skills: `/estetica-rapida`, `/copywriting`)
- [ ] Página Proyecto (con huecos para mis datos) y una línea, sin foto, sobre quién lo hace: un docente de FP que usa estos recursos en su aula
- [ ] FAQ y "Cómo usarlo en 50 minutos"
- [ ] Formulario de reportar error / sugerir recurso
- [ ] Eliminar placeholders ("Próximamente", "Provisional"); sin testimonios ni cifras inventados
  > Hoy están en: «LinkedIn · Próximamente / Provisional» (contacto y pie), la tarjeta «Materiales didácticos · Próximamente» y «(próximamente)» en el filtro de tipo. Se puede adelantar a cualquier sesión: es un arreglo rápido.
**Hecho cuando:** añadir un recurso es rellenar un JSON y no queda ningún placeholder visible.

## Sesión 4 · QA final · rama `sesion-4-qa` (1-2 h)
- [ ] Listar archivos principales y elegir cuáles auditar
- [ ] `/web-design-guidelines` sobre cada archivo clave
- [ ] Corregir fallos críticos y de accesibilidad
- [ ] Lighthouse + teclado + móvil real a 360 px
- [ ] `/seo-audit` final y comprobar que el catálogo y las fichas se leen sin JavaScript (lo que ven Google y los buscadores de IA)
- [ ] Simulación de una sesión de 50 min con una herramienta
- [ ] (Solo si lo pido yo) `/review-animations`
**Hecho cuando:** Lighthouse ≥ 90 en las cuatro categorías y cero errores críticos de accesibilidad.

## Sesión 5 (opcional) · Vida del proyecto · rama `sesion-5-vida`
- [ ] Blog/novedades y changelog público
- [ ] Boletín con doble opt-in
- [ ] Asistente de orientación alimentado solo con el catálogo (aviso de IA, sin datos personales)
- [ ] Hoja de ruta pública
- [ ] Difusión fuera de la web: publicar los recursos en Procomún (INTEF) y en LinkedIn, que es de donde las IA sacan lo que citan (skill: `/ai-seo`)
