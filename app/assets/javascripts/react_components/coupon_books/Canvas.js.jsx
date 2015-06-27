var React = require('react');
var CouponColumn = require('./CouponColumn.js.jsx');
var PrBoxColumn = require('./PrBoxColumn.js.jsx');
var CategoriesColumn = require('./CategoriesColumn.js.jsx');

var HTML5Backend = require('react-dnd/modules/backends/HTML5');
var DragDropContext = require('react-dnd').DragDropContext;

var Canvas = React.createClass({
  render: function() {
    var sources = this.props.sources;

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
              <CouponColumn source={sources.collectionCouponsSource} />
            </div>
            <div className="tab-pane" id="pr-boxes" role="tabpanel">
              <PrBoxColumn source={sources.collectionPrBoxesSource} bookId={sources.couponBookId} />
            </div>
          </div>
        </div>
        <div className="col-md-6" id="categories-col">
          <ul className="no-list" id="categories">
            <CategoriesColumn source={sources.categoriesSource} />
          </ul>
        </div>
      </div>
    );
  }
});

module.exports = DragDropContext(HTML5Backend)(Canvas);