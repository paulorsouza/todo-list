import React from 'react';
import PropTypes from 'prop-types';
import createHistory from 'history/createBrowserHistory';
import { createStore, applyMiddleware, compose } from 'redux';
import { Provider } from 'react-redux';
import thunk from 'redux-thunk';
import { routerMiddleware, ConnectedRouter } from 'connected-react-router';
import createReducer from './redux/reducers';

const history = createHistory();
const reducer = createReducer(history);

const store = createStore(
  reducer,
  compose(applyMiddleware(thunk, routerMiddleware(history)))
);

const Root = (props) => {
  const { children } = props;
  return (
    <Provider store={store}>
      <ConnectedRouter history={history}>
        {children}
      </ConnectedRouter>
    </Provider>
  );
};

Root.propTypes = {
  children: PropTypes.element.isRequired
};

export default Root;
