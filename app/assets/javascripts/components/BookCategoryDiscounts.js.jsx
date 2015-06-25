var BookCategoryDiscounts = React.createClass({
  mixins: [SortableMixin],

  sortableOptions: {
    group: 'organize',
    animation: 200,
    ghostClass: 'sortable-ghost',
    filter: '.btn-danger'
  },

  getInitialState: function () {
    return {
      items: [],
      reload: false
    };
  },

  componentDidMount: function() {
    if (this.isMounted()) {
      this.setState({
        items: this.props.source
      });
    }
  },

  handleFilter: function (event) {
    var item = event.item,
        ctrl = event.target;

    if (Sortable.utils.is(ctrl, '.btn-danger')) {
      item.parentNode.removeChild(item);
    }
  },

  render: function() {
    return (
      <ul className={this.props.className} id={this.props.id}>
        {this.renderCategoryList()}
      </ul>
    );
  },

  renderCategoryList: function () {
    if (this.state.items.length !== 0) {
      return (
        this.state.items.map (function (item, index) {
          return (
            <li className="coupon-list" id={'coupons_' + item.id}  key={index}>
              <span className="coupon-list--container">
                <span className="coupon-list--item">{'Coupon ' + item.id}</span>
                <span className="coupon-list--title">{item.title}</span>
              </span>
              <Button iconType='remove' className="btn btn-sm pull-right btn-danger">Delete</Button>
              <Button href={'/coupons/' + item.id + '/edit'} iconType="pencil" className="btn btn-sm pull-right btn-primary">Edit</Button>
              <Button iconType="eye-open" className="btn btn-sm pull-right btn-success" data-target={'#preview-coupon-' + item.id} data-toggle="modal">Preview </Button>
            </li>
          );
        })
      );
    } else {
      return <li className="empty-list"></li>
    }
  }  
});
