var React = require('react');
var Button = require('./Button.js.jsx');
var CollectionPrBoxes = require('./CollectionPrBoxes.js.jsx');

var PrBoxColumn = React.createClass({
  render: function() {
    return(
      <div className="pr-boxes-column">
        <h2>Available PR Boxes
          <Button
            href={'/pr_boxes/new?coupon_book_id=' + this.props.bookId}
            type="link"
            className="btn btn-success btn-sm pull-right">
            Add PR Box
          </Button>
        </h2>
        <CollectionPrBoxes className="collection-pr-boxes" id="collection-pr-boxes" source={this.props.source} />
      </div>
    );
  }
});

module.exports = PrBoxColumn;