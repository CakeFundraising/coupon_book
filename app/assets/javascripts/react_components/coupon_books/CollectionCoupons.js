import React, { Component, PropTypes } from 'react';
import Immutable from 'immutable'

import Button from './Button';
import Coupon from './Coupon';

export default class CollectionCoupons extends Component {
  static propTypes = {
    cssId: PropTypes.string.isRequired,
    source: PropTypes.string.isRequired
  };

  constructor(props) {
    super(props);
    this.disableCoupon = this.disableCoupon.bind(this);
    this.enableCoupon = this.enableCoupon.bind(this);
    this.state = {coupons: []};
  }

  componentDidMount() {
    $.get(this.props.source, function(data) {
      this.setState({
        coupons: Immutable.fromJS(data)
      });
    }.bind(this));
  }

  // Coupon actions
  enableCoupon(couponId){
    const couponIndex = this.state.coupons.findIndex(c => c.get('id') === couponId)

    this.setState(({coupons}) => ({
      coupons: coupons.updateIn([couponIndex], coupon => coupon.set('disabled', false))
    }));
  }

  disableCoupon(couponId){
    const couponIndex = this.state.coupons.findIndex(c => c.get('id') === couponId)

    this.setState(({coupons}) => ({
      coupons: coupons.updateIn([couponIndex], coupon => coupon.set('disabled', true))
    }));
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
            return(
              <Coupon id={coupon.get('id')} title={coupon.get('title')} itemType={coupon.get('itemType')} 
                disabled={coupon.get('disabled')} disableCoupon={this.disableCoupon} key={index}></Coupon>
            );
          })}
        </ul>
      </div>
    );
  }
}
