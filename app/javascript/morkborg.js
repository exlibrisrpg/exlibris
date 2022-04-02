import "./controllers"

import HighlightController from "./controllers/highlight_controller"
import SearchHighlightsController from "./controllers/search_highlights_controller"

Stimulus.register("highlight", HighlightController)
Stimulus.register("search-highlights", SearchHighlightsController)
