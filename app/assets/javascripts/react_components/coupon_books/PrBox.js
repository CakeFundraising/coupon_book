import React, { Component, PropTypes } from 'react';
import CouponActions from './CouponActions';

import { DragSource } from 'react-dnd'
import ItemTypes from './ItemTypes'

const prBoxSource = {
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
      props.disablePrBox(props.id);
    };
  }
}

@DragSource(ItemTypes.PRBOX, prBoxSource, (connect, monitor) =>({
  connectDragSource: connect.dragSource(),
  isDragging: monitor.isDragging()
}))
export default class PrBox extends Component {
  static propTypes = {
    id: PropTypes.number.isRequired,
    title: PropTypes.string.isRequired,
    itemType: PropTypes.string.isRequired,
    disabled: PropTypes.bool.isRequired,
    disablePrBox: PropTypes.func.isRequired,
    // Injected by React DnD:
    isDragging: PropTypes.bool.isRequired,
    connectDragSource: PropTypes.func.isRequired
  };

  render(){
    const { id, title, disabled, itemType, isDragging, connectDragSource, key } = this.props;
    const opacity = (isDragging || disabled) ? 0.4 : 1;
 
    return connectDragSource(
      <li style={{ opacity: opacity }} className="prbox-item" id={'prboxes_' + id}  key={key}>
        <span className="prbox-item--container">
          <span className="prbox-item--title">{title}</span>
        </span>
        <CouponActions className="prboxActions" couponId={id} />
      </li>
    );
  }
}
