import React, { Component } from 'react';
import Input from '../components/Input';
import Page from '../components/Page';
import { httpPostWithoutParseJson } from '../utils/httpHelper';

class RecoverAccount extends Component {
  constructor(props) {
    super(props);
    this.state = {
      credential: '',
      status: '',
      loading: false
    };
  }

  handleChange = (event) => {
    this.setState({
      [event.target.name]: event.target.value,
      status: ''
    });
  }

  handleSubmit = (event) => {
    const { credential } = this.state;
    event.preventDefault();
    this.setState({ loading: true });
    httpPostWithoutParseJson('/api/v1/recover_account', { credential })
      .then(() => this.setState({ status: 'success' }))
      .catch(() => this.setState({ status: 'error' }))
      .finally(() => this.setState({ credential: '', loading: false }));
  }

  render() {
    const { credential, status, loading } = this.state;

    return (
      <Page signUp>
        <form
          className="recover-account-form"
          id="recover-account-form"
          onSubmit={this.handleSubmit}
        >
          <h2 className="form-header">
            Recover your account
          </h2>
          <h5 className="form-subtitle">
            {"Provide your e-mail or username and you'll receive an email with recovery instructions."}
          </h5>
          {status && (
            <p className={`recover-feedback ${status}`}>
              {status === 'success' ? 'Instructions sent to your email' : 'User not found'}
            </p>
          )}
          <Input
            label="username/e-mail"
            name="credential"
            value={credential}
            handleChange={this.handleChange}
            className="input-box"
            disabled={loading}
          />
          <button
            className="btn-submit"
            type="submit"
            value="Submit"
            disabled={loading}
          >
            Recover!
          </button>
          {loading && (
            <div className="lds-ellipsis">
              <div />
              <div />
              <div />
              <div />
            </div>
          )}
        </form>
      </Page>
    );
  }
}

export default RecoverAccount;
