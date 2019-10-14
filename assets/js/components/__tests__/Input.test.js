import React from 'react';
import { shallow } from 'enzyme';
import Input from '../Input';

let wrapped;
let inputValue = '';
const handleChange = (event) => {
  const { value } = event.target;
  inputValue = value;
};

afterEach(() => {
  inputValue = '';
});

describe('<Input />', () => {
  describe('with required props', () => {
    beforeEach(() => {
      wrapped = shallow(<Input
        name="test1"
        value={inputValue}
        handleChange={handleChange}
      />);
    });
    it('has a input and label', () => {
      expect(wrapped.find('input').length).toEqual(1);
      expect(wrapped.find('label').length).toEqual(1);
    });
    it('should render default values', () => {
      const inputHtml = wrapped.find('input').html();
      expect(wrapped.find('label').text()).toContain('test1');
      expect(inputHtml).toContain('class="input"');
      expect(inputHtml).toContain('type="text"');
      expect(inputHtml).toContain('name="test1"');
    });
    it('should change value', () => {
      const event = {
        target: { value: 'teste 1' }
      };
      wrapped.find('input').simulate('change', event);
      expect(inputValue).toEqual('teste 1');
    });
  });
  describe('test with mock', () => {
    const handleChangeMock = jest.fn();
    beforeEach(() => {
      wrapped = shallow(<Input
        name="test2"
        value={inputValue}
        handleChange={handleChangeMock}
      />);
    });
    it('should change value', () => {
      const event = {
        target: { value: 'teste 2' }
      };
      wrapped.find('input').simulate('change', event);
      expect(handleChangeMock).toBeCalledWith(event);
    });
  });
  describe('with all props', () => {
    beforeEach(() => {
      wrapped = shallow(<Input
        name="test3"
        value={inputValue}
        handleChange={handleChange}
        label="label test"
        type="password"
        fieldName="fieldname"
        className="customClassName"
      />);
    });
    it('should render props values', () => {
      const inputHtml = wrapped.find('input').html();
      expect(wrapped.find('label').text()).toContain('label test');
      expect(inputHtml).toContain('class="customClassName"');
      expect(inputHtml).toContain('type="password"');
      expect(inputHtml).toContain('name="test3"');
    });
    it('should render input error', () => {
      wrapped.setProps({ errors: { errors: { fieldname: ['error 1', 'error 2'] } } });
      expect(wrapped.find('.input-error').text()).toContain('error 1\nerror 2');
    });
  });
});
