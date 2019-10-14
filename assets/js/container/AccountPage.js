import React, { Component } from 'react';
import PropTypes from 'prop-types';
import { bindActionCreators } from 'redux';
import { connect } from 'react-redux';
import * as userActions from '../redux/actions/account';
import Input from '../components/Input';
import Page from '../components/Page';

const mapStateToProps = state => ({
  currentUser: state.account.currentUser,
  errors: state.account.errors
});

const mapDispatchToProps = dispatch => ({
  update: bindActionCreators(userActions.update, dispatch),
  load: bindActionCreators(userActions.load, dispatch)
});

class AccountPage extends Component {
  constructor(props) {
    super(props);
    this.state = {
      email: null,
      password: '',
      confirm: ''
    };
  }

  componentWillMount() {
    this.props.load();
  }

  handleChange = (event) => {
    this.setState({ [event.target.name]: event.target.value });
  }

  handleSubmit = (event) => {
    const {
      email, password, confirm
    } = this.state;
    const { currentUser } = this.props;
    const payload = {
      email: email === null ? currentUser.email : email,
      virtual_password: password,
      virtual_password_confirmation: confirm
    };
    this.props.update({ user: payload });
    event.preventDefault();
  }

  render() {
    const {
      email,
      password,
      confirm,
    } = this.state;
    const { errors, currentUser } = this.props;
    return (
      <Page>
        <form
          className="account-form"
          id="account-form"
          onSubmit={this.handleSubmit}
        >
          <h2 className="form-header">
            My account
          </h2>
          <div className="input-box">
            <label className="input-label">username</label>
            <input
              value={currentUser.username}
              disabled
              className="input"
            />
          </div>
          <Input
            label="e-mail"
            name="email"
            defaultValue={currentUser.email}
            value={email === null ? currentUser.email : email}
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
            Update
          </button>
        </form>
      </Page>
    );
  }
}

AccountPage.propTypes = {
  currentUser: PropTypes.object,
  update: PropTypes.func.isRequired,
  load: PropTypes.func.isRequired,
  errors: PropTypes.object
};

AccountPage.defaultProps = {
  errors: null,
  currentUser: { email: '', username: '' }
};

export default connect(mapStateToProps, mapDispatchToProps)(AccountPage);
