import React, { Component } from 'react';

export default class Button extends Component {
  static defaultProps = {
    href: '#',
    iconType: null
  };

  render(){
    return(
      <a
        href={this.props.href}
        data-target={this.props['data-target']}
        data-toggle={this.props['data-toggle']}
        className={this.props.className}>
        {this.renderContent()}
      </a>
    );
  }

  renderContent() {
    if (this.props.iconType !== null) {
      return (
        <span className={'glyphicon glyphicon-' + this.props.iconType}></span>
      );
    } else {
      return this.props.children;
    }
  }
}
