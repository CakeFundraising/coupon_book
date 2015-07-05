import React, { Component } from 'react';
import Button from './Button';

export default class CouponActions extends Component {
  render() {
    const { className, noPreview, couponId, closeIcon } = this.props;

    return (
      <ul className={className}>
        <li className={className + '--item ' + (noPreview ? 'hide' : '')}>
          <Button
            iconType="eye-open"
            className={'btn btn-sm btn-success'}
            data-target={'#preview-coupon-' + couponId}
            data-toggle="modal">Preview
          </Button>
        </li>
        <li className={className + '--item'}>
          <Button
            href={'/coupons/' + couponId + '/edit'}
            iconType="pencil"
            className="btn btn-sm btn-primary">Edit
          </Button>
        </li>
        <li className={className + '--item'}>
          <Button
            iconType= {closeIcon ? 'remove' : 'trash'}
            className="btn btn-sm btn-danger">Delete
          </Button>
        </li>
      </ul>
    );
  }
}