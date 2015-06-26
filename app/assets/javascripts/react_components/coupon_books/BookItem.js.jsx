var React = require('react');
var Button = require('./Button.js.jsx');

var BookItem = React.createClass({

  render: function(){
    return (
      <li className="coupon-list" id={'coupons_' + this.props.item.id}  key={this.props.index}>
        <span className="coupon-list--container">
          <span className="coupon-list--title">{this.props.item.title}</span>
        </span>
        <Button iconType='remove' className="btn btn-sm pull-right btn-danger">Delete</Button>
        <Button href={'/coupons/' + this.props.item.id + '/edit'} iconType="pencil" className="btn btn-sm pull-right btn-primary">Edit</Button>
        <Button iconType="eye-open" className="btn btn-sm pull-right btn-success" data-target={'#preview-coupon-' + this.props.item.id} data-toggle="modal">Preview </Button>
      </li>
    );
  }

});

module.exports = BookItem;