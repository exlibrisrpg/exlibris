import "@hotwired/turbo-rails"
import "./controllers"

import * as ActiveStorage from "@rails/activestorage"

require("trix")
require("@rails/actiontext")

ActiveStorage.start()
