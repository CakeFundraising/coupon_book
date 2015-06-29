import React, { Component, PropTypes } from 'react';
import BookItem from './BookItem';

import { DropTarget } from 'react-dnd'
import ItemTypes from './ItemTypes'

const couponTarget = {
  drop: function (props) {
    console.log('Hola');
    //moveKnight(props.x, props.y);
  }
};

function collect(connect, monitor) {
  return {
    connectDropTarget: connect.dropTarget(),
    isOver: monitor.isOver()
  };
}

@DropTarget(ItemTypes.COUPON, couponTarget, (connect, monitor) =>({
  connectDropTarget: connect.dropTarget(),
  isOver: monitor.isOver()
}))
export default class CategoryItems extends Component {
  state = {items: [], reload: false}

  static propTypes = {
    isOver: PropTypes.bool.isRequired
  };

  componentDidMount() {
    this.setState({
      items: this.props.source
    });
  }

  render() {
    const { connectDropTarget, isOver, className, id } = this.props;

    const bookItems = this.state.items.map(function(item, index) {
      return (
        <BookItem item={item} key={index}></BookItem>
      );
    });

    return connectDropTarget(
      <ul className={className} id={id}>
        {bookItems}
      </ul>
    );
  }
}
