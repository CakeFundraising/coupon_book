/** @jsx React.DOM */

var Button = React.createClass({
  getDefaultProps: function () {
    return {
      href: '#',
      iconType: null
    };
  },

  render: function () {
    return this.renderHtmlTag();
  },

  renderHtmlTag: function () {
    return (
      <a
        href={this.props.href}
        data-target={this.props['data-target']}
        data-toggle={this.props['data-toggle']}
        className={this.props.className}>
        {this.renderContent()}
      </a>
    );
  },

  renderContent: function () {
    if (this.props.iconType !== null) {
      return (
        <span className={'glyphicon glyphicon-' + this.props.iconType}></span>
      );
    } else {
      return this.props.children;
    }
  }
});