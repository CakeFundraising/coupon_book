/** @jsx React.DOM */

$(document).ready(function () {

    var discountsContainer = document.getElementById('my-discounts'),
        categoryContainer = document.getElementById('categories').parentNode,
        collectionCoupons = "/fundraisers/collection_coupons";

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

        </div>, discountsContainer
    );

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

            <BookCategories className="collection-category" id="collection-categories" />

        </div>, categoryContainer
    );
});

