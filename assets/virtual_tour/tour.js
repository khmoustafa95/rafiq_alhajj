(function () {
  var locale = 'ar';
  var panoramaYaw = 0;
  var dragging = false;
  var lastX = 0;

  var copy = {
    ar: {
      disclaimer:
        'للتعريف والإرشاد فقط — ليس بديلاً عن الحج الفعلي. يمكن استبدال النموذج بملف glTF أو بانوراما 360° لاحقاً.',
      tabMap: 'خريطة',
      tabModel: 'نموذج 3D',
      tabPanorama: 'بانوراما',
      modelHint: 'نموذج تعليمي مبسط للكعبة — اسحب الشاشة أو استبدل بملف .glb في الأصول.',
      panoramaHint: 'اسحب يميناً ويساراً لاستكشاف المشهد. أضف panorama.jpg لبانوراما حقيقية.',
      landmarks: {
        kaaba: {
          title: 'الكعبة المشرفة',
          body: 'قبلة المسلمين وقلب المسجد الحرام. يبدأ الطواف من الحجر الأسود باتجاه عقارب الساعة.',
        },
        tawaf: {
          title: 'المطاف',
          body: 'الدوران حول الكعبة سبعة أشواط. حافظ على الطمأنينة واحترم ازدحام الحجاج.',
        },
        sai: {
          title: 'المسعى',
          body: 'السعي بين الصفا والمروة سبعة أشواط، من الصفا إلى المروة شوط ومن المروة إلى الصفا شوط.',
        },
        zamzam: {
          title: 'بئر زمزم',
          body: 'ماء زمزم مبارك. يُستحب الشرب والدعاء عند الإمكان.',
        },
        gates: {
          title: 'أبواب المسجد',
          body: 'تعرّف على البوابة الأقرب لك قبل التوجه. اتبع إرشادات رموز المركز.',
        },
      },
    },
    en: {
      disclaimer:
        'For guidance only — not a substitute for performing Hajj. Replace with glTF or 360° panoramas later.',
      tabMap: 'Map',
      tabModel: '3D model',
      tabPanorama: 'Panorama',
      modelHint: 'Simplified educational Kaaba model — replace with a .glb asset when ready.',
      panoramaHint: 'Drag left/right to explore. Add panorama.jpg for a real 360° image.',
      landmarks: {
        kaaba: {
          title: 'The Holy Kaaba',
          body: 'The qibla of Muslims and heart of Al-Masjid al-Haram. Tawaf begins at the Black Stone, counter-clockwise.',
        },
        tawaf: {
          title: 'Mataaf (Tawaf area)',
          body: 'Circle the Kaaba seven times. Stay calm and respect fellow pilgrims.',
        },
        sai: {
          title: "Sa'i walkway",
          body: "Walk between Safa and Marwah seven times — Safa to Marwah counts as one, and return counts as one.",
        },
        zamzam: {
          title: 'Zamzam well',
          body: 'Blessed Zamzam water. Drink and make du\'a when possible.',
        },
        gates: {
          title: 'Mosque gates',
          body: 'Know the nearest gate before you go. Follow your center\'s signage.',
        },
      },
    },
  };

  function t() {
    return copy[locale] || copy.ar;
  }

  function setLocale(lang) {
    locale = lang === 'en' ? 'en' : 'ar';
    document.documentElement.lang = locale;
    document.body.dir = locale === 'ar' ? 'rtl' : 'ltr';
    render();
  }

  function render() {
    var strings = t();
    document.getElementById('disclaimer').textContent = strings.disclaimer;
    document.getElementById('tab-map').textContent = strings.tabMap;
    document.getElementById('tab-model').textContent = strings.tabModel;
    document.getElementById('tab-panorama').textContent = strings.tabPanorama;
    document.getElementById('model-hint').textContent = strings.modelHint;
    document.getElementById('panorama-hint').textContent = strings.panoramaHint;

    var list = document.getElementById('landmark-list');
    list.innerHTML = '';
    Object.keys(strings.landmarks).forEach(function (id) {
      var item = strings.landmarks[id];
      var el = document.createElement('article');
      el.className = 'landmark-item';
      el.dataset.id = id;
      el.innerHTML = '<h3>' + item.title + '</h3><p>' + item.body + '</p>';
      el.addEventListener('click', function () {
        showInfo(id);
      });
      list.appendChild(el);
    });
  }

  function showInfo(id) {
    var item = t().landmarks[id];
    if (!item) return;
    document.getElementById('info-title').textContent = item.title;
    document.getElementById('info-body').textContent = item.body;
    document.getElementById('info-card').classList.remove('hidden');
    if (window.RafiqTour && window.RafiqTour.postMessage) {
      window.RafiqTour.postMessage(id);
    }
  }

  function hideInfo() {
    document.getElementById('info-card').classList.add('hidden');
  }

  function switchTab(name) {
    document.querySelectorAll('.tab').forEach(function (btn) {
      btn.classList.toggle('active', btn.dataset.tab === name);
    });
    document.querySelectorAll('.panel').forEach(function (panel) {
      panel.classList.toggle('active', panel.id === 'panel-' + name);
    });
  }

  function updatePanorama() {
    var pan = document.getElementById('panorama');
    var kaaba = pan.querySelector('.panorama-kaaba');
    var ground = pan.querySelector('.panorama-ground');
    var offset = panoramaYaw * 0.4;
    kaaba.style.transform = 'translateX(' + offset + 'px)';
    ground.style.transform = 'translateX(' + (-offset * 0.5) + 'px)';
    pan.style.backgroundPosition = panoramaYaw + 'px 0';
  }

  document.querySelectorAll('.tab').forEach(function (btn) {
    btn.addEventListener('click', function () {
      switchTab(btn.dataset.tab);
    });
  });

  document.querySelectorAll('.hotspot').forEach(function (dot) {
    dot.addEventListener('click', function () {
      showInfo(dot.dataset.id);
    });
  });

  document.getElementById('close-info').addEventListener('click', hideInfo);

  var pan = document.getElementById('panorama');
  pan.addEventListener('pointerdown', function (e) {
    dragging = true;
    lastX = e.clientX;
    pan.setPointerCapture(e.pointerId);
  });
  pan.addEventListener('pointermove', function (e) {
    if (!dragging) return;
    panoramaYaw += (e.clientX - lastX) * 0.6;
    lastX = e.clientX;
    updatePanorama();
  });
  pan.addEventListener('pointerup', function () {
    dragging = false;
  });
  pan.addEventListener('pointercancel', function () {
    dragging = false;
  });

  window.setLocale = setLocale;
  setLocale('ar');
})();
