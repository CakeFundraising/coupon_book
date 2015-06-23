var BookCategories = React.createClass({
  propTypes: {
    id: React.PropTypes.string.isRequired
  },

  mixins: [SortableMixin],

  sortableOptions: {
    animation: 200
  },

  getInitialState: function() {
    return {
      items: ['Foods', 'Drinks']
    };
  },

  render: function() {
    return (
      <ul className={this.props.className} id={this.props.id}>
        {this.renderCategoryList()}
      </ul>
    );
  },

  renderCategoryList: function () {
    var couponList = [];
    return (
      this.state.items.map (function (item, index) {
        return (
          <li className="category-list" key={index}>
            <span className="category-list--title">{item}</span>
            <CouponActions className="couponActions couponActions-category" couponId={item.id} noPreview />
            <BookCategoryDiscounts className="collection-coupons" id="collection-coupons-category" source={couponList} />
          </li>
        );
      })
    );
  }
});
