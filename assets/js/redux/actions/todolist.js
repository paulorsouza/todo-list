import { push, goBack } from 'connected-react-router';
import {
  httpPost, httpGet, httpPut, httpDelete
} from '../../utils/httpHelper';
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

export const clear = () => {
  return (dispatch) => {
    dispatch({
      type: CLEAR
    });
  };
};

export const load = (id) => {
  return (dispatch) => {
    return httpGet(`/api/v1/task/${id}`)
      .then((response) => {
        dispatch({
          task: response.data,
          readOnly: response.read_only,
          isFavorite: response.is_favorite,
          type: LOAD_TASK,
        });
      })
      .catch((error) => {
        error.response.json()
          .then((errorJSON) => {
            dispatch({
              type: ERRORS,
              errors: errorJSON
            });
          });
      });
  };
};

export const loadPublic = () => {
  return (dispatch) => {
    return httpGet('/api/v1/public_tasks')
      .then((response) => {
        dispatch({
          publicTasks: response.data,
          type: LOAD_PUBLIC,
        });
      })
      .catch((error) => {
        error.response.json()
          .then((errorJSON) => {
            dispatch({
              type: ERRORS,
              errors: errorJSON
            });
          });
      });
  };
};

export const loadRecent = () => {
  return (dispatch) => {
    return httpGet('/api/v1/recent_tasks')
      .then((response) => {
        dispatch({
          publicTasks: response.data,
          type: LOAD_PUBLIC,
        });
      })
      .catch((error) => {
        error.response.json()
          .then((errorJSON) => {
            dispatch({
              type: ERRORS,
              errors: errorJSON
            });
          });
      });
  };
};

export const clearPublicTasks = () => {
  return (dispatch) => {
    dispatch({
      type: LOAD_PUBLIC,
      publicTasks: []
    });
  };
};

export const create = (payload) => {
  return (dispatch) => {
    return httpPost('/api/v1/task', { task: payload })
      .then((response) => {
        dispatch({
          newTask: response.data,
          type: CREATE,
        });
        dispatch(push(`/task/${response.data.id}`));
      })
      .catch((error) => {
        error.response.json()
          .then((errorJSON) => {
            dispatch({
              type: ERRORS,
              errors: errorJSON
            });
          });
      });
  };
};

export const createItem = (payload) => {
  return (dispatch) => {
    return httpPost(`/api/v1/task/${payload.task_id}/task_items`, { task_item: payload })
      .then((response) => {
        dispatch({
          newItem: response.data,
          type: ADD_ITEM
        });
      })
      .catch((error) => {
        error.response.json()
          .then((errorJSON) => {
            dispatch({
              type: ERRORS,
              errors: errorJSON
            });
          });
      });
  };
};

export const deleteItem = (id) => {
  return (dispatch) => {
    return httpDelete(`/api/v1/task/1/task_items/${id}`)
      .then(() => {
        dispatch({
          itemId: id,
          type: DELETE_ITEM
        });
      })
      .catch((error) => {
        error.response.json()
          .then((errorJSON) => {
            dispatch({
              type: ERRORS,
              errors: errorJSON
            });
          });
      });
  };
};

export const deleteTask = (id) => {
  return (dispatch) => {
    return httpDelete(`/api/v1/task/${id}`)
      .then(() => {
        dispatch(goBack());
      })
      .catch((error) => {
        error.response.json()
          .then((errorJSON) => {
            dispatch({
              type: ERRORS,
              errors: errorJSON
            });
          });
      });
  };
};

export const updateTaskItem = (payload) => {
  return (dispatch) => {
    return httpPut(`/api/v1/task/1/task_items/${payload.id}`, { task_item: payload })
      .then((response) => {
        dispatch({
          updatedItem: response.data,
          type: UPDATE_ITEM
        });
      })
      .catch((error) => {
        error.response.json()
          .then((errorJSON) => {
            dispatch({
              type: ERRORS,
              errors: errorJSON
            });
          });
      });
  };
};
