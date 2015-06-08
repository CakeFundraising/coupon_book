/** @jsx React.DOM */

var CouponActions = React.createClass({

    render: function() {
        return (
            <ul className={this.props.className}>
                <li className={this.props.className + '--item'}>
                    <Button
                        iconType="eye-open"
                        className="btn btn-sm btn-success"
                        data-target={'#preview-coupon-' + this.props.couponId}
                        data-toggle="modal">Preview
                    </Button>
                </li>
                <li className={this.props.className + '--item'}>
                    <Button
                        href={'/coupons/' + this.props.couponId + '/edit'}
                        iconType="pencil"
                        className="btn btn-sm btn-primary">Edit
                    </Button>
                </li>
                <li className={this.props.className + '--item'}>
                    <Button
                        iconType="trash"
                        className="btn btn-sm btn-danger">Edit
                    </Button>
                </li>
            </ul>
        );
    }
});