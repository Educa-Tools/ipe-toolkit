# Esplora · Herramientas para explorar en el aula

Herramientas interactivas y recursos para **Itinerario Personal para la Empleabilidad I y II** (FP), FOL y EIE.

- Web: https://esplora.es (la dirección antigua https://educa-tools.github.io/ipe-toolkit/ sigue funcionando)
- Contacto: contacto@esplora.es

> **No borres ni cambies el archivo `CNAME`** de la raíz: es el que conecta la web con `esplora.es`.

## Cómo está organizado

- `index.html` — la portada. No hace falta tocarla para añadir herramientas.
- `data/estructura.json` — **todo el contenido**, en cuatro bloques:
  - `herramientas`: el catálogo. Cada herramienta tiene un identificador corto y sus datos.
  - `modulos`: IPE 1 e IPE 2 (en el orden en que salen en la portada), con sus unidades y la lista de herramientas de cada una (por identificador, en el orden en que deben aparecer). Cada módulo lleva su `lema` (la frase corta del selector "¿Con qué materia trabajas?") y su `tipo` de recurso.
  - `tipos`: los tipos de recurso del filtro "Tipo de recurso": `herramienta` (herramientas interactivas, las de IPE 2), `aula` (recursos de aula, los de IPE 1) y `material` (materiales didácticos: diapositivas y capítulos). Un tipo con `"proximamente": true` y sin recursos sale como "Próximamente".
  - `etiquetas`: las temáticas del filtro "Temática", también con su lista de herramientas.

Cada recurso toma el tipo de su módulo. Si alguno es de otro tipo (por ejemplo, unas diapositivas de IPE 1), ponle `"tipo": "material"` en su línea de `herramientas`.
- El resto de `.html` — cada herramienta interactiva, independiente.
- `CNAME` — el dominio `esplora.es`. No se toca.

## Añadir una herramienta nueva

1. Sube el archivo `.html` al repo (minúsculas, sin espacios).
2. En `data/estructura.json`, dentro de `"herramientas"`, añade una línea:

```json
"miid": { "titulo": "Nombre", "titular": "El titular de su <em>página</em>", "dibujo": "pestel", "descripcion": "Una frase sobre qué hace.", "url": "archivo.html", "color": "#3E5778" },
```

   - `titular`: el titular grande que sale en la ventanita de la portada. Copia el de la propia herramienta; lo que vaya entre `<em>` y `</em>` sale en cursiva y en su color. Si lo omites, se usa el `titulo`.
   - `dibujo`: el mini dibujo de la ventanita. Elige uno de los que ya existen (`idea`, `ficha`, `estrella`, `canvas`, `pestel`, `porter`, `buyer`, `dafo`, `forma`, `patologias`, `ruta`, `expediente`, `buscador`, `piramide`, `ue`, `contingencias`, `prestaciones`, `nomina`, `balanza`) o pide uno nuevo. Si lo omites, sale un dibujo genérico.

   Campos opcionales para las etiquetas pequeñas de la tarjeta:
   - `minutos`: tiempo aproximado en clase (sale como "≈ 20 min").
   - `guarda`: la clave con la que la herramienta guarda el progreso en el navegador (la que aparece en su código como `KEY = '...'`). Con ella la tarjeta dice "Guarda progreso", y si el alumno ya ha escrito algo, "Empezada"; además sale en "Seguir donde lo dejaste".
   - `informe`: pon `true` si la herramienta saca informe para imprimir o guardar en PDF.

   - `slug`: la dirección de su ficha, `esplora.es/recursos/<slug>/`. En minúsculas, sin tildes y con guiones (`"slug": "cinco-fuerzas-porter"`). **No lo cambies una vez publicado**: rompería los enlaces compartidos.

3. Añade `"miid"` a la lista `"herramientas"` de su unidad (en `modulos`) y de su temática (en `etiquetas`).
4. Ejecuta el generador desde la carpeta del proyecto (PowerShell 7, no hay que instalar nada más):

```
pwsh scripts/generar.ps1
```

   Crea o actualiza la ficha de la herramienta, las páginas `ipe-1/` e `ipe-2/`, el catálogo escrito dentro de la portada, `sitemap.xml` y `llms.txt`, y añade la etiqueta canonical a la herramienta si le falta. Al final avisa si algo no cuadra (una herramienta sin unidad, un slug repetido…). Los archivos generados no se editan a mano: se cambia el JSON y se vuelve a ejecutar.
5. Guarda (commit) y sube a `main`. En uno o dos minutos está en la web.

Usa siempre rutas relativas (`archivo.html`, no `/archivo.html`), para que funcionen tanto en `esplora.es` como en la dirección antigua.

Notas:
- Una unidad con la lista vacía `[]` aparece como "En construcción".
- Una temática sin herramientas no se muestra.
- Separa los elementos con **comas**, sin coma después del último. Si la web muestra un aviso de error, casi siempre es eso.

## Enlaces directos para compartir con la clase

- `https://esplora.es/ipe-1/` e `https://esplora.es/ipe-2/`: página de cada módulo con todos sus recursos.
- `https://esplora.es/recursos/<slug>/`: ficha de un recurso (por ejemplo, `recursos/cinco-fuerzas-porter/`).

Y dentro del catálogo interactivo de la portada:

- `https://esplora.es/#ipe2` abre IPE 2; `#ipe1` abre IPE 1.
- `https://esplora.es/#ipe2-ud1` baja a la Unidad didáctica 1 de IPE 2; `#ipe1-b2` baja al Bloque 2 de IPE 1.
- `https://esplora.es/#catalogo` abre todo el catálogo.
- `#tema-prl` abre el catálogo filtrado por una temática (el `id` de `etiquetas`: `idea`, `mercado`, `viabilidad`, `prl`, `laboral`).
- `#tipo-herramienta`, `#tipo-aula` o `#tipo-material` lo abren filtrado por tipo de recurso.
- En la portada, cada módulo y cada unidad tiene un botón "Copiar enlace" que copia la dirección.

## Nombres de archivo

GitHub Pages distingue mayúsculas: usa siempre minúsculas y sin espacios (`mi_herramienta.html`).
