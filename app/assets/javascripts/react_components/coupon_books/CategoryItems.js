import React, { Component, PropTypes } from 'react';
import update from 'react/lib/update';
import BookItem from './BookItem';

import { DropTarget } from 'react-dnd'
import ItemTypes from './ItemTypes'

const couponTarget = {
  drop: function (props) {
  }
};

@DropTarget(ItemTypes.CATEGORY_ITEM, couponTarget, (connect, monitor) =>({
  connectDropTarget: connect.dropTarget(),
  isOver: monitor.isOver()
}))
export default class CategoryItems extends Component {
  state = {items: [], reload: false}

  static propTypes = {
    isOver: PropTypes.bool.isRequired
  };

  constructor(props) {
    super(props);
    this.moveItem = this.moveItem.bind(this);
    this.findItem = this.findItem.bind(this);
  }

  componentDidMount() {
    this.setState({
      items: this.props.source
    });
  }

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

  render() {
    const { connectDropTarget, isOver, className, id } = this.props;
    const { items } = this.state;

    return connectDropTarget(
      <ul className={className} id={id}>
        {items.map((item, index) => {
          return (
            <BookItem id={item.id} title={item.title} key={index} moveItem={this.moveItem} findItem={this.findItem} />
          );
        })}
      </ul>
    );
  }
}
