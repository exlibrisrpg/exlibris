const defaultTheme = require("tailwindcss/defaultTheme")

module.exports = {
  content: [
    "./app/components/**/*.erb",
    "./app/helpers/**/*.rb",
    "./app/javascript/**/*.js",
    "./app/views/**/*.erb"
  ],
  theme: {
    colors: {
      inherit: "inherit",
      current: "current",
      transparent: "transparent",
      black: "black",
      white: "white"
    },
    fontFamily: {
      brand: "var(--font-family--brand)",
      body: "var(--font-family--body)",
      display: "var(--font-family--display)"
    }
  },
  // Prefix all classes with tw-* for now to ensure no collisions with the
  // original Mörk Borg design during the theme extraction process
  prefix: "tw-",
  plugins: [
    require("@tailwindcss/forms")({
      // Apply form classes manually as they are reviewed in the theme
      // extraction process:
      // https://github.com/tailwindlabs/tailwindcss-forms#using-classes-to-style
      strategy: "class"
    }),
    require("@tailwindcss/aspect-ratio"),
    require("@tailwindcss/typography")
  ]
}
