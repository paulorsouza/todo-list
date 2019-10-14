import React, { Component } from 'react';
import PropTypes from 'prop-types';
import { timeAgo } from '../utils/dateHelper';

class TaskCard extends Component {
  constructor(props) {
    super(props);
    this.state = { vitualFavorite: null };
  }

  renderStar = () => {
    if (!this.props.favorite) return null;
    const classname = this.getFavorite() ? 'fas fa-star' : 'far fa-star';
    return (
      <div
        className={`${classname} fa-3x`}
        onClick={this.toggleFavorite}
      />
    );
  }

  getFavorite = () => {
    const { vitualFavorite } = this.state;
    const { task } = this.props;
    return vitualFavorite !== null ? vitualFavorite : task.is_favorite;
  }

  getInfo = () => {
    const { task, showDoneCount } = this.props;
    const taskCount = task.task_items.length;
    const countDesc = taskCount > 1 ? 'tasks' : 'task';
    if (showDoneCount) {
      const doneCount = task.task_items.filter(t => t.done).length;
      return `${timeAgo(task.inserted_at)} - ${doneCount}/${taskCount} ${countDesc}`;
    }
    return `${timeAgo(task.inserted_at)} - ${taskCount} ${countDesc}`;
  }

  toggleFavorite = (event) => {
    event.preventDefault();
    event.stopPropagation();
    const { task } = this.props;
    const fav = this.getFavorite();
    if (fav) this.props.unfavorite(task.id);
    else this.props.favorite(task.id);
    this.setState({ vitualFavorite: !fav });
  }

  pushToUser = (event) => {
    event.preventDefault();
    event.stopPropagation();
    const { task, push } = this.props;
    push(`user/${task.owner_name}/profile`);
  }

  render() {
    const { task, push, hiddenUser } = this.props;
    return (
      <div
        className="task-card"
        onClick={() => push(`/task/${task.id}`)}
      >
        {this.renderStar()}
        <span className="title">{task.title}</span>
        <div className="footer">
          {!hiddenUser && (
            <span
              className="user-name"
              onClick={this.pushToUser}
            >
              {`by @${task.owner_name}`}
            </span>)}
          <br />
          <span className="info">
            {this.getInfo()}
          </span>
        </div>
      </div>
    );
  }
}

TaskCard.propTypes = {
  task: PropTypes.object.isRequired,
  push: PropTypes.func.isRequired,
  favorite: PropTypes.func,
  unfavorite: PropTypes.func,
  hiddenUser: PropTypes.bool,
  showDoneCount: PropTypes.bool
};

TaskCard.defaultProps = {
  favorite: null,
  unfavorite: null,
  hiddenUser: false,
  showDoneCount: false
};

TaskCard.defaultProps = {};

export default TaskCard;
