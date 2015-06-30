import React, { Component, PropTypes } from 'react';
import update from 'react/lib/update';

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
    this.state = {categories: []};
  }

  componentDidMount() {
    $.get(this.props.source, function(data) {
      this.setState({
        categories: data
      });
    }.bind(this));
  }

  // Sortable Functions
  moveCategory(id, atIndex) {
    const { category, index } = this.findCategory(id);
    
    this.setState(update(this.state, {
      categories: {
        $splice: [
          [index, 1],
          [atIndex, 0, category]
        ]
      }
    }));
  }

  findCategory(id) {
    const { categories } = this.state;
    const category = categories.filter(c => c.id === id)[0];
    
    return {
      category,
      index: categories.indexOf(category)
    };
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
              <Category id={category.id} name={category.name} categoryItems={category.items} key={index} moveCategory={this.moveCategory} findCategory={this.findCategory} />
            );
          })}
        </ul>
      </div>
    );
  }

}
