import React, { Component, PropTypes } from 'react';
import update from 'react/lib/update';
import Immutable from 'immutable'
import _ from 'underscore'

import Button from './Button';
import Category from './Category';

export default class Categories extends Component {
  static propTypes = {
    id: PropTypes.string.isRequired,
    className: PropTypes.string.isRequired
  };

  constructor(props) {
    super(props);
    this.moveCategory = this.moveCategory.bind(this);
    this.findCategory = this.findCategory.bind(this);
    this.addItemToCategory = this.addItemToCategory.bind(this);
    this.removeItemFromCategory = this.removeItemFromCategory.bind(this);
    this.state = {categories: [], categoryItems: []};
  }

  componentDidMount() {
    $.get(this.props.source, function(data) {
      this.setState({
        categories: Immutable.fromJS(data),
        categoryItems: Immutable.fromJS(_.flatten(_.map(data, (category, index) => { return category.items })))
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

  addItemToCategory(itemId, categoryId){
    let { categoryItems } = this.state;
    let item = categoryItems.find(i => i.get('id') === itemId);
    let categoryIndex = this.findCategory(categoryId).index;

    this.setState(({categories}) => ({
      categories: categories.updateIn([categoryIndex, 'items'], items => items.push(item))
    }));
  }

  removeItemFromCategory(itemId, categoryId){
    let { category, index: categoryIndex } = this.findCategory(categoryId);
    let index = category.get('items').findIndex(i => i.get('id') === itemId);

    this.setState(({categories}) => ({
      categories: categories.updateIn([categoryIndex, 'items'], items => items.size === 1 ? items.splice(-1, 1) : items.splice(index, 1))
    }));
  }

  render() {
    const { className, id } = this.props;
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
              <Category id={category.get('id')} name={category.get('name')} categoryItems={category.get('items')} key={index} 
                moveCategory={this.moveCategory} findCategory={this.findCategory} addItemToCategory={this.addItemToCategory} removeItemFromCategory={this.removeItemFromCategory} />
            );
          })}
        </ul>
      </div>
    );
  }

}
