var CouponList = React.createClass({
  propTypes: {
    id: React.PropTypes.string.isRequired,
    source: React.PropTypes.string.isRequired
  },

  mixins: [SortableMixin],

  sortableOptions: {
    sort: false,
    group: 'coupons',
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
    var coupons = this.state.items.map(function(item, index) {
      if(!item.disabled){
        return (
          <Coupon coupon={item} key={index}></Coupon>
        );
      };
    });

    return (
      <ul className={this.props.className} id={this.props.id}>
        {coupons}
      </ul>
    );
  },

});
