CakeCouponBook.coupon_books.organize = function(couponBookId){
  // React Mount nodes
  var discountsContainer = $('#organize-react #my-discounts')[0];
  var prBoxesContainer = $('#organize-react #pr-boxes')[0];
  var categoryContainer = $('#organize-react #categories-col')[0];
  
  // Sources
  var collectionCouponsSource = '/fundraisers/collection_coupons?cb_id=' + couponBookId;
  var categoriesSource = '/coupon_books/'+ couponBookId + '/categories';
  var prBoxesSource = '/fundraisers/collection_pr_boxes?cb_id=' + couponBookId;

  // Coupons
  if(discountsContainer){
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
        <CouponList className="collection-coupons" id="collection-coupons" source={collectionCouponsSource} />
      </div>, discountsContainer
    );
  };

  // PRBoxes
  if(prBoxesContainer){
    React.render(
      <div>
        <h2>Available PR Boxes
          <Button
            href={'/pr_boxes/new?coupon_book_id=' + couponBookId}
            type="link"
            className="btn btn-success btn-sm pull-right">
            Add PR Box
          </Button>
        </h2>
        <PrBoxList className="collection-pr-boxes" id="collection-pr-boxes" source={prBoxesSource} />
      </div>, prBoxesContainer
    );
  };

  // Categories
  if(categoryContainer){
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
        <BookCategories className="collection-category" id="collection-categories" source={categoriesSource} />
      </div>, categoryContainer
    );
  };
};
