import { configure } from "@storybook/react";

function loadStories() {
  require("../src/stories/avatar.story");
}

configure(loadStories, module);