import React, { Component } from 'react';
import PropTypes from 'prop-types';
import { bindActionCreators } from 'redux';
import { connect } from 'react-redux';
import * as userActions from '../redux/actions/account';
import Input from '../components/Input';
import Page from '../components/Page';

const mapStateToProps = state => ({
  errors: state.account.errors
});

const mapDispatchToProps = dispatch => ({
  signUp: bindActionCreators(userActions.signUp, dispatch)
});

class SignUpPage extends Component {
  constructor(props) {
    super(props);
    this.state = {
      username: '',
      email: '',
      password: '',
      confirm: ''
    };
  }

  handleChange = (event) => {
    this.setState({ [event.target.name]: event.target.value });
  }

  handleSubmit = (event) => {
    const { signUp } = this.props;
    const {
      username, email, password, confirm
    } = this.state;
    const payload = {
      username,
      email,
      virtual_password: password,
      virtual_password_confirmation: confirm
    };
    signUp({ user: payload });

    event.preventDefault();
  }

  render() {
    const {
      username,
      email,
      password,
      confirm,
    } = this.state;
    const { errors } = this.props;

    return (
      <Page signUp>
        <form
          className="sign-up-form"
          id="sign-up-form"
          onSubmit={this.handleSubmit}
        >
          <h2 className="form-header">
            Join now the world leader of To-Do lists
          </h2>
          <Input
            name="username"
            value={username}
            handleChange={this.handleChange}
            errors={errors}
            className="input-box"
          />
          <Input
            label="e-mail"
            name="email"
            value={email}
            handleChange={this.handleChange}
            errors={errors}
            className="input-box"
          />
          <Input
            name="password"
            value={password}
            fieldName="virtual_password"
            handleChange={this.handleChange}
            errors={errors}
            className="input-box"
            type="password"
          />
          <Input
            name="confirm"
            value={confirm}
            fieldName="virtual_password_confirmation"
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
            Sign Up!
          </button>
        </form>
      </Page>
    );
  }
}

SignUpPage.propTypes = {
  signUp: PropTypes.func.isRequired,
  errors: PropTypes.object
};

SignUpPage.defaultProps = {
  errors: null
};

export default connect(mapStateToProps, mapDispatchToProps)(SignUpPage);
