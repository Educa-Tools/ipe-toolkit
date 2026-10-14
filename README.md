# Esplora Labs · Herramientas educativas

Herramientas interactivas y recursos para **Itinerario Personal para la Empleabilidad I y II** (FP).
Web publicada: https://educa-tools.github.io/ipe-toolkit/

## Cómo está organizado

- `index.html` — la portada. No hace falta tocarla para añadir herramientas.
- `data/estructura.json` — **todo el contenido**, en tres bloques:
  - `herramientas`: el catálogo. Cada herramienta tiene un identificador corto y sus datos.
  - `modulos`: IPE 1 e IPE 2 (en el orden en que salen en la portada), con sus unidades y la lista de herramientas de cada una (por identificador, en el orden en que deben aparecer).
  - `etiquetas`: las temáticas del "Explorar por temática", también con su lista de herramientas.
- El resto de `.html` — cada herramienta interactiva, independiente.

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

3. Añade `"miid"` a la lista `"herramientas"` de su unidad (en `modulos`) y de su temática (en `etiquetas`).
4. Guarda (commit). En uno o dos minutos está en la web.

Notas:
- Una unidad con la lista vacía `[]` aparece como "En construcción".
- Una temática sin herramientas no se muestra.
- Separa los elementos con **comas**, sin coma después del último. Si la web muestra un aviso de error, casi siempre es eso.

## Enlaces directos para compartir con la clase

- `…/ipe-toolkit/#ipe2` abre IPE 2; `#ipe1` abre IPE 1.
- `…/ipe-toolkit/#ipe2-ud1` baja a la Unidad didáctica 1 de IPE 2; `#ipe1-b2` baja al Bloque 2 de IPE 1.
- En la portada, cada módulo y cada unidad tiene un botón "Copiar enlace" que copia la dirección.

## Nombres de archivo

GitHub Pages distingue mayúsculas: usa siempre minúsculas y sin espacios (`mi_herramienta.html`).
