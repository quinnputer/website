import tailwindcss from "@tailwindcss/vite";
import { defineConfig } from "astro/config";

import svelte from "@astrojs/svelte";

export default defineConfig({
  vite: { plugins: [tailwindcss()] },
  server: { host: true },
  integrations: [svelte()],
});
