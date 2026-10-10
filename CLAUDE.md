# Educa Tools (nombre provisional)

## Quién soy
Soy profesor de FP (IPE 1 e IPE 2, FOL y EIE). No sé programar:
explícame todo sin jerga y, al terminar cada tarea, dime qué has
cambiado, en qué archivos y cómo comprobarlo.

## Qué es este proyecto
Herramientas HTML interactivas que el alumnado usa en clase: reutilizables,
con margen para equivocarse y obtener una segunda visión.
Web publicada con GitHub Pages: https://educa-tools.github.io/ipe-toolkit/

## Estructura real del repositorio
- index.html: la landing (portada). No tiene las herramientas escritas:
  las lee de data/estructura.json.
- data/estructura.json: el índice del catálogo. Tiene tres partes:
  herramientas (nombre, descripción, color), módulos (IPE 2 por unidades,
  IPE 1 por bloques, con las herramientas de cada uno) y etiquetas
  (temáticas de "Explorar por temática").
- Cada herramienta es un archivo .html independiente en la raíz.
- README.md: instrucciones para añadir herramientas.
- branding/: kit de marca en texto (brand-kit-especificacion.md).

## Reglas de trabajo
- No renombres ni muevas archivos: la web publicada enlaza a ellos por
  su nombre. Si hace falta reorganizar, cuéntame el plan y espera mi OK.
- Para añadir una herramienta: crear su .html y registrarla en
  data/estructura.json (sigue el README).
- Cada herramienta es un HTML autónomo y completo (con DOCTYPE), sin
  build ni dependencias de servidor.
- Nombres de archivo en minúsculas, sin espacios ni tildes (GitHub Pages
  distingue mayúsculas de minúsculas).
- Nunca pongas claves, contraseñas ni llamadas a APIs con credenciales en
  el código: el repositorio se publica.
- Todo el texto visible, en español.
- IPE 1 usa "bloques" y IPE 2 "unidades didácticas".
- Alumnado de FP, sobre todo ciclos superiores de Comercio y Marketing.
- Las sesiones duran 50 minutos: herramientas ágiles y con opción de
  guardar el progreso para retomarlo otro día.
- Branding: usa siempre branding/brand-kit-especificacion.md (paleta,
  tipografías Fraunces e Inter, logo). Tema claro, sin modo oscuro.
  No inventes colores nuevos.
- Antes de cambios grandes (tocar varias herramientas), cuéntame el plan
  y espera mi OK. No borres nada sin avisarme.

## Notas
- La PESTEL vigente es el mapa de impacto e incertidumbre (matriz 3x3).
  La versión antigua con gráfico hexagonal está obsoleta.
