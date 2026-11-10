// Tailwind design tokens exported from the original Google Stitch file.
tailwind.config = {
  darkMode: "class",
  theme: {
    extend: {
      colors: {
        "surface-variant": "#f2f2f2",
        "inverse-surface": "#292929",
        "outline-variant": "#d6d6d6",
        primary: "#b00000",
        "primary-hover": "#c00000",
        "on-tertiary-container": "#800000",
        "tertiary-fixed": "#f4dada",
        "surface-container-low": "#f7f7f7",
        "on-tertiary-fixed": "#400000",
        "primary-fixed": "#f5dada",
        "tertiary-container": "#800000",
        "surface-container-high": "#f2f2f2",
        "surface-container-highest": "#e8e8e8",
        "inverse-on-surface": "#f5f5f5",
        "on-primary-fixed-variant": "#800000",
        "secondary-fixed-dim": "#d6a900",
        secondary: "#f0c000",
        "secondary-fixed": "#fff2b3",
        "primary-container": "#800000",
        "error-container": "#ffdad6",
        "surface-container": "#f5f5f5",
        error: "#ba1a1a",
        "on-tertiary": "#ffffff",
        "on-secondary-fixed-variant": "#594700",
        outline: "#747474",
        "on-tertiary-fixed-variant": "#800000",
        "surface-bright": "#ffffff",
        "surface-tint": "#b00000",
        "on-error": "#ffffff",
        "on-secondary-container": "#171717",
        surface: "#ffffff",
        "on-error-container": "#93000a",
        "on-primary-fixed": "#400000",
        "on-background": "#171717",
        "primary-fixed-dim": "#e3a3a3",
        background: "#ffffff",
        tertiary: "#800000",
        "tertiary-fixed-dim": "#e6b3b3",
        "on-primary-container": "#ffffff",
        "on-primary": "#ffffff",
        "surface-container-lowest": "#ffffff",
        "on-secondary-fixed": "#171717",
        "inverse-primary": "#f0c000",
        "surface-dim": "#e8e8e8",
        "on-surface": "#171717",
        "secondary-container": "#f0c000",
        "on-secondary": "#171717",
        "on-surface-variant": "#444444",
      },
      borderRadius: {
        DEFAULT: "0.25rem",
        lg: "0.5rem",
        xl: "0.75rem",
        full: "9999px",
      },
      spacing: {
        gutter: "1.5rem",
        "space-xl": "2.5rem",
        "space-md": "1rem",
        "gutter-mobile": "1rem",
        "space-xs": "0.25rem",
        "space-lg": "1.5rem",
        "space-sm": "0.5rem",
        "margin-mobile": "1rem",
        margin: "2rem",
      },
      fontFamily: {
        "label-lg": ["Inter"],
        "headline-sm": ["Inter"],
        caption: ["Inter"],
        "headline-xl-mobile": ["Inter"],
        "display-hero": ["Inter"],
        "body-lg": ["Inter"],
        "headline-xl": ["Inter"],
        "headline-md": ["Inter"],
        "display-hero-mobile": ["Inter"],
        "body-md": ["Inter"],
        "label-md": ["Inter"],
        "body-sm": ["Inter"],
        "headline-lg": ["Inter"],
      },
      fontSize: {
        "label-lg": [
          "0.875rem",
          { lineHeight: "1.4", letterSpacing: "0.02em", fontWeight: "600" },
        ],
        "headline-sm": [
          "1.25rem",
          { lineHeight: "1.35", letterSpacing: "-0.01em", fontWeight: "600" },
        ],
        caption: [
          "0.75rem",
          { lineHeight: "1.4", letterSpacing: "0.01em", fontWeight: "500" },
        ],
        "headline-xl-mobile": [
          "1.875rem",
          { lineHeight: "1.25", letterSpacing: "-0.02em", fontWeight: "700" },
        ],
        "display-hero": [
          "3.5rem",
          { lineHeight: "1.15", letterSpacing: "-0.03em", fontWeight: "800" },
        ],
        "body-lg": [
          "1.125rem",
          { lineHeight: "1.6", letterSpacing: "0", fontWeight: "400" },
        ],
        "headline-xl": [
          "2.5rem",
          { lineHeight: "1.2", letterSpacing: "-0.025em", fontWeight: "700" },
        ],
        "headline-md": [
          "1.5rem",
          { lineHeight: "1.3", letterSpacing: "-0.015em", fontWeight: "600" },
        ],
        "display-hero-mobile": [
          "2.25rem",
          { lineHeight: "1.2", letterSpacing: "-0.025em", fontWeight: "800" },
        ],
        "body-md": [
          "1rem",
          { lineHeight: "1.55", letterSpacing: "0", fontWeight: "400" },
        ],
        "label-md": [
          "0.75rem",
          { lineHeight: "1.4", letterSpacing: "0.04em", fontWeight: "600" },
        ],
        "body-sm": [
          "0.875rem",
          { lineHeight: "1.5", letterSpacing: "0.005em", fontWeight: "400" },
        ],
        "headline-lg": [
          "2rem",
          { lineHeight: "1.25", letterSpacing: "-0.02em", fontWeight: "700" },
        ],
      },
    },
  },
};

// Navigasi, dropdown, drawer mobile, dan kontrol halaman.
(() => {
  "use strict";

  const pageMap = {
    "index.html": { section: "beranda", path: "beranda" },
    "sertifikasi-profesi.html": {
      section: "sertifikasi",
      path: "sertifikasi",
    },
    "biaya-pendidikan.html": {
      section: "biaya-pendidikan",
      path: "biaya-pendidikan",
    },
    "jurnal-mi.html": { section: "jurnal-mi", path: "jurnal-mi" },
    "jurnal-tk.html": { section: "jurnal-tk", path: "jurnal-tk" },
    "jurnal-ka.html": { section: "jurnal-ka", path: "jurnal-ka" },
    "layanan-bebas-plagiasi.html": {
      section: "plagiasi",
      path: "plagiasi",
    },
    "pendaftaran.html": { section: "pendaftaran", path: "pendaftaran" },
  };

  const desktopMedia = window.matchMedia("(min-width: 1280px)");
  const hoverMedia = window.matchMedia("(hover: hover) and (pointer: fine)");
  const reducedMotionMedia = window.matchMedia(
    "(prefers-reduced-motion: reduce)",
  );

  function getActivePageInfo() {
    const path = window.location.pathname.replace(/\\/g, "/");
    const fileName = decodeURIComponent(path.split("/").pop() || "");
    const normalizedFile = (fileName || "index.html").toLowerCase();
    const info = pageMap[normalizedFile];

    if (!info) {
      return { section: "", path: "" };
    }

    return { section: info.section, path: info.path };
  }

  function applyActiveNavigation() {
    const active = getActivePageInfo();

    document.querySelectorAll("[data-nav-link]").forEach((link) => {
      const isActive =
        Boolean(active.path) && link.dataset.path === active.path;
      link.classList.toggle("is-active", isActive);

      if (isActive) {
        link.setAttribute("aria-current", "page");
      } else {
        link.removeAttribute("aria-current");
      }
    });

    document.querySelectorAll("[data-nav-section]").forEach((group) => {
      group.classList.toggle(
        "is-active",
        Boolean(active.section) && group.dataset.navSection === active.section,
      );
    });

    document.querySelectorAll("[data-nav-cta]").forEach((link) => {
      const isActive = active.section === "pendaftaran";
      link.classList.toggle("is-active", isActive);

      if (isActive) {
        link.setAttribute("aria-current", "page");
      } else {
        link.removeAttribute("aria-current");
      }
    });
  }

  let dropdowns = [];

  function openDropdown(dropdown) {
    if (!dropdown) {
      return;
    }

    window.clearTimeout(dropdown._closeTimer);
    dropdowns.forEach((item) => {
      if (item !== dropdown) {
        closeDropdown(item);
      }
    });

    dropdown.classList.add("is-open");
    const trigger = dropdown.querySelector("[data-dropdown-toggle]");
    trigger?.setAttribute("aria-expanded", "true");
  }

  function closeDropdown(dropdown) {
    if (!dropdown) {
      return;
    }

    window.clearTimeout(dropdown._closeTimer);
    dropdown.classList.remove("is-open", "is-pinned");
    const trigger = dropdown.querySelector("[data-dropdown-toggle]");
    trigger?.setAttribute("aria-expanded", "false");
  }

  function closeAllDropdowns() {
    dropdowns.forEach((dropdown) => closeDropdown(dropdown));
  }

  function initDesktopDropdowns() {
    dropdowns = Array.from(document.querySelectorAll("[data-dropdown]"));

    dropdowns.forEach((dropdown) => {
      const trigger = dropdown.querySelector("[data-dropdown-toggle]");
      const links = dropdown.querySelectorAll("a[href]");

      if (!trigger) {
        return;
      }

      trigger.addEventListener("click", (event) => {
        event.preventDefault();

        if (dropdown.classList.contains("is-open")) {
          closeDropdown(dropdown);
          return;
        }

        openDropdown(dropdown);
        dropdown.classList.add("is-pinned");
      });

      trigger.addEventListener("keydown", (event) => {
        if (event.key !== "ArrowDown") {
          return;
        }

        event.preventDefault();
        openDropdown(dropdown);
        dropdown.classList.add("is-pinned");
        const firstLink = dropdown.querySelector(".nav-submenu-link");

        window.setTimeout(() => firstLink?.focus(), 0);
      });

      dropdown.addEventListener("pointerenter", () => {
        if (!hoverMedia.matches) {
          return;
        }

        window.clearTimeout(dropdown._closeTimer);
        if (!dropdown.classList.contains("is-open")) {
          openDropdown(dropdown);
        }
      });

      dropdown.addEventListener("pointerleave", () => {
        if (!hoverMedia.matches || dropdown.classList.contains("is-pinned")) {
          return;
        }

        window.clearTimeout(dropdown._closeTimer);
        dropdown._closeTimer = window.setTimeout(() => {
          if (
            !dropdown.classList.contains("is-pinned") &&
            !dropdown.contains(document.activeElement)
          ) {
            closeDropdown(dropdown);
          }
        }, 140);
      });

      dropdown.addEventListener("focusin", () => {
        window.clearTimeout(dropdown._closeTimer);
      });

      dropdown.addEventListener("focusout", () => {
        window.setTimeout(() => {
          if (!dropdown.contains(document.activeElement)) {
            closeDropdown(dropdown);
          }
        }, 0);
      });

      links.forEach((link) => {
        link.addEventListener("click", closeAllDropdowns);
      });
    });

    document.addEventListener("click", (event) => {
      const target = event.target;

      if (!(target instanceof Element) || target.closest("[data-dropdown]")) {
        return;
      }

      closeAllDropdowns();
    });
  }

  let mobileToggle = null;
  let mobileDrawer = null;
  let mobileBackdrop = null;
  let mobileClose = null;
  let isDrawerOpen = false;
  let lastFocusedElement = null;
  let mobileGroupToggles = [];

  function setMobileGroupOpen(group, isOpen) {
    if (!group) {
      return;
    }

    const toggle = group.querySelector("[data-mobile-dropdown-toggle]");
    if (!toggle) {
      return;
    }

    const menu = document.getElementById(toggle.getAttribute("aria-controls"));
    if (!menu) {
      return;
    }

    toggle.setAttribute("aria-expanded", String(isOpen));
    menu.hidden = !isOpen;
    group.classList.toggle("is-open", isOpen);
  }

  function collapseMobileGroups() {
    mobileGroupToggles.forEach((toggle) => {
      setMobileGroupOpen(toggle.closest("[data-mobile-dropdown]"), false);
    });
  }

  function setMobileScrollLock(isLocked) {
    document.documentElement.classList.toggle("mobile-nav-open", isLocked);
    document.body.classList.toggle("mobile-nav-open", isLocked);
  }

  function getMobileFocusableElements() {
    if (!mobileDrawer) {
      return [];
    }

    return Array.from(
      mobileDrawer.querySelectorAll(
        'a[href], button:not([disabled]), [tabindex]:not([tabindex="-1"])',
      ),
    ).filter((element) => element.offsetParent !== null);
  }

  function openMobileDrawer() {
    if (!mobileDrawer || !mobileToggle || isDrawerOpen) {
      return;
    }

    lastFocusedElement =
      document.activeElement instanceof HTMLElement &&
      document.activeElement !== document.body
        ? document.activeElement
        : mobileToggle;

    closeAllDropdowns();
    isDrawerOpen = true;
    mobileDrawer.removeAttribute("inert");
    mobileDrawer.setAttribute("aria-hidden", "false");
    mobileToggle.setAttribute("aria-expanded", "true");
    mobileToggle.setAttribute("aria-label", "Tutup menu navigasi");
    setMobileScrollLock(true);

    collapseMobileGroups();
    const activeGroup = mobileDrawer.querySelector(
      ".mobile-nav-group.is-active",
    );
    setMobileGroupOpen(activeGroup, true);

    window.setTimeout(() => {
      if (isDrawerOpen) {
        mobileClose?.focus();
      }
    }, 60);
  }

  function closeMobileDrawer({ returnFocus = true } = {}) {
    if (!mobileDrawer || !mobileToggle || !isDrawerOpen) {
      setMobileScrollLock(false);
      return;
    }

    const focusTarget =
      lastFocusedElement instanceof HTMLElement &&
      lastFocusedElement.isConnected
        ? lastFocusedElement
        : mobileToggle;

    isDrawerOpen = false;
    setMobileScrollLock(false);
    mobileToggle.setAttribute("aria-expanded", "false");
    mobileToggle.setAttribute("aria-label", "Buka menu navigasi");
    collapseMobileGroups();

    if (returnFocus) {
      focusTarget.focus();
    } else if (mobileDrawer.contains(document.activeElement)) {
      document.querySelector('#site-header a[href="index.html"]')?.focus();
    }

    mobileDrawer.setAttribute("aria-hidden", "true");
    mobileDrawer.setAttribute("inert", "");
  }

  function initMobileNavigation() {
    mobileToggle = document.getElementById("mobile-nav-toggle");
    mobileDrawer = document.getElementById("mobile-nav-drawer");
    mobileBackdrop = document.getElementById("mobile-nav-backdrop");
    mobileClose = document.getElementById("mobile-nav-close");
    setMobileScrollLock(false);

    if (!mobileDrawer || !mobileToggle) {
      return;
    }

    mobileGroupToggles = Array.from(
      mobileDrawer.querySelectorAll("[data-mobile-dropdown-toggle]"),
    );

    mobileToggle.addEventListener("click", openMobileDrawer);
    mobileClose?.addEventListener("click", () => closeMobileDrawer());
    mobileBackdrop?.addEventListener("click", () => closeMobileDrawer());

    mobileDrawer.querySelectorAll("a[href]").forEach((link) => {
      link.addEventListener("click", () => closeMobileDrawer());
    });

    mobileGroupToggles.forEach((toggle) => {
      toggle.addEventListener("click", () => {
        const group = toggle.closest("[data-mobile-dropdown]");
        const isOpen = toggle.getAttribute("aria-expanded") === "true";

        if (!isOpen) {
          mobileGroupToggles.forEach((item) => {
            if (item !== toggle) {
              setMobileGroupOpen(item.closest("[data-mobile-dropdown]"), false);
            }
          });
        }

        setMobileGroupOpen(group, !isOpen);
      });
    });

    mobileDrawer.addEventListener("keydown", (event) => {
      if (event.key !== "Tab") {
        return;
      }

      const focusable = getMobileFocusableElements();
      if (!focusable.length) {
        event.preventDefault();
        return;
      }

      const first = focusable[0];
      const last = focusable[focusable.length - 1];

      if (event.shiftKey && document.activeElement === first) {
        event.preventDefault();
        last.focus();
      } else if (!event.shiftKey && document.activeElement === last) {
        event.preventDefault();
        first.focus();
      }
    });
  }

  function initBackToTop() {
    const button = document.querySelector("[data-back-to-top]");
    if (!button) {
      return;
    }

    const footer = document.querySelector("footer");
    let isFooterVisible = false;
    let frame = null;

    const update = () => {
      frame = null;
      const isVisible = window.scrollY > 400 && !isFooterVisible;
      button.classList.toggle("is-visible", isVisible);
      button.classList.toggle("is-hidden", !isVisible);
      button.setAttribute("aria-hidden", String(!isVisible));
      button.tabIndex = isVisible ? 0 : -1;
    };

    const requestUpdate = () => {
      if (frame === null) {
        frame = window.requestAnimationFrame(update);
      }
    };

    window.addEventListener("scroll", requestUpdate, { passive: true });
    window.addEventListener("resize", requestUpdate);

    if (footer && "IntersectionObserver" in window) {
      const observer = new IntersectionObserver(
        (entries) => {
          isFooterVisible = entries[0].isIntersecting;
          update();
        },
        { rootMargin: "0px 0px -24px 0px", threshold: 0 },
      );
      observer.observe(footer);
    }

    button.addEventListener("click", () => {
      window.scrollTo({
        top: 0,
        behavior: reducedMotionMedia.matches ? "auto" : "smooth",
      });
      document.getElementById("main-content")?.focus({ preventScroll: true });
    });

    update();
  }

  function init() {
    applyActiveNavigation();
    initDesktopDropdowns();
    initMobileNavigation();
    initBackToTop();

    window.addEventListener("hashchange", applyActiveNavigation);

    desktopMedia.addEventListener("change", (event) => {
      closeAllDropdowns();

      if (event.matches) {
        closeMobileDrawer({ returnFocus: false });
      }
    });

    document.addEventListener("keydown", (event) => {
      if (event.key !== "Escape") {
        return;
      }

      if (isDrawerOpen) {
        event.preventDefault();
        closeMobileDrawer();
        return;
      }

      const openDropdown = dropdowns.find((dropdown) =>
        dropdown.classList.contains("is-open"),
      );

      if (openDropdown) {
        event.preventDefault();
        closeDropdown(openDropdown);
        openDropdown.querySelector("[data-dropdown-toggle]")?.focus();
      }
    });
  }

  if (document.readyState === "loading") {
    document.addEventListener("DOMContentLoaded", init);
  } else {
    init();
  }
})();

// Formulir pendaftaran: validasi nomor telepon dan pengiriman Web3Forms.
(() => {
  "use strict";

  function initRegistrationForm() {
    var form = document.getElementById("registration-form");
    var phone = document.getElementById("applicant-phone");
    var submitButton = document.getElementById("registration-submit");
    var status = document.getElementById("registration-status");
    var successPanel = document.getElementById("registration-success");
    var successTitle = document.getElementById("registration-success-title");
    var configNotice = document.getElementById("registration-config-notice");
    var accessKeyConfig = document.querySelector('meta[name="web3forms-access-key"]');
    if (!form || !phone || !submitButton || !status || !successPanel || !successTitle || !configNotice || !accessKeyConfig) return;

    var submitting = false;
    if (!accessKeyConfig.content.trim()) configNotice.classList.remove("hidden");

    function validatePhone() {
      var value = phone.value.trim();
      var digits = value.replace(/\D/g, "");
      var validFormat = /^\+?[0-9][0-9\s().-]{7,18}$/.test(value);
      phone.setCustomValidity(
        value && (!validFormat || digits.length < 9 || digits.length > 15)
          ? "Masukkan nomor telepon yang valid dengan 9 sampai 15 digit."
          : ""
      );
    }

    function showStatus(message, isError) {
      status.textContent = message;
      status.classList.remove("hidden", "bg-red-50", "text-red-800", "bg-green-50", "text-green-800");
      status.classList.add(isError ? "bg-red-50" : "bg-green-50", isError ? "text-red-800" : "text-green-800");
    }

    phone.addEventListener("input", validatePhone);
    phone.addEventListener("blur", validatePhone);

    form.addEventListener("submit", async function (event) {
      event.preventDefault();
      if (submitting) return;

      validatePhone();
      if (!form.checkValidity()) {
        form.reportValidity();
        return;
      }

      var accessKey = accessKeyConfig.content.trim();
      if (!accessKey) {
        showStatus(
          "Pengiriman belum aktif karena Access Key Web3Forms belum dikonfigurasi. Data Anda belum dikirim. Silakan coba kembali setelah Access Key untuk alamat penerima kampus yang telah dikonfirmasi tersedia.",
          true
        );
        return;
      }

      configNotice.classList.add("hidden");
      submitting = true;
      submitButton.disabled = true;
      submitButton.setAttribute("aria-busy", "true");
      submitButton.innerHTML = '<span class="material-symbols-outlined animate-spin text-[20px]" aria-hidden="true">progress_activity</span><span>Mengirim formulir...</span>';
      status.classList.add("hidden");

      var formData = new FormData(form);
      var payload = {
        access_key: accessKey,
        subject: "Pendaftaran Mahasiswa Baru - Politeknik Surabaya",
        from_name: "Politeknik Surabaya",
        name: formData.get("name"),
        email: formData.get("email"),
        phone: formData.get("phone"),
        program_studi: formData.get("program_studi")
      };

      try {
        var response;
        try {
          response = await fetch("https://api.web3forms.com/submit", {
            method: "POST",
            headers: {
              "Content-Type": "application/json",
              Accept: "application/json"
            },
            body: JSON.stringify(payload)
          });
        } catch (error) {
          throw new Error("Layanan pengiriman tidak dapat dihubungi. Periksa koneksi internet Anda, lalu coba kembali.");
        }

        var result;
        try {
          result = await response.json();
        } catch (error) {
          throw new Error("Respons layanan pengiriman tidak dapat dibaca. Silakan coba kembali.");
        }
        if (
          !response.ok ||
          !result ||
          typeof result !== "object" ||
          result.success !== true
        ) {
          throw new Error(
            result &&
              typeof result.message === "string" &&
              result.message
              ? result.message
              : "Server belum mengonfirmasi pengiriman formulir."
          );
        }

        form.reset();
        form.classList.add("hidden");
        successPanel.classList.remove("hidden");
        successTitle.focus();
        successPanel.scrollIntoView({ behavior: "smooth", block: "center" });
      } catch (error) {
        var detail = error instanceof Error ? error.message : "";
        showStatus(
          "Formulir gagal dikirim. " +
            (detail || "Periksa koneksi internet Anda, lalu coba kembali."),
          true
        );
      } finally {
        submitting = false;
        submitButton.disabled = false;
        submitButton.removeAttribute("aria-busy");
        submitButton.innerHTML = '<span class="material-symbols-outlined text-[20px]" aria-hidden="true">send</span><span>Kirim Formulir Pendaftaran</span>';
      }
    });
  }

  if (document.readyState === "loading") {
    document.addEventListener("DOMContentLoaded", initRegistrationForm, { once: true });
  } else {
    initRegistrationForm();
  }
})();

// Sertifikasi profesi: accordion sertifikat dan lightbox pratinjau dokumen.
(() => {
  "use strict";

  function initCertAccordion() {
    var accordion = document.querySelector("[data-cert-accordion]");
    if (!accordion) return;
    var trigger = accordion.querySelector(".cert-trigger");
    var panel = accordion.querySelector(".cert-panel");
    if (!trigger || !panel) return;

    trigger.addEventListener("click", function () {
      var isOpen = accordion.classList.toggle("is-open");
      trigger.setAttribute("aria-expanded", String(isOpen));
      panel.setAttribute("aria-hidden", String(!isOpen));
    });
  }

  function initCertLightbox() {
    var lightbox = document.getElementById("cert-lightbox");
    var lightboxImg = document.getElementById("cert-lightbox-img");
    var closeBtn = document.getElementById("cert-lightbox-close");
    if (!lightbox || !lightboxImg || !closeBtn) return;
    var lastOpenedButton = null;

    function open(src, alt, button) {
      lastOpenedButton = button;
      lightboxImg.src = src;
      lightboxImg.alt = alt || "Dokumen sertifikat";
      lightbox.classList.remove("hidden");
      lightbox.classList.add("flex");
      lightbox.setAttribute("aria-hidden", "false");
      document.body.style.overflow = "hidden";
      closeBtn.focus();
    }

    function close() {
      lightbox.classList.add("hidden");
      lightbox.classList.remove("flex");
      lightbox.setAttribute("aria-hidden", "true");
      lightboxImg.src = "";
      document.body.style.overflow = "";
      if (lastOpenedButton) lastOpenedButton.focus();
    }

    document.querySelectorAll("[data-lightbox-src]").forEach(function (btn) {
      btn.addEventListener("click", function () {
        open(
          btn.getAttribute("data-lightbox-src"),
          btn.getAttribute("data-lightbox-alt"),
          btn
        );
      });
    });

    closeBtn.addEventListener("click", close);
    lightbox.addEventListener("click", function (e) {
      if (e.target === lightbox) close();
    });
    document.addEventListener("keydown", function (e) {
      if (e.key === "Escape" && !lightbox.classList.contains("hidden")) {
        close();
      }
    });
  }

  function initCertificationPage() {
    initCertAccordion();
    initCertLightbox();
  }

  if (document.readyState === "loading") {
    document.addEventListener("DOMContentLoaded", initCertificationPage, { once: true });
  } else {
    initCertificationPage();
  }
})();
