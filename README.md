# Educa Tools · IPE Toolkit

Herramientas interactivas y recursos para **Itinerario Personal para la Empleabilidad I y II** (FP).
Web publicada: https://educa-tools.github.io/ipe-toolkit/

## Cómo está organizado

- `index.html` — la portada. No hace falta tocarla para añadir contenido.
- `data/estructura.json` — **todo el contenido**: módulos, unidades y los recursos de cada unidad.
- El resto de `.html` — cada herramienta interactiva, independiente.

## Añadir un recurso a una unidad

1. Abre `data/estructura.json` (desde la app de GitHub: el archivo → lápiz de editar).
2. Busca la unidad (por su `"titulo"`).
3. Dentro de la pestaña que toque (`"herramientas"`, `"teoria"`, `"presentaciones"` o `"fichas"`), añade un bloque:

```json
{ "titulo": "Nombre del recurso", "descripcion": "Una frase sobre qué es.", "url": "archivo.html" }
```

- `url` puede ser un archivo del repo (`pestel.html`) o un enlace externo (`https://…`, se abre en pestaña nueva).
- `descripcion` y `color` (por ejemplo `"#3E5778"`) son opcionales.
- Si ya hay otro bloque en esa lista, sepáralos con una **coma**. Sin coma después del último.

4. Guarda (commit). En uno o dos minutos está en la web.

Si la sección de módulos sale con un aviso de error, casi siempre es una coma o una llave de más o de menos en el JSON.

## Nombres de archivo

GitHub Pages distingue mayúsculas: usa siempre minúsculas y sin espacios (`mi_herramienta.html`).
