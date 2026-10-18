# Esplora (antes Educa Tools / IPE Toolkit)

## Qué es este proyecto
Herramientas HTML interactivas que el alumnado usa en clase: reutilizables,
con margen para equivocarse y obtener una segunda visión. El público de la
comunicación son docentes de secundaria, con foco en FP.
Lema provisional: "herramientas para explorar en el aula".
Fuente de verdad del estado del proyecto: esplora-contexto-claude-code.md.

Esplora es una web de herramientas y recursos didácticos interactivos sobre
empleabilidad y emprendimiento para Formación Profesional (IPE 1: trabajo
por cuenta ajena; IPE 2: emprendimiento) y, más adelante, materias afines
(la portada todavía no las muestra; ver «Estructura real del repositorio»).
Nace en el aula y arranca en el curso 2026/27. Crece curso a curso.

## Público
- Docentes (quien decide usarlo): de secundaria, con foco en FP. Quieren
  encontrar rápido un recurso que encaje con su unidad y su tiempo, y
  confiar en quien lo ha hecho.
- Alumnado de FP (quien lo usa): móvil u ordenador del aula, sesiones de
  50 minutos.

## Principios no negociables
1. Todo funciona en el navegador, sin instalar nada y sin crear cuentas.
2. Debe funcionar bien en móvil y en equipos de aula modestos.
3. Privacidad primero: no recoger datos personales del alumnado (menores
   incluidos). El progreso se guarda donde se decida en la Sesión 0 (ver
   «Decisiones pendientes») y se explica con claridad.
4. Accesibilidad WCAG 2.1 AA como mínimo.
5. Lo que no existe no se muestra: nada de "Próximamente" ni placeholders
   visibles, ni testimonios o cifras inventados.

## Material de referencia
- esplora-contexto-claude-code.md y README.md.
- "Boceto organización web.docx" y "Asignaturas y modulos target.docx": la
  visión previa del autor sobre la organización de la web y las materias
  objetivo. Tienen prioridad sobre cualquier propuesta nueva; si el plan
  las contradice, avisar y preguntar.

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
- Asume que main es producción. No hagas git push sin el OK explícito
  del autor: publicar en main publica esplora.es.
- Una sesión de trabajo = una rama (sesion-N-tema). Commits pequeños y
  con mensaje claro.

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
- Web estática: páginas HTML sueltas, sin package.json, sin src y sin
  sistema de compilación. El navegador las abre tal cual.
- Cada herramienta es un archivo .html independiente en la raíz.
- fuentes/: tipografías. lib/: librerías. .claude/: configuración del autor.
- Archivos de prueba antiguos: index-prueba.html, index-renovada.html,
  index-renovada-2.html.
- Los archivos que empiezan por ~$ son temporales de Word: se ignoran
  (están en .gitignore).
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
  Única excepción: el script de Cloudflare Web Analytics (ver
  «Decisiones pendientes»), si se activa por script.
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

## Reglas de trabajo para Claude Code (revisión integral)
- Antes de tocar nada: lee los documentos de referencia, inspecciona el
  repo y resume qué hay.
- Sigue PLAN.md: trabaja solo en la sesión activa. Dentro de cada sesión,
  por bloques: termina uno, enséñalo y espera el OK del autor.
- No introduzcas npm, frameworks ni sistemas de compilación sin explicarlo
  y pedir permiso. Mantén la web como HTML estático. Si hace falta un
  script para generar páginas, propónlo antes.
- No borres ni muevas archivos (incluidas las pruebas antiguas, branding/
  y los .docx) sin preguntar antes. Lista lo que sobra y el autor decide.
- No instales dependencias nuevas sin explicar por qué.
- Textos legales: son borradores que debe revisar una persona con criterio
  jurídico. Márcalos como tales.
- Web sin servidor: no hay backend para formularios. Propón opciones
  (mailto, servicio externo) explicando el impacto en privacidad antes de
  implementar.
- Si falta una decisión del autor, pregunta; no inventes.
- Cuando acabes una tarea, marca la casilla en PLAN.md y deja una nota de
  2-3 líneas.

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
- Logotipo e isotipo definitivos: en marca/ (SVG optimizados del kit
  nuevo, oct-2026). Ya puestos en favicon (web y herramientas), cabecera, portada, pie,
  barra superior de las herramientas (logo horizontal oliva o crema) y
  404. Pendiente: avatar e imagen para compartir.
- Fuente de la marca: marca/kit/ (kit original de la diseñadora, oct-2026:
  svg/, png/ de 2000 px y COLORES.txt). Toda pieza de marca nueva sale de
  ahí. Los SVG sueltos de marca/ son copias optimizadas para la web: no se
  enlaza el kit desde las páginas (pesa más). El zip original está en
  archivo/ (no se publica).
- El símbolo (isotipo) se llama «espora». Sustituye a la estrella de cuatro
  puntas antigua; como icono se usa con <use href="#espora">.
- Mascota: Explorito, una espora con mochila y lupa, con accesorios
  según el módulo. El diseño actual es solo de referencia.
- Marca por delante de la persona: sin fotos ni imagen personal.
- Revisar el contraste del verde oliva #6B7028 en cada uso.
- Tono cercano, claro y práctico; sin jerga académica innecesaria. Humor
  ágil si encaja.
- Idioma: español (España). Preparar la estructura para añadir gallego
  más adelante.

## Skills de diseño disponibles
- /animate, /emil-design-eng, /apple-design, /web-design-guidelines,
  /estetica-rapida: úsalas solo cuando el plan de la sesión lo indique o
  el autor las invoque.
- /review-animations: NUNCA la uses por tu cuenta; solo si se pide
  expresamente.
- Toda animación debe respetar prefers-reduced-motion y no empeorar
  Lighthouse.
- La identidad de marca (verde oliva #6B7028, tono cercano) prevalece
  sobre cualquier estilo que aplique una skill.

## Definición de "hecho" global
- Lighthouse ≥ 90 en rendimiento, accesibilidad, buenas prácticas y SEO.
- Sin errores en consola.
- Probado en móvil real y a 360 px de ancho.
- Navegable solo con teclado.

## Notas
- La PESTEL vigente es el mapa de impacto e incertidumbre (matriz 3x3).
  La versión antigua con gráfico hexagonal está obsoleta.
- Marca: "Esplora". El guardado usa claves que empiezan por "esplora".
  Las herramientas llevan al principio un pequeño script que copia el
  progreso de las claves antiguas ("educa…") para que nadie lo pierda.
  No lo quites.

## Decisiones pendientes (las resuelve el autor en la Sesión 0)
- [x] Licencia de los recursos (propuesta: CC BY-NC-SA 4.0)
      → Decidido (17-oct-2026): CC BY-NC-SA 4.0.
- [x] Titular legal y datos de contacto para el aviso legal
      → Decidido (17-oct-2026): titular persona física (el autor). Contacto:
        contacto@esplora.es. El nombre y el NIF los añade el autor al
        revisar el borrador; no se escriben en el repo.
- [x] Analítica: sin cookies (Plausible/Umami) o ninguna
      → Decidido (17-oct-2026): Cloudflare Web Analytics, sin cookies y sin
        datos personales. Es la ÚNICA excepción a la regla de no hacer
        peticiones a dominios externos. Debe constar en la política de
        privacidad. Si hace falta script, solo ese y en todas las páginas.
        Pendiente de elegir cómo activarlo (ver nota de la Sesión 0).
- [x] Dónde se guarda el progreso del alumnado (local en el navegador u
      otro) y qué datos se tocan
      → Decidido (17-oct-2026): en el navegador del alumno (localStorage) y,
        además, todas las herramientas permiten exportar el progreso a un
        archivo e importarlo otro día o en otro equipo. Nada va a ningún
        servidor. Solo se guarda lo que el alumno escribe en la herramienta.
- [x] Qué hacer con los archivos de prueba antiguos y con branding/
      → Decidido (17-oct-2026): archivar. index-prueba.html,
        index-renovada.html, index-renovada-2.html y branding/ irán a una
        carpeta archivo/ ignorada por git (no se publica, no se borra).
        Se hace en una sesión posterior y con OK del autor antes de mover.
- [x] ¿Se mantiene el nombre "Esplora"?
      → Decidido (17-oct-2026): sí, Esplora.
