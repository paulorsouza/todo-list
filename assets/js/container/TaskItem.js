import React, { Component } from 'react';
import PropTypes from 'prop-types';
import { bindActionCreators } from 'redux';
import { connect } from 'react-redux';
import { updateTaskItem, deleteItem } from '../redux/actions/todolist';

const mapStateToProps = state => ({
  errors: state.todolist.errors
});

const mapDispatchToProps = dispatch => ({
  update: bindActionCreators(updateTaskItem, dispatch),
  delete: bindActionCreators(deleteItem, dispatch)
});

class TaskItem extends Component {
  constructor(props) {
    super(props);
    this.state = {
      editMode: false,
      title: props.item.title
    };
  }

  componentDidMount() {
    document.addEventListener('mousedown', this.handleClickOutside);
  }

  componentWillUnmount() {
    document.removeEventListener('mousedown', this.handleClickOutside);
  }

  handleClickOutside = (event) => {
    if (this.input && !this.input.contains(event.target)
      && this.btn && !this.btn.contains(event.target)) {
      this.setState({ editMode: false });
    }
  }

  handleChange = (event) => {
    this.setState({ title: event.target.value });
  }

  updateStatus = (event) => {
    const { item, update } = this.props;
    const payload = {
      ...item,
      done: event.target.checked
    };
    update(payload);
  }

  updateTitle = (event) => {
    event.preventDefault();
    event.stopPropagation();
    const { title } = this.state;
    const { item, update } = this.props;
    if (title !== item.title) {
      const payload = { ...item, title };
      update(payload);
    }
    this.setState({ editMode: false });
  };

  delete = (event) => {
    event.preventDefault();
    event.stopPropagation();
    const { item } = this.props;
    this.props.delete(item.id);
  }

  render() {
    const { item } = this.props;
    const { editMode, title } = this.state;
    return (
      <div className="task-item">
        {!editMode && (
          <label className="container">
            <input
              name="done"
              type="checkbox"
              checked={item.done}
              onChange={this.updateStatus}
            />
            <span className="checkmark" />
          </label>
        )}
        {!editMode ? (
          <span
            onClick={() => this.setState({ editMode: true })}
            className={`task-item-title title ${item.done ? 'done' : ''}`}
          >
            {item.title}
          </span>
        ) : (
          <form onSubmit={this.updateTitle}>
            <input
              autoComplete="off"
              type="text"
              name="newTitle"
              value={title}
              onChange={this.handleChange}
              className="new-title-input"
              // eslint-disable-next-line jsx-a11y/no-autofocus
              autoFocus
              ref={(input) => { this.input = input; }}
            />
            <button
              type="button"
              className="delete-item"
              onClick={this.delete}
              ref={(btn) => { this.btn = btn; }}
            >
              X
            </button>
          </form>
        )}
      </div>
    );
  }
}

TaskItem.propTypes = {
  update: PropTypes.func.isRequired,
  delete: PropTypes.func.isRequired,
  item: PropTypes.object.isRequired
};

TaskItem.defaultProps = {};

export default connect(mapStateToProps, mapDispatchToProps)(TaskItem);
