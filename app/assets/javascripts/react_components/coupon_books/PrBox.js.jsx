var React = require('react');
var CouponActions = require('./CouponActions.js.jsx');

var PrBox = React.createClass({
  render: function(){
    var id = this.props.prBox.id;
    var headline = this.props.prBox.headline;

    return (
      <li className="prbox-list" id={'prboxes_' + id}  key={this.props.key}>
        <span className="prbox-list--container">
          <span className="prbox-list--title">{headline}</span>
        </span>
        <CouponActions className="prboxActions" prboxId={id} />
      </li>
    );
  }

});

module.exports = PrBox;