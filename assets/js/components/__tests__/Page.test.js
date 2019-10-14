import React from 'react';
import { mount } from 'enzyme';
import Root from '../../Root';
import Page from '../Page';

describe('<Page />', () => {
  it('should render navbar and <main>', () => {
    const wrapped = mount(<Root><Page><div /></Page></Root>);
    expect(wrapped.find('.navbar').length).toBe(1);
    wrapped.unmount();
  });
});
