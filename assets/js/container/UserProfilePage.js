import React, { Component } from 'react';
import PropTypes from 'prop-types';
import { bindActionCreators } from 'redux';
import { push } from 'connected-react-router';
import { connect } from 'react-redux';
import {
  loadUserProfile, favorite, unfavorite, clearProfile
} from '../redux/actions/account';
import Page from '../components/Page';
import TaskCard from '../components/TaskCard';

const mapStateToProps = state => ({
  errors: state.account.errors,
  userProfile: state.account.userProfile
});

const mapDispatchToProps = dispatch => ({
  load: bindActionCreators(loadUserProfile, dispatch),
  push: bindActionCreators(push, dispatch),
  favorite: bindActionCreators(favorite, dispatch),
  unfavorite: bindActionCreators(unfavorite, dispatch),
  clearProfile: bindActionCreators(clearProfile, dispatch)
});

class UserProfilePage extends Component {
  componentWillMount() {
    const { username } = this.props.match.params;
    this.props.load(username);
  }

  componentWillUnmount() {
    this.props.clearProfile();
  }

  render() {
    const { userProfile, match } = this.props;
    const { username } = match.params;
    return (
      <Page>
        <div className="user-profile-page">
          <div className="form-header">
            {`@${username}`}
          </div>
          <div className="user-profile-page-container">
            {userProfile.map((task) => {
              return (
                <TaskCard
                  key={task.id}
                  task={task}
                  push={this.props.push}
                  favorite={this.props.favorite}
                  unfavorite={this.props.unfavorite}
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

UserProfilePage.propTypes = {
  load: PropTypes.func.isRequired,
  push: PropTypes.func.isRequired,
  unfavorite: PropTypes.func.isRequired,
  favorite: PropTypes.func.isRequired,
  clearProfile: PropTypes.func.isRequired,
  userProfile: PropTypes.array.isRequired,
  match: PropTypes.object.isRequired
};

export default connect(mapStateToProps, mapDispatchToProps)(UserProfilePage);
