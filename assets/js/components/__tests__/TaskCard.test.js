import React from 'react';
import { shallow } from 'enzyme';
import TaskCard from '../TaskCard';

describe('<TaskCard />', () => {
  describe('with favorite icon', () => {
    let wrapped;
    const push = jest.fn();
    const favorite = jest.fn();
    const unfavorite = jest.fn();

    beforeEach(() => {
      const task = {
        id: 10,
        title: 'title teste',
        owner_name: 'user-name',
        is_favorite: true,
        task_items: [{ id: 1 }, { id: 2 }]
      };
      wrapped = shallow(<TaskCard
        push={push}
        task={task}
        favorite={favorite}
        unfavorite={unfavorite}
      />);
    });

    it('should render card with task props', () => {
      expect(wrapped.find('.title').text()).toContain('title teste');
      expect(wrapped.find('.user-name').text()).toContain('user-name');
    });

    it('should click on div', () => {
      wrapped.find('.task-card').simulate('click');
      expect(push.mock.calls.length).toEqual(1);
    });

    it('should favorite/unfavorite on click in the star', () => {
      const event = {
        preventDefault: () => {},
        stopPropagation: () => {}
      };
      wrapped.find('.fa-star').simulate('click', event);
      expect(unfavorite.mock.calls.length).toEqual(1);
      wrapped.find('.fa-star').simulate('click', event);
      expect(favorite.mock.calls.length).toEqual(1);
    });
  });

  describe('without favorite icon', () => {
    let wrapped;
    const push = jest.fn();

    beforeEach(() => {
      const task = {
        id: 10,
        title: 'title teste',
        owner_name: 'user-name',
        is_favorite: true,
        task_items: [{ id: 1 }, { id: 2 }]
      };
      wrapped = shallow(<TaskCard
        push={push}
        task={task}
      />);
    });

    it('should render card with task props', () => {
      expect(wrapped.find('.title').text()).toContain('title teste');
      expect(wrapped.find('.user-name').text()).toContain('user-name');
    });

    it('should click on div', () => {
      wrapped.find('.task-card').simulate('click');
      expect(push.mock.calls.length).toEqual(1);
    });

    it('should not show favorite icon', () => {
      expect(wrapped.find('.fa-star').length).toEqual(0);
    });
  });

  describe('hidden user and show task done count', () => {
    let wrapped;
    const push = jest.fn();

    beforeEach(() => {
      const task = {
        id: 10,
        title: 'title teste',
        owner_name: 'user-name',
        is_favorite: true,
        task_items: [{ id: 1, done: true }, { id: 2, done: true }]
      };
      wrapped = shallow(<TaskCard
        push={push}
        task={task}
        hiddenUser
        showDoneCount
      />);
    });

    it('should show done count', () => {
      expect(wrapped.find('.info').text()).toContain('1 minute ago - 2/2 tasks');
    });

    it('should not show user-name', () => {
      expect(wrapped.find('.user-name').length).toEqual(0);
    });
  });

  it('hidden user and show task done count', () => {
    const event = {
      preventDefault: () => {},
      stopPropagation: () => {}
    };
    const push = jest.fn();
    const task = {
      id: 10,
      title: 'title teste',
      owner_name: 'user-name',
      is_favorite: true,
      task_items: [{ id: 1, done: true }, { id: 2, done: true }]
    };
    const wrapped = shallow(<TaskCard
      push={push}
      task={task}
    />);
    wrapped.find('.user-name').simulate('click', event);
    expect(push.mock.calls[0][0]).toEqual('user/user-name/profile');
  });
});
