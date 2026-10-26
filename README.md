# Esplora · Herramientas para explorar en el aula

Herramientas interactivas y recursos para **Itinerario Personal para la Empleabilidad I y II** (FP), FOL y EIE.

- Web: https://esplora.es (la dirección antigua https://educa-tools.github.io/ipe-toolkit/ sigue funcionando)
- Contacto: contacto@esplora.es

> **No borres ni cambies el archivo `CNAME`** de la raíz: es el que conecta la web con `esplora.es`.

## Cómo está organizado

- `index.html` — la portada. Está escrita a mano, pero lo que sale del catálogo (menú, caminos, índice, cifras, pie) lo rellena el generador entre marcas `<!-- generado:… -->`. No hace falta tocarla para añadir herramientas. Las cuatro ventanitas de «Cómo se usa» se eligen en su `data-herramientas`.
- `trabajar/`, `emprender/`, `materias/`, `criterios/`, `ipe-1/`, `ipe-2/` y `recursos/<slug>/` — páginas que escribe el generador. No se editan a mano.
- `estilos/` — `esplora.css` (colores y medidas, con modo oscuro en las páginas con la clase `tema-auto`), `comun.css` (menú, botones, ventanitas, banda y pie), `portada.css` y `paginas.css`.
- `js/` — `esplora.js` (menú, mini dibujos, alturas iguales y buscador de los caminos), `miniaturas.js` (símbolo, iconos y dibujos de las ventanitas) y `portada.js` (lo propio de la portada y los enlaces antiguos con #).
- `data/estructura.json` — **todo el contenido**, en cinco bloques:
  - `herramientas`: el catálogo. Cada herramienta tiene un identificador corto y sus datos, entre ellos `camino` y `tema` (dónde vive: ver `caminos`). Dentro de un tema, las herramientas salen en el orden en que están escritas aquí.
  - `caminos`: la estructura principal. Dos caminos («Trabajo por cuenta ajena» y «Emprendimiento»), cada uno con su leyenda y sus temas (`id`, nombre y resumen). Un tema sin herramientas no se muestra. `antes` guarda el nombre corto antiguo del tema para que los enlaces viejos (`#tema-prl`) sigan funcionando.
  - `materias` (antes `modulos`): IPE 1 e IPE 2, con sus bloques o unidades y la lista de herramientas de cada uno (por identificador). Una materia nueva puede citar herramientas que ya existen, sin duplicarlas. Cada materia lleva su `lema` y su `tipo` de recurso.
  - `curriculo`: resultados de aprendizaje y criterios de evaluación (de momento, IPE 2), con las herramientas que trabajan cada criterio; `"parcial": true` si lo trabaja sin cubrirlo entero.
  - `tipos`: los tipos de recurso, según el boceto: `herramienta` (herramientas interactivas: se usan en el navegador, guardan lo que escribe el alumnado y la mayoría dan un informe) y `material` (materiales didácticos: píldoras, guías, casos prácticos, boletines y diapositivas). Un tipo sin ningún recurso no se muestra en la portada; con un solo tipo con recursos, tampoco sale el desplegable «Tipo».

Cada recurso toma el tipo de su módulo. Si alguno es de otro tipo (por ejemplo, unas diapositivas de IPE 1), ponle `"tipo": "material"` en su línea de `herramientas`.
- El resto de `.html` — cada herramienta interactiva, independiente.
- `CNAME` — el dominio `esplora.es`. No se toca.

## Añadir una herramienta nueva

1. Sube el archivo `.html` al repo (minúsculas, sin espacios).
2. En `data/estructura.json`, dentro de `"herramientas"`, añade una línea:

```json
"miid": { "titulo": "Nombre", "titular": "El titular de su <em>página</em>", "pregunta": "¿Qué pregunta <em>responde</em>?", "dibujo": "pestel", "descripcion": "Una frase sobre qué hace.", "url": "archivo.html", "color": "#3E5778" },
```

   - `titular`: el titular grande de la ficha del recurso (`recursos/<slug>/`). Copia el de la propia herramienta; lo que vaya entre `<em>` y `</em>` sale en cursiva y en su color. Si lo omites, se usa el `titulo`.
   - `pregunta`: el titular de su ventanita en los caminos, las materias y las fichas (y en la 404), siempre en forma de pregunta y sin repetir el nombre, que ya sale en la barra de la tarjeta. Si lo omites, se usa el `titular`.
   - `dibujo`: el mini dibujo de la ventanita. Elige uno de los que ya existen (`idea`, `ficha`, `estrella`, `canvas`, `pestel`, `porter`, `buyer`, `dafo`, `forma`, `patologias`, `ruta`, `expediente`, `buscador`, `piramide`, `ue`, `contingencias`, `prestaciones`, `nomina`, `balanza`) o pide uno nuevo. Si lo omites, sale un dibujo genérico.

   Campos opcionales para las etiquetas pequeñas de la tarjeta:
   - `minutos`: tiempo aproximado en clase (sale como "≈ 20 min").
   - `guarda`: la clave con la que la herramienta guarda el progreso en el navegador (la que aparece en su código como `KEY = '...'`). Con ella la tarjeta dice "Guarda progreso", y si el alumno ya ha escrito algo, "Empezada"; además sale en "Seguir donde lo dejaste".
   - `informe`: pon `true` si la herramienta saca informe para imprimir o guardar en PDF.

   - `slug`: la dirección de su ficha, `esplora.es/recursos/<slug>/`. En minúsculas, sin tildes y con guiones (`"slug": "dafo-came"`). **No lo cambies una vez publicado**: rompería los enlaces compartidos.

3. Ponle en su línea `"camino"` y `"tema"` (los `id` de `caminos`, por ejemplo `"camino": "emprender", "tema": "mercado"`) y añade `"miid"` a la lista `"herramientas"` de su unidad (en `materias`). Si trabaja algún criterio de evaluación, añádela también en `curriculo`.
4. Ejecuta el generador desde la carpeta del proyecto (PowerShell 7, no hay que instalar nada más):

```
pwsh scripts/generar.ps1
```

   Crea o actualiza su ficha, su camino y su tema, `materias/`, `criterios/`, `ipe-1/` e `ipe-2/`, el menú y el índice de la portada, `sitemap.xml` y `llms.txt`, y añade la etiqueta canonical a la herramienta si le falta. Al final avisa si algo no cuadra (una herramienta sin camino o tema, un criterio que cita una herramienta que no existe, un slug repetido…). Los archivos generados no se editan a mano: se cambia el JSON y se vuelve a ejecutar.
5. Guarda (commit) y sube a `main`. En uno o dos minutos está en la web.

Usa siempre rutas relativas (`archivo.html`, no `/archivo.html`), para que funcionen tanto en `esplora.es` como en la dirección antigua.

Notas:
- Un tema, un bloque o una unidad sin herramientas no se muestra (lo que no existe no se enseña).
- Separa los elementos con **comas**, sin coma después del último. Si la web muestra un aviso de error, casi siempre es eso.

## Enlaces directos para compartir con la clase

- `https://esplora.es/trabajar/` y `https://esplora.es/emprender/`: cada camino con sus temas. `#` + el `id` del tema baja a él (`emprender/#mercado`, `trabajar/#prevencion`).
- `https://esplora.es/materias/`, `https://esplora.es/ipe-1/` e `https://esplora.es/ipe-2/`: por materia; `ipe-1/#b2` o `ipe-2/#ud1` bajan a un bloque o una unidad.
- `https://esplora.es/criterios/`: por resultados de aprendizaje y criterios de evaluación.
- `https://esplora.es/recursos/<slug>/`: ficha de una herramienta (por ejemplo, `recursos/dafo-came/`).
- `https://esplora.es/#todas`: el índice completo de la portada.

Los enlaces antiguos de la portada siguen funcionando: `#ipe1` y `#ipe2` llevan a `ipe-1/` e `ipe-2/`; `#ipe2-ud1` o `#ipe1-b2`, al tema equivalente; `#tema-prl` y compañía (el campo `antes` de cada tema), a su tema; `#catalogo`, `#tematicas` y `#tipo-…`, al índice. Lo resuelve `js/portada.js` con los datos que escribe el generador.

## Nombres de archivo

GitHub Pages distingue mayúsculas: usa siempre minúsculas y sin espacios (`mi_herramienta.html`).
