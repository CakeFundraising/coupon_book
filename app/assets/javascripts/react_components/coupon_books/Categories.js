import React, { Component, PropTypes } from 'react';
import Button from './Button';
import CouponActions from './CouponActions';
import CategoryItems from './CategoryItems';

export default class Categories extends Component {
  state = {items: []};

  static propTypes = {
    id: PropTypes.string.isRequired
  };

  componentDidMount() {
    $.get(this.props.source, function(data) {
      this.setState({
        items: data
      });
    }.bind(this));
  }

  render() {
    const { className, id } = this.props;

    const categoryItems = this.state.items.map (function (item, index) {
      return (
        <li className="category-list" key={index}>
          <span className="category-list--title">{item.name}</span>
          <CouponActions className="couponActions couponActions-category" couponId={item.id} noPreview />
          <CategoryItems className="collection-coupons" id="collection-coupons-category" source={item.coupons} />
        </li>
      );
    })

    return (
      <div className="categories-column">
        <h2>Discount Book Categories
          <Button
            data-target="#category"
            data-toggle="modal"
            href="/coupons/new"
            type="link"
            className="btn btn-success btn-sm pull-right">
            Add Category
          </Button>
        </h2>      
        <ul className={className} id={id}>
          {categoryItems}
        </ul>
      </div>
    );
  }

}
