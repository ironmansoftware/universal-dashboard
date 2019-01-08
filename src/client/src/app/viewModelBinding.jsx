import React from 'react';
import { DashboardContext } from './dashboard-context.jsx';

export default class ViewModelBinding extends React.Component {
      render() {
          if (this.props.viewModelBinding) {
            return (
                <DashboardContext.Consumer>
                    {
                        (context) => {
                            var componentProps = this.props;
                            componentProps["dispatchState"] = context.dispatchState;

                            for(var propertyName in this.props.viewModelBinding.boundProperties) {

                                var value = context[this.props.viewModelBinding.boundProperties[propertyName]];
                                if (propertyName.endsWith("_endpoint")) {
                                    var handlerName = this.props.viewModelBinding.boundProperties[propertyName];
                                    propertyName = propertyName.replace('_endpoint', '');
                                    componentProps[propertyName] = (value) => {

                                        if (value == null) {
                                            value = true
                                        }

                                        var state = {}
                                        state[handlerName] = value;
                                        context.dispatchState(state);
                                    }
                                }
                                else {
                                    componentProps[propertyName] = value;    
                                }
                            }

                            return React.createElement(this.props.element, componentProps);
                        }
                    }
                </DashboardContext.Consumer>
            )            
          }
          else {
            return React.createElement(this.props.element, this.props);
          }
      }
  }