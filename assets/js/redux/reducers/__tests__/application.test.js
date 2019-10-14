import reducer, { initialState } from '../application';
import * as constants from '../../constants/application';

describe('CHANGE_PAGE reducer', () => {
  it('returns the correct state', () => {
    const action = {
      type: constants.CHANGE_PAGE,
      currentPage: 'todolist'
    };
    const newState = reducer(initialState, action);
    expect(newState.currentPage).toEqual('todolist');
  });
});
