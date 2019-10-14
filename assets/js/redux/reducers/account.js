import {
  SIGN_UP,
  SIGN_IN,
  ERRORS,
  MY_FAVORITES,
  MY_TASKS,
  LOAD,
  UPDATE,
  LOAD_USER_PROFILE
} from '../constants/account';

export const initialState = {
  errors: null,
  favorites: [],
  myTasks: [],
  userProfile: [],
  currentUser: { email: '', username: '' }
};

export default function reducer(state = initialState, action = {}) {
  switch (action.type) {
    case UPDATE:
    case SIGN_IN:
    case SIGN_UP: {
      return { ...state, errors: null };
    }
    case MY_FAVORITES: {
      return { ...state, favorites: action.favorites };
    }
    case MY_TASKS: {
      return { ...state, myTasks: action.myTasks };
    }
    case LOAD: {
      return { ...state, currentUser: action.currentUser };
    }
    case LOAD_USER_PROFILE: {
      return { ...state, userProfile: action.userProfile };
    }
    case ERRORS: {
      return { ...state, errors: action.errors };
    }
    default:
      return state;
  }
}
