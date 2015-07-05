import React, { Component } from 'react';

export default class Button extends Component {
  static defaultProps = {
    href: '#!',
    iconType: null,
    disabled: false
  };

  content(){
    const {iconType, children} = this.props;

    if (iconType !== null) {
      return <span className={'glyphicon glyphicon-' + iconType}></span>;
    }else{
      return children;
    }
  }

  render(){
    const { href, className, onClickEvent, disabled, ['data-target']: target, ['data-toggle']: toggle } = this.props;

    return(
      <a 
        href={href} 
        data-target={target} 
        data-toggle={toggle} 
        className={className} 
        onClick={onClickEvent} 
        data-type="react-button" 
        disabled={disabled} >
        {this.content()}
      </a>
    );
  }
}
