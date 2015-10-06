import React, { Component } from 'react';
import Button from './Button';

export default class CouponActions extends Component {
  render() {
    const { className, noPreview, itemId, closeIcon, bookId } = this.props;
    const editPath = '/pr_boxes/' + itemId + '/edit?coupon_book_id=' + bookId;

    return (
      <ul className={className}>
        <li className={className + '--item ' + (noPreview ? 'hide' : '')}>
          <Button
            iconType="eye-open"
            className={'btn btn-sm btn-success'}
            dTarget={'#preview-pr-box-' + itemId}
            dToggle="modal">Preview
          </Button>
        </li>
        <li className={className + '--item'}>
          <Button
            href={editPath}
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