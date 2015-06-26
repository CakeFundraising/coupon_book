var React = require('react');
var PrBox = require('./PrBox.js.jsx');

var CollectionPrBoxes = React.createClass({
  propTypes: {
    id: React.PropTypes.string.isRequired,
    source: React.PropTypes.string.isRequired
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
    var prBoxes = this.state.items.map(function(item, index) {
      if(!item.disabled){
        return (
          <PrBox prBox={item} key={index}></PrBox>
        );
      };
    });

    return (
      <ul className={this.props.className} id={this.props.id}>
        {prBoxes}
      </ul>
    );
  }

});

module.exports = CollectionPrBoxes;
