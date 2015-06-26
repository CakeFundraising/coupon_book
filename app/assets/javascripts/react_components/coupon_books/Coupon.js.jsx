var React = require('react');
var CouponActions = require('./CouponActions.js.jsx');

var Coupon = React.createClass({
  render: function(){
    var id = this.props.coupon.id; 
    var title = this.props.coupon.title;

    return (
      <li className="coupon-list" id={'coupons_' + id}  key={this.props.key}>
        <span className="coupon-list--container">
          <span className="coupon-list--title">{title}</span>
        </span>
        <CouponActions className="couponActions" couponId={id} />
      </li>
    );
  }

});

module.exports = Coupon;