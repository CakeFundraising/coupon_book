import React, { Component, PropTypes } from 'react';
import update from 'react/lib/update';

import CategoryItemsList from './CategoryItemsList';
import CouponActions from './CouponActions';
import ItemTypes from './ItemTypes'

import { DragSource, DropTarget } from 'react-dnd'

// DragSource
const categorySource = {
  beginDrag(props) {
    return {
      id: props.id,
      originalIndex: props.findCategory(props.id).index
    };
  },

  endDrag(props, monitor) {
    const { id: droppedId, originalIndex } = monitor.getItem();
    const didDrop = monitor.didDrop();

    if (!didDrop) {
      props.moveCategory(droppedId, originalIndex);
    }
  }
};

// DropTarget
const categoryTarget = {
  hover(props, monitor) {
    const { id: draggedId } = monitor.getItem();
    const { id: overId } = props;

    if (draggedId !== overId) {
      const { index: overIndex } = props.findCategory(overId);
      props.moveCategory(draggedId, overIndex);
    }
  }
};

@DropTarget(ItemTypes.CATEGORY, categoryTarget, connect => ({
  connectDropTarget: connect.dropTarget()
}))
@DragSource(ItemTypes.CATEGORY, categorySource, (connect, monitor) => ({
  connectDragSource: connect.dragSource(),
  isDragging: monitor.isDragging()
}))
export default class Category extends Component {
  static propTypes = {
    id: PropTypes.any.isRequired,
    name: PropTypes.string.isRequired,
    categoryItems: PropTypes.object.isRequired,

    connectDragSource: PropTypes.func.isRequired,
    connectDropTarget: PropTypes.func.isRequired,
    isDragging: PropTypes.bool.isRequired,

    moveCategory: PropTypes.func.isRequired,
    findCategory: PropTypes.func.isRequired,

    addItemToCategory: PropTypes.func.isRequired,
    removeItemFromCategory: PropTypes.func.isRequired,

    addCouponToCategory: PropTypes.func.isRequired,
    enableCoupon: PropTypes.func.isRequired,
    enablePrBox: PropTypes.func.isRequired
  };

  render(){
    const { id, name, key, isDragging, connectDragSource, connectDropTarget, 
      categoryItems, addItemToCategory, removeItemFromCategory, addCouponToCategory, enableCoupon, enablePrBox } = this.props;
    const opacity = isDragging ? 0 : 1;

    return connectDropTarget(connectDragSource(
      <li className="category" key={key}>
        <span className="category--title">{name}</span>
        <CouponActions className="couponActions couponActions-category" couponId={id} noPreview />
        <CategoryItemsList 
          categoryItems={categoryItems} 
          categoryId={id} 
          addItemToCategory={addItemToCategory} 
          removeItemFromCategory={removeItemFromCategory} 
          addCouponToCategory={addCouponToCategory} 
          enableCoupon={enableCoupon}
          enablePrBox={enablePrBox} />
      </li>
    ));
  }
}