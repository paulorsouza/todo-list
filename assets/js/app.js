import * as React from 'react';
import * as ReactDOM from 'react-dom';
import Root from './Root';
import Routes from './Routes';

ReactDOM.render(
  <Root>
    <Routes />
  </Root>,
  document.getElementById('react-app')
);
