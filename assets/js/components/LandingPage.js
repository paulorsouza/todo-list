import React from 'react';
import { Link } from 'react-router-dom';
import PropTypes from 'prop-types';
import { bindActionCreators } from 'redux';
import { push } from 'connected-react-router';
import { connect } from 'react-redux';
import Page from './Page';

const mapDispatchToProps = dispatch => ({
  push: bindActionCreators(push, dispatch)
});

const LandingPage = (props) => {
  return (
    <Page signUp>
      <div className="landing-page">
        <h2 className="form-header">
          {'Don\'t lose track of your goals'}
        </h2>
        <div className="landing-page-msg">
          <p>
            Before starting your next thing, break it down into tasks!
          </p>
          <p>
            The best solution for getting start on anything big is
            {' '}
            to break it up into the small parts.
          </p>
          <br />
          <p>
            Do you wanna know how to bake a chocolate cake?
          </p>
          <p>
            Or what are the best places to visit in Rome?
          </p>
          <p>
            You can see our
            {' '}
            <Link className="nav-links" to="/public-tasks">
              {'user\'s public lists'}
            </Link>
            {' '}
            to start your activities.
          </p>
        </div>
        <button
          className="btn-sign-up"
          type="button"
          onClick={() => props.push('/sign-up')}
        >
          Sign Up!
        </button>
      </div>
    </Page>
  );
};

LandingPage.propTypes = {
  push: PropTypes.func.isRequired
};

export default connect(null, mapDispatchToProps)(LandingPage);
