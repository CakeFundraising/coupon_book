import React, { Component, PropTypes } from 'react';
import Button from './Button';

import ItemTypes from './ItemTypes';
import { DragSource, DropTarget } from 'react-dnd';

const itemSource = {
  beginDrag(props) {
    return {
      id: props.id,
      originalIndex: props.findItem(props.id).index,
      categoryId: props.categoryId
    };
  },

  endDrag(props, monitor) {
    const { id: droppedId, originalIndex, categoryId } = monitor.getItem();
    const didDrop = monitor.didDrop();

    if (!didDrop) {
      props.moveItem(droppedId, originalIndex, categoryId);
    }
  }
};

const itemTarget = {
  hover(props, monitor) {
    const { id: draggedId, draggedIndex, categoryId } = monitor.getItem();
    const { id: overId } = props;

    if (draggedId !== overId) {
      const { index: overIndex } = props.findItem(overId);

      if (overIndex !== null){
        props.moveItem(draggedId, overIndex, categoryId);
      };
    }
  }
};

@DropTarget(ItemTypes.CATEGORYITEM, itemTarget, connect => ({
  connectDropTarget: connect.dropTarget()
}))
@DragSource(ItemTypes.CATEGORYITEM, itemSource, (connect, monitor) => ({
  connectDragSource: connect.dragSource(),
  isDragging: monitor.isDragging()
}))
export default class BookItem extends Component {
  static propTypes = {
    id: PropTypes.any.isRequired,
    title: PropTypes.string.isRequired,

    connectDragSource: PropTypes.func.isRequired,
    connectDropTarget: PropTypes.func.isRequired,
    isDragging: PropTypes.bool.isRequired,
    moveItem: PropTypes.func.isRequired,
    findItem: PropTypes.func.isRequired
  };

  render(){
    const { id, title, key, isDragging, connectDragSource, connectDropTarget } = this.props;
    const opacity = isDragging ? 0 : 1;

    return connectDragSource(connectDropTarget(
      <li style={{ opacity: opacity }} className="coupon-list" id={'coupons_' + id}  key={key}>
        <span className="coupon-list--container">
          <span className="coupon-list--title">{title}</span>
        </span>
        <Button iconType='remove' className="btn btn-sm pull-right btn-danger">Delete</Button>
        <Button href={'/coupons/' + id + '/edit'} iconType="pencil" className="btn btn-sm pull-right btn-primary">Edit</Button>
        <Button iconType="eye-open" className="btn btn-sm pull-right btn-success" data-target={'#preview-coupon-' + id} data-toggle="modal">Preview </Button>
      </li>
    ));
  }
}
