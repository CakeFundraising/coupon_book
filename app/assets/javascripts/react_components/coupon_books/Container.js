import React, { Component, PropTypes } from 'react';

import CollectionCoupons from './CollectionCoupons';
import CollectionPrBoxes from './CollectionPrBoxes';
import Categories from './Categories';
import Button from './Button';

import { DragDropContext } from 'react-dnd';
import HTML5Backend from 'react-dnd/modules/backends/HTML5';

@DragDropContext(HTML5Backend)
export default class Container extends Component {
  constructor(props) {
    super(props);

    this.enableCoupon = this.enableCoupon.bind(this);
    this.enablePrBox = this.enablePrBox.bind(this);
    this.removeItemFromCategory = this.removeItemFromCategory.bind(this);
    this.save = this.save.bind(this);

    this.state = {saving: false};
  }

  // Integration Functions
  enableCoupon(couponId){
    this.refs.collectionCoupons.enableCoupon(couponId);
  }

  enablePrBox(prBoxId){
    this.refs.collectionPrBoxes.enablePrBox(prBoxId);
  }

  removeItemFromCategory(itemId){
    this.refs.categories.removeItemFromCategory(itemId);
  }

  // SAVE
  save(){
    const self = this;
    const couponBookId = this.props.sources.couponBookId;
    const categoriesTree = {
      categories: this.refs.categories.state.categories.toJS()
    };
    
    this.setState({saving: true});

    $.post('/coupon_books/' + couponBookId + '/edit/save_organize', categoriesTree).done(function (data){
      self.setState({saving: false});
    });
  }

  render() {
    const { sources } = this.props;
    const { saving } = this.state;
    const opacity = saving ? 0.4 : 1

    return(
      <div style={{ opacity: opacity }} className="row">
        <div className="col-md-6" role="tabpanel">
          <ul className="nav nav-tabs" role="tablist">
            <li className="active" role="presentation">
              <a aria-controls="discounts" data-toggle="tab" href="#my-discounts" role="tab">Discounts</a>
            </li>
            <li role="presentation">
              <a aria-controls="pr-boxes" data-toggle="tab" href="#pr-boxes" role="tab">PR Boxes</a>
            </li>
          </ul>
          <div className="tab-content">
            <div className="tab-pane active" id="my-discounts" role="tabpanel">
              <CollectionCoupons 
                cssId="collection-coupons" 
                className="collection-coupons" 
                source={sources.collectionCouponsSource} 
                removeItemFromCategory={this.removeItemFromCategory} 
                ref="collectionCoupons" />
            </div>
            <div className="tab-pane" id="pr-boxes" role="tabpanel">
              <CollectionPrBoxes 
                className="collection-pr-boxes" 
                id="collection-pr-boxes" 
                source={sources.collectionPrBoxesSource} 
                bookId={sources.couponBookId}
                removeItemFromCategory={this.removeItemFromCategory} 
                ref="collectionPrBoxes" />
            </div>
          </div>
        </div>
        <div className="col-md-6" id="categories-col">
          <ul className="no-list">
            <Categories 
              className="categories" 
              id="categories" 
              bookId={sources.couponBookId}
              source={sources.categoriesSource} 
              enableCoupon={this.enableCoupon} 
              enablePrBox={this.enablePrBox} 
              ref="categories" />
          </ul>
        </div>
        <div className="col-md-12 text-center">
          <Button className="btn btn-lg btn-success" onClickEvent={this.save} disabled={saving}>
            Save
          </Button>
          <Button href={'/coupon_books/' + sources.couponBookId + '/edit/request_coupons'} className="btn btn-lg btn-primary">
            Continue
          </Button>
        </div>
      </div>
    );
  }
}
