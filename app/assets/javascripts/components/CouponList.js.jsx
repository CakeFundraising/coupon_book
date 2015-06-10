var CouponList = React.createClass({

    propTypes: {
        id: React.PropTypes.string.isRequired,
        source: React.PropTypes.string.isRequired
    },

    mixins: [SortableMixin],

    sortableOptions: {
        group: "organize",
        animation: 200
    },

    getInitialState: function() {
        return {
            items: []
        };
    },

    componentDidMount: function() {
        $.get(this.props.source, function(data) {
            if (this.isMounted()) {
                this.setState({
                    items: data
                });
                }
        }.bind(this));

    },

    render: function() {
        return (
            <ul className={this.props.className} id={this.props.id}>
                {this.renderCouponItem()}
            </ul>
        );
    },

    renderCouponItem: function () {
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
