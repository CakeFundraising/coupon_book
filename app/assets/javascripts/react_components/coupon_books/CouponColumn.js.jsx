var React = require('react');
var Button = require('./Button.js.jsx');
var CollectionCoupons = require('./CollectionCoupons.js.jsx');

var CouponColumn = React.createClass({
  render: function() {
    return(
      <div className="coupons-column">
        <h2>Available Discounts
          <Button
            href="/coupons/new"
            type="link"
            className="btn btn-success btn-sm pull-right">
            Add Discount
          </Button>
        </h2>
        <CollectionCoupons className="collection-coupons" id="collection-coupons" source={this.props.source} />
      </div>
    );
  }
});

module.exports = CouponColumn;