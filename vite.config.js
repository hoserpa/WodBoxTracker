import { defineConfig } from "vite";
import vue from "@vitejs/plugin-vue";
import tailwindcss from "@tailwindcss/vite";
import path from "path";
import fs from "fs";

const CSP = [
  "default-src 'self'",
  "script-src 'self'",
  "style-src 'self' 'unsafe-inline'",
  "img-src 'self' data:",
  "font-src 'self'",
  "connect-src 'self' https://*.supabase.co",
  "worker-src 'self'",
  "manifest-src 'self'",
  "object-src 'none'",
  "base-uri 'self'",
  "form-action 'self'",
  "frame-src 'none'",
].join("; ");

const cspPlugin = () => ({
  name: "inject-csp-meta",
  transformIndexHtml(html, ctx) {
    if (ctx.server) return html;
    return html.replace(
      "<!-- injected-csp-meta -->",
      `<meta http-equiv="Content-Security-Policy" content="${CSP}" />`,
    );
  },
});

const swVersionPlugin = () => ({
  name: "version-sw-cache",
  apply: "build",
  closeBundle() {
    const swPath = path.resolve(__dirname, "dist", "sw.js");
    if (!fs.existsSync(swPath)) return;
    const versioned = fs
      .readFileSync(swPath, "utf8")
      .replaceAll("__BUILD_VERSION__", Date.now().toString(36));
    fs.writeFileSync(swPath, versioned);
  },
});

export default defineConfig({
  base: "./",
  plugins: [vue(), tailwindcss(), cspPlugin(), swVersionPlugin()],
  resolve: {
    alias: {
      "@": path.resolve(__dirname, "./src"),
    },
  },
});
