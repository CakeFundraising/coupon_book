var React = require('react');
var Button = require('./Button.js.jsx');
var BookCategories = require('./BookCategories.js.jsx');

var CategoriesColumn = React.createClass({
  render: function() {
    return(
      <div className="categories-column">
        <h2>Discount Book Categories
          <Button
            data-target="#category"
            data-toggle="modal"
            href="/coupons/new"
            type="link"
            className="btn btn-success btn-sm pull-right">
            Add Category
          </Button>
        </h2>      
        <BookCategories className="collection-category" id="collection-categories" source={this.props.source} />
      </div>
    );
  }
});

module.exports = CategoriesColumn;