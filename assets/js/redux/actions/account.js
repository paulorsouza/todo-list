import { push, goBack } from 'connected-react-router';
import {
  httpPost,
  httpDelete,
  httpPostWithoutParseJson,
  httpGet,
  httpPut
} from '../../utils/httpHelper';
import {
  SIGN_IN,
  SIGN_UP,
  ERRORS,
  FAVORITE,
  UNFAVORITE,
  MY_FAVORITES,
  MY_TASKS,
  LOAD,
  UPDATE,
  LOAD_USER_PROFILE
} from '../constants/account';

export const signUp = (user) => {
  return (dispatch) => {
    return httpPost('/api/v1/sign_up', user)
      .then((data) => {
        localStorage.setItem('toDoListToken', data.token);
        dispatch({
          type: SIGN_UP,
        });
        dispatch(push('/'));
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

export const signIn = (payload) => {
  return (dispatch) => {
    return httpPost('/api/v1/sign_in', payload)
      .then((data) => {
        localStorage.setItem('toDoListToken', data.token);
        dispatch({
          type: SIGN_IN
        });
        dispatch(push('/'));
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

export const load = () => {
  return (dispatch) => {
    return httpGet('/api/v1/user/current')
      .then((response) => {
        dispatch({
          type: LOAD,
          currentUser: response.data
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

export const loadUserProfile = (username) => {
  return (dispatch) => {
    return httpGet(`/api/v1/user/${username}/profile`)
      .then((response) => {
        dispatch({
          type: LOAD_USER_PROFILE,
          userProfile: response.data
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

export const clearProfile = () => {
  return (dispatch) => {
    dispatch({
      type: LOAD_USER_PROFILE,
      userProfile: []
    });
  };
};

export const update = (payload) => {
  return (dispatch) => {
    return httpPut('/api/v1/user/current', payload)
      .then((data) => {
        localStorage.setItem('toDoListToken', data.token);
        dispatch({
          type: UPDATE
        });
        dispatch(goBack(1));
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

export const myFavorites = () => {
  return (dispatch) => {
    return httpGet('/api/v1/favorites')
      .then((response) => {
        dispatch({
          type: MY_FAVORITES,
          favorites: response.data
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

export const clearMyFavorites = () => {
  return (dispatch) => {
    dispatch({
      type: MY_FAVORITES,
      favorites: []
    });
  };
};

export const loadMyTasks = () => {
  return (dispatch) => {
    return httpGet('/api/v1/my_tasks')
      .then((response) => {
        dispatch({
          type: MY_TASKS,
          myTasks: response.data
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

export const clearMyTasks = () => {
  return (dispatch) => {
    dispatch({
      type: MY_TASKS,
      myTasks: []
    });
  };
};

export const favorite = (taskId) => {
  return (dispatch) => {
    return httpPostWithoutParseJson('/api/v1/favorites', { task_id: taskId })
      .then(() => {
        dispatch({
          type: FAVORITE,
          taskId
        });
      });
  };
};

export const unfavorite = (taskId) => {
  return (dispatch) => {
    return httpDelete('/api/v1/favorites', { task_id: taskId })
      .then(() => {
        dispatch({
          type: UNFAVORITE,
          taskId
        });
      });
  };
};
