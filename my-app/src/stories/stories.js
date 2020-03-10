import React from 'react';
import {storiesOf} from '@storybook/react';
// Import your component file here
import Avatar from '../components/avatar/avatarComponent';
import SampleButton from '../components/sampleButton/sampleButton.component';
import Link from '../components/link/linkComponent';
import Name from '../components/name/Name';
import Card from '../components/Card/Card';

// Add the stories of your components here
storiesOf ('avatar', module).add ('avatar', () => <Avatar />);
storiesOf ('Sample button', module).add ('sample button', () => (
  <SampleButton />
));

storiesOf ('linkComponent', module).add ('link', () => <Link email="example@gmail.com"/>);
storiesOf ('name', module).add ('first name', () => <Name name="Joe" />);
storiesOf ('name', module).add ('surname', () => <Name name="Johnson" />);
storiesOf ('card', module).add ('card', () => <Card name="Johnson" />);

