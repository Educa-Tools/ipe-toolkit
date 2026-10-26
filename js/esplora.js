// Esplora · comportamiento de las páginas con el diseño nuevo (las escribe scripts/generar.ps1).
// Todo el contenido ya viene escrito en la página; esto solo añade el menú, los mini dibujos,
// la igualación de alturas y el buscador de los caminos. Necesita js/miniaturas.js antes.
(function () {
  const $ = s => document.querySelector(s);
  const norm = s => String(s || '').normalize('NFD').replace(/\p{M}/gu, '').toLowerCase();
  const plural = (n, s, p) => `${n} ${n === 1 ? s : p}`;

  // ---------- Menú ----------
  const megaBtn = $('#megaBtn'), mega = $('#mega'), hojaBtn = $('#hojaBtn'), hoja = $('#hoja'), nav = $('#nav');
  function abrirMega(si) {
    if (!megaBtn) return;
    megaBtn.setAttribute('aria-expanded', si);
    mega.classList.toggle('abierto', si);
  }
  function abrirHoja(si) {
    if (!hojaBtn) return;
    hojaBtn.setAttribute('aria-expanded', si);
    hojaBtn.textContent = si ? 'Cerrar' : 'Menú';
    hoja.classList.toggle('abierto', si);
    document.body.classList.toggle('sin-scroll', si);
  }
  if (megaBtn) {
    megaBtn.addEventListener('click', () => abrirMega(megaBtn.getAttribute('aria-expanded') !== 'true'));
    mega.addEventListener('click', e => { if (e.target.closest('a')) abrirMega(false); });
    mega.addEventListener('focusout', e => { if (!mega.contains(e.relatedTarget) && e.relatedTarget !== megaBtn) abrirMega(false); });
    document.addEventListener('click', e => { if (!e.target.closest('#mega, #megaBtn')) abrirMega(false); });
  }
  if (hojaBtn) {
    hojaBtn.addEventListener('click', () => abrirHoja(hojaBtn.getAttribute('aria-expanded') !== 'true'));
    hoja.addEventListener('click', e => { if (e.target.closest('a')) abrirHoja(false); });
  }
  document.addEventListener('keydown', e => {
    if (e.key !== 'Escape') return;
    if (megaBtn && megaBtn.getAttribute('aria-expanded') === 'true') { abrirMega(false); megaBtn.focus(); }
    if (hojaBtn && hojaBtn.getAttribute('aria-expanded') === 'true') { abrirHoja(false); hojaBtn.focus(); }
  });
  if (nav) addEventListener('scroll', () => nav.classList.toggle('bajado', scrollY > 8), { passive: true });

  // ---------- Mini dibujos de las ventanitas ----------
  if (typeof ART !== 'undefined') {
    document.querySelectorAll('svg.clip-art[data-dibujo]').forEach(s => { s.innerHTML = ART[s.dataset.dibujo] || ART_DEF; });
  }

  // ---------- Ventanitas: título, pregunta, descripción y etiquetas a la misma altura ----------
  // Con una sola columna no hace falta: no hay nada al lado con lo que alinear.
  function igualar() {
    const ts = [...document.querySelectorAll('.tool-card')].filter(t => t.offsetParent && !t.closest('.vista'));
    if (!ts.length) return;
    const cols = getComputedStyle(ts[0].closest('ul')).gridTemplateColumns.split(' ').length;
    for (const sel of ['.clip-kick', '.clip-h', '.win-desc', '.tool-meta']) {
      const els = ts.map(t => t.querySelector(sel)).filter(Boolean);
      els.forEach(e => { e.style.minHeight = ''; });
      if (cols < 2) continue;
      const alto = Math.max(...els.map(e => e.offsetHeight));
      els.forEach(e => { e.style.minHeight = alto + 'px'; });
    }
  }
  let espera;
  addEventListener('resize', () => { clearTimeout(espera); espera = setTimeout(igualar, 120); });
  if (document.fonts) document.fonts.ready.then(igualar);
  igualar();

  // ---------- Buscador de un camino (y filtro de tipo, si hay más de uno) ----------
  const q = $('#q[data-buscar="camino"]');
  if (!q) return;
  const temas = [...document.querySelectorAll('.tema')];
  let tipo = 'all';
  const botonesTipo = $('#tipo');
  if (botonesTipo) botonesTipo.addEventListener('click', e => {
    const b = e.target.closest('button'); if (!b) return;
    tipo = b.dataset.t;
    botonesTipo.querySelectorAll('button').forEach(x => x.setAttribute('aria-pressed', x === b));
    filtrar();
  });
  function filtrar() {
    const txt = norm(q.value.trim());
    let total = 0;
    temas.forEach(t => {
      let n = 0;
      t.querySelectorAll('li[data-busca]').forEach(li => {
        const ok = (tipo === 'all' || li.dataset.tipo === tipo) && (!txt || li.dataset.busca.includes(txt));
        li.hidden = !ok; if (ok) n++;
      });
      t.hidden = !n;
      const c = $(`[data-n="${t.id}"]`); if (c) c.textContent = plural(n, 'herramienta', 'herramientas');
      total += n;
    });
    $('#cuenta').textContent = txt || tipo !== 'all' ? plural(total, 'herramienta encontrada', 'herramientas encontradas') : plural(total, 'herramienta', 'herramientas');
    $('#vacio').hidden = !!total;
    $('#vacioQ').textContent = q.value.trim();
    igualar();
  }
  q.addEventListener('input', filtrar);
  $('#borrar').addEventListener('click', () => { q.value = ''; filtrar(); q.focus(); });
})();
