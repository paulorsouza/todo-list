import React from 'react';
import ReactDOM from 'react-dom';
import PropTypes from 'prop-types';

const DialogModal = (props) => {
  return (
    <div className="modal-background">
      <div className="modal">
        <i
          className="far fa-times-circle"
          onClick={props.handleClose}
        />
        <div className="modal-msg">
          {props.msg}
        </div>
        <div className="modal-btns">
          <button
            className="modal-btn confirm"
            type="button"
            onClick={props.handleConfirm}
          >
            Confirm
          </button>
          <button
            className="modal-btn cancel"
            type="button"
            onClick={props.handleClose}
          >
            Cancel
          </button>
        </div>
      </div>
    </div>
  );
};

DialogModal.propTypes = {
  msg: PropTypes.string.isRequired,
  handleClose: PropTypes.func.isRequired,
  handleConfirm: PropTypes.func.isRequired
};

const DialogModalPortal = (props) => {
  return ReactDOM.createPortal(
    <DialogModal {...props} />,
    document.body
  );
};

export { DialogModal };
export default DialogModalPortal;
