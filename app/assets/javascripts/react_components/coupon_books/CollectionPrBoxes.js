import React, { Component, PropTypes } from 'react';
import Button from './Button';
import PrBox from './PrBox';

export default class CollectionPrBoxes extends Component {
  state = {items: []};

  static propTypes = {
    id: PropTypes.string.isRequired,
    source: PropTypes.string.isRequired
  };
  
  componentDidMount() {
    $.get(this.props.source, function(data) {
      this.setState({
        items: data
      });
    }.bind(this));
  }

  render() {
    const prBoxes = this.state.items.map(function(item, index) {
      if(!item.disabled){
        return (
          <PrBox prBox={item} key={index}></PrBox>
        );
      };
    });

    return (
      <div className="pr-boxes-column">
        <h2>Available PR Boxes
          <Button
            href={'/pr_boxes/new?coupon_book_id=' + this.props.bookId}
            type="link"
            className="btn btn-success btn-sm pull-right">
            Add PR Box
          </Button>
        </h2>
        <ul className={this.props.className} id={this.props.id}>
          {prBoxes}
        </ul>
      </div>
    );
  }
}
