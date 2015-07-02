import React, { Component, PropTypes } from 'react';
import CouponActions from './CouponActions';

export default class PrBox extends Component {
  static propTypes = {
    prBox: PropTypes.object.isRequired,
  };

  render(){
    const { id, headline } = this.props.prBox;
 
    return (
      <li className="prbox-item" id={'prboxes_' + id}  key={this.props.key}>
        <span className="prbox-item--container">
          <span className="prbox-item--title">{headline}</span>
        </span>
        <CouponActions className="prboxActions" prboxId={id} />
      </li>
    );
  }
}
