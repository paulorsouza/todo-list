import React from 'react';
import { mount } from 'enzyme';
import Navbar from '../Navbar';
import Root from '../../Root';

let wrapped;

afterEach(() => {
  wrapped.unmount();
});

describe('<Navbar />', () => {
  describe('with signIn in prop', () => {
    it('should render sign nav-items', () => {
      wrapped = mount(<Root><Navbar signIn /></Root>);
      const link = wrapped.find('.nav-links');
      expect(link.at(0).text()).toEqual('Sign up');
    });
  });
  describe('with signIn in prop', () => {
    it('should render sign nav-items', () => {
      wrapped = mount(<Root><Navbar signUp /></Root>);
      const link = wrapped.find('.nav-links');
      expect(link.at(0).text()).toEqual('Sign in');
    });
  });
  describe('without props', () => {
    it('should render sign nav-items', () => {
      wrapped = mount(<Root><Navbar /></Root>);
      const links = wrapped.find('.nav-links');
      expect(links.at(0).text()).toEqual('My To-Do Lists');
      expect(links.at(2).text()).toEqual('Favorites');
      expect(links.at(4).text()).toEqual('Recent Lists');
      expect(links.at(6).text()).toEqual('Account');
      expect(links.at(8).text()).toEqual('Sign out');
    });
  });
});
