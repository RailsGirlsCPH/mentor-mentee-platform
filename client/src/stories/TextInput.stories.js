import { storiesOf } from '@storybook/vue';
import { text } from '@storybook/addon-knobs';

import TextInput from '../components/TextInput.vue';

storiesOf('Components/Input', module).add(
  'Default',
  () => ({
    components: { 'text-input': TextInput },
    template: `
      <div>
        <text-input
          :label="label"
          :placeholder="placeholder"
          :searchValue="searchValue"
          @change="searchValue = $event"
        />
        <p>{{ searchValue }}</p>
      </div>`,
    props: {
      label: {
        default: text('Label', 'Label'),
      },
      placeholder: {
        default: text('Placeholder', 'Type something'),
      },
      searchValue: {
        default: text('Search Value', 'hello storybook'),
      },
    },
  }),
  {
    info: {},
  }
);
