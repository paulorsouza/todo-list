import configureStore from 'redux-mock-store';
import thunk from 'redux-thunk';
import * as constants from '../../constants/application';
import * as actions from '../application';

const mockStore = configureStore([thunk]);
const store = mockStore();

describe('changePage', () => {
  it('should dispatches changePage action', () => {
    store.clearActions();
    store.dispatch(actions.changePage('todolist'));
    const resultActions = store.getActions();
    expect(resultActions[0].type).toEqual(constants.CHANGE_PAGE);
    expect(resultActions[0].currentPage).toEqual('todolist');
  });
});
