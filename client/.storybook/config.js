import { configure, addDecorator, addParameters } from '@storybook/vue';
import { withInfo } from 'storybook-addon-vue-info';
import { withKnobs } from '@storybook/addon-knobs';

addDecorator(withInfo);
addDecorator(withKnobs);

addParameters({
  options: {
    name: 'Mentor-mentee matchmaking component library',
    panelPosition: 'right',
    sortStoriesByKind: true,
  },
});

function loadStories() {
  const req = require.context('../src', true, /\.stories\.js$/);
  req.keys().forEach(filename => req(filename));
}

configure(loadStories, module);
