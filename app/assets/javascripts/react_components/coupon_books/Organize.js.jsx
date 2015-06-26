//React
var React = require('react');
var Button = require('./Button.js.jsx');
var BookCategories = require('./BookCategories.js.jsx');
var CollectionCoupons = require('./CollectionCoupons.js.jsx');
var CollectionPrBoxes = require('./CollectionPrBoxes.js.jsx');


var Organize = (function() {
  function Organize(couponBookId) {
    this.couponBookId = couponBookId
    // React Mount nodes
    this.discountsContainer = $('#organize-react #my-discounts')[0];
    this.prBoxesContainer = $('#organize-react #pr-boxes')[0];
    this.categoryContainer = $('#organize-react #categories-col')[0];
    // Sources
    this.collectionCouponsSource = '/fundraisers/collection_coupons?cb_id=' + couponBookId;
    this.categoriesSource = '/coupon_books/'+ couponBookId + '/categories';
    this.prBoxesSource = '/fundraisers/collection_pr_boxes?cb_id=' + couponBookId;
    return;
  }

  Organize.prototype.renderCollectionCoupons = function(){
    // Coupons
    if(this.discountsContainer){
      React.render(
        <div>
          <h2>Available Discounts
            <Button
              href="/coupons/new"
              type="link"
              className="btn btn-success btn-sm pull-right">
              Add Discount
            </Button>
          </h2>
          <CollectionCoupons className="collection-coupons" id="collection-coupons" source={this.collectionCouponsSource} />
        </div>, this.discountsContainer
      );
    };
  };

  Organize.prototype.renderCollectionPrBoxes = function(){
    // PRBoxes
    if(this.prBoxesContainer){
      React.render(
        <div>
          <h2>Available PR Boxes
            <Button
              href={'/pr_boxes/new?coupon_book_id=' + this.couponBookId}
              type="link"
              className="btn btn-success btn-sm pull-right">
              Add PR Box
            </Button>
          </h2>
          <CollectionPrBoxes className="collection-pr-boxes" id="collection-pr-boxes" source={this.prBoxesSource} />
        </div>, this.prBoxesContainer
      );
    };
  };

  Organize.prototype.renderBookCategories = function(){
    // Categories
    if(this.categoryContainer){
      React.render(
        <div>
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
          <BookCategories className="collection-category" id="collection-categories" source={this.categoriesSource} />
        </div>, this.categoryContainer
      );
    };
  };

  Organize.prototype.init = function() {
    this.renderCollectionCoupons();
    this.renderCollectionPrBoxes();
    this.renderBookCategories();
  };

  return Organize;

})();

module.exports = Organize;

