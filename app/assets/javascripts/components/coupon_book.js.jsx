if (CakeCouponBook.React == null) {
  CakeCouponBook.React = {};
}

var Category, CategoryList, CouponList, Coupon, CouponCollection;

Coupon = React.createClass({
  render: function() {
    var couponEditPath = "/coupons/" + this.props.coupon.id + "/edit"
    var couponDeletePath = "/coupons/" + this.props.coupon.id

    return (
      <table className="table table-hover table-bordered table-striped data-table">
        <tr>
          <td>
            <div className="coupon-sp">{this.props.sponsor.name}</div>
            <div className="coupon-title">{this.props.coupon.title}</div>
          </td>
          <td className="coupon-actions">
            <a className="btn btn-primary btn-sm" href={couponEditPath}><span className="glyphicon glyphicon-pencil"></span></a>
            <a className="btn btn-danger btn-sm" data-confirm="Are you sure?" data-method="delete" href={couponDeletePath}><span className="glyphicon glyphicon-trash"></span></a>
          </td>
        </tr>
      </table>
    );
  }
});

Category = React.createClass({
  render: function() {
    var categoryDeletePath = "/categories/" + this.props.category.id

    return <div className="category">
      <table className="table table-hover table-bordered table-striped data-table">
        <thead className="cf">
          <tr>
            <th>
              <span className="category-title">{this.props.category.name}</span>
            </th>
            <th className="category-actions">
              <a className="btn btn-primary btn-sm"><span className="glyphicon glyphicon-pencil"></span></a>
              <a className="btn btn-danger btn-sm" data-confirm="Are you sure?" data-method="delete" href={categoryDeletePath}><span className="glyphicon glyphicon-trash"></span></a>
            </th>
          </tr>
        </thead>
      </table> 
      <CouponList coupons={this.props.coupons}></CouponList>
    </div>;
  }
});

CouponList = React.createClass({
  render: function() {
    var coupons = this.props.coupons.map(function(coupon, index) {
      return (
        <Coupon coupon={coupon} sponsor={coupon.sponsor} key={index}></Coupon>
      );
    });
    return (
      <ul className="coupons-list">
        {coupons}
      </ul>
    );
  }
});

CouponCollection = React.createClass({
  getInitialState: function() {
    return {coupons: []};
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
    var coupons = this.state.coupons.map(function(coupon, index) {
      return (
        <Coupon coupon={coupon} sponsor={coupon.sponsor} key={index}></Coupon>
      );
    });
    return (
      <div className="myCollection">
        {coupons}
      </div>
    );
  }
});


CategoryList = React.createClass({
  getInitialState: function() {
    return {categories: []};
  },

  componentDidMount: function() {
    $.get(this.props.source, function(data) {
      if (this.isMounted()) {
        this.setState({
          categories: data
        });
      }
    }.bind(this));
  },

  render: function() {
    var categories = this.state.categories.map(function(category, index) {
      return <Category category={category} key={index} coupons={category.coupons}></Category>;
    });
    return <div className="categories-list">
      {categories}
    </div>;
  }
});


