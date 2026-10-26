// Esplora · portada. La escribe a mano index.html y la rellena scripts/generar.ps1 (window.ESPLORA).
// Aquí: enlaces antiguos con #, entrada del panel, «Seguir donde lo dejaste», pasos de «Cómo se usa»,
// buscador del índice y la animación del Generador (la de la portada anterior, sin cambios).

// ---------- Enlaces antiguos con # (#ipe2-ud1, #tema-prl, #catalogo…) ----------
// El servidor no ve lo que va detrás de #, así que se resuelve aquí, antes de pintar nada más.
(function () {
  function resolver() {
    let h = '';
    try { h = decodeURIComponent(location.hash.slice(1)); } catch (e) { return; }
    if (!h) return;
    const antiguos = (window.ESPLORA && window.ESPLORA.antiguos) || {};
    if (antiguos[h]) { location.replace(antiguos[h]); return; }
    if (h === 'catalogo' || h === 'tematicas' || /^tipo-/.test(h) || h === 'explorar' || h === 'recursos') {
      history.replaceState(null, '', '#todas');
      const todas = document.getElementById('todas');
      if (todas) todas.scrollIntoView();
    }
  }
  resolver();
  addEventListener('hashchange', resolver);   // también si el enlace antiguo se usa estando ya en la portada
})();

(function () {
  const $ = s => document.querySelector(s);
  const norm = s => String(s || '').normalize('NFD').replace(/\p{M}/gu, '').toLowerCase();
  const plural = (n, s, p) => `${n} ${n === 1 ? s : p}`;

  // ---------- Panel principal: datos y botón del generador en una fila, y entrada ----------
  const facts = $('.gen-facts'), go = $('.gen-go');
  if (facts && go) {
    const fila = document.createElement('div');
    fila.className = 'gen-pie';
    facts.before(fila);
    fila.append(facts, go);
  }
  // setTimeout y no requestAnimationFrame: en una pestaña en segundo plano rAF no llega y el panel se quedaría vacío
  setTimeout(() => { const p = $('#panel'); if (p) p.classList.add('listo'); }, 40);

  // ---------- Seguir donde lo dejaste: solo si este navegador tiene trabajo guardado ----------
  const guarda = (window.ESPLORA && window.ESPLORA.guarda) || [];
  const empezadas = guarda.filter(g => { try { return localStorage.getItem(g.k); } catch (e) { return false; } });
  const seguir = $('#seguir');
  if (seguir && empezadas.length) {
    empezadas.forEach(g => {
      const a = document.createElement('a');
      a.href = g.u; a.textContent = g.t; a.style.setProperty('--c', g.c);
      seguir.append(a);
    });
    seguir.hidden = false;
  }

  // ---------- Cómo se usa: un paso abierto cada vez y su ventanita al lado ----------
  const acordeon = $('#acordeon');
  if (acordeon) acordeon.addEventListener('click', e => {
    const b = e.target.closest('button'); if (!b) return;
    const i = +b.id.split('-')[1];
    acordeon.querySelectorAll('li').forEach((li, k) => {
      li.classList.toggle('abierto', k === i);
      li.querySelector('button').setAttribute('aria-expanded', k === i);
    });
    document.querySelectorAll('#vista > div').forEach((d, k) => d.setAttribute('aria-hidden', k !== i));
  });

  // ---------- Índice completo: buscador ----------
  const q = $('#q');
  if (q) {
    const filtrar = () => {
      const txt = norm(q.value.trim());
      let total = 0;
      document.querySelectorAll('.tema-i').forEach(t => {
        let n = 0;
        t.querySelectorAll('li[data-busca]').forEach(li => { const ok = !txt || li.dataset.busca.includes(txt); li.hidden = !ok; if (ok) n++; });
        t.hidden = !n; total += n;
      });
      document.querySelectorAll('#indice > div').forEach(d => { d.hidden = !d.querySelector('.tema-i:not([hidden])'); });
      $('#vacio').hidden = !!total;
      $('#vacioQ').textContent = q.value.trim();
      $('#cuenta').textContent = txt ? plural(total, 'herramienta encontrada', 'herramientas encontradas') : '';
    };
    q.addEventListener('input', filtrar);
    $('#borrar').addEventListener('click', () => { q.value = ''; filtrar(); q.focus(); });
  }
})();

// ---------- Animación del Generador ----------
const calm = matchMedia('(prefers-reduced-motion: reduce)').matches;
// Reclamo de la portada: un cursor elige ciclo, marca casillas y pulsa «Ver mis ideas»; la pantalla cambia y aparecen
// tres ideas que encajan con ese perfil (ideas y etiquetas reales de generador.html). Luego, otro perfil.
// Se repite solo mientras se ve en pantalla; con menos movimiento se quedan quietas las ideas del primer perfil
(function(){
  const fig = document.getElementById('demo');
  if(!fig || calm || !('IntersectionObserver' in window)) return;
  const wait = ms => new Promise(r=>setTimeout(r, ms));
  let visible = false, seguir = null;
  const enPantalla = () => visible ? Promise.resolve() : new Promise(r=>{ seguir = r; });
  new IntersectionObserver(([e])=>{ visible = e.isIntersecting; if(visible && seguir){ seguir(); seguir = null; } }).observe(fig);
  const perfiles = [
    { ciclo:'Marketing y Publicidad', marca:['Moda / belleza','Tecnología / gaming','Creatividad','Tecnología / RRSS','100% online'],
      ideas:[['Contenido UGC','Creación de contenido UGC en vídeo para marcas'],['Social media para pymes','Gestión de redes sociales y contenido para negocios locales'],['Mini-agencia de lanzamiento','Branding y plan de lanzamiento para emprendedores']] },
    { ciclo:'Cocina y Gastronomía', marca:['Gastronomía','Viajes / turismo','Trato con personas','Creatividad','A domicilio'],
      ideas:[['Cocina privada','Chef a domicilio y clases de cocina'],['Catering','Catering para empresas, celebraciones y eventos pequeños'],['Cocina sobre ruedas','Food truck o puesto en mercados gastronómicos']] },
    { ciclo:'Comercio Internacional', marca:['Gastronomía','Viajes / turismo','Ventas','Idiomas','100% online'],
      ideas:[['E-commerce cross-border de nicho','Tienda online de producto español para la diáspora en el extranjero'],['Agente de exportación','Departamento de exportación externalizado para pymes productoras'],['Comercio digital internacional','Gestor de ventas cross-border en marketplaces europeos']] }
  ];
  const stage = document.getElementById('giStage'), cursor = document.getElementById('giCursor');
  const valor = document.getElementById('giCiclo'), res = document.getElementById('giRes');
  const casillas = [...fig.querySelectorAll('.gi-s1 .gi-p')], boton = fig.querySelector('.gi-btn'), ideas = [...fig.querySelectorAll('.gi-ideas li')];
  // Lleva la punta del cursor al centro de un elemento de la pantalla
  const ir = el => { const s = stage.getBoundingClientRect(), r = el.getBoundingClientRect();
    cursor.style.translate = `${r.left - s.left + r.width * .55}px ${r.top - s.top + r.height * .6}px`; };
  const pulsar = async el => { await enPantalla(); ir(el); await wait(700);
    cursor.classList.add('pulsa'); el.classList.add('pulsa'); await wait(160);
    cursor.classList.remove('pulsa'); el.classList.remove('pulsa'); };
  (async function bucle(){
    await wait(3200);
    for(let i = 0;; i = (i + 1) % perfiles.length){
      const p = perfiles[i];
      await enPantalla();
      // Pantalla de respuestas, vacía, con el ciclo del nuevo perfil
      valor.classList.add('cambia'); casillas.forEach(c=>c.classList.remove('si'));
      fig.classList.remove('ver'); ideas.forEach(li=>li.classList.remove('in'));
      await wait(300); valor.textContent = p.ciclo; valor.classList.remove('cambia');
      ir(boton); await wait(500); cursor.classList.add('vivo'); await wait(300);
      for(const texto of p.marca){
        const c = casillas.find(c=>c.textContent === texto);
        await pulsar(c); c.classList.add('si'); await wait(250);
      }
      await pulsar(boton); await wait(250);
      // Pantalla de ideas
      res.textContent = `${p.ciclo} · ${p.marca[p.marca.length - 1]}`;
      p.ideas.forEach(([n, t], k)=>{ ideas[k].querySelector('.gi-n').textContent = n; ideas[k].querySelector('.gi-t').textContent = t; });
      cursor.classList.remove('vivo'); fig.classList.add('ver'); await wait(500);
      for(const li of ideas){ await enPantalla(); li.classList.add('in'); await wait(450); }
      await wait(4800);
    }
  })();
})();
