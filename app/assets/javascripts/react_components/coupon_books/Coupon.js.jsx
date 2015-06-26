var React = require('react');
var CouponActions = require('./CouponActions.js.jsx');

var Coupon = React.createClass({
  render: function(){
    return (
      //<li className={constructor.couponClasses(coupon)} id={'coupons_' + this.props.coupon.id}  key={index}>
      <li className="coupon-list" id={'coupons_' + this.props.coupon.id}  key={this.props.key}>
        <span className="coupon-list--container">
          <span className="coupon-list--title">{this.props.coupon.title}</span>
        </span>
        <CouponActions className="couponActions" couponId={this.props.coupon.id} />
      </li>
    );
  }

});

module.exports = Coupon;