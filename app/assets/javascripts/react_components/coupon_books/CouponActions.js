import React, { Component } from 'react';
import Button from './Button';

export default class CouponActions extends Component {
  render() {
    const { className, noPreview, itemId, itemType, closeIcon } = this.props;
    const editPath = '/' + itemType + '/';

    return (
      <ul className={className}>
        <li className={className + '--item ' + (noPreview ? 'hide' : '')}>
          <Button
            iconType="eye-open"
            className={'btn btn-sm btn-success'}
            dTarget={'#preview-coupon-' + itemId}
            dToggle="modal">Preview
          </Button>
        </li>
        <li className={className + '--item'}>
          <Button
            href={editPath + itemId + '/edit'}
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