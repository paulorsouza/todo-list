import { CHANGE_PAGE } from '../constants/application';

// eslint-disable-next-line import/prefer-default-export
export const changePage = (currentPage) => {
  return (dispatch) => {
    dispatch({
      type: CHANGE_PAGE,
      currentPage
    });
  };
};
