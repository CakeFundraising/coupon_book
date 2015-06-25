var BookCategoryItems = React.createClass({
  mixins: [SortableMixin],

  sortableOptions: {
    group: {
      name: 'category',
      put: ['coupons', 'prboxes']
    },
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
    var bookItems = this.state.items.map(function(item, index) {
      return (
        <BookItem item={item} key={index}></BookItem>
      );
    });

    return (
      <ul className={this.props.className} id={this.props.id}>
        {bookItems}
      </ul>
    );
  }

});
