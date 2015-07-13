import React, { Component, PropTypes } from 'react';
import update from 'react/lib/update';
import Immutable from 'immutable'
import _ from 'underscore'

import Button from './Button';
import Category from './Category';

export default class Categories extends Component {
  static propTypes = {
    id: PropTypes.string.isRequired,
    bookId: PropTypes.string.isRequired,
    className: PropTypes.string.isRequired,
    enableCoupon: PropTypes.func.isRequired,
    enablePrBox: PropTypes.func.isRequired
  };

  constructor(props) {
    super(props);

    this.moveCategory = this.moveCategory.bind(this);
    this.getCategoriesItems = this.getCategoriesItems.bind(this);

    this.findCategory = this.findCategory.bind(this);
    this.findCategoryByItem = this.findCategoryByItem.bind(this);
    this.findItem = this.findItem.bind(this);

    this.addItemToCategory = this.addItemToCategory.bind(this);
    this.addCouponToCategory = this.addCouponToCategory.bind(this);
    this.toggleItem = this.toggleItem.bind(this);
    this.itemInCategory = this.itemInCategory.bind(this);

    this.removeItem = this.removeItem.bind(this);
    this.removeItemFromCategory = this.removeItemFromCategory.bind(this);
    this.flagItemAsDeleted = this.flagItemAsDeleted.bind(this);
    this.deleteFromCategory = this.deleteFromCategory.bind(this);

    this.state = {categories: []};
  }

  componentDidMount() {
    $.get(this.props.source, function(data) {
      this.setState({
        categories: Immutable.fromJS(data)
      });
    }.bind(this));
  }

  // Finder Functions
  findCategory(id) {
    const { categories } = this.state;
    const category = categories.find(c => c.get('id') === id);
    
    return {
      category,
      index: categories.indexOf(category)
    };
  }

  findItem(itemId){
    const categoryItems = this.getCategoriesItems();
    const item = categoryItems.find(i => i.get('id') === itemId);
    return item;
  }

  findCategoryByItem(itemId){
    const { categories } = this.state;
    const item = this.findItem(itemId);
    const category = categories.find(c => c.get('items').includes(item));

    return {
      category,
      index: categories.indexOf(category)
    }
  }

  moveCategory(id, atIndex) {
    const { category, index } = this.findCategory(id);

    this.setState(({categories}) => ({
      categories: categories.update(categories => categories.splice(index, 1).splice(atIndex, 0, category))
    }));
  }

  getCategoriesItems(){
    return this.state.categories.flatMap(c => c.get('items'));
  }

  toggleItem(id, atIndex, categoryId){
    const item = this.findItem(id);
    const { category, index: categoryIndex } = this.findCategory(categoryId);
    const itemIndex = category.get('items').findIndex(i => i.get('id') === id)

    this.setState(({categories}) => ({
      categories: categories.updateIn([categoryIndex, 'items'], items => items.splice(itemIndex, 1).splice(atIndex, 0, item))
    }));
  }

  itemInCategory(itemId, categoryId){
    const { category, index: categoryIndex } = this.findCategory(categoryId);
    const itemIndex = category.get('items').findIndex(i => i.get('id') === itemId)
    return itemIndex !== -1;
  }

  // Additive functions
  addItemToCategory(itemId, categoryId){
    const categoryItems = this.getCategoriesItems();
    const item = categoryItems.find(i => i.get('id') === itemId).delete('collection_id');
    const {index: categoryIndex} = this.findCategory(categoryId);

    this.setState(({categories}) => ({
      categories: categories.updateIn([categoryIndex, 'items'], items => items.unshift(item))
    }));
  }

  addCouponToCategory(coupon, categoryId){
    const { index: categoryIndex } = this.findCategory(categoryId);
    const item = Immutable.fromJS(_.extend(coupon, {_destroy: false, saved: false}));
    
    const categoryItems = this.getCategoriesItems();
    const existing = categoryItems.find(i => 
      i.get('id') === coupon.id && i.get('itemType') === coupon.itemType && i.get('_destroy') === false
    );

    if(existing === undefined){
      this.setState(({categories}) => ({
        categories: categories.updateIn([categoryIndex, 'items'], items => items.unshift(item))
      }));
    };
  }

  // Subtractive Functions
  removeItem(itemId, categoryId=null){
    if(categoryId === null){
      const { category, index: categoryIndex } = this.findCategoryByItem(itemId);
      this.removeItemFromCategory(category, categoryIndex, itemId);
    }else{
      const { category, index: categoryIndex } = this.findCategory(categoryId);
      this.removeItemFromCategory(category, categoryIndex, itemId);
    };
    
  }

  removeItemFromCategory(category, categoryIndex, itemId){
    const index = category.get('items').findIndex(i => i.get('id') === itemId);
    const item = category.get('items').toJS()[index]
    
    if(item.saved){ // Set _destroy to true
      this.flagItemAsDeleted(categoryIndex, index)
    }else{ // Just remove it from Category
      this.setState(({categories}) => ({
        categories: categories.deleteIn([categoryIndex, 'items', index])
      }));
    };
  }

  flagItemAsDeleted(categoryIndex, itemIndex){
    this.setState(({categories}) => ({
      categories: categories.setIn([categoryIndex, 'items', itemIndex, '_destroy'], true)
    }));
  }

  deleteFromCategory(itemId, categoryId){
    const { category, index: categoryIndex } = this.findCategory(categoryId);
    const itemIndex = category.get('items').findIndex(i => i.get('id') === itemId);

    if (itemIndex !== -1) {
      this.setState(({categories}) => ({
        categories: categories.deleteIn([categoryIndex, 'items', itemIndex])
      }));
    };
  }

  // Render
  render() {
    const { className, id, enableCoupon, enablePrBox, bookId } = this.props;
    const { categories } =  this.state;

    return (
      <div className="categories-column">
        <h2>Discount Book Categories
          <Button
            //data-target="#category"
            //data-toggle="modal"
            href={"/categories/new?coupon_book_id=" + bookId}
            type="link"
            className="btn btn-success btn-sm pull-right">
            Add Category
          </Button>
        </h2>      
        <ul className={className} id={id}>
          {categories.map((category, index) => {
            return (
              <Category 
                id={category.get('id')} 
                name={category.get('name')} 
                categoryItems={category.get('items')} 
                key={index} 
                moveCategory={this.moveCategory} 
                findCategory={this.findCategory} 
                addItemToCategory={this.addItemToCategory} 
                addCouponToCategory={this.addCouponToCategory} 
                removeItem={this.removeItem}
                deleteFromCategory={this.deleteFromCategory} 
                toggleItem={this.toggleItem} 
                itemInCategory={this.itemInCategory} 
                enableCoupon={enableCoupon}
                enablePrBox={enablePrBox} />
            );
          })}
        </ul>
      </div>
    );
  }

}
