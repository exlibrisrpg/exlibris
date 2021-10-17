// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import "@hotwired/turbo-rails"
import * as ActiveStorage from "@rails/activestorage"
import "channels"

ActiveStorage.start()

require("trix")
require("@rails/actiontext")

require.context("../favicons", true)
require.context("../fonts", true)
require.context("../images", true)

import "controllers"
import "../scss/application.scss"
