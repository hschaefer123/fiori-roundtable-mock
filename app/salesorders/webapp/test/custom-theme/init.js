sap.ui.define([], function () {
    "use strict";

    function injectCssFile(href) {
        if (document.querySelector(`link[data-preview-style="${href}"]`)) {
            return;
        }

        const link = document.createElement("link");
        link.rel = "stylesheet";
        link.href = href;
        link.setAttribute("data-preview-style", href);
        document.head.appendChild(link);
    }

    function injectInlineCss(cssText) {
        if (document.getElementById("custom-preview-style")) {
            return;
        }

        const style = document.createElement("style");
        style.id = "custom-preview-style";
        style.textContent = cssText;
        document.head.appendChild(style);
    }

    // Variante A: externe CSS-Datei
    injectCssFile("custom-theme/variables-light.css");
    injectCssFile("custom-theme/variables-dark.css");

    // Variante B: inline CSS
    injectInlineCss(`
        #shell-header-icon {
          content: var(--sapCompanyLogo);
        }
        .sapUiGlobalBackgroundImage {
          background-image: var(--sapShell_BackgroundImage) !important;
        }
  `);
});