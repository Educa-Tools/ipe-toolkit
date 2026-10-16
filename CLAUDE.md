# Esplora (antes Educa Tools / IPE Toolkit)

## Qué es este proyecto
Herramientas HTML interactivas que el alumnado usa en clase: reutilizables,
con margen para equivocarse y obtener una segunda visión. El público de la
comunicación son docentes de secundaria, con foco en FP.
Lema provisional: "herramientas para explorar en el aula".
Fuente de verdad del estado del proyecto: esplora-contexto-claude-code.md.

## Web, dominio y correo
- Web: https://esplora.es (también https://www.esplora.es), servida por
  GitHub Pages desde el repo Educa-Tools/ipe-toolkit, rama main, raíz /.
- La dirección antigua https://educa-tools.github.io/ipe-toolkit/ sigue
  funcionando: las rutas deben ser relativas para que valgan en las dos.
- Contacto: contacto@esplora.es (Zoho Mail).
- DNS en Cloudflare. No se toca el DNS sin confirmación.
- No renombres el repositorio ni la organización de GitHub: rompería el
  CNAME de www y los enlaces ya compartidos.

## Git
- Haz git pull antes de empezar.
- El archivo CNAME de la raíz (contenido: esplora.es) no se borra ni se
  sobrescribe nunca: si desaparece, se cae el dominio.
- Hacer push a main publica la web en 1-2 minutos. Mostrar el diff
  antes de hacer push.
- Mensajes de commit claros y en español.

## Estructura real del repositorio
- index.html: la landing (portada). No tiene las herramientas escritas:
  las lee de data/estructura.json.
- data/estructura.json: el índice del catálogo. Tiene cuatro partes:
  herramientas (nombre, descripción, color), módulos (IPE 2 por unidades,
  IPE 1 por bloques, con las herramientas de cada uno), tipos de recurso
  (herramientas interactivas = IPE 2, recursos de aula = IPE 1, materiales
  didácticos = diapositivas y capítulos, aún sin contenido) y etiquetas
  (temáticas del filtro "Temática").
- La portada se organiza por materia (IPE 1, IPE 2 u otra materia) y
  filtra el catálogo por temática y tipo de recurso. Sin versión "Pro" y
  sin "materias afines" por ahora.
- Cada herramienta es un archivo .html independiente en la raíz.
- CNAME: dominio personalizado (no tocar).
- README.md: instrucciones para añadir herramientas.
- branding/: kit de marca anterior (brand-kit-especificacion.md).
- Objetivo: unas 30 herramientas; el catálogo tiene que seguir escalando.

## Reglas de trabajo
- No renombres ni muevas archivos: la web publicada enlaza a ellos por
  su nombre. Si hace falta reorganizar, explicar el plan y esperar confirmación.
- Para añadir una herramienta: crear su .html y registrarla en
  data/estructura.json (sigue el README).
- Cada herramienta es un HTML autónomo y completo (con DOCTYPE), sin
  build ni dependencias de servidor.
- Las fuentes y librerías se cargan siempre desde fuentes/ y lib/, nunca
  desde Google Fonts ni desde un CDN. Ninguna herramienta debe hacer
  peticiones a dominios externos, salvo enlaces normales a webs oficiales
  (BOE, SEPE, Seguridad Social).
- Nombres de archivo en minúsculas, sin espacios ni tildes (GitHub Pages
  distingue mayúsculas de minúsculas).
- Nunca pongas claves, contraseñas ni llamadas a APIs con credenciales en
  el código: el repositorio se publica.
- Todo el texto visible, en español. Tono cercano pero riguroso.
- IPE 1 usa "bloques" y IPE 2 "unidades didácticas".
- Alumnado de FP, sobre todo ciclos superiores de Comercio y Marketing.
- Las sesiones duran 50 minutos: herramientas ágiles y con opción de
  guardar el progreso para retomarlo otro día.
- Antes de cambios grandes (tocar varias herramientas) o irreversibles
  (borrar, renombrar, DNS), explicar el plan y esperar confirmación.
  No borrar nada sin avisar.

## Identidad visual vigente (provisional)
- Verde oliva de marca #6B7028 (en modo oscuro #A7AE4B), fondo crema
  #F7F5EC, texto #2B2D14, acento terracota #C2683A / #B5482F, cuerpo de
  la mascota #8A9136. No inventes colores nuevos.
- Tipografía system-ui en la web. Versión retro: Alfa Slab One para
  títulos y Courier Prime.
- Con modo oscuro mediante prefers-color-scheme.
- Las herramientas actuales todavía usan el kit anterior (Fraunces e
  Inter, tema claro). Pasarlas a la identidad nueva es un cambio grande:
  pedir confirmación antes.
- Logotipo e isotipo definitivos: pendientes. Cuando lleguen, sustituir
  favicon, avatar, cabecera y 404.
- Mascota: Explorito, una espora con mochila y lupa, con accesorios
  según el módulo. El diseño actual es solo de referencia.
- Marca por delante de la persona: sin fotos ni imagen personal.

## Notas
- La PESTEL vigente es el mapa de impacto e incertidumbre (matriz 3x3).
  La versión antigua con gráfico hexagonal está obsoleta.
- Marca: "Esplora". El guardado usa claves que empiezan por "esplora".
  Las herramientas llevan al principio un pequeño script que copia el
  progreso de las claves antiguas ("educa…") para que nadie lo pierda.
  No lo quites.
