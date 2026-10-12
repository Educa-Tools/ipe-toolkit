# Educa Tools · IPE Toolkit

Herramientas interactivas y recursos para **Itinerario Personal para la Empleabilidad I y II** (FP).
Web publicada: https://educa-tools.github.io/ipe-toolkit/

## Cómo está organizado

- `index.html` — la portada. No hace falta tocarla para añadir herramientas.
- `data/estructura.json` — **todo el contenido**, en tres bloques:
  - `herramientas`: el catálogo. Cada herramienta tiene un identificador corto y sus datos.
  - `modulos`: IPE 2 e IPE 1, con sus unidades y la lista de herramientas de cada una (por identificador, en el orden en que deben aparecer).
  - `etiquetas`: las temáticas del "Explorar por temática", también con su lista de herramientas.
- El resto de `.html` — cada herramienta interactiva, independiente.

## Añadir una herramienta nueva

1. Sube el archivo `.html` al repo (minúsculas, sin espacios).
2. En `data/estructura.json`, dentro de `"herramientas"`, añade una línea:

```json
"miid": { "titulo": "Nombre", "titular": "El titular de su <em>página</em>", "dibujo": "pestel", "descripcion": "Una frase sobre qué hace.", "url": "archivo.html", "color": "#3E5778" },
```

   - `titular`: el titular grande que sale en la ventanita de la portada. Copia el de la propia herramienta; lo que vaya entre `<em>` y `</em>` sale en cursiva y en su color. Si lo omites, se usa el `titulo`.
   - `dibujo`: el mini dibujo de la ventanita. Elige uno de los que ya existen (`idea`, `ficha`, `estrella`, `canvas`, `pestel`, `porter`, `buyer`, `dafo`, `forma`, `patologias`, `ruta`, `expediente`, `buscador`, `piramide`, `ue`, `contingencias`, `prestaciones`, `nomina`) o pide uno nuevo. Si lo omites, sale un dibujo genérico.

3. Añade `"miid"` a la lista `"herramientas"` de su unidad (en `modulos`) y de su temática (en `etiquetas`).
4. Guarda (commit). En uno o dos minutos está en la web.

Notas:
- Una unidad con la lista vacía `[]` aparece como "En construcción".
- Una temática sin herramientas no se muestra.
- Separa los elementos con **comas**, sin coma después del último. Si la web muestra un aviso de error, casi siempre es eso.

## Nombres de archivo

GitHub Pages distingue mayúsculas: usa siempre minúsculas y sin espacios (`mi_herramienta.html`).
