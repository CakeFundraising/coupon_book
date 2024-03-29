import React, { Component, PropTypes } from 'react';
import update from 'react/lib/update';

import CategoryItemsList from './CategoryItemsList';
import Button from './Button';
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

    removeItem: PropTypes.func.isRequired,
    deleteFromCategory: PropTypes.func.isRequired,
    toggleItem: PropTypes.func.isRequired,
    itemInCategory: PropTypes.func.isRequired,

    addItemToCategory: PropTypes.func.isRequired,
    addCouponToCategory: PropTypes.func.isRequired,
    enableCoupon: PropTypes.func.isRequired,
    enablePrBox: PropTypes.func.isRequired
  };

  render(){
    const { id, name, key, isDragging, connectDragSource, connectDropTarget, 
      categoryItems, addItemToCategory, removeItem, deleteFromCategory, addCouponToCategory, 
      toggleItem, itemInCategory, enableCoupon, enablePrBox } = this.props;
    const opacity = isDragging ? 0 : 1;

    return connectDropTarget(connectDragSource(
      <li className="category" key={key}>
        <span className="category--title">{name}</span>
        <ul className="couponActions couponActions-category">
          <li className='couponActions couponActions-category--item'>
            <Button
              href={'/categories/' + id + '/edit'}
              iconType="pencil"
              className="btn btn-sm btn-primary">Edit
            </Button>
          </li>
          <li className='couponActions couponActions-category--item'>
            <Button
              iconType='trash'
              href={"/categories/" + id}
              dMethod="delete"
              dConfirm="Are you sure? This action will remove any item inside this Category."
              className="btn btn-sm btn-danger">Delete
            </Button>
          </li>
        </ul>
        <CategoryItemsList 
          categoryItems={categoryItems} 
          categoryId={id} 
          addItemToCategory={addItemToCategory} 
          addCouponToCategory={addCouponToCategory} 
          removeItem={removeItem}
          deleteFromCategory={deleteFromCategory}
          toggleItem={toggleItem}
          itemInCategory={itemInCategory}
          enableCoupon={enableCoupon}
          enablePrBox={enablePrBox} />
      </li>
    ));
  }
}