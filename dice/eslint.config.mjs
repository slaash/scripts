import html from "eslint-plugin-html";
import js from "@eslint/js";

export default [
  js.configs.recommended,
  {
    plugins: { html },
    files: ["**/*.html"],
    languageOptions: {
      ecmaVersion: 2022,
      sourceType: "script",
      parserOptions: {
        ecmaFeatures: { jsx: true },
      },
      globals: {
        // Browser
        window: "readonly", document: "readonly", fetch: "readonly",
        console: "readonly", setTimeout: "readonly", clearTimeout: "readonly",
        setInterval: "readonly", clearInterval: "readonly",
        URL: "readonly", Blob: "readonly", FileReader: "readonly", Image: "readonly",
        AbortController: "readonly", AbortSignal: "readonly", crypto: "readonly",
        DOMParser: "readonly", TextDecoder: "readonly",
        Promise: "readonly", Set: "readonly", Map: "readonly",
        // React (loaded via CDN)
        React: "readonly", ReactDOM: "readonly",
      },
    },
    rules: {
      "no-unused-vars": "warn",
      "no-undef": "error",
      "no-console": "off",
      "no-constant-condition": "warn",
      "no-unreachable": "warn",
    },
  },
];
