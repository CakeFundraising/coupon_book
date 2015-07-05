import React, { Component, PropTypes } from 'react';

import CollectionCoupons from './CollectionCoupons';
import CategoryItem from './CategoryItem';
import ItemTypes from './ItemTypes'

import { DropTarget } from 'react-dnd'

// DropTarget
const itemsTarget = {
  hover(props, monitor, component) {
    // Add item when category is empty
    const noItems = component.state.items.size === 0;

    if (noItems) {
      const { id: draggedId, draggedIndex, categoryId } = monitor.getItem();
      component.moveItem(draggedId, draggedIndex, categoryId)
    };
  }
};

const couponTarget = {
  hover(props, monitor){
    props.addCouponToCategory(monitor.getItem(), props.categoryId);
  }
};

const prBoxTarget = {
  hover(props, monitor){
    props.addCouponToCategory(monitor.getItem(), props.categoryId);
  }
};

@DropTarget(ItemTypes.PRBOX, prBoxTarget, connect => ({
  prBoxDropTarget: connect.dropTarget()
}))
@DropTarget(ItemTypes.COUPON, couponTarget, connect => ({
  couponDropTarget: connect.dropTarget()
}))
@DropTarget(ItemTypes.CATEGORYITEM, itemsTarget, connect => ({
  itemDropTarget: connect.dropTarget()
}))
export default class CategoryItemsList extends Component {
  static propTypes = {
    categoryItems: PropTypes.any.isRequired,
    categoryId: PropTypes.number.isRequired,

    addItemToCategory: PropTypes.func.isRequired,
    removeItemFromCategory: PropTypes.func.isRequired,
    addCouponToCategory: PropTypes.func.isRequired,
    enableCoupon: PropTypes.func.isRequired,
    enablePrBox: PropTypes.func.isRequired,

    itemDropTarget: PropTypes.func.isRequired,
    couponDropTarget: PropTypes.func.isRequired,
    prBoxDropTarget: PropTypes.func.isRequired
  };

  constructor(props) {
    super(props);
    this.moveItem = this.moveItem.bind(this);
    this.findItem = this.findItem.bind(this);
    this.removeItem = this.removeItem.bind(this);
    this.state = {items: this.props.categoryItems};
  }

  componentWillReceiveProps(newProps){
    this.setState({items: newProps.categoryItems}); 
  }

  // Sortable Functions

  //Find whether item is included in current category
  findItem(id) {
    const { items } = this.state;
    const item = items.find(i => i.get('id') === id);
    var response = {};

    if(item !== undefined){
      response = {
        item,
        index: items.indexOf(item)
      };
    }else{
      response = {
        null, 
        index: null
      }
    };

    return response;
  }

  moveItem(id, atIndex, categoryId) {
    const { item, index } = this.findItem(id); 

    if(index !== null){
      // If item is in current category update array
      this.setState(({items}) => ({
        items: items.update(items => items.splice(index, 1).splice(atIndex, 0, item))
      }));
    }else{
      // Add item to current category and remove from original
      this.props.addItemToCategory(id, this.props.categoryId);
      this.props.removeItemFromCategory(id, categoryId);
    };
    
  }

  removeItem(id, itemType){
    this.props.removeItemFromCategory(id, this.props.categoryId);
    (itemType === 'COUPON') ? this.props.enableCoupon(id) : this.props.enablePrBox(id)
  }

  render(){
    const { itemDropTarget, couponDropTarget, prBoxDropTarget, categoryId } = this.props;
    const { items: categoryItems } = this.state;

    return prBoxDropTarget(couponDropTarget(itemDropTarget(
      <ul className="category-items">
        {categoryItems.map((item, index) => {
          return (
            <CategoryItem 
              id={item.get('id')} 
              title={item.get('title')}
              position={item.get('position')}
              itemType={item.get('itemType')} 
              categoryId={categoryId} 
              saved={item.get('saved')} 
              _destroy={item.get('_destroy')} 
              key={index} 
              moveItem={this.moveItem} 
              findItem={this.findItem} 
              removeItem={this.removeItem} />
          );
        })}
      </ul>
    )));
  }
}