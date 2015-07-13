import React, { Component, PropTypes } from 'react';
import CouponActions from './CouponActions';

import { DragSource } from 'react-dnd'
import ItemTypes from './ItemTypes'

const couponSource = {
  beginDrag(props) {
    return {
      id: props.id,
      title: props.title,
      itemType: props.itemType
    };
  },

  canDrag(props){
    return !props.disabled;
  },

  endDrag(props, monitor){
    if(monitor.didDrop()){
      props.disableCoupon(props.id);
    }else{
      props.removeItemFromCategory(props.id);
    };
  }
}

@DragSource(ItemTypes.COUPON, couponSource, (connect, monitor) =>({
  connectDragSource: connect.dragSource(),
  isDragging: monitor.isDragging()
}))
export default class Coupon extends Component {
  static propTypes = {
    id: PropTypes.number.isRequired,
    title: PropTypes.string.isRequired,
    itemType: PropTypes.string.isRequired,
    disabled: PropTypes.bool.isRequired,
    disableCoupon: PropTypes.func.isRequired,
    removeItemFromCategory: PropTypes.func.isRequired,
    // Injected by React DnD:
    isDragging: PropTypes.bool.isRequired,
    connectDragSource: PropTypes.func.isRequired
  };

  render(){
    const { id, title, disabled, itemType, sponsorName, isDragging, connectDragSource, key } = this.props;
    const opacity = (isDragging || disabled) ? 0.4 : 1;

    return connectDragSource(
      <li style={{ opacity: opacity }} className="coupon-item" id={'coupons_' + id}  key={key}>
        <span className="coupon-item--container">
          <span className="coupon-item--title">{title}</span>
          <span className="coupon-item--owner">{sponsorName}</span>
        </span>
        <CouponActions className="couponActions" itemId={id} itemType="coupons" />
      </li>
    );
  }
}
