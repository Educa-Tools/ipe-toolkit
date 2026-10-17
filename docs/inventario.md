# Inventario de Esplora (Sesión 0)

Foto del repositorio a 17 oct 2026, rama `sesion-0-base` (sale de `main`, commit `14f4604`). Solo se describe: no se ha borrado ni movido nada.

## 1. Cómo funciona la web

- **Web estática.** HTML sueltos en la raíz, sin `package.json`, sin `src` y sin sistema de compilación. GitHub Pages publica `main` tal cual en https://esplora.es.
- **Catálogo.** `index.html` lee `data/estructura.json` con `fetch` y pinta en el navegador los módulos, las fichas y los filtros. Sin JavaScript, el catálogo no aparece. `404.html` lee el mismo JSON para sugerir una herramienta al azar.
- **Rutas.** Hay una sola página para todo el catálogo; las «secciones» son anclas (`#ipe1`, `#ipe2-ud1`, `#catalogo`, `#tema-prl`, `#tipo-aula`…). Cada herramienta tiene su propio archivo (`pestel.html`, etc.). No hay `sitemap.xml`, `robots.txt`, canonical ni `LICENSE`.
- **Guardado del progreso.** Cada herramienta guarda en el `localStorage` del navegador del alumno (no sale del equipo; no hay servidor). La portada lee esas claves (campo `guarda` del JSON) para marcar «Empezada» y «Seguir donde lo dejaste». Un script al inicio de las páginas copia las claves antiguas `educa…` a `esplora…`.
- **Metadatos de la portada.** Ya tiene `description`, Open Graph y Twitter card (`summary`, sin imagen). Las herramientas no los tienen.

## 2. Páginas publicadas

| Archivo | Qué es |
|---|---|
| `index.html` | Portada y catálogo (86 KB) |
| `404.html` | Página «no encontrado» |
| `CNAME` | Dominio esplora.es (**no tocar**) |

## 3. Herramientas (24, todas registradas en `data/estructura.json`)

Leyenda: **Guarda** = clave de `localStorage`. **Libs** = qué carga de `lib/`. Todas cargan `fuentes/fuentes.css`.

### IPE 2 · Herramientas interactivas

| UD | id JSON | Archivo | Título | Min | Guarda | Informe | Libs | Peso |
|---|---|---|---|---|---|---|---|---|
| 1 | generador | `generador.html` | Generador de ideas de negocio | 30 | esplora-generador-v1 | – | – | 296 KB |
| 1 | fichaidea | `fichaidea.html` | Ficha inicial de la idea | 20 | ficha-idea-draft-v1 ⚠ | – | jsPDF | 29 KB |
| 1 | estrella | `estrella.html` | Matriz Estrella | 25 | esplora-estrella-v1 | Sí | – | 46 KB |
| 1 | canvas | `modelocanvas.html` | Modelo Canvas | 50 | esplora-canvas-v1 | Sí | – | 37 KB |
| 2 | pestel | `pestel.html` | Análisis PESTEL (mapa de impacto) | 40 | esplora-pestel-v1 | Sí | – | 84 KB |
| 2 | porter | `porter.html` | Análisis PORTER | 30 | esplora-porter-v1 | Sí | – | 72 KB |
| 2 | buyer | `buyerpersona.html` | Buyer Persona | 30 | esplora_buyer_persona_v1 | Sí | – | 77 KB |
| 2 | dafocame | `dafocame.html` | DAFO y CAME | 45 | esplora-dafocame-v1 | Sí | – | 75 KB |
| 3 | formajuridica | `selector_forma_juridica.html` | Selector de forma jurídica | 20 | esplora-formajuridica-v1 | Sí | – | 109 KB |
| 3 | inversion | `inversionfinanciacion.html` | Plan de inversión y financiación | 50 | esplora-expediente ⚠ | Sí | jsPDF + html2canvas | 105 KB |
| 3 | umbral | `umbralrentabilidad.html` | Umbral de rentabilidad | 40 | esplora-umbral-v1 (+ lee esplora-expediente) | Sí | jsPDF + html2canvas | 103 KB |
| 4 | — | — | *Empleabilidad e inserción laboral: sin recursos* | | | | | |

### IPE 1 · Recursos de aula

| Bloque | id JSON | Archivo | Título | Min | Guarda | Informe | Peso |
|---|---|---|---|---|---|---|---|
| 1 | patologias | `patologias.html` | Diagnóstico de patologías inespecíficas | 15 | – | – | 25 KB |
| 1 | ruta22 | `rutaarticulo22.html` | Ruta al Artículo 22 | 25 | ipe_ruta_art22_progreso_v1 ⚠ | – | 37 KB |
| 1 | simuladorprl | `simuladorprl.html` | Simulador de expedientes PRL | 30 | ipe-expedientes-prl-v1 ⚠ | – | 42 KB |
| 1 | enfprofesionales | `enfermedadesprofesionales.html` | Buscador de enfermedades profesionales | 10 | – | – | 27 KB |
| 1 | guiaruido | `guia-ruido.html` | Guía del ruido | 40 | esplora-guia-ruido-v1 | Sí | 71 KB |
| 1 | guialuz | `guia-iluminacion.html` | Guía de la iluminación | 40 | esplora-guia-iluminacion-v1 | Sí | 69 KB |
| 1 | guiavib | `guia-vibraciones.html` | Guía de las vibraciones | 35 | esplora-guia-vibraciones-v1 | Sí | 62 KB |
| 1 | guiatermo | `guia-termohigrometricas.html` | Guía de las condiciones termohigrométricas | 40 | esplora-guia-termohigrometricas-v1 | Sí | 67 KB |
| 2 | piramide | `piramide.html` | Pirámide de la jerarquía normativa | 10 | – | – | 17 KB |
| 2 | mapaue | `mapaeuropa.html` | Mapa interactivo de la Unión Europea | 15 | – | – | 279 KB |
| 2 | contingencias | `determinacioncontingencias.html` | Wizard de determinación de contingencias | 15 | – | – | 43 KB |
| 2 | prestaciones | `prestaciones.html` | Prestaciones de la Seguridad Social | 40 | esplora-prestaciones-v1 | Sí | 76 KB |
| 2 | casosnomina | `casosnomina.html` | Casos prácticos de nóminas | 45 | esplora-casosnomina-v1 | Sí | 44 KB |
| 3 | — | — | *Autoconocimiento e itinerario profesional: sin recursos* | | | | |

**Materiales didácticos** (diapositivas, capítulos): ninguno todavía.

⚠ Claves de guardado que no siguen la regla de empezar por `esplora`: `ficha-idea-draft-v1`, `ipe_ruta_art22_progreso_v1`, `ipe-expedientes-prl-v1`. Cambiarlas exige migrar el progreso guardado; no se ha tocado. `esplora-expediente` se comparte a propósito entre inversión y umbral (expediente común de viabilidad).

Temáticas del filtro (`etiquetas`): idea, mercado, viabilidad, prl, laboral. Coinciden 1:1 con las unidades/bloques con contenido.

## 4. Dependencias

| Carpeta / archivo | Contenido | Quién lo usa |
|---|---|---|
| `fuentes/fuentes.css` + 7 `.woff2` | Fraunces (normal y cursiva) e Inter, alojadas en el repo, con sus licencias OFL | Portada, 404 y las 24 herramientas |
| `lib/jspdf.umd.min.js` (356 KB) | Generar PDF | fichaidea, inversionfinanciacion, umbralrentabilidad |
| `lib/html2canvas.min.js` (194 KB) | Captura de pantalla para el PDF | inversionfinanciacion, umbralrentabilidad |
| `data/estructura.json` | Catálogo | index.html, 404.html |

- **Peticiones externas en lo publicado:** ninguna. Solo hay enlaces normales a BOE, SEPE y Seguridad Social (prestaciones, casosnomina, enfermedadesprofesionales). Los `http://www.w3.org` son espacios de nombres de SVG, no peticiones.
- **Nota de identidad:** las fuentes alojadas son las del kit anterior (Fraunces/Inter). CLAUDE.md marca `system-ui` como tipografía nueva; el cambio está pendiente y requiere confirmación.

## 5. Placeholders visibles detectados (para la Sesión 3)

- `index.html`, contacto: «LinkedIn · Próximamente» con insignia «Provisional».
- `index.html`: unidades vacías muestran «En construcción» (IPE 1 bloque 3, IPE 2 UD 4).
- `index.html`: el tipo «Materiales didácticos» sale como «Próximamente».
- (`porter.html` usa «Provisional» en el sentido de puntuación parcial; no es un placeholder.)

## 6. Archivos que parecen sobrar · NO se ha borrado ni movido nada

Ninguno de estos se publica: o están en `.gitignore` o no están en git.

| Archivo | Por qué parece sobrar | Riesgo si se borra |
|---|---|---|
| `index-prueba.html` | Borrador antiguo de portada («Esplora Labs»), usa Google Fonts | Ninguno en la web (ignorado en git) |
| `index-renovada.html` | Borrador antiguo de portada, usa Google Fonts | Igual |
| `index-renovada-2.html` | Borrador antiguo de portada, usa Google Fonts | Igual |
| `~$ceto organización web.docx` | Temporal de Word (archivo abierto) | Ninguno; desaparece al cerrar Word |
| `~$ignaturas y modulos target.docx` | Temporal de Word | Igual |
| `branding/brand-kit-especificacion.md` | Kit de marca anterior («Esplora Labs»); **sí está en git y se publica** | Ninguno técnico; contiene la identidad antigua |

Para tener en cuenta, pero **no sobran**:

- `salario-nomina.html` y `salario-nomina-profesor.html`: ignorados en git porque llevan una nómina con datos personales reales. No están en el catálogo. Cargan Google Fonts (incumple la regla de fuentes locales si algún día se publican).
- `esplora-contexto-claude-code.md`, `Boceto organización web.docx`, `Asignaturas y modulos target.docx`: material de referencia, ignorados en git.
- `.claude/`: configuración local de Claude Code, ignorada en git.
