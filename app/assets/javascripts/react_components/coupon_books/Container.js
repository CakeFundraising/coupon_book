import React, { Component, PropTypes } from 'react';

import CollectionCoupons from './CollectionCoupons';
import CollectionPrBoxes from './CollectionPrBoxes';
import Categories from './Categories';

import { DragDropContext } from 'react-dnd';
import HTML5Backend from 'react-dnd/modules/backends/HTML5';

@DragDropContext(HTML5Backend)
export default class Container extends Component {

  render() {
    const { sources } = this.props;

    return(
      <div className="row">
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
              <CollectionCoupons cssId="collection-coupons" className="collection-coupons" source={sources.collectionCouponsSource} />
            </div>
            <div className="tab-pane" id="pr-boxes" role="tabpanel">
              <CollectionPrBoxes className="collection-pr-boxes" id="collection-pr-boxes" source={sources.collectionPrBoxesSource} bookId={sources.couponBookId} />
            </div>
          </div>
        </div>
        <div className="col-md-6" id="categories-col">
          <ul className="no-list" id="categories">
            <Categories className="categories" id="categories" source={sources.categoriesSource} />
          </ul>
        </div>
      </div>
    );
  }
}
