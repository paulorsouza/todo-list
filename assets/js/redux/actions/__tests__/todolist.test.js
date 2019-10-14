import configureStore from 'redux-mock-store';
import thunk from 'redux-thunk';
import * as constants from '../../constants/todolist';
import * as actions from '../todolist';

const mockStore = configureStore([thunk]);
const store = mockStore();

describe('success actions', () => {
  beforeEach(() => {
    fetch.resetMocks();
    store.clearActions();
  });

  it('should dispatches clear action', () => {
    store.dispatch(actions.clear());
    const resultActions = store.getActions();
    expect(resultActions[0].type).toEqual(constants.CLEAR);
  });

  it('should dispatches load action', async () => {
    const response = {
      data: { id: 1 },
      is_favorite: false,
      read_only: true
    };
    fetch.mockResponse(JSON.stringify(response));
    await store.dispatch(actions.load(1));
    const resultActions = store.getActions();
    expect(resultActions[0].type).toEqual(constants.LOAD_TASK);
    expect(resultActions[0].readOnly).toBeTruthy();
    expect(resultActions[0].isFavorite).toBeFalsy();
    expect(resultActions[0].task).toEqual({ id: 1 });
  });

  it('should dispatches loadPublic action', async () => {
    const response = {
      data: [{ id: 1 }, { id: 2 }],
    };
    fetch.mockResponse(JSON.stringify(response));
    await store.dispatch(actions.loadPublic());
    const resultActions = store.getActions();
    expect(resultActions[0].type).toEqual(constants.LOAD_PUBLIC);
    expect(resultActions[0].publicTasks).toEqual([{ id: 1 }, { id: 2 }]);
  });

  it('should dispatches create action', async () => {
    const response = { data: { id: 1 } };
    fetch.mockResponse(JSON.stringify(response));
    await store.dispatch(actions.create({ task: { title: 'teste' } }));
    const resultActions = store.getActions();
    expect(resultActions[0].type).toEqual(constants.CREATE);
    expect(resultActions[0].newTask).toEqual({ id: 1 });
    expect(resultActions[1].type).toEqual('@@router/CALL_HISTORY_METHOD');
    expect(resultActions[1].payload.method).toEqual('push');
    expect(resultActions[1].payload.args).toEqual(['/task/1']);
  });

  it('should dispatches createItem action', async () => {
    const response = { data: { id: 1 } };
    fetch.mockResponse(JSON.stringify(response));
    await store.dispatch(actions.createItem({ title: 'teste' }));
    const resultActions = store.getActions();
    expect(resultActions[0].type).toEqual(constants.ADD_ITEM);
    expect(resultActions[0].newItem).toEqual({ id: 1 });
  });

  it('should dispatches deleteItem action', async () => {
    fetch.mockResponse();
    await store.dispatch(actions.deleteItem(2));
    const resultActions = store.getActions();
    expect(resultActions[0].type).toEqual(constants.DELETE_ITEM);
    expect(resultActions[0].itemId).toEqual(2);
  });

  it('should dispatches deleteTask action', async () => {
    fetch.mockResponse();
    await store.dispatch(actions.deleteTask(2));
    const resultActions = store.getActions();
    expect(resultActions[0].type).toEqual('@@router/CALL_HISTORY_METHOD');
    expect(resultActions[0].payload.method).toEqual('goBack');
  });

  it('should dispatches updateTaskItem action', async () => {
    const response = { data: { title: 'updated' } };
    fetch.mockResponse(JSON.stringify(response));
    await store.dispatch(actions.updateTaskItem(2));
    const resultActions = store.getActions();
    expect(resultActions[0].type).toEqual(constants.UPDATE_ITEM);
    expect(resultActions[0].updatedItem).toEqual({ title: 'updated' });
  });

  it('should clear public tasks', () => {
    store.clearActions();
    store.dispatch(actions.clearPublicTasks());
    const resultActions = store.getActions();
    expect(resultActions[0].type).toEqual(constants.LOAD_PUBLIC);
    expect(resultActions[0].publicTasks).toEqual([]);
  });
});

describe('error actions', () => {
  beforeEach(() => {
    fetch.resetMocks();
    store.clearActions();
    fetch.mockReject({
      response: {
        json: () => Promise.resolve(
          JSON.stringify({ errors: { field: ['msg'] } })
        )
      }
    });
  });

  describe('load', () => {
    it('should dispatches error', async () => {
      await store.dispatch(actions.load());
      const resultActions = store.getActions();
      expect(resultActions[0].type).toEqual(constants.ERRORS);
      expect(resultActions[0].errors).toEqual(
        JSON.stringify({ errors: { field: ['msg'] } })
      );
    });
  });

  describe('create', () => {
    it('should dispatches error', async () => {
      await store.dispatch(actions.create());
      const resultActions = store.getActions();
      expect(resultActions[0].type).toEqual(constants.ERRORS);
      expect(resultActions[0].errors).toEqual(
        JSON.stringify({ errors: { field: ['msg'] } })
      );
    });
  });

  describe('loadPublic', () => {
    it('should dispatches error', async () => {
      await store.dispatch(actions.loadPublic());
      const resultActions = store.getActions();
      expect(resultActions[0].type).toEqual(constants.ERRORS);
      expect(resultActions[0].errors).toEqual(
        JSON.stringify({ errors: { field: ['msg'] } })
      );
    });
  });

  describe('createItem', () => {
    it('should dispatches error', async () => {
      await store.dispatch(actions.createItem({ task_id: 1 }));
      const resultActions = store.getActions();
      expect(resultActions[0].type).toEqual(constants.ERRORS);
      expect(resultActions[0].errors).toEqual(
        JSON.stringify({ errors: { field: ['msg'] } })
      );
    });
  });

  describe('deleteItem', () => {
    it('should dispatches error', async () => {
      await store.dispatch(actions.deleteItem());
      const resultActions = store.getActions();
      expect(resultActions[0].type).toEqual(constants.ERRORS);
      expect(resultActions[0].errors).toEqual(
        JSON.stringify({ errors: { field: ['msg'] } })
      );
    });
  });

  describe('deleteTask', () => {
    it('should dispatches error', async () => {
      await store.dispatch(actions.deleteTask());
      const resultActions = store.getActions();
      expect(resultActions[0].type).toEqual(constants.ERRORS);
      expect(resultActions[0].errors).toEqual(
        JSON.stringify({ errors: { field: ['msg'] } })
      );
    });
  });

  describe('updateTaskItem', () => {
    it('should dispatches error', async () => {
      await store.dispatch(actions.updateTaskItem({ id: 1 }));
      const resultActions = store.getActions();
      expect(resultActions[0].type).toEqual(constants.ERRORS);
      expect(resultActions[0].errors).toEqual(
        JSON.stringify({ errors: { field: ['msg'] } })
      );
    });
  });
});
