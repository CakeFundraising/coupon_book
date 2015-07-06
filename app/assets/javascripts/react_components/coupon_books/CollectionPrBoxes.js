import React, { Component, PropTypes } from 'react';
import Immutable from 'immutable'

import Button from './Button';
import PrBox from './PrBox';

export default class CollectionPrBoxes extends Component {
  static propTypes = {
    id: PropTypes.string.isRequired,
    source: PropTypes.string.isRequired,
    removeItemFromCategory: PropTypes.func.isRequired
  };

  constructor(props) {
    super(props);
    this.disablePrBox = this.disablePrBox.bind(this);
    this.enablePrBox = this.enablePrBox.bind(this);
    this.state = {prBoxes: []};
  }
  
  componentDidMount() {
    $.get(this.props.source, function(data) {
      this.setState({
        prBoxes: Immutable.fromJS(data)
      });
    }.bind(this));
  }

  // PrBox actions
  enablePrBox(prBoxId){
    const prBoxIndex = this.state.prBoxes.findIndex(c => c.get('id') === prBoxId)

    this.setState(({prBoxes}) => ({
      prBoxes: prBoxes.updateIn([prBoxIndex], prBox => prBox.set('disabled', false))
    }));
  }

  disablePrBox(prBoxId){
    const prBoxIndex = this.state.prBoxes.findIndex(c => c.get('id') === prBoxId)

    this.setState(({prBoxes}) => ({
      prBoxes: prBoxes.updateIn([prBoxIndex], prBox => prBox.set('disabled', true))
    }));
  }

  render() {
    const { className, id, removeItemFromCategory } = this.props;
    const { prBoxes } =  this.state;

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
        <ul className={className} id={id}>
          {prBoxes.map((prBox, index) => {
            return(
              <PrBox 
                id={prBox.get('id')} 
                title={prBox.get('title')} 
                itemType={prBox.get('itemType')} 
                disabled={prBox.get('disabled')} 
                disablePrBox={this.disablePrBox} 
                key={index} 
                removeItemFromCategory={removeItemFromCategory} />
            );
          })}
        </ul>
      </div>
    );
  }
}
