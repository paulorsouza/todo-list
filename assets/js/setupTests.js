/* eslint-disable import/no-extraneous-dependencies */
import Enzyme from 'enzyme';
import Adapter from 'enzyme-adapter-react-16';
import fetchMock from 'jest-fetch-mock';

Enzyme.configure({ adapter: new Adapter() });

global.fetch = fetchMock;
