import React from 'react';
import {storiesOf} from '@storybook/react';
// Import your component file here
import Avatar from '../components/avatar/avatarComponent';
import SampleButton from '../components/sampleButton/sampleButton.component';

// Add the stories of your components here
storiesOf ('avatar', module).add ('avatar', () => <Avatar />);
storiesOf ('Sample button', module).add ('sample button', () => (
  <SampleButton />
));
