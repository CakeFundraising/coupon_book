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
    const { href, className, onClickEvent, disabled, dMethod, dConfirm, dTarget, dToggle } = this.props;

    return(
      <a 
        href={href} 
        data-target={dTarget} 
        data-toggle={dToggle} 
        data-method={dMethod} 
        data-confirm={dConfirm} 
        className={className} 
        onClick={onClickEvent} 
        data-type="react-button" 
        disabled={disabled} >
        {this.content()}
      </a>
    );
  }
}
