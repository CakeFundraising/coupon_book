var PrBoxList = React.createClass({
  propTypes: {
    id: React.PropTypes.string.isRequired,
    source: React.PropTypes.string.isRequired
  },

  mixins: [SortableMixin],

  sortableOptions: {
    sort: false,
    group: {
      name: 'organize'
      //pull: 'clone'
    },
    filter: '.disabled',
    model: 'items',
    animation: 200,
    ghostClass: 'sortable-ghost'
  },

  getInitialState: function() {
    return {
      items: []
    };
  },

  componentDidMount: function() {
    $.get(this.props.source, function(data) {
      if (this.isMounted()) {
        this.setState({
          items: data
        });
      }
    }.bind(this));
  },

  render: function() {
    return (
      <ul className={this.props.className} id={this.props.id}>
        {this.renderItem()}
      </ul>
    );
  },

  renderItem: function () {
    if (this.state.items.length !== 0) {
      var constructor = this;
      return (
        this.state.items.map (function (item, index) {
          return (
            <li className={constructor.itemClasses(item)} id={'prboxes_' + item.id}  key={index}>
              <span className="prbox-list--container">
                <span className="prbox-list--item">{'PRBox ' + item.id}</span>
                <span className="prbox-list--title">{item.title}</span>
              </span>
              <CouponActions className="prboxActions" prboxId={item.id} />
            </li>
          );
        })
      );
    } else {
      return <li className="empty-list"></li>
    }
  },

  itemClasses: function(prbox){
    var cx = React.addons.classSet;
    var classes = cx({
      'prbox-list': true,
      'disabled': prbox.disabled,
    });
    return classes;
  }
  
});
