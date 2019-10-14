import React, { Component } from 'react';
import PropTypes from 'prop-types';
import { bindActionCreators } from 'redux';
import { push } from 'connected-react-router';
import { connect } from 'react-redux';
import { loadMyTasks, clearMyTasks } from '../redux/actions/account';
import Page from '../components/Page';
import TaskCard from '../components/TaskCard';

const mapStateToProps = state => ({
  errors: state.account.errors,
  myTasks: state.account.myTasks
});

const mapDispatchToProps = dispatch => ({
  load: bindActionCreators(loadMyTasks, dispatch),
  clear: bindActionCreators(clearMyTasks, dispatch),
  push: bindActionCreators(push, dispatch)
});

class MyTaskPage extends Component {
  componentWillMount() {
    this.props.load();
  }

  componentWillUnmount() {
    this.props.clear();
  }

  render() {
    const { myTasks } = this.props;
    return (
      <Page>
        <div className="my-task-page">
          <div className="form-header">
            My To-Do Lists
          </div>
          <button
            className="btn-create"
            type="button"
            onClick={() => this.props.push('/task-create')}
          >
            Create New
          </button>
          <div className="my-task-page-container">
            {myTasks.map((task) => {
              return (
                <TaskCard
                  key={task.id}
                  task={task}
                  push={this.props.push}
                  hiddenUser
                  showDoneCount
                />
              );
            })
           }
          </div>
        </div>
      </Page>
    );
  }
}

MyTaskPage.propTypes = {
  load: PropTypes.func.isRequired,
  push: PropTypes.func.isRequired,
  clear: PropTypes.func.isRequired,
  myTasks: PropTypes.array
};

MyTaskPage.defaultProps = {
  myTasks: []
};

export default connect(mapStateToProps, mapDispatchToProps)(MyTaskPage);
