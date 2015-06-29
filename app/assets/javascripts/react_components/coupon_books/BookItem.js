import React, { Component, PropTypes } from 'react';
import Button from './Button';

export default class BookItem extends Component {
  static propTypes = {
    item: PropTypes.object.isRequired,
  };
  
  render(){
    const { id, title } =  this.props.item;

    return (
      <li className="coupon-list" id={'coupons_' + id}  key={this.props.index}>
        <span className="coupon-list--container">
          <span className="coupon-list--title">{title}</span>
        </span>
        <Button iconType='remove' className="btn btn-sm pull-right btn-danger">Delete</Button>
        <Button href={'/coupons/' + id + '/edit'} iconType="pencil" className="btn btn-sm pull-right btn-primary">Edit</Button>
        <Button iconType="eye-open" className="btn btn-sm pull-right btn-success" data-target={'#preview-coupon-' + id} data-toggle="modal">Preview </Button>
      </li>
    );
  }
}
