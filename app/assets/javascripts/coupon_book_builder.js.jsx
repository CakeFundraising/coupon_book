/** @jsx React.DOM */

$(document).ready(function () {

var container = document.getElementById('my-collection');
var collectionCoupons = "http://localhost:3001/fundraisers/collection_coupons";

React.render(
    <div>
        <h2>All Discounts
            <Button
                href="/coupons/new"
                type="link"
                className="btn btn-success btn-sm pull-right">
                Add Discount
            </Button>
        </h2>

    <CouponList
        className="collection-coupons"
        id="collection-coupons"
        source={collectionCoupons} />

    </div>, container);

});