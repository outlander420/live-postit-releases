// Live PostIt site — scroll reveals, FAQ accordion, active nav.
(function () {
  'use strict';

  var reduceMotion = window.matchMedia('(prefers-reduced-motion: reduce)').matches;

  // --- Scroll reveal ---
  var revealEls = Array.prototype.slice.call(document.querySelectorAll('.reveal'));
  if (reduceMotion || !('IntersectionObserver' in window)) {
    revealEls.forEach(function (el) {
      el.classList.add('is-visible');
    });
  } else {
    var io = new IntersectionObserver(
      function (entries) {
        entries.forEach(function (entry) {
          if (entry.isIntersecting) {
            entry.target.classList.add('is-visible');
            io.unobserve(entry.target);
          }
        });
      },
      { threshold: 0, rootMargin: '0px 0px -8% 0px' }
    );
    revealEls.forEach(function (el) {
      io.observe(el);
    });
  }

  // --- FAQ accordion ---
  var faqButtons = Array.prototype.slice.call(document.querySelectorAll('.faq-q'));
  faqButtons.forEach(function (btn) {
    btn.addEventListener('click', function () {
      var item = btn.closest('.faq-item');
      var answer = item ? item.querySelector('.faq-a') : null;
      var isOpen = item && item.classList.contains('open');

      // Close others for a tidy single-open accordion.
      Array.prototype.slice
        .call(document.querySelectorAll('.faq-item.open'))
        .forEach(function (other) {
          if (other !== item) {
            other.classList.remove('open');
            var otherBtn = other.querySelector('.faq-q');
            var otherAnswer = other.querySelector('.faq-a');
            if (otherBtn) otherBtn.setAttribute('aria-expanded', 'false');
            if (otherAnswer) otherAnswer.style.maxHeight = null;
          }
        });

      if (item) {
        item.classList.toggle('open', !isOpen);
        btn.setAttribute('aria-expanded', isOpen ? 'false' : 'true');
        if (answer) {
          answer.style.maxHeight = isOpen ? null : answer.scrollHeight + 'px';
        }
      }
    });
  });

  // --- Active nav highlighting (main + manual TOC) ---
  var tocSelectors = [
    '.nav-links a[href^="#"]',
    '.manual-toc a[href^="#"]'
  ];
  var tocLinks = tocSelectors
    .map(function (sel) {
      return Array.prototype.slice.call(document.querySelectorAll(sel));
    })
    .reduce(function (a, b) {
      return a.concat(b);
    }, []);
  var tocSections = tocLinks
    .map(function (link) {
      var id = link.getAttribute('href').slice(1);
      return document.getElementById(id);
    })
    .filter(Boolean);

  if ('IntersectionObserver' in window && tocSections.length) {
    var tocObserver = new IntersectionObserver(
      function (entries) {
        entries.forEach(function (entry) {
          if (entry.isIntersecting) {
            var id = entry.target.id;
            tocLinks.forEach(function (link) {
              var active = link.getAttribute('href') === '#' + id;
              link.classList.toggle('active', active);
            });
          }
        });
      },
      { rootMargin: '-45% 0px -50% 0px' }
    );
    tocSections.forEach(function (section) {
      tocObserver.observe(section);
    });
  }
})();
