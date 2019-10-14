import {
  CREATE,
  ADD_ITEM,
  LOAD_TASK,
  ERRORS,
  UPDATE_ITEM,
  LOAD_PUBLIC,
  DELETE_ITEM,
  CLEAR
} from '../constants/todolist';

export const initialState = {
  tasks: [],
  currentTask: null,
  readOnly: false,
  errors: null,
  publicTasks: [],
  isFavorite: false
};

export default function reducer(state = initialState, action = {}) {
  switch (action.type) {
    case LOAD_TASK: {
      return {
        ...state,
        currentTask: action.task,
        errors: null,
        readOnly: action.readOnly,
        isFavorite: action.isFavorite
      };
    }
    case LOAD_PUBLIC: {
      return { ...state, publicTasks: action.publicTasks, errors: null };
    }
    case CREATE: {
      return {
        ...state,
        tasks: [...state.tasks, action.newTask],
        errors: null
      };
    }
    case ADD_ITEM: {
      const { currentTask } = state;
      const { task_items: taskItems } = currentTask;
      return {
        ...state,
        currentTask: {
          ...currentTask,
          task_items: [...taskItems, action.newItem]
        },
        errors: null
      };
    }
    case UPDATE_ITEM: {
      const { currentTask } = state;
      const { task_items: taskItems } = currentTask;
      const filteredItems = taskItems.filter((item) => {
        return item.id !== action.updatedItem.id;
      });
      return {
        ...state,
        currentTask: {
          ...currentTask,
          task_items: [...filteredItems, action.updatedItem]
        },
        errors: null
      };
    }
    case DELETE_ITEM: {
      const { currentTask } = state;
      const { task_items: taskItems } = currentTask;
      const filteredItems = taskItems.filter((item) => {
        return item.id !== action.itemId;
      });
      return {
        ...state,
        currentTask: {
          ...currentTask,
          task_items: filteredItems
        },
        errors: null
      };
    }
    case CLEAR: {
      return initialState;
    }
    case ERRORS: {
      return { ...state, errors: action.errors };
    }
    default:
      return state;
  }
}
