import React from 'react';
import { shallow } from 'enzyme';
import { DialogModal } from '../DialogModal';

describe('<DialogModal />', () => {
  const handleConfirm = jest.fn();
  const handleClose = jest.fn();
  let wrapped;

  beforeEach(() => {
    wrapped = shallow(
      <DialogModal
        handleClose={handleClose}
        handleConfirm={handleConfirm}
        msg="teste?"
      />
    );
  });

  it('should render dialog modal with msg', () => {
    expect(wrapped.find('.modal-msg').text()).toContain('teste?');
  });

  it('should click on buttons and icon', () => {
    wrapped.find('.confirm').simulate('click');
    expect(handleConfirm.mock.calls.length).toEqual(1);
    wrapped.find('.cancel').simulate('click');
    expect(handleClose.mock.calls.length).toEqual(1);
    wrapped.find('.fa-times-circle').simulate('click');
    expect(handleClose.mock.calls.length).toEqual(2);
  });
});
