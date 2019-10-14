import reducer, { initialState } from '../account';
import * as constants from '../../constants/account';

const errors = { errors: { field: ['msg'] } };

describe('SIGN_IN reducer', () => {
  it('returns the correct state', () => {
    const oldState = { errors };
    const action = { type: constants.SIGN_IN };
    const newState = reducer(oldState, action);
    expect(newState.errors).toEqual(null);
  });
});

describe('SIGN_UP reducer', () => {
  it('returns the correct state', () => {
    const oldState = { errors };
    const action = { type: constants.SIGN_UP };
    const newState = reducer(oldState, action);
    expect(newState.errors).toEqual(null);
  });
});

describe('UPDATE reducer', () => {
  it('returns the correct state', () => {
    const oldState = { errors };
    const action = { type: constants.UPDATE };
    const newState = reducer(oldState, action);
    expect(newState.errors).toEqual(null);
  });
});

describe('ERRORS reducer', () => {
  it('returns the correct state', () => {
    const action = { type: constants.ERRORS, errors };
    const newState = reducer(initialState, action);
    expect(newState.errors).toEqual(errors);
  });
});

describe('LOAD reducer', () => {
  it('returns the correct state', () => {
    const action = {
      type: constants.LOAD,
      currentUser: { username: 'teste', email: 't@t' }
    };
    const newState = reducer(initialState, action);
    expect(newState.currentUser).toEqual({ username: 'teste', email: 't@t' });
  });
});

describe('MY_FAVORITES reducer', () => {
  it('returns the correct state', () => {
    const action = {
      type: constants.MY_FAVORITES,
      favorites: [{ id: 1 }, { id: 2 }]
    };
    const newState = reducer(initialState, action);
    expect(newState.favorites).toEqual([{ id: 1 }, { id: 2 }]);
  });
});

describe('MY_TASKS reducer', () => {
  it('returns the correct state', () => {
    const action = {
      type: constants.MY_TASKS,
      myTasks: [{ id: 1 }, { id: 2 }]
    };
    const newState = reducer(initialState, action);
    expect(newState.myTasks).toEqual([{ id: 1 }, { id: 2 }]);
  });
});

describe('LOAD_USER_PROFILE reducer', () => {
  it('returns the correct state', () => {
    const action = {
      type: constants.LOAD_USER_PROFILE,
      userProfile: [{ id: 1 }, { id: 2 }]
    };
    const newState = reducer(initialState, action);
    expect(newState.userProfile).toEqual([{ id: 1 }, { id: 2 }]);
  });
});
