import React, { Component } from 'react';
import PropTypes from 'prop-types';

class Input extends Component {
  constructor(props) {
    super(props);
    this.state = {
      error: null
    };
  }

  componentWillReceiveProps(nextProps) {
    if (this.shouldUpdateError(this.props, nextProps)) {
      this.setState({ error: this.parseError(nextProps) });
    }
  }

  shouldUpdateError = (oldProps, nextProps) => {
    return (!oldProps.errors && nextProps.errors)
    || (oldProps.errors && oldProps.errors !== nextProps.errors);
  }

  parseError = (props) => {
    const {
      errors, fieldName, name
    } = props;
    const error = errors
      && errors.errors
      && errors.errors[fieldName || name];
    if (error) return error.join('\n');
    return null;
  }

  handleChange = (event) => {
    const { handleChange } = this.props;
    this.setState({ error: null });
    handleChange(event);
  }

  render() {
    const {
      name,
      className,
      value,
      label,
      type,
      disabled
    } = this.props;
    const { error } = this.state;
    return (
      <div className={`${className} ${error ? 'has-error' : ''}`}>
        <label className="input-label">{label || name}</label>
        <input
          name={name}
          className={className}
          value={value}
          onChange={this.handleChange}
          type={type}
          autoComplete="off"
          disabled={disabled}
        />
        {error && (
          <p className="input-error">{error}</p>
        )}
      </div>
    );
  }
}

Input.propTypes = {
  name: PropTypes.string.isRequired,
  value: PropTypes.string.isRequired,
  handleChange: PropTypes.func.isRequired,
  fieldName: PropTypes.string,
  errors: PropTypes.object,
  className: PropTypes.string,
  label: PropTypes.string,
  type: PropTypes.string,
  disabled: PropTypes.bool
};

Input.defaultProps = {
  fieldName: null,
  label: null,
  errors: null,
  className: 'input',
  type: 'text',
  disabled: false
};

export default Input;
