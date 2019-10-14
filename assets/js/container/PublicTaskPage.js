import React, { Component } from 'react';
import PropTypes from 'prop-types';
import { bindActionCreators } from 'redux';
import { push } from 'connected-react-router';
import { connect } from 'react-redux';
import { loadPublic, loadRecent, clearPublicTasks } from '../redux/actions/todolist';
import { favorite, unfavorite } from '../redux/actions/account';
import Page from '../components/Page';
import TaskCard from '../components/TaskCard';

const mapStateToProps = state => ({
  errors: state.todolist.errors,
  publicTasks: state.todolist.publicTasks
});

const mapDispatchToProps = dispatch => ({
  load: bindActionCreators(loadPublic, dispatch),
  loadRecent: bindActionCreators(loadRecent, dispatch),
  clear: bindActionCreators(clearPublicTasks, dispatch),
  push: bindActionCreators(push, dispatch),
  favorite: bindActionCreators(favorite, dispatch),
  unfavorite: bindActionCreators(unfavorite, dispatch)
});

class PublicTaskPage extends Component {
  componentWillMount() {
    if (this.props.anonymous) {
      this.props.load();
    } else {
      this.props.loadRecent();
    }
  }

  componentWillUnmount() {
    this.props.clear();
  }

  render() {
    const { publicTasks, anonymous } = this.props;
    return (
      <Page signUp={anonymous}>
        <div className="public-page">
          <div className="form-header">
            {anonymous ? 'Public tasks' : 'Recent created lists'}
          </div>
          <div className="public-page-container">
            {publicTasks.map((task) => {
              return (
                <TaskCard
                  key={task.id}
                  task={task}
                  push={this.props.push}
                  favorite={!anonymous ? this.props.favorite : null}
                  unfavorite={!anonymous ? this.props.unfavorite : null}
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

PublicTaskPage.propTypes = {
  load: PropTypes.func.isRequired,
  push: PropTypes.func.isRequired,
  unfavorite: PropTypes.func.isRequired,
  clear: PropTypes.func.isRequired,
  favorite: PropTypes.func.isRequired,
  publicTasks: PropTypes.array,
  anonymous: PropTypes.bool,
  loadRecent: PropTypes.func.isRequired
};

PublicTaskPage.defaultProps = {
  publicTasks: [],
  anonymous: true
};

export default connect(mapStateToProps, mapDispatchToProps)(PublicTaskPage);
