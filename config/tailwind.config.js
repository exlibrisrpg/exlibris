const defaultTheme = require("tailwindcss/defaultTheme")
const plugin = require("tailwindcss/plugin")

function withOpacityValue(variable) {
  return ({ opacityValue }) => {
    if (opacityValue === undefined) {
      return `hsl(var(${variable}))`
    }
    return `hsl(var(${variable}) / ${opacityValue})`
  }
}

function colorDefinition(type) {
  return Object.fromEntries(
    Array.from(Array(13).keys())
      .slice(1)
      .map((i) => [i, withOpacityValue(`--color--${type}-${i}`)])
  )
}

module.exports = {
  content: [
    "./app/components/**/*.{erb,rb}",
    "./app/helpers/**/*.rb",
    "./app/javascript/**/*.js",
    "./app/views/**/{*,_*}.erb",
    "./test/components/docs/*.md.erb",
    "./test/components/previews/*.{erb,rb}"
  ],
  theme: {
    colors: {
      inherit: "inherit",
      current: "currentColor",
      transparent: "transparent",
      black: "black",
      white: "white",
      accent: colorDefinition("accent"),
      main: colorDefinition("main"),
      primary: colorDefinition("primary"),
      secondary: colorDefinition("secondary")
    },
    fontFamily: {
      brand: "var(--font-family--brand)",
      body: "var(--font-family--body)",
      display: "var(--font-family--display)"
    },
    container: {
      screens: {
        DEFAULT: "100%",
        lg: "1024px"
      }
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
    require("@tailwindcss/typography"),
    plugin(function ({ addVariant }) {
      addVariant("busy", "&[busy]")
      addVariant("group-busy", ":merge(.group)[busy] &")
      addVariant("peer-busy", "[busy] ~ &")
      addVariant("disabled", ["&[disabled]", "&[aria-disabled='true']"])
      addVariant("group-disabled", [
        ":merge(.group)[disabled] &",
        ":merge(.group)[aria-disabled='true'] &"
      ])
      addVariant("peer-disabled", [
        "[disabled] ~ &",
        "[aria-disabled='true'] ~ &"
      ])
      addVariant("aria-selected", "&[aria-selected=true]")
    })
  ]
}
