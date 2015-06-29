import React, { Component, PropTypes } from 'react';
import Button from './Button';
import Coupon from './Coupon';

export default class CollectionCoupons extends Component {
  state = {items: []};

  static propTypes = {
    cssId: PropTypes.string.isRequired,
    source: PropTypes.string.isRequired
  };

  componentDidMount() {
    $.get(this.props.source, function(data) {
      this.setState({
        items: data
      });
    }.bind(this));
  }

  render() {
    var coupons = this.state.items.map(function(item, index) {
      if(!item.disabled){
        return (
          <Coupon coupon={item} key={index}></Coupon>
        );
      };
    });

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
          {coupons}
        </ul>
      </div>
    );
  }
}
