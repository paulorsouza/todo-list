import React from 'react';
import PropTypes from 'prop-types';
import { Link } from 'react-router-dom';
import { bindActionCreators } from 'redux';
import { connect } from 'react-redux';
import { withRouter } from 'react-router';
import { goBack } from 'connected-react-router';
import { changePage } from '../redux/actions/application';

const NavBarItems = ({
  signUp, signIn, highlight, change
}) => {
  if (signUp) {
    return (
      <Link className="nav-links" to="/sign-in">Sign in</Link>
    );
  }
  if (signIn) {
    return (
      <Link className="nav-links" to="/sign-up">Sign up</Link>
    );
  }
  return (
    <div>
      <Link
        className={`nav-links${highlight === '/my-to-do-lists' ? ' highlight' : ''}`}
        to="/my-to-do-lists"
        onClick={() => change('/my-to-do-lists')}
      >
        My To-Do Lists
      </Link>
      <Link
        className={`nav-links${highlight === '/favorites' ? ' highlight' : ''}`}
        to="/favorites"
        onClick={() => change('/favorites')}
      >
        Favorites
      </Link>
      <Link
        className={`nav-links${highlight === '/recent-lists' ? ' highlight' : ''}`}
        to="/recent-lists"
        onClick={() => change('/recent-lists')}
      >
        Recent Lists
      </Link>
      <Link
        className={`nav-links${highlight === '/account' ? ' highlight' : ''}`}
        to="/account"
        onClick={() => change('/account')}
      >
        Account
      </Link>
      <Link
        className="nav-links"
        to="/"
        onClick={() => {
          localStorage.removeItem('toDoListToken');
          change('/');
        }}
      >
        Sign out
      </Link>
    </div>
  );
};

NavBarItems.propTypes = {
  signIn: PropTypes.bool,
  signUp: PropTypes.bool,
  highlight: PropTypes.string,
  change: PropTypes.func
};

NavBarItems.defaultProps = {
  signIn: false,
  signUp: false,
  highlight: '',
  change: () => {}
};

const navItems = {
  '/sign-in': '/sign-in',
  '/sign-up': '/sign-up',
  '/': '/recent-lists',
  '/public-tasks': '/recent-lists',
  '/recent-lists': '/recent-lists',
  '/favorites': '/favorites',
  '/my-to-do-lists': '/my-to-do-lists',
  '/account': '/account'
};

const mapStateToProps = state => ({
  currentPage: state.application.currentPage,
});

const mapDispatchToProps = dispatch => ({
  changePage: bindActionCreators(changePage, dispatch),
  goBack: bindActionCreators(goBack, dispatch)
});

const Navbar = (props) => {
  const {
    signIn,
    signUp,
    location,
    currentPage,
  } = props;
  const currentNav = navItems[location.pathname];
  return (
    <nav className="navbar">
      {!currentNav && (
        <i
          className="back-icon fas fa-arrow-left fa-2x"
          onClick={() => props.goBack(1)}
        />
      )}
      <div className="nav-items" id="nav-menu">
        <NavBarItems
          signIn={signIn}
          signUp={signUp}
          highlight={currentNav || currentPage}
          change={props.changePage}
        />
      </div>
    </nav>
  );
};

Navbar.propTypes = {
  location: PropTypes.object.isRequired,
  signIn: PropTypes.bool,
  signUp: PropTypes.bool,
  currentPage: PropTypes.string.isRequired,
  changePage: PropTypes.func.isRequired,
  goBack: PropTypes.func.isRequired
};

Navbar.defaultProps = {
  signIn: false,
  signUp: false
};

export default withRouter(connect(mapStateToProps, mapDispatchToProps)(Navbar));
