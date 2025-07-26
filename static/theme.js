// ==================================================================
// 🌙 theme.js — Gestion du dark mode (localStorage + toggle live)
// ==================================================================

document.addEventListener("DOMContentLoaded", function () {
  const toggle = document.getElementById("toggle-theme");

  // 🔁 Vérifie si un thème est déjà stocké
  const currentTheme = localStorage.getItem("theme");
  if (currentTheme === "dark") {
    document.body.classList.add("dark-mode");
    if (toggle) toggle.checked = true;
  }

  // 🎚️ Lorsqu'on clique sur le bouton toggle
  if (toggle) {
    toggle.addEventListener("change", function () {
      if (this.checked) {
        document.body.classList.add("dark-mode");
        localStorage.setItem("theme", "dark");
      } else {
        document.body.classList.remove("dark-mode");
        localStorage.setItem("theme", "light");
      }
    });
  }
});
