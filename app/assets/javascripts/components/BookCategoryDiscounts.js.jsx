var BookCategoryDiscounts = React.createClass({

    mixins: [SortableMixin],

    sortableOptions: {
        group: "organize",
        animation: 200
    },

    getInitialState: function () {
        return {
            items: ['']
        };
    },

    render: function() {
        return (
            <ul className={this.props.className} id={this.props.id}>
                {this.renderCategoryList()}
            </ul>
        );
    },

    renderCategoryList: function () {
        return (
            this.state.items.map (function (item, index) {
                return (
                    <li className="coupon-list" id={'coupons_' + item.id}  key={index}>
                        <span className="coupon-list--container">
                            <span className="coupon-list--item">{'Coupon ' + item.id}</span>
                            <span className="coupon-list--title">{item.title}</span>
                        </span>
                        <CouponActions className="couponActions" couponId={item.id} />
                    </li>
                );
            })
        );
    }
});
