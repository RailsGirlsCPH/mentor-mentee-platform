import { configure } from "@storybook/react";

function loadStories() {
  require("../src/stories/stories.js");
}

configure(loadStories, module);