var CouponList = React.createClass({
  propTypes: {
    id: React.PropTypes.string.isRequired,
    source: React.PropTypes.string.isRequired
  },

  mixins: [SortableMixin],

  sortableOptions: {
    sort: false,
    group: {
      name: 'organize'
      //pull: 'clone'
    },
    filter: '.disabled',
    model: 'items',
    animation: 200,
    ghostClass: 'sortable-ghost'
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
        {this.renderCouponItem()}
      </ul>
    );
  },

  renderCouponItem: function () {
    if (this.state.items.length !== 0) {
      //var constructor = this;
      return (
        this.state.items.map (function (item, index) {
          if(!item.disabled){
            return (
              //<li className={constructor.couponClasses(item)} id={'coupons_' + item.id}  key={index}>
              <li className="coupon-list" id={'coupons_' + item.id}  key={index}>
                <span className="coupon-list--container">
                  <span className="coupon-list--title">{item.title}</span>
                </span>
                <CouponActions className="couponActions" couponId={item.id} />
              </li>
            );
          };
        })
      );
    } else {
      return <li className="empty-list"></li>
    }
  },

  // couponClasses: function(coupon){
  //   var cx = React.addons.classSet;
  //   var classes = cx({
  //     'coupon-list': true,
  //     'hidden': coupon.disabled,
  //   });
  //   return classes;
  // }
  
});
