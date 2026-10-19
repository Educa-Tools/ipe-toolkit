<#
  Esplora · genera las páginas que salen del catálogo (data/estructura.json).

  Cuándo ejecutarlo: cada vez que cambies data/estructura.json (herramienta
  nueva, nombre, descripción, unidad…). Después, revisa y haz commit de todo.

  Cómo: en PowerShell 7, desde la carpeta del proyecto:
      pwsh scripts/generar.ps1

  Qué escribe (todo se puede volver a generar; no edites esos archivos a mano):
    - recursos/<slug>/index.html   ficha de cada herramienta
    - ipe-1/index.html, ipe-2/…    página de cada módulo
    - index.html                   solo el trozo entre las marcas
                                   <!-- catalogo-generado:inicio --> y :fin
    - sitemap.xml, llms.txt        índices para Google y para los asistentes de IA
    - robots.txt                   añade la línea Sitemap si falta
    - <herramienta>.html           añade <link rel="canonical"> si falta y mantiene
                                   el pie legal entre <!-- pie-legal:inicio --> y :fin
    - herramientas y legales       etiquetas para compartir (imagen marca/compartir.png)
                                   entre <!-- compartir:inicio --> y :fin
  No borra nada: si sobra una ficha de una herramienta que ya no está, lo avisa.
#>
param([string]$Root = (Split-Path -Parent $PSScriptRoot))

$ErrorActionPreference = 'Stop'
$Sitio = 'https://esplora.es'
$Marca = '<!-- Generado por scripts/generar.ps1 desde data/estructura.json: no lo edites a mano. -->'
$utf8 = New-Object System.Text.UTF8Encoding($false)
$avisos = [System.Collections.Generic.List[string]]::new()
# Imagen que sale al compartir un enlace (WhatsApp, LinkedIn, X…): la misma en todas las páginas
$ImagenCompartir = @"
<meta property="og:image" content="$Sitio/marca/compartir.png">
<meta property="og:image:width" content="1200">
<meta property="og:image:height" content="630">
<meta property="og:image:alt" content="Esplora: herramientas y recursos didácticos sobre empleabilidad y emprendimiento">
<meta name="twitter:card" content="summary_large_image">
"@

# ---------- Utilidades ----------
function Esc([string]$s) { if ($null -eq $s) { return '' }; $s.Replace('&','&amp;').Replace('<','&lt;').Replace('>','&gt;').Replace('"','&quot;') }
function SinEtiquetas([string]$s) { [regex]::Replace($s, '<[^>]+>', '') }
function Escribir([string]$rel, [string]$texto) {
  $ruta = Join-Path $Root $rel
  $dir = Split-Path -Parent $ruta
  if (-not (Test-Path $dir)) { New-Item -ItemType Directory -Force $dir | Out-Null }
  $texto = $texto.Replace("`r`n", "`n")
  $antes = if (Test-Path $ruta) { [IO.File]::ReadAllText($ruta, $utf8).Replace("`r`n", "`n") } else { $null }
  if ($antes -ne $texto) { [IO.File]::WriteAllText($ruta, $texto, $utf8); "  escrito   $rel" } else { "  igual     $rel" }
}
function Recortar([string]$s, [int]$max) {
  if ($s.Length -le $max) { return $s }
  $c = $s.Substring(0, $max - 1); $c = $c.Substring(0, $c.LastIndexOf(' ')); return $c.TrimEnd(',', ';', ':') + '…'
}

# ---------- Datos ----------
$db = Get-Content -Raw -Encoding utf8 (Join-Path $Root 'data/estructura.json') | ConvertFrom-Json
$H = @{}; foreach ($p in $db.herramientas.PSObject.Properties) { $H[$p.Name] = $p.Value }
$tipos = @{}; foreach ($t in $db.tipos) { $tipos[$t.id] = $t }
$tematica = @{}; foreach ($e in $db.etiquetas) { foreach ($id in $e.herramientas) { $tematica[$id] = $e.nombre } }

$UNIDAD_DEF = @{ sing = 'Unidad didáctica'; plural = 'unidades didácticas'; abrev = 'UD' }
function PalabraUnidad($m) { if ($m.nomUnidad) { @{ sing = $m.nomUnidad.sing; plural = $m.nomUnidad.plural; abrev = $m.nomUnidad.abrev } } else { $UNIDAD_DEF } }
function CarpetaModulo($m) { $m.id -replace '^([a-z]+)(\d+)$', '$1-$2' }   # ipe1 -> ipe-1

# Recorrido en el orden del catálogo: módulo > unidad > herramienta
$entradas = [System.Collections.Generic.List[object]]::new()
foreach ($m in $db.modulos) {
  $w = PalabraUnidad $m
  foreach ($u in $m.unidades) {
    foreach ($id in $u.herramientas) {
      $t = $H[$id]
      if (-not $t) { $avisos.Add("La unidad «$($u.titulo)» de $($m.tag) cita «$id», que no está en herramientas."); continue }
      if (-not $t.slug) { $avisos.Add("«$id» no tiene slug: no se genera su ficha."); continue }
      $entradas.Add([pscustomobject]@{ id = $id; t = $t; m = $m; u = $u; w = $w })
    }
  }
}
foreach ($id in $H.Keys) { if (-not ($entradas | Where-Object id -eq $id)) { $avisos.Add("«$id» está en herramientas pero en ninguna unidad: no sale en las páginas generadas.") } }

# ---------- Piezas comunes de las páginas ----------
function Cabeza($o) {
  # $o: titulo, desc, ruta (relativa al sitio, con / final), base (../ o ../../)
@"
<!DOCTYPE html>
<html lang="es">
<head>
$Marca
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>$(Esc $o.titulo)</title>
<meta name="description" content="$(Esc $o.desc)">
<link rel="canonical" href="$Sitio/$($o.ruta)">
<meta property="og:type" content="website">
<meta property="og:site_name" content="Esplora">
<meta property="og:locale" content="es_ES">
<meta property="og:url" content="$Sitio/$($o.ruta)">
<meta property="og:title" content="$(Esc $o.titulo)">
<meta property="og:description" content="$(Esc $o.desc)">
$ImagenCompartir
<meta name="theme-color" content="#FBFCEF">
<link rel="icon" href="$($o.base)marca/simbolo-oliva.svg" type="image/svg+xml">
<link rel="apple-touch-icon" href="$($o.base)marca/apple-touch-icon.png">
<link rel="stylesheet" href="$($o.base)fuentes/fuentes.css">
<link rel="stylesheet" href="$($o.base)estilos/esplora.css">
</head>
<body class="doc">
<a class="skip" href="#contenido">Saltar al contenido</a>
<header class="top">
  <div class="wrap">
    <a href="$($o.base)" aria-label="Esplora, ir a la portada"><img src="$($o.base)marca/logo-horizontal-oliva.svg" alt="" width="114" height="28"></a>
    <a class="link" href="$($o.base)#catalogo">Todo el catálogo</a>
  </div>
</header>
"@
}

# Páginas legales: se enlazan desde el pie de todas las páginas
$Legales = [ordered]@{ 'aviso-legal.html' = 'Aviso legal'; 'privacidad.html' = 'Privacidad'; 'cookies.html' = 'Cookies'; 'licencia.html' = 'Licencia y créditos'; 'accesibilidad.html' = 'Accesibilidad' }
function EnlacesLegales($base, [string]$sep) { ($Legales.Keys | ForEach-Object { "<a href=""$base$_"">$($Legales[$_])</a>" }) -join $sep }

function Pie($base) {
@"
<footer>
  <div class="wrap">
    <p><span translate="no">Esplora</span> · Herramientas para explorar en el aula · <a href="mailto:contacto@esplora.es">contacto@esplora.es</a></p>
    <p>Gratis, en el navegador y sin crear cuentas. <a href="$($base)licencia.html">Licencia CC BY-NC-SA 4.0</a>.</p>
    <p class="legal">$(EnlacesLegales $base ' · ')</p>
  </div>
</footer>
</body>
</html>
"@
}

function Datos($e) {
  # Etiquetas cortas: duración, informe
  $d = @()
  if ($e.t.minutos) { $d += "≈ $($e.t.minutos) min" }
  if ($e.t.guarda) { $d += 'Guarda progreso' }
  if ($e.t.informe) { $d += 'Informe PDF' }
  $d -join ' · '
}

function Tarjeta($e, [string]$href) {
  $c = if ($e.t.color) { " style=""--c:$($e.t.color)""" } else { '' }
  $meta = Datos $e
  "  <li><a href=""$href""$c><b>$(Esc $e.t.titulo)</b><span>$(Esc $e.t.descripcion)</span>$(if ($meta) { "<small>$meta</small>" })</a></li>"
}

# ---------- Fichas: recursos/<slug>/index.html ----------
"Fichas de recurso"
$slugs = @{}
foreach ($e in $entradas) {
  $t = $e.t; $m = $e.m; $u = $e.u; $w = $e.w
  if ($slugs[$t.slug]) { $avisos.Add("El slug «$($t.slug)» está repetido."); continue }
  $slugs[$t.slug] = $true
  $unidadLarga = "$($w.sing) $($u.n)"
  $tipoId = if ($t.tipo) { $t.tipo } else { $m.tipo }
  $tipo = $tipos[$tipoId]
  $hashUnidad = "$($m.id)-$($w.abrev.ToLower())$($u.n)"
  $titulo = "$($t.titulo) para $($m.tag) · Esplora"
  $desc = Recortar "$($t.descripcion) Recurso gratuito para $($m.tag), $($unidadLarga.ToLower()): $($u.titulo)." 160
  $hermanas = $entradas | Where-Object { $_.u -eq $u -and $_.id -ne $e.id }

  $facts = @()
  if ($t.minutos) { $facts += "<div><dt>Duración</dt><dd>≈ $($t.minutos) min</dd></div>" }
  if ($tipo) { $facts += "<div><dt>Tipo</dt><dd>$(Esc $tipo.sing)</dd></div>" }
  if ($tematica[$e.id]) { $facts += "<div><dt>Temática</dt><dd>$(Esc $tematica[$e.id])</dd></div>" }
  $facts += "<div><dt>Progreso</dt><dd>$(if ($t.guarda) { 'Se guarda en el navegador' } else { 'Se hace en una sesión' })</dd></div>"
  if ($t.informe) { $facts += "<div><dt>Entregable</dt><dd>Informe para imprimir o PDF</dd></div>" }

  $html = (Cabeza @{ titulo = $titulo; desc = $desc; ruta = "recursos/$($t.slug)/"; base = '../../' }) + @"
<main id="contenido" class="wrap">
  <nav class="crumbs" aria-label="Estás aquí">
    <ol>
      <li><a href="../../">Inicio</a></li>
      <li><a href="../../$(CarpetaModulo $m)/">$(Esc $m.tag)</a></li>
      <li aria-current="page">$(Esc $t.titulo)</li>
    </ol>
  </nav>
  <article class="ficha"$(if ($t.color) { " style=""--c:$($t.color)""" })>
    <p class="eyebrow">$(Esc $m.tag) · $(Esc $unidadLarga) · $(Esc $u.titulo)</p>
    <h1>$(if ($t.titular) { $t.titular } else { Esc $t.titulo })</h1>
    <p class="lede">$(Esc $t.descripcion)</p>
    <dl class="facts">
      $($facts -join "`n      ")
    </dl>
    <p class="actions">
      <a class="btn" href="../../$($t.url)">Abrir la herramienta <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><line x1="5" y1="12" x2="19" y2="12"/><polyline points="12 5 19 12 12 19"/></svg></a>
      <a class="btn-sec" href="../../#$hashUnidad">Ver $(Esc $unidadLarga.ToLower()) en el catálogo</a>
    </p>
    <p class="note">Se abre en el navegador del aula o del móvil, sin instalar nada y sin crear cuentas.</p>
  </article>
"@
  if ($hermanas) {
    $html += @"

  <section aria-labelledby="mas-t">
    <h2 id="mas-t">Más recursos de $(if ($w.sing -eq 'Bloque') { 'este bloque' } else { 'esta unidad' })</h2>
    <ul class="list">
$(($hermanas | ForEach-Object { Tarjeta $_ "../$($_.t.slug)/" }) -join "`n")
    </ul>
  </section>
"@
  }
  $html += "`n</main>`n" + (Pie '../../')
  Escribir "recursos/$($t.slug)/index.html" $html
}

# ---------- Páginas de módulo: ipe-1/, ipe-2/ ----------
"Páginas de módulo"
foreach ($m in $db.modulos) {
  $w = PalabraUnidad $m
  $suyas = $entradas | Where-Object { $_.m -eq $m }
  if (-not $suyas) { continue }
  $carpeta = CarpetaModulo $m
  $titulo = "Recursos gratuitos para $($m.tag) · Esplora"
  $desc = Recortar "$($m.tag) · $($m.nombre) (FP): $($m.descripcion) $(@($suyas).Count) recursos gratis, en el navegador y sin registro." 160
  $html = (Cabeza @{ titulo = $titulo; desc = $desc; ruta = "$carpeta/"; base = '../' }) + @"
<main id="contenido" class="wrap">
  <nav class="crumbs" aria-label="Estás aquí">
    <ol>
      <li><a href="../">Inicio</a></li>
      <li aria-current="page">$(Esc $m.tag)</li>
    </ol>
  </nav>
  <p class="eyebrow">$(Esc $m.lema)</p>
  <h1>$(Esc $m.tag) · <em>$(Esc $m.nombre)</em></h1>
  <p class="lede">$(Esc $m.descripcion) $(@($suyas).Count) recursos para usar en clase, ordenados por $(Esc $w.plural).</p>
"@
  foreach ($u in $m.unidades) {
    $deU = $suyas | Where-Object { $_.u -eq $u }
    if (-not $deU) { continue }   # Lo que no existe no se muestra
    $hid = "$($w.abrev.ToLower())$($u.n)"
    $html += @"

  <section aria-labelledby="$hid">
    <h2 id="$hid">$(Esc $w.sing) $($u.n) · $(Esc $u.titulo)</h2>
    <ul class="list">
$(($deU | ForEach-Object { Tarjeta $_ "../recursos/$($_.t.slug)/" }) -join "`n")
    </ul>
  </section>
"@
  }
  $html += "`n</main>`n" + (Pie '../')
  Escribir "$carpeta/index.html" $html
}

# ---------- Portada: catálogo ya escrito (lo sustituye el JavaScript al cargar) ----------
"Portada"
$bloques = foreach ($m in $db.modulos) {
  $w = PalabraUnidad $m
  $suyas = $entradas | Where-Object { $_.m -eq $m }
  if (-not $suyas) { continue }
  "<section class=""pre-mod""><h3><a href=""$(CarpetaModulo $m)/"">$(Esc $m.tag) · $(Esc $m.nombre)</a></h3>"
  foreach ($u in $m.unidades) {
    $deU = $suyas | Where-Object { $_.u -eq $u }
    if (-not $deU) { continue }
    "<h4>$(Esc $w.sing) $($u.n) · $(Esc $u.titulo)</h4><ul>"
    foreach ($e in $deU) { "<li><a href=""recursos/$($e.t.slug)/"">$(Esc $e.t.titulo)</a>: $(Esc $e.t.descripcion)</li>" }
    "</ul>"
  }
  "</section>"
}
$rutaIndex = Join-Path $Root 'index.html'
$idx = [IO.File]::ReadAllText($rutaIndex, $utf8)
$re = '(?s)(<!-- catalogo-generado:inicio -->).*?(<!-- catalogo-generado:fin -->)'
if ([regex]::IsMatch($idx, $re)) {
  $nl = if ($idx.Contains("`r`n")) { "`r`n" } else { "`n" }
  $dentro = "<div class=""pre-cat"">$nl" + ($bloques -join $nl) + "$nl</div>"
  $nuevo = [regex]::Replace($idx, $re, { param($x) $x.Groups[1].Value + $nl + $dentro + $nl + $x.Groups[2].Value })
  if ($nuevo -ne $idx) { [IO.File]::WriteAllText($rutaIndex, $nuevo, $utf8); "  escrito   index.html (catálogo)" } else { "  igual     index.html (catálogo)" }
} else { $avisos.Add('index.html no tiene las marcas <!-- catalogo-generado:inicio --> y :fin: no se ha escrito el catálogo en la portada.') }

# ---------- Herramientas: pie legal y canonical ----------
"Herramientas"
$pieLegal = @"
<!-- pie-legal:inicio (scripts/generar.ps1) -->
<nav class="pie-legal" aria-label="Información legal" style="clear:both;max-width:880px;margin:32px auto 0;padding:16px 16px 28px;text-align:center;font:14px/1.6 system-ui,-apple-system,'Segoe UI',sans-serif;color:inherit">$(EnlacesLegales '' ' · ')</nav>
<style>.pie-legal a{color:inherit;display:inline-block;padding-block:6px;text-underline-offset:3px}@media print{.pie-legal{display:none!important}}</style>
<!-- pie-legal:fin -->
"@
foreach ($e in $entradas) {
  $ruta = Join-Path $Root $e.t.url
  if (-not (Test-Path $ruta)) { $avisos.Add("No existe $($e.t.url) («$($e.id)»)."); continue }
  $txt = [IO.File]::ReadAllText($ruta, $utf8)
  $nl = if ($txt.Contains("`r`n")) { "`r`n" } else { "`n" }
  $bloque = $pieLegal.Replace("`r`n", "`n").Replace("`n", $nl)
  $rePie = '(?s)<!-- pie-legal:inicio.*?<!-- pie-legal:fin -->'
  $nuevo = if ([regex]::IsMatch($txt, $rePie)) { [regex]::Replace($txt, $rePie, { param($x) $bloque }) }
           else { $i = $txt.LastIndexOf('</body>'); if ($i -lt 0) { $avisos.Add("$($e.t.url) no tiene </body>: sin pie legal."); $txt } else { $txt.Insert($i, "$bloque$nl") } }
  if ($nuevo -ne $txt) { $txt = $nuevo; [IO.File]::WriteAllText($ruta, $txt, $utf8); "  pie legal $($e.t.url)" }
  if ($txt -match 'rel="canonical"') { continue }
  $hit = [regex]::Match($txt, '(?m)^([ \t]*)<meta name="description"[^>]*>')
  if (-not $hit.Success) { $hit = [regex]::Match($txt, '(?m)^([ \t]*)<title>[^<]*</title>') }
  if (-not $hit.Success) { $avisos.Add("$($e.t.url) no tiene <title>: no se ha añadido canonical."); continue }
  $nl = if ($txt.Contains("`r`n")) { "`r`n" } else { "`n" }
  $txt = $txt.Insert($hit.Index + $hit.Length, "$nl$($hit.Groups[1].Value)<link rel=""canonical"" href=""$Sitio/$($e.t.url)"">")
  [IO.File]::WriteAllText($ruta, $txt, $utf8); "  canonical $($e.t.url)"
}

# ---------- Herramientas y páginas legales: etiquetas para compartir ----------
# Bloque marcado justo debajo del canonical, con el título y la descripción de la propia página
"Compartir"
$paraCompartir = @($entradas | ForEach-Object { $_.t.url } | Select-Object -Unique) + @($Legales.Keys)
foreach ($url in $paraCompartir) {
  $ruta = Join-Path $Root $url
  if (-not (Test-Path $ruta)) { continue }
  $txt = [IO.File]::ReadAllText($ruta, $utf8)
  $nl = if ($txt.Contains("`r`n")) { "`r`n" } else { "`n" }
  $can = [regex]::Match($txt, '(?m)^([ \t]*)<link rel="canonical" href="([^"]*)">')
  if (-not $can.Success) { $avisos.Add("$url no tiene canonical: sin etiquetas para compartir."); continue }
  $tit = [regex]::Match($txt, '<title>([^<]*)</title>').Groups[1].Value
  $des = [regex]::Match($txt, '<meta name="description" content="([^"]*)"').Groups[1].Value
  $sang = $can.Groups[1].Value
  $lineas = @('<!-- compartir:inicio (scripts/generar.ps1) -->',
    '<meta property="og:type" content="website">',
    '<meta property="og:site_name" content="Esplora">',
    '<meta property="og:locale" content="es_ES">',
    "<meta property=""og:url"" content=""$($can.Groups[2].Value)"">",
    "<meta property=""og:title"" content=""$tit"">",
    "<meta property=""og:description"" content=""$des"">") +
    @($ImagenCompartir.Replace("`r`n", "`n").Split("`n")) + @('<!-- compartir:fin -->')
  $bloque = ($lineas | ForEach-Object { "$sang$_" }) -join $nl
  $re = '(?s)[ \t]*<!-- compartir:inicio.*?<!-- compartir:fin -->'
  $nuevo = if ([regex]::IsMatch($txt, $re)) { [regex]::Replace($txt, $re, { param($x) $bloque }) }
           else { $txt.Insert($can.Index + $can.Length, "$nl$bloque") }
  if ($nuevo -ne $txt) { [IO.File]::WriteAllText($ruta, $nuevo, $utf8); "  compartir $url" }
}

# ---------- sitemap.xml ----------
"Índices"
$urls = @("$Sitio/")
foreach ($m in $db.modulos) { if ($entradas | Where-Object { $_.m -eq $m }) { $urls += "$Sitio/$(CarpetaModulo $m)/" } }
foreach ($e in $entradas) { $urls += "$Sitio/recursos/$($e.t.slug)/" }
foreach ($e in $entradas) { $urls += "$Sitio/$($e.t.url)" }
foreach ($l in $Legales.Keys) { if (Test-Path (Join-Path $Root $l)) { $urls += "$Sitio/$l" } }
$xml = "<?xml version=""1.0"" encoding=""UTF-8""?>`n<urlset xmlns=""http://www.sitemaps.org/schemas/sitemap/0.9"">`n" +
  (($urls | ForEach-Object { "  <url><loc>$_</loc></url>" }) -join "`n") + "`n</urlset>`n"
Escribir 'sitemap.xml' $xml

# ---------- llms.txt ----------
$llms = @"
# Esplora

> Herramientas y recursos didácticos gratuitos sobre empleabilidad y emprendimiento para Formación Profesional: Itinerario Personal para la Empleabilidad I (IPE 1: prevención de riesgos, derecho del trabajo y Seguridad Social) e Itinerario Personal para la Empleabilidad II (IPE 2: emprendimiento). Funcionan en el navegador del aula o del móvil, sin instalar nada y sin crear cuentas. El progreso se guarda en el navegador del alumno y no se envía a ningún servidor. Licencia CC BY-NC-SA 4.0. Contacto: contacto@esplora.es.

Cada recurso tiene una ficha (enlace principal) y la herramienta en sí (enlace «abrir»). Las duraciones son aproximadas, para sesiones de clase de 50 minutos.
"@
$llms += "`n`n"
foreach ($m in $db.modulos) {
  $w = PalabraUnidad $m
  foreach ($u in $m.unidades) {
    $deU = $entradas | Where-Object { $_.u -eq $u }
    if (-not $deU) { continue }
    $llms += "## $($m.tag) · $($w.sing) $($u.n): $($u.titulo)`n`n"
    foreach ($e in $deU) {
      $extra = @(); if ($e.t.minutos) { $extra += "≈ $($e.t.minutos) min" }; if ($e.t.informe) { $extra += 'con informe en PDF' }
      $llms += "- [$($e.t.titulo)]($Sitio/recursos/$($e.t.slug)/): $($e.t.descripcion)$(if ($extra) { ' (' + ($extra -join ', ') + ')' }) · [abrir]($Sitio/$($e.t.url))`n"
    }
    $llms += "`n"
  }
}
Escribir 'llms.txt' ($llms.TrimEnd() + "`n")

# ---------- robots.txt: línea del sitemap ----------
$rutaRobots = Join-Path $Root 'robots.txt'
if (Test-Path $rutaRobots) {
  $rb = [IO.File]::ReadAllText($rutaRobots, $utf8)
  if ($rb -notmatch '(?m)^Sitemap:') { [IO.File]::WriteAllText($rutaRobots, $rb.TrimEnd() + "`n`nSitemap: $Sitio/sitemap.xml`n", $utf8); "  escrito   robots.txt (Sitemap)" }
}

# ---------- Fichas que sobran ----------
$dirRec = Join-Path $Root 'recursos'
if (Test-Path $dirRec) {
  foreach ($d in Get-ChildItem $dirRec -Directory) {
    if (-not $slugs[$d.Name]) { $avisos.Add("recursos/$($d.Name)/ ya no corresponde a ninguna herramienta. Si sobra, bórrala a mano (el script no borra nada).") }
  }
}

""
if ($avisos.Count) { "AVISOS:"; $avisos | ForEach-Object { "  - $_" } } else { "Listo, sin avisos. Revisa los cambios y haz commit." }
