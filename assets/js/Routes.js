import * as React from 'react';
import PropTypes from 'prop-types';
import { Route, Switch, Redirect } from 'react-router-dom';
import SignUpPage from './container/SignUpPage';
import SignInPage from './container/SignInPage';
import TaskCreate from './container/TaskCreate';
import TaskEdit from './container/TaskEdit';
import PublicTaskPage from './container/PublicTaskPage';
import FavoritePage from './container/FavoritePage';
import MyTaskPage from './container/MyTaskPage';
import AccountPage from './container/AccountPage';
import UserProfilePage from './container/UserProfilePage';
import LandingPage from './components/LandingPage';
import RecoverAccount from './container/RecoverAccount';

const Authenticated = (props) => {
  const { component: Component, ...rest } = props;
  const token = localStorage.getItem('toDoListToken');
  return (
    <Route
      {...rest}
      render={(renderProps) => {
        if (token) {
          return (
            <Component {...renderProps} />
          );
        }
        return (
          <Redirect to={{
            pathname: '/sign-in',
            state: { from: renderProps.location }
          }}
          />
        );
      }
    }
    />
  );
};

const HomeRoute = (props) => {
  const { component: Component, ...rest } = props;
  const token = localStorage.getItem('toDoListToken');
  return (
    <Route
      {...rest}
      render={(renderProps) => {
        if (token) {
          return (
            <PublicTaskPage
              {...renderProps}
              anonymous={false}
            />);
        }
        return (<LandingPage {...renderProps} />);
      }}
    />
  );
};

const Recover = (props) => {
  const { location, match } = props;
  localStorage.setItem('toDoListToken', match.params.token);
  return <Redirect to={{ pathname: '/', state: { from: location } }} />;
};

Recover.propTypes = {
  location: PropTypes.object.isRequired,
  match: PropTypes.object.isRequired
};

const RecentTasks = () => {
  return <PublicTaskPage anonymous={false} />;
};

export default () => {
  return (
    <Switch>
      <Route exact path="/sign-up" component={SignUpPage} />
      <Route exact path="/sign-in" component={SignInPage} />
      <Route exact path="/recover-account" component={RecoverAccount} />
      <Route exact path="/recover-account/:token" component={Recover} />
      <Route exact path="/public-tasks" component={PublicTaskPage} />
      <Authenticated exact path="/task-create" component={TaskCreate} />
      <Authenticated exact path="/task/:id" component={TaskEdit} />
      <Authenticated exact path="/recent-lists" component={RecentTasks} />
      <Authenticated exact path="/favorites" component={FavoritePage} />
      <Authenticated exact path="/my-to-do-lists" component={MyTaskPage} />
      <Authenticated exact path="/account" component={AccountPage} />
      <Authenticated exact path="/user/:username/profile" component={UserProfilePage} />
      <HomeRoute />
    </Switch>
  );
};
