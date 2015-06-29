import React, { Component, PropTypes } from 'react';
import CouponActions from './CouponActions';

export default class PrBox extends Component {
  static propTypes = {
    prBox: PropTypes.object.isRequired,
  };

  render(){
    var id = this.props.prBox.id;
    var headline = this.props.prBox.headline;

    return (
      <li className="prbox-list" id={'prboxes_' + id}  key={this.props.key}>
        <span className="prbox-list--container">
          <span className="prbox-list--title">{headline}</span>
        </span>
        <CouponActions className="prboxActions" prboxId={id} />
      </li>
    );
  }
}
