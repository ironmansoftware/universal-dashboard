import React from 'react';

export const defaultContext = {
    dispatchState: () => {}
}
export const DashboardContext = React.createContext(defaultContext);
import dotnetify from 'dotnetify';

export class DashboardViewModel extends React.Component {

    constructor() {
        super();
        
        this.state = {
            dispatchState: state => {
                this.setState(state);
                this.vm.$dispatch(state); 
            }
        };
        this.vm = dotnetify.react.connect("root", this);
    }

    render() {
        return (
            <DashboardContext.Provider value={this.state}>
                {this.props.children}
            </DashboardContext.Provider>
        )
    }
}