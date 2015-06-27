var React = require('react');
var PropTypes = React.PropTypes;
var CouponActions = require('./CouponActions.js.jsx');

// ReactDnD
var DragSource = require('react-dnd').DragSource;
var ItemTypes = require('./ItemTypes');

var couponSource = {
  beginDrag: function (props) {
    return {
      id: props.coupon.id,
      title: props.coupon.title
    };
  }
}

function collect(connect, monitor) {
  return {
    connectDragSource: connect.dragSource(),
    isDragging: monitor.isDragging()
  };
}

// Define React Component
var Coupon = React.createClass({
  propTypes: {
    coupon: PropTypes.object.isRequired,
    // Injected by React DnD:
    isDragging: PropTypes.bool.isRequired,
    connectDragSource: PropTypes.func.isRequired
  },

  render: function(){
    var id = this.props.coupon.id; 
    var title = this.props.coupon.title;
    var isDragging = this.props.isDragging;
    var connectDragSource = this.props.connectDragSource;

    return connectDragSource(
      <li className="coupon-list" id={'coupons_' + id}  key={this.props.key}>
        <span className="coupon-list--container">
          <span className="coupon-list--title">{title}</span>
        </span>
        <CouponActions className="couponActions" couponId={id} />
      </li>
    );
  }

});

module.exports = DragSource(ItemTypes.COUPON, couponSource, collect)(Coupon);