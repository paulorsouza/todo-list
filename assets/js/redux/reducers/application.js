import {
  CHANGE_PAGE
} from '../constants/application';

export const initialState = {
  currentPage: ''
};

export default function reducer(state = initialState, action = {}) {
  switch (action.type) {
    case CHANGE_PAGE: {
      return {
        ...state,
        currentPage: action.currentPage,
      };
    }
    default:
      return state;
  }
}
