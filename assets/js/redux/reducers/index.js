import { combineReducers } from 'redux';
import { connectRouter } from 'connected-react-router';
import account from './account';
import todolist from './todolist';
import application from './application';

export default history => combineReducers({
  router: connectRouter(history),
  account,
  todolist,
  application
});
