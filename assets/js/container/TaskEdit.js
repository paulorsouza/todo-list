import React, { Component } from 'react';
import PropTypes from 'prop-types';
import { bindActionCreators } from 'redux';
import { connect } from 'react-redux';
import {
  deleteTask, createItem, load, clear
} from '../redux/actions/todolist';
import { favorite, unfavorite } from '../redux/actions/account';
import Input from '../components/Input';
import Page from '../components/Page';
import TaskItem from './TaskItem';
import { timeAgo } from '../utils/dateHelper';
import DialogModalPortal from '../components/DialogModal';

const mapStateToProps = state => ({
  errors: state.todolist.errors,
  currentTask: state.todolist.currentTask,
  readOnly: state.todolist.readOnly,
  isFavorite: state.todolist.isFavorite
});

const mapDispatchToProps = dispatch => ({
  loadTask: bindActionCreators(load, dispatch),
  addTaskItem: bindActionCreators(createItem, dispatch),
  deleteAll: bindActionCreators(deleteTask, dispatch),
  clear: bindActionCreators(clear, dispatch),
  unfavorite: bindActionCreators(unfavorite, dispatch),
  favorite: bindActionCreators(favorite, dispatch)
});

class TaskEdit extends Component {
  constructor(props) {
    super(props);
    this.state = {
      title: '',
      vitualFavorite: null,
      showDeleteModal: false
    };
  }

  componentWillMount() {
    const { loadTask } = this.props;
    const taskId = this.getTaskId(this.props);
    loadTask(taskId);
  }

  componentWillUnmount() {
    this.props.clear();
  }

  handleChange = (event) => {
    this.setState({ [event.target.name]: event.target.value });
  }

  handleSubmit = (event) => {
    const { addTaskItem, currentTask } = this.props;
    const { title } = this.state;
    if (title) {
      addTaskItem({ title, task_id: currentTask.id });
      this.setState({ title: '' });
    }
    event.preventDefault();
  }

  openDeleteModal = () => this.setState({ showDeleteModal: true })

  closeDeleteModal = () => this.setState({ showDeleteModal: false })

  deleteTasks = (event) => {
    event.preventDefault();
    event.stopPropagation();
    const { deleteAll, currentTask } = this.props;
    deleteAll(currentTask.id);
  }

  getTaskId = (props) => {
    return props.match
      && props.match.params
      && props.match.params.id;
  }

  getSubHeader = () => {
    const { currentTask, readOnly } = this.props;
    const {
      inserted_at: createdDate, updated_at: updatedDate
    } = currentTask;
    const createdString = timeAgo(createdDate);
    const updatedString = timeAgo(updatedDate || createdDate);
    if (readOnly) {
      return `by @${currentTask.owner_name} - Created ${createdString}`;
    }
    return `Created: ${createdString} | Last update: ${updatedString}`;
  }

  getFavorite = () => {
    const { vitualFavorite } = this.state;
    const { isFavorite } = this.props;
    return vitualFavorite !== null ? vitualFavorite : isFavorite;
  }

  toggleFavorite = () => {
    const { currentTask } = this.props;
    const fav = this.getFavorite();
    if (fav) this.props.unfavorite(currentTask.id);
    else this.props.favorite(currentTask.id);
    this.setState({ vitualFavorite: !fav });
  }

  renderEditMode = () => {
    const { title } = this.state;
    const { errors, currentTask } = this.props;
    return (
      <div>
        <form
          className="task-item-create-form"
          id="task-item-create-form"
          onSubmit={e => this.handleSubmit(e)}
        >
          <div className="form-header">
            {currentTask.title}
          </div>

          <div className="sub-header">{this.getSubHeader()}</div>

          <h5 className="form-subtitle">
            Breakdown time! Type the task name and hit enter
          </h5>

          <Input
            label=""
            name="title"
            value={title}
            handleChange={this.handleChange}
            errors={errors}
            className="input-box"
          />
        </form>
        <div className="task-items">
          {currentTask && currentTask.task_items
            .sort((a, b) => a.id - b.id)
            .map((item) => {
              return (
                <TaskItem key={item.id} item={item} />
              );
            })}
        </div>
        <button
          className="btn-delete"
          type="button"
          onClick={this.openDeleteModal}
        >
          Delete List
        </button>
        {this.state.showDeleteModal && (
          <DialogModalPortal
            msg="Do you want to delete the entire task?"
            handleConfirm={this.deleteTasks}
            handleClose={this.closeDeleteModal}
          />)}
      </div>
    );
  }

  renderReadOnlyMode = () => {
    const { currentTask } = this.props;
    return (
      <div className="task-item-view">
        <div className="form-header">
          <span
            className={this.getFavorite() ? 'fas fa-star' : 'far fa-star'}
            onClick={this.toggleFavorite}
          />
          {currentTask.title}
        </div>
        <div className="sub-header">{this.getSubHeader()}</div>
        <ul className="task-items">
          {currentTask && currentTask.task_items
            .sort((a, b) => b.id - a.id)
            .map((item) => {
              return (
                <li key={item.id}>
                  {item.title}
                </li>
              );
            })}
        </ul>
      </div>
    );
  }

  render() {
    const { readOnly, currentTask, errors } = this.props;
    return (
      <Page>
        <div>
          {errors && (<p className="page-error">{errors && errors.error}</p>)}
          {!readOnly && currentTask && this.renderEditMode()}
          {readOnly && currentTask && this.renderReadOnlyMode()}
        </div>
      </Page>
    );
  }
}

TaskEdit.propTypes = {
  addTaskItem: PropTypes.func.isRequired,
  loadTask: PropTypes.func.isRequired,
  deleteAll: PropTypes.func.isRequired,
  clear: PropTypes.func.isRequired,
  currentTask: PropTypes.object,
  errors: PropTypes.object,
  readOnly: PropTypes.bool,
  isFavorite: PropTypes.bool,
  favorite: PropTypes.func.isRequired,
  unfavorite: PropTypes.func.isRequired
};

TaskEdit.defaultProps = {
  errors: null,
  currentTask: null,
  readOnly: false,
  isFavorite: false
};

export default connect(mapStateToProps, mapDispatchToProps)(TaskEdit);
