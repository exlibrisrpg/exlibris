// Load all the controllers within this directory and all subdirectories.
// Controller files must be named *_controller.js.

import { Application } from "@hotwired/stimulus"

import ComboboxController from "./combobox_controller"
import FrameController from "./frame_controller"
import FormController from "./form_controller"
import HideController from "./hide_controller"
import NestedFormController from "./nested_form_controller"
import ReelController from "./reel_controller"
import ScrollProgressController from "./scroll_progress_controller"
import SearchHighlightsController from "./search_highlights_controller"

window.Stimulus = Application.start()
Stimulus.register("combobox", ComboboxController)
Stimulus.register("frame", FrameController)
Stimulus.register("form", FormController)
Stimulus.register("hide", HideController)
Stimulus.register("nested-form", NestedFormController)
Stimulus.register("reel", ReelController)
Stimulus.register("scroll-progress", ScrollProgressController)
Stimulus.register("search-highlights", SearchHighlightsController)
