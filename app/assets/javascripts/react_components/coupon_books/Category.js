import React, { Component, PropTypes } from 'react';
import update from 'react/lib/update';

import CategoryItem from './CategoryItem';
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

    connectDragSource: PropTypes.func.isRequired,
    connectDropTarget: PropTypes.func.isRequired,
    isDragging: PropTypes.bool.isRequired,
    moveCategory: PropTypes.func.isRequired,
    findCategory: PropTypes.func.isRequired
  };

  constructor(props) {
    super(props);
    this.moveItem = this.moveItem.bind(this);
    this.findItem = this.findItem.bind(this);
    this.state = {items: this.props.categoryItems};
  }

  componentWillReceiveProps(newProps){
    this.setState({items: newProps.categoryItems}); 
  }

  // Sortable Functions
  moveItem(id, atIndex) {
    const { item, index } = this.findItem(id);
    
    this.setState(update(this.state, {
      items: {
        $splice: [
          [index, 1],
          [atIndex, 0, item]
        ]
      }
    }));
  }

  findItem(id) {
    const { items } = this.state;
    const item = items.filter(i => i.id === id)[0];

    return {
      item,
      index: items.indexOf(item)
    };
  }

  render(){
    const { id, name, key, isDragging, connectDragSource, connectDropTarget } = this.props;
    const { items: categoryItems } = this.state;
    const opacity = isDragging ? 0 : 1;

    return connectDragSource(connectDropTarget(
      <li className="category-list" key={key}>
        <span className="category-list--title">{name}</span>
        <CouponActions className="couponActions couponActions-category" couponId={id} noPreview />
        <ul className="collection-coupons" id="collection-coupons-category">
          {categoryItems.map((item, index) => {
            return (
              <CategoryItem id={item.id} title={item.title} key={index} moveItem={this.moveItem} findItem={this.findItem} />
            );
          })}
        </ul>
      </li>
    ));
  }
}