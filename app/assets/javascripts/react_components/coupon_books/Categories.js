import React, { Component, PropTypes } from 'react';
import update from 'react/lib/update';
import Immutable from 'immutable'
import _ from 'underscore'

import Button from './Button';
import Category from './Category';

export default class Categories extends Component {
  static propTypes = {
    id: PropTypes.string.isRequired,
    className: PropTypes.string.isRequired,
    enableCoupon: PropTypes.func.isRequired,
    enablePrBox: PropTypes.func.isRequired
  };

  constructor(props) {
    super(props);

    this.moveCategory = this.moveCategory.bind(this);
    this.findCategory = this.findCategory.bind(this);

    this.getCategoriesItems = this.getCategoriesItems.bind(this);
    this.findCategoryByItem = this.findCategoryByItem.bind(this);
    this.findItem = this.findItem.bind(this);

    this.addItemToCategory = this.addItemToCategory.bind(this);
    this.removeItemFromCategory = this.removeItemFromCategory.bind(this);
    this.addCouponToCategory = this.addCouponToCategory.bind(this);

    this.state = {categories: []};
  }

  componentDidMount() {
    $.get(this.props.source, function(data) {
      this.setState({
        categories: Immutable.fromJS(data)
      });
    }.bind(this));
  }

  // Sortable Functions
  findCategory(id) {
    const { categories } = this.state;
    const category = categories.find(c => c.get('id') === id);
    
    return {
      category,
      index: categories.indexOf(category)
    };
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

  //Item actions
  addItemToCategory(itemId, categoryId){
    const categoryItems = this.getCategoriesItems();
    const item = categoryItems.find(i => i.get('id') === itemId);
    const categoryIndex = this.findCategory(categoryId).index;

    this.setState(({categories}) => ({
      categories: categories.updateIn([categoryIndex, 'items'], items => items.unshift(item))
    }));
  }

  removeItemFromCategory(itemId, categoryId=null){
    if(categoryId === null){
      const { category, index: categoryIndex } = this.findCategoryByItem(itemId);
      const index = category.get('items').findIndex(i => i.get('id') === itemId);

      this.setState(({categories}) => ({
        categories: categories.deleteIn([categoryIndex, 'items', index])
      }));
    }else{
      const { category, index: categoryIndex } = this.findCategory(categoryId);
      const index = category.get('items').findIndex(i => i.get('id') === itemId);
      
      this.setState(({categories}) => ({
        categories: categories.deleteIn([categoryIndex, 'items', index])
      }));
    };

  }

  addCouponToCategory(coupon, categoryId){
    const { index: categoryIndex } = this.findCategory(categoryId);
    const item = Immutable.fromJS(coupon);
    
    const categoryItems = this.getCategoriesItems();
    const existing = categoryItems.find(i => i.get('id') === coupon.id && i.get('itemType') === coupon.itemType);

    if(existing === undefined){
      this.setState(({categories}) => ({
        categories: categories.updateIn([categoryIndex, 'items'], items => items.unshift(item))
      }));
    };
  }

  render() {
    const { className, id, enableCoupon, enablePrBox } = this.props;
    const { categories } =  this.state;

    return (
      <div className="categories-column">
        <h2>Discount Book Categories
          <Button
            data-target="#category"
            data-toggle="modal"
            href="/coupons/new"
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
                removeItemFromCategory={this.removeItemFromCategory} 
                addCouponToCategory={this.addCouponToCategory} 
                enableCoupon={enableCoupon}
                enablePrBox={enablePrBox} />
            );
          })}
        </ul>
      </div>
    );
  }

}
