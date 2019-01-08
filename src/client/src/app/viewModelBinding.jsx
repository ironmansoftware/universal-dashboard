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
                                if (value == null)
                                {
                                    value = this.props.viewModelBinding.boundProperties[propertyName];
                                }

                                componentProps[propertyName] = value;
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