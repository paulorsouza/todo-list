import reducer, { initialState } from '../todolist';
import * as constants from '../../constants/todolist';

const errors = { errors: { field: ['msg'] } };

describe('LOAD_TASK reducer', () => {
  it('returns the correct state', () => {
    const action = {
      type: constants.LOAD_TASK,
      task: { id: 1 },
      readOnly: true,
      isFavorite: true
    };
    const newState = reducer(initialState, action);
    expect(newState.readOnly).toBeTruthy();
    expect(newState.isFavorite).toBeTruthy();
    expect(newState.currentTask).toEqual({ id: 1 });
  });
});

describe('LOAD_PUBLIC reducer', () => {
  it('returns the correct state', () => {
    const action = {
      type: constants.LOAD_PUBLIC,
      publicTasks: [{ id: 1 }, { id: 2 }]
    };
    const newState = reducer(initialState, action);
    expect(newState.publicTasks).toEqual([{ id: 1 }, { id: 2 }]);
  });
});

describe('CREATE reducer', () => {
  it('returns the correct state', () => {
    const oldState = {
      ...initialState,
      tasks: [{ id: 1 }]
    };
    const action = {
      type: constants.CREATE,
      newTask: { id: 2 }
    };
    const newState = reducer(oldState, action);
    expect(newState.tasks).toEqual(([{ id: 1 }, { id: 2 }]));
  });
});

describe('ADD_ITEM reducer', () => {
  it('returns the correct state', () => {
    const oldState = {
      ...initialState,
      currentTask: {
        task_items: []
      }
    };
    const action = {
      type: constants.ADD_ITEM,
      newItem: { id: 1 }
    };
    const newState = reducer(oldState, action);
    expect(newState.currentTask.task_items).toEqual([{ id: 1 }]);
    const newState2 = reducer(newState, action);
    expect(newState2.currentTask.task_items).toEqual([{ id: 1 }, { id: 1 }]);
  });
});

describe('UPDATE_ITEM reducer', () => {
  it('returns the correct state', () => {
    const oldState = {
      ...initialState,
      currentTask: {
        task_items: [
          { id: 1, title: 'teste 1' },
          { id: 2, title: 'teste 2' }
        ]
      }
    };
    const action = {
      type: constants.UPDATE_ITEM,
      updatedItem: { id: 2, title: 'updated title' }
    };
    const newState = reducer(oldState, action);
    expect(newState.currentTask.task_items)
      .toEqual([
        { id: 1, title: 'teste 1' },
        { id: 2, title: 'updated title' }
      ]);
  });
});

describe('DELETE_ITEM reducer', () => {
  it('returns the correct state', () => {
    const oldState = {
      ...initialState,
      currentTask: {
        task_items: [
          { id: 1, title: 'teste 1' },
          { id: 2, title: 'teste 2' }
        ]
      }
    };
    const action = {
      type: constants.DELETE_ITEM,
      itemId: 1
    };
    const newState = reducer(oldState, action);
    expect(newState.currentTask.task_items)
      .toEqual([
        { id: 2, title: 'teste 2' }
      ]);
  });
});

describe('CLEAR reducer', () => {
  it('returns the correct state', () => {
    const oldState = { errors };
    const action = { type: constants.CLEAR };
    const newState = reducer(oldState, action);
    expect(newState).toEqual(initialState);
  });
});

describe('ERRORS reducer', () => {
  it('returns the correct state', () => {
    const action = { type: constants.ERRORS, errors };
    const newState = reducer(initialState, action);
    expect(newState.errors).toEqual(errors);
  });
});
