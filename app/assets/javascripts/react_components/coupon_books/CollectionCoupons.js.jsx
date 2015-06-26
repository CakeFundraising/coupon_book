var React = require('react');
var Coupon = require('./Coupon.js.jsx');

var CollectionCoupons = React.createClass({
  propTypes: {
    id: React.PropTypes.string.isRequired,
    source: React.PropTypes.string.isRequired
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

module.exports = CollectionCoupons;
