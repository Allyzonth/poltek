// Tailwind design tokens exported from the original Google Stitch file.
tailwind.config = {
  darkMode: "class",
  theme: {
    extend: {
      colors: {
        "surface-variant": "#d7e2ff",
        "inverse-surface": "#243048",
        "outline-variant": "#c4c6d3",
        primary: "#002566",
        "on-tertiary-container": "#ff8a88",
        "tertiary-fixed": "#ffdad8",
        "surface-container-low": "#f1f3ff",
        "on-tertiary-fixed": "#410006",
        "primary-fixed": "#dae2ff",
        "tertiary-container": "#860017",
        "surface-container-high": "#e0e8ff",
        "surface-container-highest": "#d7e2ff",
        "inverse-on-surface": "#ecf0ff",
        "on-primary-fixed-variant": "#1c4292",
        "secondary-fixed-dim": "#b4c5ff",
        secondary: "#1d52cb",
        "secondary-fixed": "#dbe1ff",
        "primary-container": "#123b8b",
        "error-container": "#ffdad6",
        "surface-container": "#e8eeff",
        error: "#ba1a1a",
        "on-tertiary": "#ffffff",
        "on-secondary-fixed-variant": "#003daa",
        outline: "#747783",
        "on-tertiary-fixed-variant": "#93001b",
        "surface-bright": "#f9f9ff",
        "surface-tint": "#395bab",
        "on-error": "#ffffff",
        "on-secondary-container": "#fefcff",
        surface: "#f9f9ff",
        "on-error-container": "#93000a",
        "on-primary-fixed": "#001848",
        "on-background": "#0e1b32",
        "primary-fixed-dim": "#b2c5ff",
        background: "#f9f9ff",
        tertiary: "#5c000d",
        "tertiary-fixed-dim": "#ffb3b0",
        "on-primary-container": "#8aa9ff",
        "on-primary": "#ffffff",
        "surface-container-lowest": "#ffffff",
        "on-secondary-fixed": "#00174c",
        "inverse-primary": "#b2c5ff",
        "surface-dim": "#cddaf9",
        "on-surface": "#0e1b32",
        "secondary-container": "#3f6de5",
        "on-secondary": "#ffffff",
        "on-surface-variant": "#444651",
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
