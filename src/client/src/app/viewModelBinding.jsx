import React from 'react';
require('react-dom');
import dotnetify from 'dotnetify';

export default class ViewModelBinding extends React.Component {
    constructor(props) {
        super(props);

        this.state = props;

        if (this.props.viewModelBinding) {
            this.vm = dotnetify.react.connect(this.props.viewModelBinding.viewModelName, this);
            this.dispatchState = state => {
                this.setState(state);
                this.vm.$dispatch(state);
            };
        }
      }
  
      componentWillUnmount() {
        if (this.props.viewModelBinding) {
            this.vm.$destroy();
        }
      }
  
      render() {
          if (this.props.viewModelBinding) {
            var componentProps = this.state;
            for(var propertyName in this.props.viewModelBinding.boundProperties) {
                componentProps[propertyName] = this.state[ this.props.viewModelBinding.boundProperties[propertyName]];
            }

            return React.createElement(this.props.element, this.state);
          }
          else {
            return React.createElement(this.props.element, this.props);
          }
      }
  }