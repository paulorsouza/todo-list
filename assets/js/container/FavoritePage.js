import React, { Component } from 'react';
import PropTypes from 'prop-types';
import { bindActionCreators } from 'redux';
import { push } from 'connected-react-router';
import { connect } from 'react-redux';
import { myFavorites, clearMyFavorites } from '../redux/actions/account';
import Page from '../components/Page';
import TaskCard from '../components/TaskCard';

const mapStateToProps = state => ({
  errors: state.account.errors,
  favorites: state.account.favorites
});

const mapDispatchToProps = dispatch => ({
  load: bindActionCreators(myFavorites, dispatch),
  push: bindActionCreators(push, dispatch),
  clearMyFavorites: bindActionCreators(clearMyFavorites, dispatch)
});

class FavoritePage extends Component {
  componentWillMount() {
    this.props.load();
  }

  componentWillUnmount() {
    this.props.clearMyFavorites();
  }

  render() {
    const { favorites } = this.props;
    return (
      <Page>
        <div className="favorite-page">
          <div className="form-header">
            Favorites
          </div>
          <div className="favorite-page-container">
            {favorites.map((task) => {
              return (
                <TaskCard
                  key={task.id}
                  task={task}
                  push={this.props.push}
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

FavoritePage.propTypes = {
  load: PropTypes.func.isRequired,
  push: PropTypes.func.isRequired,
  clearMyFavorites: PropTypes.func.isRequired,
  favorites: PropTypes.array
};

FavoritePage.defaultProps = {
  favorites: []
};

export default connect(mapStateToProps, mapDispatchToProps)(FavoritePage);
