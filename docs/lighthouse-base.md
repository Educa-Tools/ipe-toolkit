# Lighthouse base · portada (Sesión 0)

- **Página medida:** https://esplora.es/ (la portada publicada, igual a `main` en el commit `14f4604`).
- **Fecha:** 17 oct 2026, 15:57 (hora peninsular).
- **Herramienta:** PageSpeed Insights (Lighthouse 13.5.0). Informe: https://pagespeed.web.dev/analysis/https-esplora-es/fvzm9gx99g
- **Condiciones:** móvil = Moto G Power emulado con 4G lenta; ordenador = escritorio estándar. Una sola carga, sin caché.

## Puntuaciones

| Categoría | Móvil | Ordenador | Meta (≥ 90) |
|---|---|---|---|
| Rendimiento | 96 | 100 | Cumple |
| Accesibilidad | 96 | 96 | Cumple |
| Buenas prácticas | 100 | 100 | Cumple |
| SEO | 100 | 100 | Cumple |

## Métricas de carga

| Métrica | Móvil | Ordenador |
|---|---|---|
| Primer contenido visible (FCP) | 2,0 s | 0,3 s |
| Elemento más grande visible (LCP) | 2,0 s | 0,3 s |
| Tiempo de bloqueo (TBT) | 0 ms | 0 ms |
| Saltos de diseño (CLS) | 0 | 0,003 |
| Índice de velocidad | 4,2 s | 0,5 s |

## Qué falla o se puede mejorar

1. **Contraste (accesibilidad, móvil y ordenador).** No llegan al contraste mínimo:
   - la frase «Así cabe un recurso en una sesión de 50 minutos:» (`.session-t`);
   - las etiquetas de los pasos «Al empezar», «Durante la clase», «Al sonar el timbre» y «Para entregar» (`.step-when`), dentro de la sección «Proyecto».
2. **Hoja que bloquea la carga.** `fuentes/fuentes.css` frena el primer pintado en móvil (ahorro estimado de unos 1,6 s según Lighthouse; en la práctica es una petición pequeña de 1 KiB).
3. **Caché corta.** GitHub Pages sirve las fuentes con 10 minutos de caché (unos 195 KiB por visita repetida). No se puede cambiar desde el repo; solo se nota en visitas repetidas.
4. **Buenas prácticas, sin puntuar:** no hay CSP, HSTS fuerte, COOP ni protección contra marcos (XFO). GitHub Pages no deja poner cabeceras; habría que valorarlo con el proxy de Cloudflare (implica tocar DNS/SSL, solo con confirmación).

## Notas

- Las cuatro categorías ya superan 90: la meta de la Sesión 4 es **no bajar** de aquí al cambiar rutas, diseño y contenido.
- Solo se ha medido la portada. Las herramientas se medirán en la Sesión 4.
- PageSpeed da algo distinto en cada pasada (±3-5 puntos en rendimiento móvil). Comparar con varias mediciones.
