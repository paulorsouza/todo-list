import React, { Component } from 'react';
import PropTypes from 'prop-types';
import { bindActionCreators } from 'redux';
import { connect } from 'react-redux';
import { create } from '../redux/actions/todolist';
import Input from '../components/Input';
import Page from '../components/Page';

const mapStateToProps = state => ({
  errors: state.todolist.errors
});

const mapDispatchToProps = dispatch => ({
  addTask: bindActionCreators(create, dispatch)
});

class TaskCreate extends Component {
  constructor(props) {
    super(props);
    this.state = {
      title: '',
      isPublic: true
    };
  }

  handleChange = (event) => {
    this.setState({ [event.target.name]: event.target.value });
  }

  handleRadioChange = (event) => {
    const { value } = event.target;
    this.setState({ isPublic: value === 'public' });
  }

  handleSubmit = (event) => {
    const { addTask } = this.props;
    const { isPublic, title } = this.state;
    const payload = {
      title,
      public: isPublic
    };
    addTask(payload);
    event.preventDefault();
  }

  render() {
    const { title, isPublic } = this.state;
    const { errors } = this.props;

    return (
      <Page>
        <form
          className="task-create-form"
          id="task-create-form"
          onSubmit={this.handleSubmit}
        >
          <div className="form-header">
            Create a To-Do list
          </div>

          {errors && errors.error && (
            <p className="page-error">{errors.error}</p>
          )}

          <h5 className="form-subtitle">
            A trip? A project? A User Story? Insert the name of your next thing:
          </h5>

          <Input
            label=""
            name="title"
            value={title}
            handleChange={this.handleChange}
            errors={errors}
            className="input-box"
          />
          <div className="public-radio">
            <label>
              <input
                type="radio"
                value="public"
                checked={isPublic}
                onChange={this.handleRadioChange}
              />
              Public
            </label>
            <label>
              <input
                type="radio"
                value="private"
                checked={!isPublic}
                onChange={this.handleRadioChange}
              />
              Private
            </label>
          </div>
          <button
            className="btn-submit"
            type="submit"
            value="Submit"
          >
            Create
          </button>
        </form>
      </Page>
    );
  }
}

TaskCreate.propTypes = {
  addTask: PropTypes.func.isRequired,
  errors: PropTypes.object
};

TaskCreate.defaultProps = {
  errors: null
};

export default connect(mapStateToProps, mapDispatchToProps)(TaskCreate);
