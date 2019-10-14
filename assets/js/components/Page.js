import React from 'react';
import PropTypes from 'prop-types';
import Navbar from './Navbar';

const Page = (props) => {
  const { children, signUp, signIn } = props;
  return (
    <div className="page-wrapper">
      <Navbar
        signUp={signUp}
        signIn={signIn}
      />
      <main>
        {children}
      </main>
    </div>
  );
};

Page.propTypes = {
  children: PropTypes.any.isRequired,
  signIn: PropTypes.bool,
  signUp: PropTypes.bool
};

Page.defaultProps = {
  signIn: false,
  signUp: false
};

export default Page;
