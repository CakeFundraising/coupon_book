import React, { Component, PropTypes } from 'react';
import CouponActions from './CouponActions';

import { DragSource } from 'react-dnd'
import ItemTypes from './ItemTypes'

const couponSource = {
  beginDrag(props) {
    return {
      id: props.coupon.id,
      title: props.coupon.title
    };
  }
}

@DragSource(ItemTypes.COUPON, couponSource, (connect, monitor) =>({
  connectDragSource: connect.dragSource(),
  //connectDragPreview: connect.dragPreview(),
  isDragging: monitor.isDragging()
}))
export default class Coupon extends Component {
  static propTypes = {
    coupon: PropTypes.object.isRequired,
    // Injected by React DnD:
    isDragging: PropTypes.bool.isRequired,
    connectDragSource: PropTypes.func.isRequired
  };

  render(){
    const { id, title } = this.props.coupon;
    const { isDragging, connectDragSource, key } = this.props;
    const opacity = isDragging ? 0.4 : 1;

    return connectDragSource(
      <li style={{ opacity: opacity }} className="coupon-item" id={'coupons_' + id}  key={key}>
        <span className="coupon-item--container">
          <span className="coupon-item--title">{title}</span>
        </span>
        <CouponActions className="couponActions" couponId={id} />
      </li>
    );
  }
}
