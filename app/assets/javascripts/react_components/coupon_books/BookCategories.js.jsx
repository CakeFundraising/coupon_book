var React = require('react');
var CouponActions = require('./CouponActions.js.jsx');
var BookCategoryItems = require('./BookCategoryItems.js.jsx');

var BookCategories = React.createClass({
  propTypes: {
    id: React.PropTypes.string.isRequired
  },

  getInitialState: function() {
    return {
      items: []
    };
  },

  componentDidMount: function() {
    $.get(this.props.source, function(data) {
      if (this.isMounted()) {
        this.setState({
          items: data
        });
      }
    }.bind(this));
  },

  render: function() {
    return (
      <ul className={this.props.className} id={this.props.id}>
        {this.renderCategoryList()}
      </ul>
    );
  },

  renderCategoryList: function () {
    return (
      this.state.items.map (function (item, index) {
        return (
          <li className="category-list" key={index}>
            <span className="category-list--title">{item.name}</span>
            <CouponActions className="couponActions couponActions-category" couponId={item.id} noPreview />
            <BookCategoryItems className="collection-coupons" id="collection-coupons-category" source={item.coupons} />
          </li>
        );
      })
    );
  }
});

module.exports = BookCategories;
