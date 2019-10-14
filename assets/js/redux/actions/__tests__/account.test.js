import configureStore from 'redux-mock-store';
import thunk from 'redux-thunk';
import * as constants from '../../constants/account';
import * as actions from '../account';

const mockStore = configureStore([thunk]);
const store = mockStore();

describe('signUp', () => {
  describe('success signUp', () => {
    beforeAll(async () => {
      fetch.resetMocks();
      store.clearActions();
      localStorage.clear();
      fetch.mockResponse(JSON.stringify({ token: 'teste' }));
      await store.dispatch(actions.signUp({ username: 'teste' }));
    });

    it('should dispatches signUp action', () => {
      const resultActions = store.getActions();
      expect(resultActions[0].type).toEqual(constants.SIGN_UP);
    });

    it('should dispatches push to /', () => {
      const resultActions = store.getActions();
      expect(resultActions[1].type).toEqual('@@router/CALL_HISTORY_METHOD');
      expect(resultActions[1].payload.method).toEqual('push');
      expect(resultActions[1].payload.args).toEqual(['/']);
    });

    it('should save token in localStorage', () => {
      expect(localStorage.getItem('toDoListToken')).toEqual('teste');
    });
  });

  describe('error signUp', () => {
    beforeAll(async () => {
      fetch.resetMocks();
      store.clearActions();
      localStorage.clear();
      fetch.mockReject({
        response: {
          json: () => Promise.resolve(
            JSON.stringify({ errors: { field: ['msg'] } })
          )
        }
      });
      await store.dispatch(actions.signUp({ }));
    });

    it('should dispatches error', () => {
      const resultActions = store.getActions();
      expect(resultActions[0].type).toEqual(constants.ERRORS);
      expect(resultActions[0].errors).toEqual(
        JSON.stringify({ errors: { field: ['msg'] } })
      );
    });

    it('should save token in localStorage', () => {
      expect(localStorage.getItem('toDoListToken')).toBeFalsy();
    });
  });
});

describe('signIn', () => {
  describe('success signIn', () => {
    beforeAll(async () => {
      fetch.resetMocks();
      store.clearActions();
      localStorage.clear();
      fetch.mockResponse(JSON.stringify({ token: 'teste' }));
      await store.dispatch(actions.signIn({ username: 'teste' }));
    });

    it('should dispatches signUp action', () => {
      const resultActions = store.getActions();
      expect(resultActions[0].type).toEqual(constants.SIGN_IN);
    });

    it('should dispatches push to /', () => {
      const resultActions = store.getActions();
      expect(resultActions[1].type).toEqual('@@router/CALL_HISTORY_METHOD');
      expect(resultActions[1].payload.method).toEqual('push');
      expect(resultActions[1].payload.args).toEqual(['/']);
    });

    it('should save token in localStorage', () => {
      expect(localStorage.getItem('toDoListToken')).toEqual('teste');
    });
  });

  describe('error signIn', () => {
    beforeAll(async () => {
      fetch.resetMocks();
      store.clearActions();
      localStorage.clear();
      fetch.mockReject({
        response: {
          json: () => Promise.resolve(
            JSON.stringify({ errors: { field: ['msg'] } })
          )
        }
      });
      await store.dispatch(actions.signIn({ }));
    });

    it('should dispatches error', () => {
      const resultActions = store.getActions();
      expect(resultActions[0].type).toEqual(constants.ERRORS);
      expect(resultActions[0].errors).toEqual(
        JSON.stringify({ errors: { field: ['msg'] } })
      );
    });

    it('should save token in localStorage', () => {
      expect(localStorage.getItem('toDoListToken')).toBeFalsy();
    });
  });
});

describe('load', () => {
  it('should dispatches load action', async () => {
    fetch.resetMocks();
    store.clearActions();
    fetch.mockResponse(JSON.stringify({
      data: { username: 'teste', email: 't@t' }
    }));
    await store.dispatch(actions.load());
    const resultActions = store.getActions();
    expect(resultActions[0].type).toEqual(constants.LOAD);
    expect(resultActions[0].currentUser).toEqual({ username: 'teste', email: 't@t' });
  });
});

describe('update', () => {
  it('should dispatches update action', async () => {
    fetch.resetMocks();
    store.clearActions();
    localStorage.clear();
    fetch.mockResponse(JSON.stringify({ token: 'update' }));
    await store.dispatch(actions.update({ user: { username: 'teste', email: 't@t' } }));
    const resultActions = store.getActions();
    expect(localStorage.getItem('toDoListToken')).toEqual('update');
    expect(resultActions[0].type).toEqual(constants.UPDATE);
    expect(resultActions[1].type).toEqual('@@router/CALL_HISTORY_METHOD');
    expect(resultActions[1].payload.method).toEqual('goBack');
    expect(resultActions[1].payload.args).toEqual([1]);
  });
});

describe('favorite/unfavorite', () => {
  it('should dispatches favorite action', async () => {
    fetch.resetMocks();
    store.clearActions();
    fetch.mockResponse();
    await store.dispatch(actions.favorite(1));
    const resultActions = store.getActions();
    expect(resultActions[0].type).toEqual(constants.FAVORITE);
    expect(resultActions[0].taskId).toEqual(1);
  });

  it('should dispatches unfavorite action', async () => {
    fetch.resetMocks();
    store.clearActions();
    fetch.mockResponse();
    await store.dispatch(actions.unfavorite(1));
    const resultActions = store.getActions();
    expect(resultActions[0].type).toEqual(constants.UNFAVORITE);
    expect(resultActions[0].taskId).toEqual(1);
  });
});

describe('my favorites', () => {
  it('should dispatches load user favorites', async () => {
    fetch.resetMocks();
    store.clearActions();
    const response = { data: [{ id: 1 }, { id: 2 }] };
    fetch.mockResponse(JSON.stringify(response));
    await store.dispatch(actions.myFavorites());
    const resultActions = store.getActions();
    expect(resultActions[0].type).toEqual(constants.MY_FAVORITES);
    expect(resultActions[0].favorites).toEqual([{ id: 1 }, { id: 2 }]);
  });

  it('should clear user favorites', () => {
    store.clearActions();
    store.dispatch(actions.clearMyFavorites());
    const resultActions = store.getActions();
    expect(resultActions[0].type).toEqual(constants.MY_FAVORITES);
    expect(resultActions[0].favorites).toEqual([]);
  });
});

describe('my tasks', () => {
  it('should dispatches load user tasks', async () => {
    fetch.resetMocks();
    store.clearActions();
    const response = { data: [{ id: 1 }, { id: 2 }] };
    fetch.mockResponse(JSON.stringify(response));
    await store.dispatch(actions.loadMyTasks());
    const resultActions = store.getActions();
    expect(resultActions[0].type).toEqual(constants.MY_TASKS);
    expect(resultActions[0].myTasks).toEqual([{ id: 1 }, { id: 2 }]);
  });

  it('should clear my tasks', () => {
    store.clearActions();
    store.dispatch(actions.clearMyTasks());
    const resultActions = store.getActions();
    expect(resultActions[0].type).toEqual(constants.MY_TASKS);
    expect(resultActions[0].myTasks).toEqual([]);
  });
});

describe('load user profile', () => {
  it('should dispatches load user profile', async () => {
    fetch.resetMocks();
    store.clearActions();
    const response = { data: [{ id: 1 }, { id: 2 }] };
    fetch.mockResponse(JSON.stringify(response));
    await store.dispatch(actions.loadUserProfile('teste'));
    const resultActions = store.getActions();
    expect(resultActions[0].type).toEqual(constants.LOAD_USER_PROFILE);
    expect(resultActions[0].userProfile).toEqual([{ id: 1 }, { id: 2 }]);
  });

  it('should clear user profile', () => {
    store.clearActions();
    store.dispatch(actions.clearProfile());
    const resultActions = store.getActions();
    expect(resultActions[0].type).toEqual(constants.LOAD_USER_PROFILE);
    expect(resultActions[0].userProfile).toEqual([]);
  });
});
