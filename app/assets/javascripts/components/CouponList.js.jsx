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
            coupons: []
        };
    },

    componentDidMount: function() {
        $.get(this.props.source, function(data) {
            if (this.isMounted()) {
                this.setState({
                    coupons: data
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
            this.state.coupons.map (function (item, index) {
                var indexBase = index + 1;

                return (
                    <li className="coupon-list" id={'coupons_' + item.id}  key={index}>
                        <span className="coupon-list--item">{'Coupon ' + indexBase}</span>
                        <span className="coupon-list--title">{item.title}</span>
                        <CouponActions className="couponActions" couponId={item.id} />
                    </li>
                );
            })
        );
    }
});
