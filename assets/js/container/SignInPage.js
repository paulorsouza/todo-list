import React, { Component } from 'react';
import PropTypes from 'prop-types';
import { bindActionCreators } from 'redux';
import { connect } from 'react-redux';
import { Link } from 'react-router-dom';
import * as userActions from '../redux/actions/account';
import Input from '../components/Input';
import Page from '../components/Page';

const mapStateToProps = state => ({
  errors: state.account.errors
});

const mapDispatchToProps = dispatch => ({
  signIn: bindActionCreators(userActions.signIn, dispatch)
});

class SignInPage extends Component {
  constructor(props) {
    super(props);
    this.state = {
      credential: '',
      password: ''
    };
  }

  handleChange = (event) => {
    this.setState({ [event.target.name]: event.target.value });
  }

  handleSubmit = (event) => {
    const { signIn } = this.props;
    signIn(this.state);
    event.preventDefault();
  }

  render() {
    const { credential, password } = this.state;
    const { errors } = this.props;

    return (
      <Page signIn>
        <form
          className="sign-in-form"
          id="sign-in-form"
          onSubmit={this.handleSubmit}
        >
          <h2 className="form-header">
            Welcome back!
          </h2>
          {errors && errors.error && (
            <p className="page-error">{errors.error}</p>
          )}
          <Input
            label="username/e-mail"
            name="credential"
            value={credential}
            handleChange={this.handleChange}
            errors={errors}
            className="input-box"
          />
          <Input
            name="password"
            value={password}
            handleChange={this.handleChange}
            errors={errors}
            className="input-box"
            type="password"
          />
          <button
            className="btn-submit"
            type="submit"
            value="Submit"
          >
            Sign In!
          </button>
          <div className="forgot-password">
            <Link className="nav-links" to="/recover-account">
              I forgot my password
            </Link>
          </div>
        </form>
      </Page>
    );
  }
}

SignInPage.propTypes = {
  signIn: PropTypes.func.isRequired,
  errors: PropTypes.object
};

SignInPage.defaultProps = {
  errors: null
};

export default connect(mapStateToProps, mapDispatchToProps)(SignInPage);
