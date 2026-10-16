# Esplora Labs — Especificación de marca

> Versión en texto del Brand Kit, lista para usar sin tener que releer el PDF.
> El PDF original está en el proyecto como `Educa_Tools_Brand_Kit.pdf`.

---

## Tokens CSS

```css
:root {
  /* Fondos */
  --bg:          #FBFCEF;  /* canvas-pestel — fondo principal de página */
  --canvas:      #FAF7F2;
  --surface:     #FFFFFF;  /* tarjetas, hero, footer */
  --surface-alt: #F5F6E4;  /* secciones alternas */

  /* Texto */
  --ink:         #1E1C1A;  /* principal */
  --ink-soft:    #4A463F;  /* secundario */
  --ink-muted:   #8B847A;  /* terciario, taglines, metadatos */

  /* Líneas */
  --line:        #E8E1D6;
  --line-soft:   #EEEFD8;

  /* Marca */
  --olive-deep:  #6B7028;  /* primario */
  --olive-mid:   #A8AD5C;  /* secundario */
  --lime-soft:   #E8EDC4;
  --lime-mid:    #C5CD78;

  /* Tipografía */
  --font-display: 'Fraunces', Georgia, serif;
  --font-ui:      'Inter', -apple-system, 'Segoe UI', sans-serif;

  /* Radios */
  --radius-card: 18px;
  --radius-pill: 999px;
}
```

### Carga de fuentes

```html
<link rel="stylesheet" href="fuentes/fuentes.css">
```

---

## Colores de acento por herramienta

Cada herramienta tiene su color propio. Se aplica al icono, al badge y al borde superior de la tarjeta.

| Herramienta | Acento | Fondo de icono |
|---|---|---|
| Generador de ideas | `#6B7028` olive-deep | `#EFF1D8` |
| Análisis PESTEL | `#3E5778` slate-blue | `#E4E8F0` |
| Forma jurídica | `#8B6430` amber | `#F2E8D9` |
| Estrella | `#557A35` forest green | `#E5EDDB` |
| Modelo Canvas | `#7A3244` berry/vino | `#F2E1E6` |

---

## Logo — lockup completo (SVG listo para pegar)

Estructura en dos líneas: "Esplora" arriba, y debajo las dos estrellas seguidas de "Labs". Tagline al pie.

```svg
<svg viewBox="0 0 220 112" fill="none" xmlns="http://www.w3.org/2000/svg" role="img">
  <title>Esplora Labs</title>

  <!-- "Esplora" — olive-mid, fila superior -->
  <text x="0" y="38" font-family="'Fraunces', Georgia, serif"
        font-size="40" font-weight="700" fill="#A8AD5C" letter-spacing="-1.5">Esplora</text>

  <!-- Estrella grande (olive-deep) — debajo de "Esplora" -->
  <path d="M20 0 C20 0 18 9 14 13 C10 17 0 20 0 20 C0 20 10 23 14 27 C18 31 20 40 20 40
           C20 40 22 31 26 27 C30 23 40 20 40 20 C40 20 30 17 26 13 C22 9 20 0 20 0Z"
        fill="#6B7028" transform="translate(0, 52)"/>

  <!-- Estrella pequeña (olive-mid) — arriba a la derecha de la grande -->
  <path d="M10 0 C10 0 9 4 7 6 C5 8 0 9 0 9 C0 9 5 10 7 12 C9 14 10 18 10 18
           C10 18 11 14 13 12 C15 10 20 9 20 9 C20 9 15 8 13 6 C11 4 10 0 10 0Z"
        fill="#A8AD5C" transform="translate(30, 50)"/>

  <!-- "Labs" — ink, misma fila que las estrellas -->
  <text x="55" y="92" font-family="'Fraunces', Georgia, serif"
        font-size="40" font-weight="700" fill="#1E1C1A" letter-spacing="-1.5">Labs</text>

  <!-- Tagline -->
  <text x="0" y="110" font-family="'Inter', sans-serif"
        font-size="7" font-weight="600" fill="#8B847A" letter-spacing="2.2">HERRAMIENTAS DIDÁCTICAS</text>
</svg>
```

**Cuidado con el espaciado vertical.** En una versión anterior las estrellas se solapaban con la palabra "Esplora": el texto terminaba en `y=40` y las estrellas arrancaban en `y=44`, solo 4px de separación. La corrección fue ampliar el `viewBox` a `0 0 220 112` y bajar el grupo de estrellas a `translate(0, 52)` y `translate(30, 50)`, dándoles su propia fila limpia.

### Estrella suelta

Las estrellas de 4 puntas funcionan bien como elemento gráfico independiente: separadores de sección, marcadores de lista, decoración del hero, favicon.

```svg
<svg viewBox="0 0 40 40" xmlns="http://www.w3.org/2000/svg" role="img" aria-hidden="true">
  <path d="M20 0 C20 0 18 9 14 13 C10 17 0 20 0 20 C0 20 10 23 14 27 C18 31 20 40 20 40
           C20 40 22 31 26 27 C30 23 40 20 40 20 C40 20 30 17 26 13 C22 9 20 0 20 0Z"
        fill="currentColor"/>
</svg>
```

Usa `fill="currentColor"` para que herede el color del contexto.

---

## Criterios de aplicación

**Fondo de página:** `--bg` `#FBFCEF`. Es el pastel más claro de la paleta y es el que da el aire característico. Las tarjetas y el hero van en blanco puro por encima, lo que crea la separación sin necesidad de sombras fuertes.

**Diferenciación de secciones:** alternar `--surface` (blanco) y `--surface-alt` (`#F5F6E4`) con un `border-bottom` de `--line-soft`. Nada de sombras pesadas.

**Tipografía:** Fraunces solo para titulares y logo. Inter para todo lo demás. Los titulares llevan `text-wrap: balance`. Las etiquetas en mayúsculas llevan `letter-spacing` amplio.

**El proyecto es de tema claro.** No lleva modo oscuro — es una decisión de diseño, no una omisión. Los colores se pintan siempre explícitamente.

---

## Estilo "cuaderno" (portada, octubre 2026)

Capa de detalle que se suma a lo anterior sin cambiar paleta, tipografías ni logo. Se estrenó en `index.html` y puede usarse en herramientas nuevas.

```css
--frame:        1px solid var(--ink);   /* marco fino en tinta */
--sticker:      3px 3px 0 var(--ink);   /* sombra "pegatina": dura, sin difuminar */
--sticker-lift: 5px 5px 0 var(--ink);   /* la misma, al pasar el ratón */
```

**Marcos finos:** tarjetas, píldoras y chips con borde de 1px en `--ink`. Separan sin necesidad de sombras difuminadas.

**Botón pegatina (acción principal):** fondo `--lime-mid`, borde de 1.5px en `--ink` y sombra `--sticker`. Al pasar el ratón se desplaza 2px y la sombra crece; al pulsar se hunde y la sombra desaparece. Solo uno por pantalla.

**Rotulador:** una palabra clave del titular con un trazo `--lime-mid` detrás (más o menos la mitad inferior de las letras), que se "pinta" de izquierda a derecha al cargar.

**Tarjetas de herramienta:** al pasar el ratón se levantan con una sombra dura en el color de acento de la herramienta, no en tinta.

**Franja de contraste:** `--olive-deep` a todo lo ancho con texto blanco, como mucho una por página.

**Garabatos:** trazos a mano en `--olive-deep` (flechas, círculos) de 2px, sin relleno, que se dibujan una sola vez al aparecer.

**Movimiento:** siempre con un motivo (entrar en pantalla, responder al ratón, cambiar de vista). Los iconos pueden reaccionar al pasar el ratón con un gesto ligado a su significado (la bombilla se enciende, la balanza se inclina). Todo se desactiva con `prefers-reduced-motion`.
