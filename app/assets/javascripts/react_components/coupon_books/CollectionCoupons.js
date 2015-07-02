import React, { Component, PropTypes } from 'react';
//import Immutable from 'immutable'

import Button from './Button';
import Coupon from './Coupon';

export default class CollectionCoupons extends Component {
  state = {coupons: []};

  static propTypes = {
    cssId: PropTypes.string.isRequired,
    source: PropTypes.string.isRequired
  };

  componentDidMount() {
    $.get(this.props.source, function(data) {
      this.setState({
        coupons: data
      });
    }.bind(this));
  }

  render() {
    const { coupons } =  this.state;

    return (
      <div className="coupons-column">
        <h2>Available Discounts
          <Button
            href="/coupons/new"
            type="link"
            className="btn btn-success btn-sm pull-right">
            Add Discount
          </Button>
        </h2>
        <ul className={this.props.className} id={this.props.cssId}>
          {coupons.map((coupon, index) => {
            return <Coupon id={coupon.id} title={coupon.title} itemType={coupon.itemType} disabled={coupon.disabled} key={index}></Coupon>
          })}
        </ul>
      </div>
    );
  }
}
